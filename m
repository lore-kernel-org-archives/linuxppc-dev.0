Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BD8E67D5B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:20:57 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 5/6] [RFC] POWERPC cpm2: get rid of remapping the whole immr
Date: Sat, 12 Aug 2006 04:10:23 +0400
Message-Id: <20060812001022.6186.33609.stgit@localhost.localdomain>
In-Reply-To: <20060812000655.6186.42738.stgit@localhost.localdomain>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The stuff below cleans up the code attempting to remap the whole cpm2_immr
early, as well as places happily assuming that fact. This is more like the 2.4
legacy stuff, and is at least confusing and unclear now.

To keep the world comfortable, a new mechanism is introduced: before accessing
specific immr register/register set, one needs to map it, using cpm2_map(<reg>),
for instance, access to CPM command register will look like
	volatile cpm_cpm2_t *cp = cpm2_map(im_cpm);
keeping the code clear, yet without "already defined somewhere" cpm2_immr.

So far, unmapping code is not implemented, but it's not a big deal to add it, 
if the whole idea makes sense.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/sysdev/cpm2_common.c       |   19 +++--
 arch/powerpc/sysdev/cpm2_pic.c          |   28 +++----
 arch/powerpc/sysdev/cpm2_pic.h          |    2 
 arch/powerpc/sysdev/fsl_soc.c           |    2 
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |  130 +++++++++++++++++++++----------
 drivers/serial/cpm_uart/cpm_uart_cpm2.h |    2 
 include/asm-powerpc/fs_pd.h             |   18 ++++
 include/asm-ppc/cpm2.h                  |    4 +
 include/asm-ppc/fs_pd.h                 |    4 +
 9 files changed, 145 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 1161970..ea1a7bf 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -44,6 +44,7 @@ cpm_cpm2_t	*cpmp;		/* Pointer to comm pr
  * the communication processor devices.
  */
 cpm2_map_t *cpm2_immr;
+intctl_cpm2_t *cpm2_intctl;
 
 #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
 					   of space for CPM as it is larger
@@ -53,6 +54,7 @@ void
 cpm2_reset(void)
 {
 	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+	cpm2_intctl = cpm2_map(im_intctl);
 
 	/* Reclaim the DP memory for our use.
 	 */
@@ -87,14 +89,16 @@ cpm_setbrg(uint brg, uint rate)
 	/* This is good enough to get SMCs running.....
 	*/
 	if (brg < 4) {
-		bp = (uint *)&cpm2_immr->im_brgc1;
+		bp = cpm2_map_size(im_brgc1, 16);
 	}
 	else {
-		bp = (uint *)&cpm2_immr->im_brgc5;
+		bp = cpm2_map_size(im_brgc5, 16);
 		brg -= 4;
 	}
 	bp += brg;
 	*bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
+
+	cpm2_unmap(bp);
 }
 
 /* This function is used to set high speed synchronous baud rate
@@ -106,16 +110,18 @@ cpm2_fastbrg(uint brg, uint rate, int di
 	volatile uint	*bp;
 
 	if (brg < 4) {
-		bp = (uint *)&cpm2_immr->im_brgc1;
+		bp = cpm2_map_size(im_brgc1, 16);
 	}
 	else {
-		bp = (uint *)&cpm2_immr->im_brgc5;
+		bp = cpm2_map_size(im_brgc5, 16);
 		brg -= 4;
 	}
 	bp += brg;
 	*bp = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
 	if (div16)
 		*bp |= CPM_BRG_DIV16;
+
+	cpm2_unmap(bp);
 }
 
 /*
@@ -126,11 +132,14 @@ static spinlock_t cpm_dpmem_lock;
  * until the memory subsystem goes up... */
 static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
+static u8* im_dprambase;
 
 static void cpm2_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
+	im_dprambase = ioremap(CPM_MAP_ADDR, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
+
 	/* initialize the info header */
 	rh_init(&cpm_dpmem_info, 1,
 			sizeof(cpm_boot_dpmem_rh_block) /
@@ -199,6 +208,6 @@ EXPORT_SYMBOL(cpm_dpdump);
 
 void *cpm_dpram_addr(uint offset)
 {
-	return (void *)&cpm2_immr->im_dprambase[offset];
+	return (void *)(im_dprambase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index ec9df31..845a08b 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -76,7 +76,7 @@ static void cpm2_mask_irq(unsigned int i
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_immr->im_intctl.ic_simrh);
+	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 }
@@ -91,7 +91,7 @@ static void cpm2_unmask_irq(unsigned int
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_immr->im_intctl.ic_simrh);
+	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] |= 1 << bit;
 	simr[word] = ppc_cached_irq_mask[word];
 }
@@ -106,8 +106,8 @@ static void cpm2_mask_and_ack(unsigned i
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
+	simr = &(cpm2_intctl->ic_simrh);
+	sipnr = &(cpm2_intctl->ic_sipnrh);
 	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 	sipnr[word] = 1 << bit;
@@ -125,7 +125,7 @@ static void cpm2_end_irq(unsigned int ir
 		bit = irq_to_siubit[irq_nr];
 		word = irq_to_siureg[irq_nr];
 
-		simr = &(cpm2_immr->im_intctl.ic_simrh);
+		simr = &(cpm2_intctl->ic_simrh);
 		ppc_cached_irq_mask[word] |= 1 << bit;
 		simr[word] = ppc_cached_irq_mask[word];
 		/*
@@ -152,7 +152,7 @@ int cpm2_get_irq(struct pt_regs *regs)
 
         /* For CPM2, read the SIVEC register and shift the bits down
          * to get the irq number.         */
-        bits = cpm2_immr->im_intctl.ic_sivec;
+        bits = cpm2_intctl->ic_sivec;
         irq = bits >> 26;
 
 	if (irq == 0)
@@ -223,26 +223,26 @@ void cpm2_pic_init(struct device_node *n
 
 	/* Mask out everything */
 
-	cpm2_immr->im_intctl.ic_simrh = 0x00000000;
-	cpm2_immr->im_intctl.ic_simrl = 0x00000000;
+	cpm2_intctl->ic_simrh = 0x00000000;
+	cpm2_intctl->ic_simrl = 0x00000000;
 
 	wmb();
 
 	/* Ack everything */
-	cpm2_immr->im_intctl.ic_sipnrh = 0xffffffff;
-	cpm2_immr->im_intctl.ic_sipnrl = 0xffffffff;
+	cpm2_intctl->ic_sipnrh = 0xffffffff;
+	cpm2_intctl->ic_sipnrl = 0xffffffff;
 	wmb();
 
 	/* Dummy read of the vector */
-	i = cpm2_immr->im_intctl.ic_sivec;
+	i = cpm2_intctl->ic_sivec;
 	rmb();
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
 	 */
-	cpm2_immr->im_intctl.ic_sicr = 0;
-	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
-	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
+	cpm2_intctl->ic_sicr = 0;
+	cpm2_intctl->ic_scprrh = 0x05309770;
+	cpm2_intctl->ic_scprrl = 0x05309770;
 
 	/* create a legacy host */
 	if (node)
diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
index 436cca7..d63e45d 100644
--- a/arch/powerpc/sysdev/cpm2_pic.h
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -1,6 +1,8 @@
 #ifndef _PPC_KERNEL_CPM2_H
 #define _PPC_KERNEL_CPM2_H
 
+extern intctl_cpm2_t *cpm2_intctl;
+
 extern int cpm2_get_irq(struct pt_regs *regs);
 
 extern void cpm2_pic_init(struct device_node*);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7f4ed40..cff9bf7 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -622,7 +622,7 @@ static int __init fs_enet_of_init(void)
 		if (strstr(model, "FCC")) {
 			int fcc_index = fs_get_fcc_index(*id);
 
-			fs_enet_data.dpram_offset = (u32)cpm2_immr->im_dprambase;
+			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
 			fs_enet_data.tx_ring = 32;
 			fs_enet_data.rx_copybreak = 240;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 02b9ef9..b691d3e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -51,8 +51,9 @@ #include "cpm_uart.h"
 
 void cpm_line_cr_cmd(int line, int cmd)
 {
-	volatile cpm_cpm2_t *cp = cpmp;
 	ulong val;
+	volatile cpm_cpm2_t *cp = cpm2_map(im_cpm);
+
 
 	switch (line) {
 	case UART_SMC1:
@@ -85,11 +86,14 @@ void cpm_line_cr_cmd(int line, int cmd)
 	}
 	cp->cp_cpcr = val;
 	while (cp->cp_cpcr & CPM_CR_FLG) ;
+
+	cpm2_unmap(cp);
 }
 
 void smc1_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
 
 	/* SMC1 is only on port D */
 	io->iop_ppard |= 0x00c00000;
@@ -98,13 +102,17 @@ void smc1_lineif(struct uart_cpm_port *p
 	io->iop_psord &= ~0x00c00000;
 
 	/* Wire BRG1 to SMC1 */
-	cpm2_immr->im_cpmux.cmx_smr &= 0x0f;
+	cpmux->cmx_smr &= 0x0f;
 	pinfo->brg = 1;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
 
 	/* SMC2 is only on port A */
 	io->iop_ppara |= 0x00c00000;
@@ -113,13 +121,17 @@ void smc2_lineif(struct uart_cpm_port *p
 	io->iop_psora &= ~0x00c00000;
 
 	/* Wire BRG2 to SMC2 */
-	cpm2_immr->im_cpmux.cmx_smr &= 0xf0;
+	cpmux->cmx_smr &= 0xf0;
 	pinfo->brg = 2;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 void scc1_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
 
 	/* Use Port D for SCC1 instead of other functions.  */
 	io->iop_ppard |= 0x00000003;
@@ -129,9 +141,12 @@ void scc1_lineif(struct uart_cpm_port *p
 	io->iop_pdird |= 0x00000002;	/* Tx */
 
 	/* Wire BRG1 to SCC1 */
-	cpm2_immr->im_cpmux.cmx_scr &= 0x00ffffff;
-	cpm2_immr->im_cpmux.cmx_scr |= 0x00000000;
+	cpmux->cmx_scr &= 0x00ffffff;
+	cpmux->cmx_scr |= 0x00000000;
 	pinfo->brg = 1;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 void scc2_lineif(struct uart_cpm_port *pinfo)
@@ -144,43 +159,57 @@ void scc2_lineif(struct uart_cpm_port *p
 	 * be supported in a sane fashion.
 	 */
 #ifndef CONFIG_STX_GP3
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
+
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
 #endif
-	cpm2_immr->im_cpmux.cmx_scr &= 0xff00ffff;
-	cpm2_immr->im_cpmux.cmx_scr |= 0x00090000;
+	cpmux->cmx_scr &= 0xff00ffff;
+	cpmux->cmx_scr |= 0x00090000;
 	pinfo->brg = 2;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 void scc3_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
+
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
-	cpm2_immr->im_cpmux.cmx_scr &= 0xffff00ff;
-	cpm2_immr->im_cpmux.cmx_scr |= 0x00001200;
+	cpmux->cmx_scr &= 0xffff00ff;
+	cpmux->cmx_scr |= 0x00001200;
 	pinfo->brg = 3;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 void scc4_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
 
 	io->iop_ppard |= 0x00000600;
 	io->iop_psord &= ~0x00000600;	/* Tx/Rx */
 	io->iop_pdird &= ~0x00000200;	/* Rx */
 	io->iop_pdird |= 0x00000400;	/* Tx */
 
-	cpm2_immr->im_cpmux.cmx_scr &= 0xffffff00;
-	cpm2_immr->im_cpmux.cmx_scr |= 0x0000001b;
+	cpmux->cmx_scr &= 0xffffff00;
+	cpmux->cmx_scr |= 0x0000001b;
 	pinfo->brg = 4;
+
+	cpm2_unmap(cpmux);
+	cpm2_unmap(io);
 }
 
 /*
@@ -255,16 +284,23 @@ void cpm_uart_freebuf(struct uart_cpm_po
 /* Setup any dynamic params in the uart desc */
 int cpm_uart_init_portdesc(void)
 {
+#if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
+	u32 addr;
+#endif
 	pr_debug("CPM uart[-]:init portdesc\n");
 
 	cpm_uart_nr = 0;
 #ifdef CONFIG_SERIAL_CPM_SMC1
-	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) & cpm2_immr->im_smc[0];
-	cpm_uart_ports[UART_SMC1].smcup =
-	    (smc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SMC1];
-	*(u16 *)(&cpm2_immr->im_dprambase[PROFF_SMC1_BASE]) = PROFF_SMC1;
+	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) cpm2_map(im_smc[0]);
 	cpm_uart_ports[UART_SMC1].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_smc[0];
+	    (unsigned long)cpm_uart_ports[UART_SMC1].smcp;
+
+	cpm_uart_ports[UART_SMC1].smcup =
+	    (smc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SMC1], PROFF_SMC_SIZE);
+	addr = (u16 *)cpm2_map_size(im_dprambase[PROFF_SMC1_BASE], 2);
+	*addr = PROFF_SMC1;
+	cpm2_unmap(addr);
+
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
@@ -272,12 +308,16 @@ #ifdef CONFIG_SERIAL_CPM_SMC1
 #endif
 
 #ifdef CONFIG_SERIAL_CPM_SMC2
-	cpm_uart_ports[UART_SMC2].smcp = (smc_t *) & cpm2_immr->im_smc[1];
-	cpm_uart_ports[UART_SMC2].smcup =
-	    (smc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SMC2];
-	*(u16 *)(&cpm2_immr->im_dprambase[PROFF_SMC2_BASE]) = PROFF_SMC2;
+	cpm_uart_ports[UART_SMC2].smcp = (smc_t *) cpm2_map(im_smc[1]);
 	cpm_uart_ports[UART_SMC2].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_smc[1];
+	    (unsigned long)cpm_uart_ports[UART_SMC2].smcp;
+
+	cpm_uart_ports[UART_SMC2].smcup =
+	    (smc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SMC2], PROFF_SMC_SIZE);
+	addr = (u16 *)cpm2_map_size(im_dprambase[PROFF_SMC2_BASE], 2);
+	*addr = PROFF_SMC2;
+	cpm2_unmap(addr);
+
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
@@ -285,11 +325,12 @@ #ifdef CONFIG_SERIAL_CPM_SMC2
 #endif
 
 #ifdef CONFIG_SERIAL_CPM_SCC1
-	cpm_uart_ports[UART_SCC1].sccp = (scc_t *) & cpm2_immr->im_scc[0];
-	cpm_uart_ports[UART_SCC1].sccup =
-	    (scc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SCC1];
+	cpm_uart_ports[UART_SCC1].sccp = (scc_t *) cpm2_map(im_scc[0]);
 	cpm_uart_ports[UART_SCC1].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_scc[0];
+	    (unsigned long)cpm_uart_ports[UART_SCC1].sccp;
+	cpm_uart_ports[UART_SCC1].sccup =
+	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC1], PROFF_SCC_SIZE);
+
 	cpm_uart_ports[UART_SCC1].sccp->scc_sccm &=
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
@@ -299,11 +340,12 @@ #ifdef CONFIG_SERIAL_CPM_SCC1
 #endif
 
 #ifdef CONFIG_SERIAL_CPM_SCC2
-	cpm_uart_ports[UART_SCC2].sccp = (scc_t *) & cpm2_immr->im_scc[1];
-	cpm_uart_ports[UART_SCC2].sccup =
-	    (scc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SCC2];
+	cpm_uart_ports[UART_SCC2].sccp = (scc_t *) cpm2_map(im_scc[1]);
 	cpm_uart_ports[UART_SCC2].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_scc[1];
+	    (unsigned long)cpm_uart_ports[UART_SCC2].sccp;
+	cpm_uart_ports[UART_SCC2].sccup =
+	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC2], PROFF_SCC_SIZE);
+
 	cpm_uart_ports[UART_SCC2].sccp->scc_sccm &=
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
@@ -313,11 +355,12 @@ #ifdef CONFIG_SERIAL_CPM_SCC2
 #endif
 
 #ifdef CONFIG_SERIAL_CPM_SCC3
-	cpm_uart_ports[UART_SCC3].sccp = (scc_t *) & cpm2_immr->im_scc[2];
-	cpm_uart_ports[UART_SCC3].sccup =
-	    (scc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SCC3];
+	cpm_uart_ports[UART_SCC3].sccp = (scc_t *) cpm2_map(im_scc[2]);
 	cpm_uart_ports[UART_SCC3].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_scc[2];
+	    (unsigned long)cpm_uart_ports[UART_SCC3].sccp;
+	cpm_uart_ports[UART_SCC3].sccup =
+	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC3], PROFF_SCC_SIZE);
+
 	cpm_uart_ports[UART_SCC3].sccp->scc_sccm &=
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
@@ -327,11 +370,12 @@ #ifdef CONFIG_SERIAL_CPM_SCC3
 #endif
 
 #ifdef CONFIG_SERIAL_CPM_SCC4
-	cpm_uart_ports[UART_SCC4].sccp = (scc_t *) & cpm2_immr->im_scc[3];
-	cpm_uart_ports[UART_SCC4].sccup =
-	    (scc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SCC4];
+	cpm_uart_ports[UART_SCC4].sccp = (scc_t *) cpm2_map(im_scc[3]);
 	cpm_uart_ports[UART_SCC4].port.mapbase =
-	    (unsigned long)&cpm2_immr->im_scc[3];
+	    (unsigned long)cpm_uart_ports[UART_SCC4].sccp;
+	cpm_uart_ports[UART_SCC4].sccup =
+	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC4], PROFF_SCC_SIZE);
+
 	cpm_uart_ports[UART_SCC4].sccp->scc_sccm &=
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index 4793fec..a663300 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -40,6 +40,6 @@ static inline void cpm_set_smc_fcr(volat
 	up->smc_tfcr = CPMFCR_GBL | CPMFCR_EB;
 }
 
-#define DPRAM_BASE	((unsigned char *)&cpm2_immr->im_dprambase[0])
+#define DPRAM_BASE	((unsigned char *)cpm_dpram_addr(0))
 
 #endif
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index d530f68..3d0e819 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -11,6 +11,7 @@
 
 #ifndef FS_PD_H
 #define FS_PD_H
+#include <asm/cpm2.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/time.h>
 
@@ -24,4 +25,21 @@ static inline int uart_clock(void)
         return ppc_proc_freq;
 }
 
+#define cpm2_map(member)						\
+({									\
+	u32 offset = offsetof(cpm2_map_t, member);			\
+	void *addr = ioremap (CPM_MAP_ADDR + offset,			\
+			      sizeof( ((cpm2_map_t*)0)->member));	\
+	addr;								\
+})
+
+#define cpm2_map_size(member, size)					\
+({									\
+	u32 offset = offsetof(cpm2_map_t, member);			\
+	void *addr = ioremap (CPM_MAP_ADDR + offset, size);		\
+	addr;								\
+})
+
+#define cpm2_unmap(addr)	iounmap(addr)
+
 #endif
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 876974e..bd6623a 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -177,6 +177,10 @@ #define PROFF_RAND		((uint)0x8af8)
 #define PROFF_I2C_BASE		((uint)0x8afc)
 #define PROFF_IDMA4_BASE	((uint)0x8afe)
 
+#define PROFF_SCC_SIZE		((uint)0x100)
+#define PROFF_FCC_SIZE		((uint)0x100)
+#define PROFF_SMC_SIZE		((uint)64)
+
 /* The SMCs are relocated to any of the first eight DPRAM pages.
  * We will fix these at the first locations of DPRAM, until we
  * get some microcode patches :-).
diff --git a/include/asm-ppc/fs_pd.h b/include/asm-ppc/fs_pd.h
index eed7778..8691327 100644
--- a/include/asm-ppc/fs_pd.h
+++ b/include/asm-ppc/fs_pd.h
@@ -29,4 +29,8 @@ static inline int uart_clock(void)
 	return (((bd_t *) __res)->bi_intfreq);
 }
 
+#define cpm2_map(member)	(&cpm2_immr->member)
+#define cpm2_map_size(member, size)	(&cpm2_immr->member)
+#define cpm2_unmap(addr)        do {} while(0)
+
 #endif
