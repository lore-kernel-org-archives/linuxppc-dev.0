Return-Path: <florian.belser@freenet.de>
Received: from mout4.freenet.de (mout4.freenet.de [195.4.92.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F3FEDE144
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 19:37:49 +1100 (EST)
Received: from [195.4.92.15] (helo=5.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID florian.belser@freenet.de) (port
	25) (Exim 4.69 #76) id 1LN1Fp-0005tr-B5
	for linuxppc-dev@ozlabs.org; Wed, 14 Jan 2009 09:37:43 +0100
Received: from [195.243.49.242] (port=29048 helo=[192.168.4.215])
	by 5.mx.freenet.de with esmtpsa (ID florian.belser@freenet.de)
	(SSLv3:AES256-SHA:256) (port 25) (Exim 4.69 #76) id 1LN1Fo-0000vQ-R0
	for linuxppc-dev@ozlabs.org; Wed, 14 Jan 2009 09:37:37 +0100
Message-ID: <496DA450.9010803@freenet.de>
Date: Wed, 14 Jan 2009 09:37:36 +0100
From: Florian Belser <florian.belser@freenet.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: RE: Re: mpc5200b configure nand driver via dts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >  On Mon, Jan 12, 2009 at 2:07 AM,  <florian.belser@freenet.de>
>  wrote:
> > > hello,
> > >
> > > I have some problems with an mpc5200b based board. It's nearly
>  compatible to
> > > the lite5200b board.
> > > I connected an samsung k9k8g08u0a nand flash via the lpb bus. This
>  works
> > > fine with an self written nand driver.
> > > Now I try to use the standard nand driver from linux and configure
>  it via
> > > the dts file. But this doesn't work and I get
> > > the following output:
> > >
> > >   nand@1,0 {  //cs1
> > >    compatible = "samsung, k9k8g08u08", "cfi-flash";
> >                                            ^^^^^^^^^
> > 
> >  NAND Flash is not a CFI flash device.  The cfi-flash driver won't
>  work with it.
Which compatible mode whould you choose ?
> > 
> > > Now my questions are:
> > >  Is there any error in the dts configuration?
> > >  Is it principle posible to configure a nand flash via the dts
>  file (in
> > > combination with mpc5200b)?
> > 
> >  It is possible to *describe* the NAND flash via the dts file.  The
>  dts
> >  file doesn't configure anything.  It just describes the hardware
> >  layout so that you can write or bind the appropriate driver to the
> >  device.  I don't know if a device tree binding has been defined for
> >  NAND flash yet.
>  I find 3 MTD NAND drivers with OF bindings in
>  linux-2.6/drivers/mtd/nand
>  
>    $ grep -l of_device *.c
>    fsl_elbc_nand.c
>    fsl_upm.c
>    pasemi_nand.c
>  
>  The bindings for the FSL UPM are described in
>  http://lxr.linux.no/linux <http://lxr.linux.no/linux%3C/font%3E>
v2.6.28/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt.
>  Something similar is needed for his board (NAND connected to lpb) as
>  well.

Am I wrong or is the MTD_NAND_FSL_UPM only useable with PPC_83xx or
PPC_85xx?
>  
> > >  I read in some forums that the nand flash must be activated in
>  the u-boot
> > > before it can be configured via dts.
> > 
> >  You definitely need to set up the CS line for the NAND before using
>  it
> >  in Linux.  Typically this is done in U-Boot, but in a pinch it can
>  be
> >  done in the platform support code (arch/powerpc/platforms/52xx/*)
>  
>  Yep, and also the R/B pin should be handled somehow, preferably using
>  the OF GPIO interface.

I set the upper named points in the u-boot, now. 

+++ b/board/ybox/ybox.c
@@ -282,6 +282,32 @@ void flash_preinit(void)
         * executing in flash.
         */
        *(vu_long *)MPC5XXX_BOOTCS_CFG &= ~0x1; /* clear RO */
+
+
+       /* Configure PSC3_6 as ChipSelect for NAND Flash chip
+        set PSC3_6 pin as GPIO output */
+        *(vu_long *)MPC5XXX_GPIO_ENABLE |= 0x00001000; /*enable GPIO*/
+        *(vu_long *)MPC5XXX_GPIO_ODE &=  ~0x00001000; /* no OpenDrain
*/
+        *(vu_long *)MPC5XXX_GPIO_DIR |= 0x00001000; /* Direction =
output */
+        *(vu_long *)MPC5XXX_GPIO_DATA_O |= 0x00001000; /* Set CS to 1
(low active)*/
+       /* NAND config*/
+       /* Configure IRQ_0 as input for Ready/Busy pin*/
+        *(vu_long *)MPC5XXX_ICTL_EXT &= ~0x00000800; /*disable IRQ_0
interrupt */
+        *(vu_long *)MPC5XXX_ICTL_EXT |= 0x00C00000; /*low active */
+       *(vu_long *)MPC5XXX_ADDECR &= ~0x00020000; /*disable cs1 */
+
+        /* Configure the ChipSelect 1 on LocalPlusBus for data
transfers
+        there is a config chip select function allready, but beter do
all for nand
+        at one place */
+        /*CS1 start / end address*/
+        *(vu_long *)MPC5XXX_CS1_START = 0x00007000;
+        *(vu_long *)MPC5XXX_CS1_STOP = (0x00007000 + 0x100);
+        /*CS1 master enable */
+        *(vu_long *)MPC5XXX_CS_CTRL = 0x01;
+        *(vu_long *)MPC5XXX_CS1_CFG = 0x0f0f1800;
+       *(vu_long *)MPC5XXX_ADDECR |= ~0x00020000; /*enable cs1 */
+        /*enable PIN as ChipSelect*/
+        *(vu_long *)MPC5XXX_GPS_PORT_CONFIG |= 0x80000000;
 }


Thanks for your replays
Best regards
Florian Belser
