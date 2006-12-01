Return-Path: <guinan@bluebutton.com>
Received: from ns3.townisp.com (ns3a.townisp.com [216.195.0.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ns3.townisp.com", Issuer "ns3.townisp.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4130A67A39
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 18:22:01 +1100 (EST)
Date: Fri, 1 Dec 2006 01:54:18 -0500 (EST)
From: Jamie Guinan <guinan@bluebutton.com>
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: RE: Rattler 8347 and USB 2.0
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FCAEA@zch01exm20.fsl.freescale.net>
Message-ID: <Pine.LNX.4.64.0611300204310.5401@gemini.home.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0FCAEA@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Jamie Guinan <guinan@bluebutton.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 1 Sep 2006, Li Yang-r58472 wrote:

> > -----Original Message-----
> > From: 
> > linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org 
> > [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.o
> > rg] On Behalf Of Jamie Guinan
> > Sent: Friday, September 01, 2006 12:14 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: Rattler 8347 and USB 2.0
> > 
> > 
> > Greetings,
> > 
> > I have an mpc8347 board here (A&M Rattler 8347).  It shipped with a
> > 2.6.16 patched enough to boot the board, but support for 
> > freescale USB 2.0 (ehci) is not present.
> > 
> > Working my way backwards in the mainline kernel tree 
> > (2.6.18-rc5), I found drivers/usb/host/ehci-fsl.c, for 
> > FreeScale/PPC EHCI support.
> > 
> > In that module, usb_hcd_fsl_probe() requires an initialized 
> > "struct fsl_usb2_platform_data", which only appears in 
> > arch/powerpc/sysdev/fsl_soc.c, yet the 2.6.16 patch provided 
> > puts the board in arch/ppc.
> > 
> > My question is, what would be the best way to go about 
> > getting ehci-fsl.c working with this board?
> > 
> > 1) Nudge the Rattler port from arch/ppc to arch/powerpc.  One 
> > problem with this is that the rattler uses RedBoot, and reading this,
> > 
> > http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/024116.html
> > 
> > it looks like arch/powerpc wants to boot from 
> > OpenFirmware-like "flattened device tree" (does RedBoot 
> > support this?).
> 
> Use a shim which directly builds FDT in kernel to use powerpc arch.
> > 
> > 2) Support ehci-fsl.c from arch/ppc.  If arch/ppc is 
> > deprecated, that's a bad long-term solution.  And since 
> > fsl_soc.c lives under arch/powerpc, that doesn't look good either.
> 
> Actually you don't need fsl_soc.c in ppc arch.  There are predefined
> platform_device and platform_data in arch/ppc/syslib/mpc83xx_devices.c.
> You can add your usb platform_data there easily.

So I got back on this (months later), and I added that entry like you 
suggested (below is against 2.6.17, for reference only, do not apply),

<patch>
--- mpc83xx_devices.c.ori	2006-11-30 01:09:19.000000000 -0500
+++ mpc83xx_devices.c	2006-11-30 01:49:46.000000000 -0500
@@ -64,6 +64,12 @@
 	{ },
 };
 
+static struct fsl_usb2_platform_data mpc83xx_usb_platform_data = {
+	.operating_mode = FSL_USB2_MPH_HOST,
+	.phy_mode = FSL_USB2_PHY_ULPI,
+	.port_enables = FSL_USB2_PORT0_ENABLED | 
FSL_USB2_PORT1_ENABLED,
+};
+
 struct platform_device ppc_sys_platform_devices[] = {
 	[MPC83xx_TSEC1] = {
 		.name = "fsl-gianfar",
@@ -205,6 +211,7 @@
 	[MPC83xx_USB2_MPH] = {
 		.name = "fsl-usb2-mph",
 		.id	= 1,
+		.dev.platform_data = &mpc83xx_usb_platform_data,
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
</patch>

and I was quite pleased to see this on my console on the next
boot,

  fsl-usb2-mph fsl-usb2-mph.1: Freescale On-Chip EHCI Host Controller
  fsl-usb2-mph fsl-usb2-mph.1: new USB bus registered, assigned bus number 1
  fsl-usb2-mph fsl-usb2-mph.1: irq 39, io base 0xff022000
  fsl-usb2-mph fsl-usb2-mph.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
  usb usb1: Product: Freescale On-Chip EHCI Host Controller
  usb usb1: Manufacturer: Linux 2.6.17-1_AM_JSG_NOV29 ehci_hcd
  usb usb1: SerialNumber: fsl-usb2-mph.1
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  Initializing USB Mass Storage driver...

Thanks for that tip.

Next (hopefully minor) hurdle is that I'm not seeing any activity when 
I plug in a device, and the ehci irq39 line in /proc/interrupts stays 
at 0.

Some of the PHY signals go through an FPGA on this board, I'm talking 
to my vendor about that.

-Jamie
