Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <m12n2oz-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Need CPM clock >= 100 Mhz for fast ethernet operation
To: dan@netx4.com (Dan Malek), linuxppc-embedded@lists.linuxppc.org
Date: Wed, 3 May 2000 13:20:24 -0400 (EDT)
Cc: beatson_mark@bucks.si.com
In-Reply-To: <3907A22C.D82EF0D1@embeddededge.com> from "Dan Malek" at Apr 26, 2000 10:13:00 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: Dan Malek <dan@netx4.com>
> Organization: Embedded Edge, LLC

> diekema_jon wrote:
>
> >         - What clock multiplier are you using for the CPM?

> I don't remember.  I think it was clock mode 0010_011, which would
> be 133 MHz CPM and 166 MHz core.  This is all pretty simple.  Just
> pick your own clock speed and set the board descriptor in embed_config.c
> to match it.

In order for fast Ethernet to work reliably, the CPM clock needs to be
>= 100 Mhz.

If the CPM clock is 66 Mhz, then about 1 of 5-20 Tx packets will get
dropped.  It also appears that Rx has precedence over Tx.  We are
guessing that the CPM runs out of cycles at 66 Mhz while trying to
support fast ethernet.

dell 143} rcsdiff -r1.1 -u arch/ppc/mbxboot/embed_config.c
===================================================================
RCS file: arch/ppc/mbxboot/RCS/embed_config.c,v
retrieving revision 1.1
diff -u -r1.1 arch/ppc/mbxboot/embed_config.c
--- arch/ppc/mbxboot/embed_config.c     2000/04/27 13:37:13     1.1
+++ arch/ppc/mbxboot/embed_config.c     2000/05/02 21:57:02
@@ -25,7 +25,7 @@
  */
 static ushort  def_enet_addr[] = { 0x0800, 0x3e26, 0x1559 };

-#if defined(CONFIG_RPXLITE) || defined(RPX_CLASSIC)
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)

 static void    rpx_eth(bd_t *bd, u_char *cp);
 static void    rpx_brate(bd_t *bd, u_char *cp);
@@ -236,12 +236,12 @@
         * here for those people that may load the kernel with
         * a JTAG/COP tool and not the rom monitor.
         */
-       bd->bi_baudrate = 115200;
-       bd->bi_intfreq = 200;
-       bd->bi_busfreq = 66;
-       bd->bi_cpmfreq = 66;
-       bd->bi_brgfreq = 33;
-       bd->bi_memsize = 16 * 1024 * 1024;
+       bd->bi_baudrate = 19200;
+       bd->bi_intfreq  = 165;
+       bd->bi_busfreq  = 33;
+       bd->bi_cpmfreq  = 132;
+       bd->bi_brgfreq  = bd->bi_cpmfreq / 2; /* BRGCLK = (CPM*2/4) */
+       bd->bi_memsize  = 16 * 1024 * 1024;
 #endif

        cp = (u_char *)def_enet_addr;

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
