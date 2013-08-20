Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.103])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta7.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 753B92C013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:05:43 +1000 (EST)
In-Reply-To: <1376959471.31636.395.camel@snotra.buserror.net>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>			
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
 <1375985244.4514.21.camel@snotra.buserror.net>		
 <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
 <1376345070.20487.41.camel@snotra.buserror.net>	
 <OFE77F59FB.5CB18F2A-ONCA257BCB.007040E3-CA257BCB.00733D8F@csc.com>
 <1376959471.31636.395.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF0DA3729A.32A5A180-ONCA257BCD.0004B57B-CA257BCD.00167EF8@csc.com>
Date: Tue, 20 Aug 2013 15:05:34 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, Stephen N Chivers <schivers@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 08/20/2013 10:44:31 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: Chris Proctor <cproctor@csc.com.au>, Kumar Gala 
> <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>, 
> <paulus@samba.org>
> Date: 08/20/2013 10:44 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> On Mon, 2013-08-19 at 07:58 +1100, Stephen N Chivers wrote:
> > The serial console setup in 'legacy_serial' does not support reg-shift
> > or reg-offset properties and so a preferred_console is not added by 
it.
> > The DTS file for the board does specify the register shift so that
> > 'of_serial' will correctly setup the UARTS. But that is too late, the
> > preferred console will be tty0 as the .config derived from 
> > ppc6xx_defconfig
> > has CONF_VT_CONSOLE set. In the test kernels I have built 'con_init' 
in
> > the VT support is always called before serial8250_console_init.
> 
> Are you setting console=ttyS0,<baud> on the kernel command line?
>
Yes, most certainly.
During the testing was specifying the command line in the dts
as doing so in the .config would be wrong.
When booting got:

        Linux/PowerPC Load: console=ttyS0,9600 ip=dhcp root=/dev/nfs

So no problem there.

> > I did try modifying legacy_serial to correctly support the tsi-bridge
> > UARTS and add the preferred console but encountered even more problems
> > in 8250_core when registering the serial console (to the point of
> > having a silently panic'ing kernel).
> > 
> > So I think for the moment, the board will need its own default config.
> 
> Which config symbol is relevant here?
>
On reflection, maybe it wasn't panicing as in the configuration I was
using the boot times were quite protracted, something to do with the
network setup and e100 PHY initialisation.
(Embedding the e100 firmware in the kernel appears to fix that).
But at the point at which I gave up chasing the problem, the machine
was not showing any sign of life within what would be regarded as
"normal" times.
As to config symbol I don't know.

This may be the first attempt to
combine PPC6xx configurations with their embedded brethren.
What is certain that there is an incompatibility between what is
required for the "quirks" of the MVME-5100 onboard UARTS and the
configuration required for the non-embedded PPC6xx platforms.
> -Scott
> 
> 
> 
