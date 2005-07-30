Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 6253967E05
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 31 Jul 2005 02:46:47 +1000 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Sat, 30 Jul 2005 18:46:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507301846.43162.roger.larsson@norran.net>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] PPC440EP (405GPr) 2.4.20 (2.6) scatter/gather DMA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch has been tested on PPC440EP,
an earlier, almost identical, version was used on 405GPr
(on a later Linux release).
Both should work.

I now see that some of these changes maybe should not be
done... (removal of inline, export of ppc4xx_set_sg_addr)

/RogerL

--- linux-2.4.20_mvl31_AR2/arch/ppc/kernel/ppc4xx_sgdma.c.org	2005-07-01 
13:10:27.000000000 +0200
+++ linux-2.4.20_mvl31_AR2/arch/ppc/kernel/ppc4xx_sgdma.c	2005-07-12 
11:11:16.000000000 +0200
@@ -4,11 +4,17 @@
  * IBM PPC4xx DMA engine scatter/gather library 
  *
  * Copyright 2002-2003 MontaVista Software Inc.
+ * Copyright 2005      Optronic dp AB
  *
  * Cleaned by Matt Porter <mporter@mvista.com>
  *
  * Original code by Armin Kuster <akuster@mvista.com>
  * and Pete Popov <ppopov@mvista.com>
+ *
+ * Use of kmalloc, good for short and very long lists
+ * End of Transfer termination and residue
+ * Roger Larsson <roger.larsson@optronic.se> and
+ * Ronnie Hedlund, DataDuctus AB
  *   
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -19,7 +25,7 @@
  * with this program; if not, write  to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
+ 
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -31,7 +37,7 @@
 #include <asm/io.h>
 #include <asm/ppc4xx_dma.h>
 
-static __inline__ void
+void
 ppc4xx_set_sg_addr(int dmanr, phys_addr_t sg_addr)
 {
 	switch (dmanr) {
@@ -73,7 +79,7 @@
  *   memory to peripheral: set dst_addr to NULL,
  *   peripheral to memory: set src_addr to NULL.
  */
-static __inline__ int
+int
 ppc4xx_add_dma_sgl(sgl_handle_t handle, phys_addr_t src_addr, phys_addr_t 
dst_addr,
 		   unsigned int count)
 {
@@ -125,18 +131,19 @@
 	}
 #endif
 
-	if ((unsigned) (psgl->ptail + 1) >= ((unsigned) psgl + SGL_LIST_SIZE)) {
-		printk("sgl handle out of memory \n");
-		return DMA_STATUS_OUT_OF_MEMORY;
-	}
-
-	if (!psgl->ptail) {
-		psgl->phead = (ppc_sgl_t *)
-		    ((unsigned) psgl + sizeof (sgl_list_info_t));
-		psgl->ptail = psgl->phead;
-	} else {
-		psgl->ptail->next = virt_to_bus(psgl->ptail + 1);
-		psgl->ptail++;
+	/* dynamic alloc each list element */
+	{
+		ppc_sgl_t *sgl_el = kmalloc(sizeof(ppc_sgl_t), GFP_KERNEL|GFP_DMA);
+		if (!sgl_el)
+			return DMA_STATUS_OUT_OF_MEMORY;
+
+		if (!psgl->phead) { /* list was empty */
+			psgl->phead = sgl_el;
+		} else { /* not empty, tail exists */
+			psgl->ptail->next = virt_to_phys(sgl_el);
+			dma_cache_wback((unsigned long)psgl->ptail, sizeof(ppc_sgl_t));
+		}
+		psgl->ptail = sgl_el;
 	}
 
 	psgl->ptail->control = psgl->control;
@@ -144,7 +151,8 @@
 	psgl->ptail->dst_addr = dst_addr;
 	psgl->ptail->control_count = (count >> p_dma_ch->shift) |
 	    psgl->sgl_control;
-	psgl->ptail->next = (uint32_t) NULL;
+	psgl->ptail->next = virt_to_phys(NULL);
+	dma_cache_wback((unsigned long)psgl->ptail, sizeof(ppc_sgl_t)); /* handled 
later, skip this one? */
 
 	return DMA_STATUS_GOOD;
 }
@@ -152,7 +160,8 @@
 /*
  * Enable (start) the DMA described by the sgl handle.
  */
-static __inline__ void
+
+void
 ppc4xx_enable_dma_sgl(sgl_handle_t handle)
 {
 	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
@@ -173,9 +182,18 @@
 
 	p_dma_ch = &dma_channels[psgl->dmanr];
 	psgl->ptail->control_count &= ~SG_LINK;	/* make this the last dscrptr */
+	if (p_dma_ch->int_enable)
+	{
+		/* Require Terminal Count interrupt on last */
+		psgl->ptail->control_count |= SG_TCI_ENABLE; 
+	}
+	
+	/* No more changes to tail object allowed */
+	dma_cache_wback((unsigned long)psgl->ptail, sizeof(ppc_sgl_t));
+	
 	sg_command = mfdcr(DCRN_ASGC);
 
-	ppc4xx_set_sg_addr(psgl->dmanr, virt_to_bus(psgl->phead));
+	ppc4xx_set_sg_addr(psgl->dmanr, virt_to_phys(psgl->phead));
 
 	switch (psgl->dmanr) {
 	case 0:
@@ -193,37 +211,14 @@
 	default:
 		printk("ppc4xx_enable_dma_sgl: bad channel: %d\n", psgl->dmanr);
 	}
-
-#if 0				/* debug */
-	printk("\n\nppc4xx_enable_dma_sgl at dma_addr 0x%x\n",
-	       virt_to_bus(psgl->phead));
-	{
-		ppc_sgl_t *pnext, *sgl_addr;
-
-		pnext = psgl->phead;
-		while (pnext) {
-			printk("dma descriptor at 0x%x, dma addr 0x%x\n",
-			       (unsigned) pnext, (unsigned) virt_to_bus(pnext));
-			printk
-			    ("control 0x%x src 0x%x dst 0x%x c_count 0x%x, next 0x%x\n",
-			     (unsigned) pnext->control,
-			     (unsigned) pnext->src_addr,
-			     (unsigned) pnext->dst_addr,
-			     (unsigned) pnext->control_count,
-			     (unsigned) pnext->next);
-
-			(unsigned) pnext = bus_to_virt(pnext->next);
-		}
-		printk("sg_command 0x%x\n", sg_command);
-	}
-#endif
+	
 	mtdcr(DCRN_ASGC, sg_command);	/* start transfer */
 }
 
 /*
  * Halt an active scatter/gather DMA operation.
  */
-static __inline__ void
+void
 ppc4xx_disable_dma_sgl(sgl_handle_t handle)
 {
 	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
@@ -265,8 +260,10 @@
  *  the sgl descriptor where the DMA stopped.
  *
  *  An sgl transfer must NOT be active when this function is called.
+ *  Note: Make sure ppc4xx_disable_dma_sgl was called before returning from
+ *  interrupt handler (TSn, CSn will not disable the sgl)!
  */
-static __inline__ int
+int
 ppc4xx_get_dma_sgl_residue(sgl_handle_t handle, phys_addr_t * src_addr,
 			   phys_addr_t * dst_addr)
 {
@@ -286,19 +283,19 @@
 
 	switch (psgl->dmanr) {
 	case 0:
-		sgl_addr = (ppc_sgl_t *) bus_to_virt(mfdcr(DCRN_ASG0));
+		sgl_addr = (ppc_sgl_t *) phys_to_virt(mfdcr(DCRN_ASG0));
 		count_left = mfdcr(DCRN_DMACT0);
 		break;
 	case 1:
-		sgl_addr = (ppc_sgl_t *) bus_to_virt(mfdcr(DCRN_ASG1));
+		sgl_addr = (ppc_sgl_t *) phys_to_virt(mfdcr(DCRN_ASG1));
 		count_left = mfdcr(DCRN_DMACT1);
 		break;
 	case 2:
-		sgl_addr = (ppc_sgl_t *) bus_to_virt(mfdcr(DCRN_ASG2));
+		sgl_addr = (ppc_sgl_t *) phys_to_virt(mfdcr(DCRN_ASG2));
 		count_left = mfdcr(DCRN_DMACT2);
 		break;
 	case 3:
-		sgl_addr = (ppc_sgl_t *) bus_to_virt(mfdcr(DCRN_ASG3));
+		sgl_addr = (ppc_sgl_t *) phys_to_virt(mfdcr(DCRN_ASG3));
 		count_left = mfdcr(DCRN_DMACT3);
 		break;
 	default:
@@ -307,54 +304,34 @@
 	}
 
 	if (!sgl_addr) {
-		printk("ppc4xx_get_dma_sgl_residue: sgl addr register is null\n");
-		goto error;
+		/* Last in list */
+		return count_left;
 	}
 
-	pnext = psgl->phead;
-	while (pnext &&
-	       ((unsigned) pnext < ((unsigned) psgl + SGL_LIST_SIZE) &&
-		(pnext != sgl_addr))
-	    ) {
-		pnext++;
-	}
-
-	if (pnext == sgl_addr) {	/* found the sgl descriptor */
-
-		*src_addr = pnext->src_addr;
-		*dst_addr = pnext->dst_addr;
-
-		/*
-		 * Now search the remaining descriptors and add their count.
-		 * We already have the remaining count from this descriptor in
-		 * count_left.
-		 */
-		pnext++;
-
-		while ((pnext != psgl->ptail) &&
-		       ((unsigned) pnext < ((unsigned) psgl + SGL_LIST_SIZE))
-		    ) {
-			count_left += pnext->control_count & SG_COUNT_MASK;
-		}
+	pnext = sgl_addr; /* sgl_addr is next to be loaded */
 
-		if (pnext != psgl->ptail) {	/* should never happen */
-			printk
-			    ("ppc4xx_get_dma_sgl_residue error (1) psgl->ptail 0x%x handle 
0x%x\n",
-			     (unsigned int) psgl->ptail, (unsigned int) handle);
-			goto error;
-		}
+	/*
+	 * Why this strange interface? return nothing or sgl_addr instead...
+	 * (please check for null pointers)
+	 */
+	*src_addr = pnext->src_addr;
+	*dst_addr = pnext->dst_addr;
 
-		/* success */
-		p_dma_ch = &dma_channels[psgl->dmanr];
-		return (count_left << p_dma_ch->shift);	/* count in bytes */
+	/*
+	 * Now search the remaining descriptors and add their count.
+	 * We already have the remaining count from this descriptor in
+	 * count_left.
+	 */
+		
+	while (pnext) {
+		count_left += pnext->control_count & SG_COUNT_MASK;
+		pnext = phys_to_virt(pnext->next);
+	}
 
-	} else {
-		/* this shouldn't happen */
-		printk
-		    ("get_dma_sgl_residue, unable to match current address 0x%x, handle 
0x%x\n",
-		     (unsigned int) sgl_addr, (unsigned int) handle);
 
-	}
+	/* success */
+	p_dma_ch = &dma_channels[psgl->dmanr];
+	return (count_left << p_dma_ch->shift);	/* count in bytes */
 
       error:
 	*src_addr = (phys_addr_t) NULL;
@@ -369,7 +346,7 @@
  *
  * This function should only be called when the DMA is not active.
  */
-static __inline__ int
+int
 ppc4xx_delete_dma_sgl_element(sgl_handle_t handle, phys_addr_t * 
src_dma_addr,
 			      phys_addr_t * dst_dma_addr)
 {
@@ -385,7 +362,7 @@
 	}
 
 	if (!psgl->phead) {
-		printk("ppc4xx_delete_sgl_element: sgl list empty\n");
+		/* printk("ppc4xx_delete_sgl_element: sgl list empty\n"); - not an error */
 		*src_dma_addr = (phys_addr_t) NULL;
 		*dst_dma_addr = (phys_addr_t) NULL;
 		return DMA_STATUS_SGL_LIST_EMPTY;
@@ -396,10 +373,13 @@
 
 	if (psgl->phead == psgl->ptail) {
 		/* last descriptor on the list */
+		kfree(psgl->phead);
 		psgl->phead = NULL;
 		psgl->ptail = NULL;
 	} else {
-		psgl->phead++;
+		ppc_sgl_t *next = phys_to_virt(psgl->phead->next);
+		kfree(psgl->phead);
+		psgl->phead = next;
 	}
 
 	return DMA_STATUS_GOOD;
@@ -411,12 +391,7 @@
  *   describes a scatter/gather list.
  *
  *   A handle is returned in "handle" which the driver should save in order 
to 
- *   be able to access this list later.  A chunk of memory will be allocated 
- *   to be used by the API for internal management purposes, including 
managing 
- *   the sg list and allocating memory for the sgl descriptors.  One page 
should 
- *   be more than enough for that purpose.  Perhaps it's a bit wasteful to 
use 
- *   a whole page for a single sg list, but most likely there will be only 
one 
- *   sg list per channel.
+ *   be able to access this list later.
  *
  *   Interrupt notes:
  *   Each sgl descriptor has a copy of the DMA control word which the DMA 
engine
@@ -433,15 +408,15 @@
  *   however, only the last descriptor will be setup to interrupt. Thus, an 
  *   interrupt will occur (if interrupts are enabled) only after the complete
  *   sgl transfer is done.
+ *   End of Transfer Interrupt needs to be enabled in all descriptors, since 
it
+ *   is impossible to know which one will be the last...
  */
 int
 ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned int mode, unsigned 
int dmanr)
 {
-	sgl_list_info_t *psgl;
-	dma_addr_t dma_addr;
+	sgl_list_info_t *psgl = NULL;
 	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
 	uint32_t sg_command;
-	void *ret;
 
 	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
 		printk("ppc4xx_alloc_dma_handle: invalid channel 0x%x\n", dmanr);
@@ -453,19 +428,15 @@
 		return DMA_STATUS_NULL_POINTER;
 	}
 
-	/* Get a page of memory, which is zeroed out by consistent_alloc() */
-	ret = consistent_alloc(GFP_KERNEL, DMA_PPC4xx_SIZE, &dma_addr);
-	if (ret != NULL) {
-		memset(ret, 0, DMA_PPC4xx_SIZE);
-		psgl = (sgl_list_info_t *) ret;
-	}
-
+	/* Get memory for the listinfo struct */
+	psgl = kmalloc(sizeof(sgl_list_info_t), GFP_KERNEL);
 	if (psgl == NULL) {
 		*phandle = (sgl_handle_t) NULL;
 		return DMA_STATUS_OUT_OF_MEMORY;
 	}
-
-	psgl->dma_addr = dma_addr;
+	memset(psgl, 0, sizeof(sgl_list_info_t));
+	
+	/* dma_addr is unused now */
 	psgl->dmanr = dmanr;
 
 	/*
@@ -479,7 +450,9 @@
 	psgl->control &= ~(DMA_TM_MASK | DMA_TD);
 	/* Save control word and mode */
 	psgl->control |= (mode | DMA_CE_ENABLE);
-
+	 /* PPC Errata? DMA else ignore count on first in list */
+	psgl->control |= SET_DMA_TCE(1);
+	
 	/* In MM mode, we must set ETD/TCE */
 	if (mode == DMA_MODE_MM)
 		psgl->control |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
@@ -514,13 +487,15 @@
 
 	/* Enable SGL control access */
 	mtdcr(DCRN_ASGC, sg_command);
-	psgl->sgl_control = SG_ERI_ENABLE | SG_LINK;
+	psgl->sgl_control = SG_LINK;
 
 	if (p_dma_ch->int_enable) {
 		if (p_dma_ch->tce_enable)
+		{	 
+			 /* reuse as Terminal Count Interrupt Enable on all descr. */
 			psgl->sgl_control |= SG_TCI_ENABLE;
-		else
-			psgl->sgl_control |= SG_ETI_ENABLE;
+		}
+		psgl->sgl_control |= SG_ERI_ENABLE | SG_ETI_ENABLE;
 	}
 
 	*phandle = (sgl_handle_t) psgl;
@@ -539,19 +514,19 @@
 	if (!handle) {
 		printk("ppc4xx_free_dma_handle: got NULL\n");
 		return;
-	} else if (psgl->phead) {
-		printk("ppc4xx_free_dma_handle: list not empty\n");
-		return;
-	} else if (!psgl->dma_addr) {	/* should never happen */
-		printk("ppc4xx_free_dma_handle: no dma address\n");
-		return;
+	} else if (psgl->phead) { /* free list here, why do it externaly? */
+		phys_addr_t dummy;
+		while (ppc4xx_delete_dma_sgl_element(handle, &dummy, &dummy) == 
DMA_STATUS_GOOD)
+			/* NOOP */;
+		/* printk("ppc4xx_free_dma_handle: list not empty\n"); */
 	}
 
-	consistent_free((void *) psgl);
+	kfree((void *) psgl);
 }
 
 EXPORT_SYMBOL(ppc4xx_alloc_dma_handle);
 EXPORT_SYMBOL(ppc4xx_free_dma_handle);
+EXPORT_SYMBOL(ppc4xx_set_sg_addr);
 EXPORT_SYMBOL(ppc4xx_add_dma_sgl);
 EXPORT_SYMBOL(ppc4xx_delete_dma_sgl_element);
 EXPORT_SYMBOL(ppc4xx_enable_dma_sgl);
--- linux-2.4.20_mvl31_AR2/include/asm-ppc/ppc4xx_dma.h.org	2005-07-12 
14:08:18.000000000 +0200
+++ linux-2.4.20_mvl31_AR2/include/asm-ppc/ppc4xx_dma.h	2005-07-27 
13:09:39.000000000 +0200
@@ -67,7 +67,7 @@
  * DMA Channel Control Registers
  */
 
-#ifdef CONFIG_44x
+#if defined(CONFIG_44x) && !defined(CONFIG_440EP)
 #define	PPC4xx_DMA_64BIT
 #define DMA_CR_OFFSET 1
 #else
@@ -183,9 +183,6 @@
 
 #ifdef CONFIG_PPC4xx_EDMA
 
-#define SGL_LIST_SIZE 4096
-#define DMA_PPC4xx_SIZE SGL_LIST_SIZE
-
 #define SET_DMA_PRIORITY(x)   (((x)&0x3)<<(6-DMA_CR_OFFSET))	/* DMA Channel 
Priority */
 #define DMA_PRIORITY_MASK SET_DMA_PRIORITY(3)
 #define PRIORITY_LOW           0
@@ -531,8 +528,8 @@
 #else
 typedef struct {
 	uint32_t control;
-	phys_addr_t src_addr;
-	phys_addr_t dst_addr;
+	uint32_t src_addr;
+	uint32_t dst_addr;
 	uint32_t control_count;
 	uint32_t next;
 } ppc_sgl_t;
@@ -567,6 +564,12 @@
 extern unsigned int ppc4xx_get_peripheral_width(unsigned int);
 extern int ppc4xx_alloc_dma_handle(sgl_handle_t *, unsigned int, unsigned 
int);
 extern void ppc4xx_free_dma_handle(sgl_handle_t);
+extern void ppc4xx_set_sg_addr(int dmanr, phys_addr_t sg_addr);
+extern int ppc4xx_add_dma_sgl(sgl_handle_t handle, phys_addr_t src_addr, 
phys_addr_t dst_addr,	unsigned int count);
+extern void ppc4xx_enable_dma_sgl(sgl_handle_t handle);
+extern void ppc4xx_disable_dma_sgl(sgl_handle_t handle);
+extern int ppc4xx_get_dma_sgl_residue(sgl_handle_t handle, phys_addr_t * 
src_addr, phys_addr_t * dst_addr);
+extern int ppc4xx_delete_dma_sgl_element(sgl_handle_t handle, phys_addr_t * 
src_dma_addr, phys_addr_t * dst_dma_addr);
 extern int ppc4xx_get_dma_status(void);
 extern void ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr);
 extern void ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr);
