Subject: Re: PPC Linux painic problem!
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Marius Groeger <mgroeger@sysgo.com>
Cc: jeffy <leo_guo@jisung.cn>,
	"linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.56.0404260913440.2550@mag.sysgo.com>
References: <200404260127.UAA32565@lists.linuxppc.org>
	 <Pine.LNX.4.56.0404260913440.2550@mag.sysgo.com>
Content-Type: text/plain
Message-Id: <1082976321.27938.9.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: Mon, 26 Apr 2004 11:45:22 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-04-26 at 08:20, Marius Groeger wrote:
> Jeffy,
>
> On Mon, 26 Apr 2004, jeffy wrote:
>
> >
> > Hi all,
> > 	I hit on a problem about PPC Linux version 2.4.4 on a MPC855T board.
> >     The kernel can start up ok normally, but when another PC
> > continous sending UDP packets to it(about 8Mbps) when kernel is
> > starting up, the kernel failed start up and printf the following
> > messages:
>
> This is just a VERY wild guess: check the driver source
> (arch/ppc/8xx_io/fec.c in your case) and make sure the driver only forwards
> received packets to the IP stack when the interface is configured "UP".
> There once was a similar problem with the 826x driver.
>
> Another reason could be that the FEC channel is not properly shut down by
> the firmware/bootloader before entering the kernel.
>
> Next time try to add more information about your system, especially about
> the kernel and bootloader version you are using.
>
> Regards,
> Marius

Hi all,

I think Marius' wild guess is correct!  Until 5 minutes ago I had the
same problem as Jeffy.  My fix is to disable rx interrupts until
fec_enet_open() is called.  See the patch below.  Thanks Marius.

BTW, the patch may not apply because of other changes to fec.c, so
here's a description:
	1st block: add int allow_rx to fec_enet_private struct
	2nd block: set allow_rx in fec_enet_open()
	3rd block: unset allow_rx in fec_enet_stop()
	4th block: in fec_restart() only set IMASK[RXF] if allow_rx set

Alex

===================================================================
RCS file: /newcvs/ppc-linux/kernel/arch/ppc/8xx_io/fec.c,v
retrieving revision 1.41
diff -u -r1.41 fec.c
--- fec.c	22 Apr 2004 13:32:01 -0000	1.41
+++ fec.c	26 Apr 2004 10:34:28 -0000
@@ -220,6 +220,7 @@
 	struct	net_device_stats stats;
 	uint	tx_full;
 	spinlock_t lock;
+    int allow_rx;

 #ifdef	CONFIG_USE_MDIO
 	uint	phy_id;
@@ -1932,6 +1933,7 @@
 {
 	struct fec_enet_private *fep = dev->priv;

+    fep->allow_rx = 1;
 	/* I should reset the ring buffers here, but I don't yet know
 	 * a simple way to do that.
 	 */
@@ -1971,11 +1973,12 @@
 static int
 fec_enet_close(struct net_device *dev)
 {
+	struct fec_enet_private *fep = dev->priv;
 	/* Don't know what to do yet.
 	*/
 	netif_stop_queue(dev);
 	fec_stop(dev);
-
+    fep->allow_rx = 0;
 	return 0;
 }

@@ -2661,7 +2664,7 @@

 	/* Enable interrupts we wish to service.
 	*/
-	fecp->fec_imask = ( FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII );
+	fecp->fec_imask = ( FEC_ENET_TXF | ((fep->allow_rx)?FEC_ENET_RXF:0) | FEC_ENET_MII );

 	/* And last, enable the transmit and receive processing.
 	*/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
