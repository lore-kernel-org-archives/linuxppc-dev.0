From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 17 Aug 2004 11:49:06 +0200
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-20894
Subject: Re: MPC82xx enet on SCC3
Cc: Dan Malek <dan@embeddededge.com>
Message-ID: <4121F0B2.31001.D95ECA@localhost>
In-reply-to: <B97F656A-EFB0-11D8-A698-003065F9B7DC@embeddededge.com>
References: <4120DA20.2984.1BD2DC2@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Message-Boundary-20894
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

From:           	Dan Malek <dan@embeddededge.com>
>
> Apologies, I had FCC on the brain.
>
never mind

> > I have modified arch/ppc/config.in and arch/ppc/8260_io/enet.c so
> > that it fits to SCC1-4 w/o further modifications there.
The idea is to have some board specific defines within
arch/ppc/platforms/<board>.h

like this:
--snip--
/* defines for arch/ppc/8260_io/enet.c */

#define PB_ENET_RXD      ((uint)0x00020000)
#define PD_ENET_RXD      ((uint)0x00000000)

#define PB_ENET_TXD	     ((uint)0x00000000)
#define PD_ENET_TXD      ((uint)0x00000080)

#define PC_ENET_CLSN     ((uint)0x00100000)

#define PC_ENET_TXCLK    ((uint)0x00000020)
#define PC_ENET_RXCLK    ((uint)0x00000010)

#define PB_ENET_LBK      ((uint)0x00400000)


#define CMXSCR_RS3CS_CLK5  0x00002000	/* SCC3 Rx Clock Source CLK5 */
#define CMXSCR_TS3CS_CLK6  0x00000500	/* SCC3 Tx Clock Source CLK6 */

#define CMX_CLK_ROUTE	((uint)(CMXSCR_RS3CS_CLK5 | CMXSCR_TS3CS_CLK6))

/* #define SCC_ENET_PIN_ENABLE */
--snap--

mind the defines for RxD and TxD for both ports B and D
it's needed to decide which port is used
SCC_ENET_PIN_ENABLE could be used to setup LBK, FDE or DSQ

> Just send it to me and I'll get it into some source base :-)
>
here you are
It's tested for SCC3.


Best regards,
Oliver Fuchs


--Message-Boundary-20894
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'sccenet.patch'

diff -purN linux-2.4.24/arch/ppc/8260_io/Config.in linux-2.4.24.scc/arch/ppc/8260_io/Config.in
--- linux-2.4.24/arch/ppc/8260_io/Config.in	2003-10-30 01:32:09.000000000 +0100
+++ linux-2.4.24.scc/arch/ppc/8260_io/Config.in	2004-08-16 16:55:45.000000000 +0200
@@ -7,10 +7,11 @@ bool 'Enable SCC Console' CONFIG_SCC_CON
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
   bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
   if [ "$CONFIG_SCC_ENET" = "y" ]; then
-  bool 'Ethernet on SCC1' CONFIG_SCC1_ENET
-    if [ "$CONFIG_SCC1_ENET" != "y" ]; then
-      bool 'Ethernet on SCC2' CONFIG_SCC2_ENET
-    fi
+  choice 'SCC Ethernet' \
+         "SCC1 CONFIG_SCC1_ENET \
+          SCC2 CONFIG_SCC2_ENET \
+          SCC3 CONFIG_SCC3_ENET \
+          SCC4 CONFIG_SCC4_ENET" SCC1
   fi
 #
 #  CONFIG_FEC_ENET is only used to get netdevices to call our init
diff -purN linux-2.4.24/arch/ppc/8260_io/enet.c linux-2.4.24.scc/arch/ppc/8260_io/enet.c
--- linux-2.4.24/arch/ppc/8260_io/enet.c	2003-10-30 01:32:09.000000000 +0100
+++ linux-2.4.24.scc/arch/ppc/8260_io/enet.c	2004-08-16 15:54:23.000000000 +0200
@@ -129,29 +129,95 @@ static void set_multicast_list(struct ne

 /* These will be configurable for the SCC choice.
 */
+#if defined(CONFIG_SCC1_ENET)
 #define CPM_ENET_BLOCK	CPM_CR_SCC1_SBLOCK
 #define CPM_ENET_PAGE	CPM_CR_SCC1_PAGE
 #define PROFF_ENET	PROFF_SCC1
 #define SCC_ENET	0
 #define SIU_INT_ENET	SIU_INT_SCC1
-
-/* These are both board and SCC dependent....
-*/
-#define PD_ENET_RXD	((uint)0x00000001)
-#define PD_ENET_TXD	((uint)0x00000002)
 #define PD_ENET_TENA	((uint)0x00000004)
 #define PC_ENET_RENA	((uint)0x00020000)
-#define PC_ENET_CLSN	((uint)0x00000004)
-#define PC_ENET_TXCLK	((uint)0x00000800)
-#define PC_ENET_RXCLK	((uint)0x00000400)
-#define CMX_CLK_ROUTE	((uint)0x25000000)
 #define CMX_CLK_MASK	((uint)0xff000000)

+#elif defined(CONFIG_SCC2_ENET)
+#define CPM_ENET_BLOCK	CPM_CR_SCC2_SBLOCK
+#define CPM_ENET_PAGE	CPM_CR_SCC2_PAGE
+#define PROFF_ENET	PROFF_SCC2
+#define SCC_ENET	1
+#define SIU_INT_ENET	SIU_INT_SCC2
+#define PD_ENET_TENA	((uint)0x00000020)
+#define PC_ENET_RENA	((uint)0x00080000)
+#define CMX_CLK_MASK	((uint)0x00ff0000)
+
+#elif defined(CONFIG_SCC3_ENET)
+#define CPM_ENET_BLOCK	CPM_CR_SCC3_SBLOCK
+#define CPM_ENET_PAGE	CPM_CR_SCC3_PAGE
+#define PROFF_ENET	PROFF_SCC3
+#define SCC_ENET	2
+#define SIU_INT_ENET	SIU_INT_SCC3
+#define PD_ENET_TENA	((uint)0x00000100)
+#define PC_ENET_RENA	((uint)0x00200000)
+#define CMX_CLK_MASK	((uint)0x0000ff00)
+
+#elif defined(CONFIG_SCC4_ENET)
+#define CPM_ENET_BLOCK	CPM_CR_SCC4_SBLOCK
+#define CPM_ENET_PAGE	CPM_CR_SCC4_PAGE
+#define PROFF_ENET	PROFF_SCC4
+#define SCC_ENET	3
+#define SIU_INT_ENET	SIU_INT_SCC4
+#define PD_ENET_TENA	((uint)0x00000800)
+#define PC_ENET_RENA	((uint)0x00800000)
+#define CMX_CLK_MASK	((uint)0x000000ff)
+
+#else
+  #error no SCC defined
+#endif
+/*
+  These are both board and SCC dependent....
+  RxD and TxD can be on port B or D
+  TENA is always on port D
+  RENA and CLSN are always on port C
+*/
+#ifndef PD_ENET_RXD
+  #define PD_ENET_RXD	((uint)0x00000001)
+#endif
+
+#ifndef PB_ENET_RXD
+  #define PB_ENET_RXD	((uint)0x00000000)
+#endif
+
+#ifndef PD_ENET_TXD
+  #define PD_ENET_TXD	((uint)0x00000002)
+#endif
+
+#ifndef PB_ENET_TXD
+  #define PB_ENET_TXD	((uint)0x00000000)
+#endif
+
+#ifndef PC_ENET_CLSN
+  #define PC_ENET_CLSN	((uint)0x00000004)
+#endif
+
+#ifndef PC_ENET_TXCLK
+  #define PC_ENET_TXCLK	((uint)0x00000800)
+#endif
+
+#ifndef PC_ENET_RXCLK
+  #define PC_ENET_RXCLK	((uint)0x00000400)
+#endif
+
+#ifndef CMX_CLK_ROUTE
+  #define CMX_CLK_ROUTE	((uint)0x25000000)
+#endif
+
+
 /* Specific to a board.
 */
+#ifdef CONFIG_EST8260
 #define PC_EST8260_ENET_LOOPBACK	((uint)0x80000000)
 #define PC_EST8260_ENET_SQE		((uint)0x40000000)
 #define PC_EST8260_ENET_NOTFD		((uint)0x20000000)
+#endif

 static int
 scc_enet_open(struct net_device *dev)
@@ -650,7 +716,7 @@ int __init scc_enet_init(void)
 	*/
 	sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);

-	/* Configure port C and D pins for SCC Ethernet.  This
+    /* Configure port C and D pins for SCC Ethernet.  This
 	 * won't work for all SCC possibilities....it will be
 	 * board/port specific.
 	 */
@@ -659,16 +725,26 @@ int __init scc_enet_init(void)
 	io->iop_pdirc &=
 		~(PC_ENET_RENA | PC_ENET_CLSN | PC_ENET_TXCLK | PC_ENET_RXCLK);
 	io->iop_psorc &=
-		~(PC_ENET_RENA | PC_ENET_TXCLK | PC_ENET_RXCLK);
-	io->iop_psorc |= PC_ENET_CLSN;
+		~(PC_ENET_RENA | PC_ENET_TXCLK | PC_ENET_RXCLK | (PC_ENET_CLSN & 0x00550000));
+	io->iop_psorc |= (PC_ENET_CLSN & 0x1080000c);

 	io->iop_ppard |= (PD_ENET_RXD | PD_ENET_TXD | PD_ENET_TENA);
 	io->iop_pdird |= (PD_ENET_TXD | PD_ENET_TENA);
 	io->iop_pdird &= ~PD_ENET_RXD;
-	io->iop_psord |= PD_ENET_TXD;
-	io->iop_psord &= ~(PD_ENET_RXD | PD_ENET_TENA);
+	io->iop_psord |= (PD_ENET_TXD & 0x00000002);
+	io->iop_psord &= ~(PD_ENET_TENA | ((PD_ENET_RXD | PD_ENET_TXD) & 0x000006fd));
+
+    /* if RxD or TxD are connected to port B, configure it */
+    if(PB_ENET_RXD | PB_ENET_TXD)
+    {
+      io->iop_pparb |= (PB_ENET_RXD | PB_ENET_TXD);
+      io->iop_pdirb |= (PB_ENET_TXD);
+      io->iop_pdirb &= ~(PB_ENET_RXD);
+      io->iop_psorb |= PB_ENET_TXD;
+      io->iop_psorb &= ~(PB_ENET_RXD);
+    }

-	/* Configure Serial Interface clock routing.
+    /* Configure Serial Interface clock routing.
 	 * First, clear all SCC bits to zero, then set the ones we want.
 	 */
 	immap->im_cpmux.cmx_scr &= ~CMX_CLK_MASK;
@@ -819,10 +895,11 @@ int __init scc_enet_init(void)
 	 */
 	sccp->scc_pmsr = (SCC_PSMR_ENCRC | SCC_PSMR_NIB22);

-	/* It is now OK to enable the Ethernet transmitter.
+    /* It is now OK to enable the Ethernet transmitter.
 	 * Unfortunately, there are board implementation differences here.
 	 */
-	io->iop_pparc &= ~(PC_EST8260_ENET_LOOPBACK |
+	#ifdef CONFIG_EST8260
+    io->iop_pparc &= ~(PC_EST8260_ENET_LOOPBACK |
 				PC_EST8260_ENET_SQE | PC_EST8260_ENET_NOTFD);
 	io->iop_psorc &= ~(PC_EST8260_ENET_LOOPBACK |
 				PC_EST8260_ENET_SQE | PC_EST8260_ENET_NOTFD);
@@ -830,8 +907,14 @@ int __init scc_enet_init(void)
 				PC_EST8260_ENET_SQE | PC_EST8260_ENET_NOTFD);
 	io->iop_pdatc &= ~(PC_EST8260_ENET_LOOPBACK | PC_EST8260_ENET_SQE);
 	io->iop_pdatc |= PC_EST8260_ENET_NOTFD;
+    #endif
+
+    #ifdef SCC_ENET_PIN_ENABLE
+      /* SCC_ENET_PIN_ENABLE must be a valid C statement !!! */
+      SCC_ENET_PIN_ENABLE;
+    #endif

-	dev->base_addr = (unsigned long)ep;
+    dev->base_addr = (unsigned long)ep;
 	dev->priv = cep;

 	/* The CPM Ethernet specific entries in the device structure. */

--Message-Boundary-20894--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
