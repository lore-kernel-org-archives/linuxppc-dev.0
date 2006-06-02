Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id E276267A44
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 10:06:58 +1000 (EST)
Message-ID: <4480C385.4020309@mvista.com>
Date: Fri, 02 Jun 2006 16:02:29 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: almoeli@gmx.de
Subject: Re: USB on MPC8349 with MPH controller
References: <447FFD1E.6030208@gmx.de>
In-Reply-To: <447FFD1E.6030208@gmx.de>
Content-Type: multipart/mixed; boundary="------------000509020800010307060107"
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
--------------000509020800010307060107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

almoeli@gmx.de wrote:
> Hi,
> 
> im using kernel 2.6.16.18 with the ehci-fsl and a patch from this list
> to get USB working.
> So SCCR and SICRL register are set correctly.
> The external connected PHY is a SMSC 3300-EZK which has an ULPI interface.
> If I configure the USB controller of the MPC8349 to use the DR
> controller, port 1 can be used with low, full and high speed devices
> without any errors.
> But if the USB controller is switched to MPH, the port 0 and port 1
> cannot read the device descriptor.
> Error message is:
> 
> fsl-usb2-mph: devpath1 ep0in 3strikes
> fsl-usb2-mph: devpath1 ep0in 3strikes
> fsl-usb2-mph: devpath1 ep0in 3strikes
> usb1-1: device decriptor read/64, error -71
> 
> Does anyone know this problem or knows a solution?
The 8349 has quirk regarding the port numbering in its queues. The attached patch may resolve your problems. This patch was taken from the powerpc.git tree at git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

		Randy Vinson
		MontaVista Software

--------------000509020800010307060107
Content-Type: text/plain;
 name="834x_usb_quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="834x_usb_quirk.patch"

commit 8cd42e97bf451bbbb2f54dc571366ae5a72faaea
Author: Kumar Gala <galak@gate.crashing.org>
Date:   Fri Jan 20 13:57:52 2006 -0800

    [PATCH] USB: EHCI and Freescale 83xx quirk
    
    On the MPC834x processors the multiport host (MPH) EHCI controller has an
    erratum in which the port number in the queue head expects to be 0..N-1
    instead of 1..N.  If we are on one of these chips we subtract one from
    the port number before putting it into the queue head.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index c6012d6..59f90f7 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -198,6 +198,16 @@ static void mpc83xx_usb_setup(struct usb
 		mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
+		unsigned int chip, rev, svr;
+
+		svr = mfspr(SPRN_SVR);
+		chip = svr >> 16;
+		rev = (svr >> 4) & 0xf;
+
+		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1 chips */
+		if ((rev == 1) && (chip >= 0x8050) && (chip <= 0x8055))
+			ehci->has_fsl_port_bug = 1;
+
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
 			mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 9b13bf2..6e28e59 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -721,7 +721,14 @@ qh_make (
 		info1 |= maxp << 16;
 
 		info2 |= (EHCI_TUNE_MULT_TT << 30);
-		info2 |= urb->dev->ttport << 23;
+
+		/* Some Freescale processors have an erratum in which the
+		 * port number in the queue head was 0..N-1 instead of 1..N.
+		 */
+		if (ehci_has_fsl_portno_bug(ehci))
+			info2 |= (urb->dev->ttport-1) << 23;
+		else
+			info2 |= urb->dev->ttport << 23;
 
 		/* set the address of the TT; for TDI's integrated
 		 * root hub tt, leave it zeroed.
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 86af41c..679c1cd 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -88,8 +88,11 @@ #define	DEFAULT_I_TDPS		1024		/* some HC
 	unsigned long		next_statechange;
 	u32			command;
 
+	/* SILICON QUIRKS */
 	unsigned		is_tdi_rh_tt:1;	/* TDI roothub with TT */
 	unsigned		no_selective_suspend:1;
+	unsigned		has_fsl_port_bug:1; /* FreeScale */
+
 	u8			sbrn;		/* packed release number */
 
 	/* irq statistics */
@@ -639,6 +642,18 @@ #endif
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_PPC_83xx
+/* Some Freescale processors have an erratum in which the TT
+ * port number in the queue head was 0..N-1 instead of 1..N.
+ */
+#define	ehci_has_fsl_portno_bug(e)		((e)->has_fsl_port_bug)
+#else
+#define	ehci_has_fsl_portno_bug(e)		(0)
+#endif
+
+
+/*-------------------------------------------------------------------------*/
+
 #ifndef DEBUG
 #define STUB_DEBUG_FILES
 #endif	/* DEBUG */

--------------000509020800010307060107--
