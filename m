Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id F2F19DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 01:48:44 +1100 (EST)
Received: by gxk9 with SMTP id 9so5017670gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 06:48:42 -0800 (PST)
Message-ID: <fa686aa40901120648x3c224999sd0da6e80e4fd43be@mail.gmail.com>
Date: Mon, 12 Jan 2009 07:48:42 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: florian.belser@freenet.de
Subject: Re: mpc5200b configure nand driver via dts
In-Reply-To: <c4fbc703368c62be70c700e6f962eb12@email.freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c4fbc703368c62be70c700e6f962eb12@email.freenet.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2009 at 2:07 AM,  <florian.belser@freenet.de> wrote:
> hello,
>
> I have some problems with an mpc5200b based board. It's nearly compatible to
> the lite5200b board.
> I connected an samsung k9k8g08u0a nand flash via the lpb bus. This works
> fine with an self written nand driver.
> Now I try to use the standard nand driver from linux and configure it via
> the dts file. But this doesn't work and I get
> the following output:
>
>   nand@1,0 {  //cs1
>    compatible = "samsung, k9k8g08u08", "cfi-flash";
                                          ^^^^^^^^^

NAND Flash is not a CFI flash device.  The cfi-flash driver won't work with it.

> Now my questions are:
>  Is there any error in the dts configuration?
>  Is it principle posible to configure a nand flash via the dts file (in
> combination with mpc5200b)?

It is possible to *describe* the NAND flash via the dts file.  The dts
file doesn't configure anything.  It just describes the hardware
layout so that you can write or bind the appropriate driver to the
device.  I don't know if a device tree binding has been defined for
NAND flash yet.

>  I read in some forums that the nand flash must be activated in the u-boot
> before it can be configured via dts.

You definitely need to set up the CS line for the NAND before using it
in Linux.  Typically this is done in U-Boot, but in a pinch it can be
done in the platform support code (arch/powerpc/platforms/52xx/*)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
