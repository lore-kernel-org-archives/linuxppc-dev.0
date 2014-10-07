Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60AF11A03F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 11:20:02 +1100 (EST)
Message-ID: <1412641184.13320.506.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Mon, 6 Oct 2014 19:19:44 -0500
In-Reply-To: <542FC8C1.1000707@c-s.fr>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
 <1412367858.13320.432.camel@snotra.buserror.net> <542FC8C1.1000707@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-10-04 at 12:15 +0200, christophe leroy wrote:
> Le 03/10/2014 22:24, Scott Wood a écrit :
> > On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
> >> Le 03/10/2014 16:44, Mark Brown a écrit :
> >>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
> >>>
> >>>> +config CPM1_RELOCSPI
> >>>> +	bool "Dynamic SPI relocation"
> >>>> +	default n
> >>>> +	help
> >>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
> >>>> +	  without micropatch. This activates relocation to a dynamically
> >>>> +	  allocated area in the CPM Dual port RAM.
> >>>> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
> >>>> +	  the "loss" of additional Dual port RAM space just above the patch,
> >>>> +	  which might be needed for example when using the CPM QMC.
> >>> Something like this shouldn't be a compile time option.  Either it
> >>> should be unconditional or it should be triggered in some system
> >>> specific manner (from DT, from knowing about other users or similar).
> >> Can't be unconditional as older versions of mpc8xx (eg MPC860) don't
> >> support relocation without a micropatch.
> >> I have therefore submitted a v2 based on a DTS compatible property.
> > So the device tree change is about whether relocation is supported, not
> > whether it is required?
> Indeed no, my intension is to say that relocation is requested. Do you 
> mean that it should then not use a compatible ?

The device tree describes hardware.  It doesn't tell software how to use
that hardware.

Based on one of your other e-mails, I think what you want to say here is
that the old binding didn't describe the registers needed for
relocation, so the new compatible describes the new binding, rather than
requesting that software do a relocation.  Software that sees the new
binding could choose to relocate, or just choose to read the current
offset from the register.

> > How about checking for the existing specific-SoC compatibles?
> What do you mean ?

Look for "fsl,mpc885-cpm-i2c" etc.  Or, if you didn't follow that
pattern (remember, I can't see your device tree!), look for
"fsl,mpc885-cpm" or "fsl,mpc866-cpm" in the parent node.  It's moot
though, if the device tree also needs to be modified to describe the
register used to relocate.

-Scott
