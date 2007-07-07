Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 524DFDDDFE
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 15:46:49 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so533262wag
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jul 2007 22:46:48 -0700 (PDT)
Message-ID: <fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
Date: Fri, 6 Jul 2007 23:46:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <200707070148.20526.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, leoli@freescale.com,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/6/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 07 July 2007, Grant Likely wrote:
> > --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > @@ -63,6 +63,8 @@ static void __init mpc834x_itx_setup_arch(void)
> >
> > ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> > #endif
> > +
> > +mpc834x_usb_cfg();
> > }
>
> Why is that necessary? Shouldn't there be an of_platform_driver that
> simply does all the setup automatically if the device is present?

This call is actually for SoC setup stuff.  There are actually 2 USB
engines on the SoC, and this call figures out what mode the pins are
supposed to be in.  I think this stuff firmly falls into the platform
setup arena since it is highly chip specific.

You bring up a good point though.  The current usb support code in
sysdev/fsl_soc.c uses arch_initcall(fsl_usb_of_init) to go searching
for USB interfaces in the device tree, which are EHCI (and sometimes
OTG) compatible.  fsl_usb_of_init calls
platform_device_register_simple() for each USB device found which is
kind of a round about way of doing things.  That should probably be
depreciated and an of_platform_device binding should be added to the
EHCI driver.

This same comment probably goes for the other arch_initcall functions
in fsl_soc.c which do exactly the same thing for other devices.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
