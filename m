Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23ADE67C45
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 00:34:18 +1000 (EST)
Message-ID: <44EF0A61.3050205@cambridgebroadband.com>
Date: Fri, 25 Aug 2006 15:34:09 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Keinen Namen <GSM909@gmx.de>
Subject: Re: m8260_cpm_dpalloc -> m8260_cpm_dpfree ?
References: <20060825121947.88490@gmx.net>
In-Reply-To: <20060825121947.88490@gmx.net>
Content-Type: multipart/mixed; boundary="------------020407030202030601030003"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020407030202030601030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keinen Namen wrote:
> Hi
> 
> Simple Question, I allocate Memory for my BDs with m8260_cpm_dpalloc, but there are no dpfree in Linux 2.4.25. In Linux 2.6 are a funktion to free dp memory.
> 
> Are there no funktion in Linux 2.4 ? 
> 

I've implemented the free function for my own benefit.  See attached patch
which should work against ELDK 3.1

Alex


--------------020407030202030601030003
Content-Type: text/plain;
 name="patch-2006-08-25-m8260_cpm_dpfree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2006-08-25-m8260_cpm_dpfree"

Index: commproc.c
===================================================================
RCS file: /newcvs/pq2-linux/kernel/arch/ppc/8260_io/commproc.c,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- commproc.c	24 Aug 2005 12:05:13 -0000	1.1.1.1
+++ commproc.c	11 May 2006 13:14:31 -0000	1.3
@@ -29,12 +29,264 @@
 #include <asm/immap_8260.h>
 #include <asm/cpm_8260.h>
 
+#define DPFREE
+
+#ifdef DPFREE
+typedef struct	cpm_dpalloc_entry_s {
+	u_short				start_addr;
+    u_short             retloc;    /* This is start_addr + alignment offset: only valid in alloc list */
+	u_short				size;
+	struct	cpm_dpalloc_entry_s *	next_entr;
+} cpm_dpalloc_entry_t;
+
+static	void	cpm_dpalloc_init(void);
+static	void	cpm_dpalloc_data_init(cpm_dpalloc_entry_t  *);
+static	int	    cpm_dpalloc_cl(cpm_dpalloc_entry_t *);
+static	int  	cpm_dpalloc_rem(cpm_dpalloc_entry_t **, cpm_dpalloc_entry_t *);
+static	void	cpm_dpalloc_ins(cpm_dpalloc_entry_t **, cpm_dpalloc_entry_t *);
+# define CPM_DPALLOC_COUNT (CPM_DATAONLY_SIZE / sizeof(cbd_t) + 1)  
+/* Dynamic lists of allocated and free DPRAM */
+static	cpm_dpalloc_entry_t  *cpm_dpalloc_free;
+static	cpm_dpalloc_entry_t  *cpm_dpalloc_alloc;
+static	cpm_dpalloc_entry_t	cpm_dpalloc_list[CPM_DPALLOC_COUNT];
+#else
 static	uint	dp_alloc_base;	/* Starting offset in DP ram */
 static	uint	dp_alloc_top;	/* Max offset + 1 */
+#endif
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
 cpm8260_t	*cpmp;		/* Pointer to comm processor space */
 
+#ifdef DPFREE
+/* Initialize dynamic lists
+ */
+static void cpm_dpalloc_init(void)
+{
+	int i;
+
+	cpm_dpalloc_free = cpm_dpalloc_list;
+	cpm_dpalloc_free->start_addr = CPM_DATAONLY_BASE;
+	cpm_dpalloc_free->size = CPM_DATAONLY_SIZE;
+	cpm_dpalloc_free->next_entr = NULL;
+	cpm_dpalloc_alloc = NULL;
+
+	for(i = 1; i <= CPM_DPALLOC_COUNT; i++) {
+		cpm_dpalloc_data_init (cpm_dpalloc_list + i);
+	}
+}
+
+/* Initialize element in list of DPRAM
+ */
+static void cpm_dpalloc_data_init(cpm_dpalloc_entry_t * ptr)
+{
+	ptr->retloc = ptr->start_addr = 0;
+	ptr->size = 0;
+	ptr->next_entr = NULL;
+}
+
+static int cpm_dpalloc_cl(cpm_dpalloc_entry_t * head)
+{
+	cpm_dpalloc_entry_t	* curr;
+	cpm_dpalloc_entry_t	* next;
+	int			  retloc;
+
+	curr = head;
+	retloc = -1;
+
+	if (curr) {
+		retloc = 0;
+
+		while ((next = curr->next_entr)) {
+			if (curr->start_addr + curr->size == next->start_addr) {
+				curr->size = curr->size + next->size;
+				curr->next_entr = next->next_entr;
+				cpm_dpalloc_data_init(next);
+			} else {
+				curr = next;
+			}
+		 }
+	}
+
+	return retloc;
+}
+
+/* Remove element from dynamic list of DPRAM
+ */
+static int cpm_dpalloc_rem(cpm_dpalloc_entry_t ** head, cpm_dpalloc_entry_t * ptr)
+{
+	cpm_dpalloc_entry_t	* prev;
+	cpm_dpalloc_entry_t	* curr;
+	int			  retloc;
+
+	retloc = -1;
+	for (prev = NULL , curr = *head;
+	     curr != NULL && ptr != curr;
+	     prev = curr , curr = curr->next_entr)
+		/* EMPTY */ ;
+
+	if (curr) {
+		if (prev) {
+			prev->next_entr = curr->next_entr;
+		} else {
+			*head = curr->next_entr;
+		}
+		retloc = 0;
+	}
+
+	return retloc;
+}
+
+/* Insert element in dynamic list of DPRAM
+ */
+static void cpm_dpalloc_ins(cpm_dpalloc_entry_t ** head, cpm_dpalloc_entry_t * ptr)
+{
+	cpm_dpalloc_entry_t	* prev;
+	cpm_dpalloc_entry_t	* curr;
+
+	for (prev = NULL , curr = *head;
+	     curr != NULL && ptr->start_addr >= curr->start_addr;
+	     prev = curr , curr = curr->next_entr)
+		/* EMPTY */ ;
+
+	ptr->next_entr = curr;
+
+	if (prev) {
+		prev->next_entr = ptr;
+	} else {
+		*head = ptr;
+	}
+}
+/* Allocate some memory from the dual ported ram.  We may want to
+ * enforce alignment restrictions, but right now everyone is a good
+ * citizen.
+ */
+uint m8260_cpm_dpalloc(uint size, uint align)
+{
+    cpm_dpalloc_entry_t   * new_el;
+    cpm_dpalloc_entry_t   * p;
+    cpm_dpalloc_entry_t   * p1;
+    uint			retloc;
+    u_short			max;
+    unsigned long		flags;
+    int			i;
+    uint align_mask;
+    uint off;
+
+    size = (size + 7) & ~7;
+    align_mask = align - 1;
+    max = CPM_DATAONLY_SIZE;
+    retloc = CPM_DP_NOSPACE;
+    new_el = NULL;
+
+    if (size == 0) goto DONE;
+
+    save_flags(flags);
+    cli();
+
+    /* Find free area in DPRAM
+     */
+    for (p = cpm_dpalloc_free; p != NULL; p = p->next_entr) {
+        if (p->size <= max) {
+            off = ((p->start_addr + align_mask) & (~align_mask)) - p->start_addr;
+            if (p->size >= size + off) {
+                new_el = p;
+                max = p->size;
+                retloc = p->start_addr + off;
+            }
+        }
+    }
+
+    if (new_el == NULL) goto DONE1;
+
+    /* Insert new element in the list of allocated DPRAM
+     */
+    p1 = cpm_dpalloc_list;
+    p = NULL;
+    i = 0;
+    while (i < CPM_DPALLOC_COUNT) {
+        if (p1->start_addr == 0 && !p1->size && !p1->next_entr) {
+            p = p1;
+            break;
+        }
+        i ++;
+        p1 ++;
+    }
+
+    if (p == NULL) {
+        panic ("m8xx_cpm_dpalloc: INTERNAL ERROR\n");
+    }
+
+    off = retloc - new_el->start_addr;
+
+    p->start_addr = new_el->start_addr;
+    p->retloc = retloc;
+    p->size = size + off;
+
+    if (new_el->size >  (size+off)) {
+        new_el->size -= (size+off);
+        new_el->start_addr += (size+off);
+        cpm_dpalloc_ins(&cpm_dpalloc_alloc, p);
+    } else {
+        cpm_dpalloc_ins(&cpm_dpalloc_alloc, p);
+        i = cpm_dpalloc_rem(&cpm_dpalloc_free, new_el);
+
+        if ( i == -1) {
+            panic ("m8xx_cpm_dpalloc: INTERNAL ERROR\n");
+        }
+
+        cpm_dpalloc_data_init(new_el);
+    }
+
+ DONE1:
+    restore_flags(flags);
+ DONE:
+    return retloc;
+}
+
+int m8260_cpm_dpfree(uint retloc)
+{
+	cpm_dpalloc_entry_t   * r;
+	int			retval;
+	unsigned long		flags;
+
+	retval = -1;
+
+	if ((retloc < CPM_DATAONLY_BASE) ||
+	    (retloc > CPM_DATAONLY_SIZE + CPM_DATAONLY_BASE)) {
+		goto DONE;
+	}
+
+	save_flags(flags);
+	cli();
+
+	for (r = cpm_dpalloc_alloc;
+	     (r != NULL) && (r->retloc != retloc);
+	     r = r->next_entr)
+		/* EMPTY */ ;
+
+	if (r) {
+		retval = cpm_dpalloc_rem(&cpm_dpalloc_alloc, r);
+
+		if (retval == -1) {
+			panic("m8xx_cpm_dpfree: INTERNAL ERROR\n");
+		}
+		cpm_dpalloc_ins(&cpm_dpalloc_free, r);
+		retval = cpm_dpalloc_cl(cpm_dpalloc_free);
+
+		if (retval == -1) {
+			panic("m8xx_cpm_dpfree: INTERNAL ERROR\n");
+		}
+		retval = 0;
+	} else {
+	  printk(KERN_ERR "m8xx_cpm_dpfree: address not found in alloc list\n");
+	}
+
+	restore_flags(flags);
+DONE:
+	return retval;
+}
+#endif /* DPFREE */
+
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
@@ -50,11 +302,14 @@
 	immr = imp = (volatile immap_t *)IMAP_ADDR;
 	commproc = &imp->im_cpm;
 
+#ifdef DPFREE
+	cpm_dpalloc_init();
+#else
 	/* Reclaim the DP memory for our use.
 	*/
 	dp_alloc_base = CPM_DATAONLY_BASE;
 	dp_alloc_top = dp_alloc_base + CPM_DATAONLY_SIZE;
-
+#endif
 	/* Set the host page for allocation.
 	*/
 	host_buffer =
@@ -68,6 +323,7 @@
 	cpmp = (cpm8260_t *)commproc;
 }
 
+#ifndef DPFREE
 /* Allocate some memory from the dual ported ram.
  * To help protocols with object alignment restrictions, we do that
  * if they ask.
@@ -95,6 +351,12 @@
 
 	return(retloc);
 }
+int m8260_cpm_dpfree(uint start_addr)
+{
+    printk(KERN_ERR "%s() not implemented\n", __FUNCTION__);
+    return -1;
+}
+#endif /*ifndef DPFREE*/
 
 /* We also own one page of host buffer space for the allocation of
  * UART "fifos" and the like.

--------------020407030202030601030003--
