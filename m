Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id BE48CDDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:18:36 +1100 (EST)
Subject: [Fwd: [PATCH Repost] Add Uboot ASMP suport for MPC8641D]
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174508310.6595.486.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 21 Mar 2007 15:18:30 -0500
Cc: Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

As I indicated on IRC to you a few days ago, here is a copy
of the Asymmetric Multi-Processor support patch for 8641 HPCN.
For completeness and reference, the corresponding U-Boot patch
will be posted to the U-Boot list as well.

Thanks,
jdl

PS -- Apologies if this is a duplicate.  The first appears
        to have dropped out of the ether into /dev/null.




From: Haiying Wang <Haiying.Wang@freescale.com>
Subject: [PATCH] Add Uboot ASMP suport for MPC8641D
Date: Mon, 26 Feb 2007 15:51:27 -0500

1. Core1 low memeory translate mode is enabled, so both cores have private 256M byte memory.
2. Core0 kicks off core1 at the end of board_init_r. Both cores can run independently then.
3.TSEC1/2, Uart0, PCIe are assigned to core0 and TSEC3/4, Uart1 are assigned to core1.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Xianghua Xiao <X.Xiao@freescale.com>
---
 board/mpc8641hpcn/mpc8641hpcn.c |    6 ++++++
 common/ft_build.c               |   10 +++++++++-
 cpu/mpc86xx/interrupts.c        |    9 +++++++++
 cpu/mpc86xx/start.S             |   10 +++++++++-
 drivers/serial.c                |   29 +++++++++++++++++++++++++++++
 drivers/tsec.c                  |   17 +++++++++++++++++
 include/asm-ppc/global_data.h   |    3 +++
 include/configs/MPC8641HPCN.h   |   11 ++++++++++-
 lib_ppc/board.c                 |   31 +++++++++++++++++++++++++++++++
 net/eth.c                       |    9 +++++++++
 10 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/board/mpc8641hpcn/mpc8641hpcn.c b/board/mpc8641hpcn/mpc8641hpcn.c
index 1d67365..861130e 100644
--- a/board/mpc8641hpcn/mpc8641hpcn.c
+++ b/board/mpc8641hpcn/mpc8641hpcn.c
@@ -99,6 +99,12 @@ initdram(int board_type)
 {
 	long dram_size = 0;
 
+#ifdef CONFIG_ASMP
+	DECLARE_GLOBAL_DATA_PTR;
+	if (gd->pir == 1)
+		return CONFIG_ASMP_RAM_SIZE;
+#endif
+
 #if defined(CONFIG_SPD_EEPROM)
 	dram_size = spd_sdram();
 #else
diff --git a/common/ft_build.c b/common/ft_build.c
index 980e40f..679aaf1 100644
--- a/common/ft_build.c
+++ b/common/ft_build.c
@@ -522,10 +522,18 @@ void ft_setup(void *blob, bd_t * bd, ulong initrd_start, ulong initrd_end)
 		ft_prop_int(&cxt, "linux,initrd-start", initrd_start);
 		ft_prop_int(&cxt, "linux,initrd-end", initrd_end);
 	}
+
+#ifdef CONFIG_ASMP
+	DECLARE_GLOBAL_DATA_PTR;
+	if (gd->pir == 1)
+		ft_prop_str(&cxt, "linux, stdout-path", OF_STDOUT_CORE1_PATH);
+	else
+		ft_prop_str(&cxt, "linux, stdout-path", OF_STDOUT_PATH);
+#else
 #ifdef OF_STDOUT_PATH
 	ft_prop_str(&cxt, "linux,stdout-path", OF_STDOUT_PATH);
 #endif
-
+#endif
 	ft_end_node(&cxt);
 
 	ft_end_node(&cxt);	/* end root */
diff --git a/cpu/mpc86xx/interrupts.c b/cpu/mpc86xx/interrupts.c
index 49820bb..bf910cc 100644
--- a/cpu/mpc86xx/interrupts.c
+++ b/cpu/mpc86xx/interrupts.c
@@ -95,9 +95,18 @@ int interrupt_init(void)
 	 */
 	if ((get_svr() & 0xf0) == 0x20) {
 		volatile immap_t *immr = (immap_t *)CFG_IMMR;
+#ifdef CONFIG_ASMP
+		DECLARE_GLOBAL_DATA_PTR;
+		if (gd->pir == 0) {
+			immr->im_pic.gcr = MPC86xx_PICGCR_RST;
+			while (immr->im_pic.gcr & MPC86xx_PICGCR_RST);
+			immr->im_pic.gcr = MPC86xx_PICGCR_MODE;
+		}
+#else
 		immr->im_pic.gcr = MPC86xx_PICGCR_RST;
 		while (immr->im_pic.gcr & MPC86xx_PICGCR_RST);
 		immr->im_pic.gcr = MPC86xx_PICGCR_MODE;
+#endif
 	}
 
 	/* call cpu specific function from $(CPU)/interrupts.c */
diff --git a/cpu/mpc86xx/start.S b/cpu/mpc86xx/start.S
index 2b0f0be..9f7e361 100644
--- a/cpu/mpc86xx/start.S
+++ b/cpu/mpc86xx/start.S
@@ -192,8 +192,10 @@ boot_warm:
 	mtspr	PIR, r0
 	beq	1f
 
+#if !defined(CONFIG_ASMP)
 	bl	secondary_cpu_setup
 #endif
+#endif
 
 	/* disable everything */
 1:	li	r0, 0
@@ -236,6 +238,12 @@ in_flash:
 	bl	setup_bats
 	sync
 
+#ifdef CONFIG_ASMP
+	mfspr   r0, PIR
+	cmpwi   r0, 0
+	bne     2f
+#endif
+
 #if (CFG_CCSRBAR_DEFAULT != CFG_CCSRBAR)
 	/* setup ccsrbar */
 	bl	setup_ccsrbar
@@ -312,7 +320,7 @@ in_flash:
 	 */
 
 	/* enable address translation */
-	bl	enable_addr_trans
+2:	bl	enable_addr_trans
 	sync
 
 	/* enable and invalidate the data cache */
diff --git a/drivers/serial.c b/drivers/serial.c
index 76425d8..15cf0ae 100644
--- a/drivers/serial.c
+++ b/drivers/serial.c
@@ -153,6 +153,11 @@ int serial_init (void)
 {
 	int clock_divisor;
 
+#ifdef CONFIG_ASMP
+	if (gd->pir ==1)
+		return 0;
+#endif
+
 #ifdef CFG_NS87308
 	initialise_ns87308();
 #endif
@@ -233,7 +238,11 @@ serial_putc_dev(unsigned int dev_index,const char c)
 void
 serial_putc(const char c)
 {
+#ifdef CONFIG_ASMP
+	_serial_putc(c,CONFIG_CONS_INDEX + gd->pir);
+#else
 	_serial_putc(c,CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
@@ -247,7 +256,11 @@ serial_putc_raw_dev(unsigned int dev_index,const char c)
 void
 serial_putc_raw(const char c)
 {
+#ifdef CONFIG_ASMP
+	_serial_putc_raw(c,CONFIG_CONS_INDEX + gd->pir);
+#else
 	_serial_putc_raw(c,CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
@@ -261,7 +274,11 @@ serial_puts_dev(unsigned int dev_index,const char *s)
 void
 serial_puts(const char *s)
 {
+#ifdef CONFIG_ASMP
+	_serial_puts(s,CONFIG_CONS_INDEX + gd->pir);
+#else
 	_serial_puts(s,CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
@@ -275,7 +292,11 @@ serial_getc_dev(unsigned int dev_index)
 int
 serial_getc(void)
 {
+#ifdef CONFIG_ASMP
+	return _serial_getc(CONFIG_CONS_INDEX + gd->pir);
+#else
 	return _serial_getc(CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
@@ -289,7 +310,11 @@ serial_tstc_dev(unsigned int dev_index)
 int
 serial_tstc(void)
 {
+#ifdef CONFIG_ASMP
+	return _serial_tstc(CONFIG_CONS_INDEX + gd->pir);
+#else
 	return _serial_tstc(CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
@@ -303,7 +328,11 @@ serial_setbrg_dev(unsigned int dev_index)
 void
 serial_setbrg(void)
 {
+#ifdef CONFIG_ASMP
+	_serial_setbrg(CONFIG_CONS_INDEX + gd->pir);
+#else
 	_serial_setbrg(CONFIG_CONS_INDEX);
+#endif
 }
 #endif
 
diff --git a/drivers/tsec.c b/drivers/tsec.c
index 8edfc8c..0be3bf7 100644
--- a/drivers/tsec.c
+++ b/drivers/tsec.c
@@ -683,6 +683,18 @@ static void startup_tsec(struct eth_device *dev)
 	struct tsec_private *priv = (struct tsec_private *)dev->priv;
 	volatile tsec_t *regs = priv->regs;
 
+#ifdef CONFIG_ASMP
+	/* Point to the buffer descriptors */
+	regs->tbase = (unsigned int)(&rtx.txbd[txIdx]) + 0x10000000 * gd->pir;
+	regs->rbase = (unsigned int)(&rtx.rxbd[rxIdx]) + 0x10000000 * gd->pir;
+
+	/* Initialize the Rx Buffer descriptors */
+	for (i = 0; i < PKTBUFSRX; i++) {
+		rtx.rxbd[i].status = RXBD_EMPTY;
+		rtx.rxbd[i].length = 0;
+		rtx.rxbd[i].bufPtr = (uint) NetRxPackets[i] + 0x10000000 * gd->pir;
+	}
+#else
 	/* Point to the buffer descriptors */
 	regs->tbase = (unsigned int)(&rtx.txbd[txIdx]);
 	regs->rbase = (unsigned int)(&rtx.rxbd[rxIdx]);
@@ -693,6 +705,7 @@ static void startup_tsec(struct eth_device *dev)
 		rtx.rxbd[i].length = 0;
 		rtx.rxbd[i].bufPtr = (uint) NetRxPackets[i];
 	}
+#endif
 	rtx.rxbd[PKTBUFSRX - 1].status |= RXBD_WRAP;
 
 	/* Initialize the TX Buffer Descriptors */
@@ -737,7 +750,11 @@ static int tsec_send(struct eth_device *dev, volatile void *packet, int length)
 		}
 	}
 
+#ifdef CONFIG_ASMP
+	rtx.txbd[txIdx].bufPtr = (uint) packet + 0x10000000 * gd->pir;
+#else
 	rtx.txbd[txIdx].bufPtr = (uint) packet;
+#endif
 	rtx.txbd[txIdx].length = length;
 	rtx.txbd[txIdx].status |=
 	    (TXBD_READY | TXBD_LAST | TXBD_CRC | TXBD_INTERRUPT);
diff --git a/include/asm-ppc/global_data.h b/include/asm-ppc/global_data.h
index 8bc61b6..e2d003b 100644
--- a/include/asm-ppc/global_data.h
+++ b/include/asm-ppc/global_data.h
@@ -127,6 +127,9 @@ typedef	struct	global_data {
 #ifdef CONFIG_LWMON
 	unsigned long kbd_status;
 #endif
+#ifdef CONFIG_ASMP
+	unsigned long   pir;
+#endif
 	void		**jt;		/* jump table */
 } gd_t;
 
diff --git a/include/configs/MPC8641HPCN.h b/include/configs/MPC8641HPCN.h
index f663d72..018da3e 100644
--- a/include/configs/MPC8641HPCN.h
+++ b/include/configs/MPC8641HPCN.h
@@ -46,7 +46,12 @@
 
 #define CFG_RESET_ADDRESS    0xfff00100
 
-/*#undef CONFIG_PCI*/
+#define CONFIG_ASMP
+#ifdef CONFIG_ASMP
+#define CONFIG_ASMP_RAM_SIZE    0x10000000
+#define OF_STDOUT_CORE1_PATH   "/soc8641@f8000000/serial@4600"
+#endif
+
 #define CONFIG_PCI
 
 #define CONFIG_TSEC_ENET 		/* tsec ethernet support */
@@ -397,7 +402,11 @@
  * 0x0000_0000  2G     DDR
  */
 #define CFG_DBAT0L      (BATL_PP_RW | BATL_MEMCOHERENCE)
+#ifdef CONFIG_ASMP
+#define CFG_DBAT0U      (BATU_BL_512M | BATU_VS | BATU_VP)
+#else
 #define CFG_DBAT0U      (BATU_BL_2G | BATU_VS | BATU_VP)
+#endif
 #define CFG_IBAT0L      (BATL_PP_RW | BATL_MEMCOHERENCE )
 #define CFG_IBAT0U      CFG_DBAT0U
 
diff --git a/lib_ppc/board.c b/lib_ppc/board.c
index 24e8e97..c517390 100644
--- a/lib_ppc/board.c
+++ b/lib_ppc/board.c
@@ -71,6 +71,10 @@
 #ifdef CONFIG_PS2KBD
 #include <keyboard.h>
 #endif
+#ifdef CONFIG_ASMP
+#include <asm/processor.h>
+#include <asm/io.h>
+#endif
 
 #ifdef CFG_UPDATE_FLASH_SIZE
 extern int update_flash_size (int flash_size);
@@ -223,6 +227,9 @@ static int init_func_ram (void)
 	puts ("DRAM:  ");
 
 	if ((gd->ram_size = initdram (board_type)) > 0) {
+#ifdef CONFIG_ASMP
+		gd->ram_size = CONFIG_ASMP_RAM_SIZE;
+#endif
 		print_size (gd->ram_size, "");
 #ifdef CONFIG_ADD_RAM_INFO
 		board_add_ram_info(0);
@@ -385,6 +392,10 @@ void board_init_f (ulong bootflag)
 	memset ((void *) gd, 0, sizeof (gd_t));
 #endif
 
+#ifdef CONFIG_ASMP
+	gd->pir = mfspr(PIR);
+#endif
+
 	for (init_fnc_ptr = init_sequence; *init_fnc_ptr; ++init_fnc_ptr) {
 		if ((*init_fnc_ptr) () != 0) {
 			hang ();
@@ -907,11 +918,16 @@ void board_init_r (gd_t *id, ulong dest_addr)
 	WATCHDOG_RESET ();
 
 #if defined(CONFIG_PCI) && !defined(CONFIG_BAB7xx) && !defined(CONFIG_CPC45)
+#ifdef CONFIG_ASMP
+	if (gd->pir == 0)
+		pci_init();
+#else
 	/*
 	 * Do pci configuration
 	 */
 	pci_init ();
 #endif
+#endif
 
 /** leave this here (after malloc(), environment and PCI are working) **/
 	/* Initialize devices */
@@ -984,10 +1000,17 @@ void board_init_r (gd_t *id, ulong dest_addr)
 	WATCHDOG_RESET ();
 
 #if (CONFIG_COMMANDS & CFG_CMD_SCSI)
+#ifdef CONFIG_ASMP
+	if (gd->pir == 0)
+		WATCHDOG_RESET ();
+		puts ("SCSI:  ");
+		scsi_init ();
+#else
 	WATCHDOG_RESET ();
 	puts ("SCSI:  ");
 	scsi_init ();
 #endif
+#endif
 
 #if (CONFIG_COMMANDS & CFG_CMD_DOC)
 	WATCHDOG_RESET ();
@@ -1104,6 +1127,14 @@ void board_init_r (gd_t *id, ulong dest_addr)
  }
 #endif
 
+#ifdef CONFIG_ASMP
+	volatile immap_t    *immap = (immap_t *)CFG_IMMR;
+	volatile ccsr_local_mcm_t *mcm = &immap->im_local_mcm;
+	if(gd->pir == 0)
+		/* kick off core1 */
+		mcm->pcr |= 1 << (1 + 24);
+#endif
+
 	/* Initialization complete - start the monitor */
 
 	/* main_loop() can return to retry autoboot, if so just run it again. */
diff --git a/net/eth.c b/net/eth.c
index cca9392..964c5ef 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -200,6 +200,14 @@ int eth_initialize(bd_t *bis)
 #if defined(CONFIG_UEC_ETH2)
 	uec_initialize(1);
 #endif
+#ifdef CONFIG_ASMP
+	DECLARE_GLOBAL_DATA_PTR;
+	char tsec_name[10];
+	for (i = 0; i < 2; i++) {
+		sprintf(tsec_name, "eTSEC%d", (gd->pir * 2 + 1 + i));
+		tsec_initialize(bis, (gd->pir * 2 + i), tsec_name);
+	}
+#else
 #if defined(CONFIG_MPC86XX_TSEC1)
        tsec_initialize(bis, 0, CONFIG_MPC86XX_TSEC1_NAME);
 #endif
@@ -215,6 +223,7 @@ int eth_initialize(bd_t *bis)
 #if defined(CONFIG_MPC86XX_TSEC4)
        tsec_initialize(bis, 3, CONFIG_MPC86XX_TSEC4_NAME);
 #endif
+#endif
 
 #if defined(FEC_ENET) || defined(CONFIG_ETHER_ON_FCC)
 	fec_initialize(bis);
