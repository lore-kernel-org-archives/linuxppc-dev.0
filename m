Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7E8F1A0610
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 05:45:38 +1100 (EST)
Message-ID: <1412793921.13320.545.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Wed, 8 Oct 2014 13:45:21 -0500
In-Reply-To: <54356A53.3010700@c-s.fr>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
 <1412367858.13320.432.camel@snotra.buserror.net> <542FC8C1.1000707@c-s.fr>
 <1412641184.13320.506.camel@snotra.buserror.net> <54356A53.3010700@c-s.fr>
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

On Wed, 2014-10-08 at 18:46 +0200, leroy christophe wrote:
> Le 07/10/2014 02:19, Scott Wood a écrit :
> > On Sat, 2014-10-04 at 12:15 +0200, christophe leroy wrote:
> >> Le 03/10/2014 22:24, Scott Wood a écrit :
> >>> On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
> >>>> Le 03/10/2014 16:44, Mark Brown a écrit :
> >>>>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
> >>>>>
> >>>>>> +config CPM1_RELOCSPI
> >>>>>> +	bool "Dynamic SPI relocation"
> >>>>>> +	default n
> >>>>>> +	help
> >>>>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
> >>>>>> +	  without micropatch. This activates relocation to a dynamically
> >>>>>> +	  allocated area in the CPM Dual port RAM.
> >>>>>> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
> >>>>>> +	  the "loss" of additional Dual port RAM space just above the patch,
> >>>>>> +	  which might be needed for example when using the CPM QMC.
> >>>>> Something like this shouldn't be a compile time option.  Either it
> >>>>> should be unconditional or it should be triggered in some system
> >>>>> specific manner (from DT, from knowing about other users or similar).
> >>>> Can't be unconditional as older versions of mpc8xx (eg MPC860) don't
> >>>> support relocation without a micropatch.
> >>>> I have therefore submitted a v2 based on a DTS compatible property.
> >>> So the device tree change is about whether relocation is supported, not
> >>> whether it is required?
> >> Indeed no, my intension is to say that relocation is requested. Do you
> >> mean that it should then not use a compatible ?
> > The device tree describes hardware.  It doesn't tell software how to use
> > that hardware.
> >
> > Based on one of your other e-mails, I think what you want to say here is
> > that the old binding didn't describe the registers needed for
> > relocation, so the new compatible describes the new binding, rather than
> > requesting that software do a relocation.  Software that sees the new
> > binding could choose to relocate, or just choose to read the current
> > offset from the register.
> Not exactly.
> The old binding does describe the entire default param RAM (0x3d80 size 
> 0x30). The relocation index is within this param RAM at 0x3dac.
> So the old binding is enough to allow relocation.

Oh, so the relocation register is part of the region?  If you relocate
the region, does the relocation register move, or stay at 0x3dac?  I
checked the manual and it wasn't clear.  I had assumed it worked the
same as cpm2, where the relocation register does not move.

> The issue today with the driver (hence my first patch) is that the 
> driver reads the relocation index but takes a wrong decision if the 
> index is 0: it assumes that an nul index means that a param RAM shall be 
> allocated, which is wrong. A nul index means that the component doesn't 
> support relocation, so the default param RAM shall be used. The function 
> used for that is supposed to return the index. So when the index is 
> null, I need to calculate it.
> 
> Now, it can't be the SPI driver by itself that decide if he has to 
> relocate or not. Because it depends whether I need to relocate or not. 
> There is no point in waisting another area of the dualport RAM if I 
> don't need to use SCC2 in a mode that overlaps the SPI parameter RAM.

Is the DPRAM currently fully utilized?

If it's really important to not waste 48 bytes of DPRAM, Could you make
the policy decision in platform code, or check at runtime what mode SCC2
is in?

> Today on the old MPC8xx, a microcode patch is needed in order to be able 
> to relocate, and relocated address is directly fixed by the code 
> handling the patch (sysdev/micropatch.c). The patch loading function is 
> call very early in the boot process by cpm_reset() which is call by the 
> xxx_setup_arch().
> I have two issues with the way it is done today:
> 1/ the address which in hard coded is the micropatch loading function() 
> is within the area for descripters for the QMC, so I would need to use 
> another address.
> 2/ for new MPC8xx which don't need microcode patch, I have no way today 
> to relocate.
> 
> I have the same issue with the relocation of SMC1. Today when we 
> activate SMC1 relocation microcode patch, the loading function has a 
> hard coded relocation area for SMC1 which is the area dedicated to the 
> MPC8xx DSP. It means that I need to change it as I want to use the DSP.
> 
> Would it be acceptable to define a fixed relocation address in the 
> Kconfig in which we select microcode patch (arch/powerpc/platforms/8xx), 
> instead of having it hardcoded in micropatch.c ?

No, that would prevent the ability to build support for all 8xx in one
kernel.

> Or maybe it would be possible to select which microcode patch we 
> want/need via the device tree and which address shall be used for 
> relocation ? What would you suggest to describe it ?

Yes, use the existing information in the device tree, or use PVR, to
determine which chip you're on and thus whic microcode to use.

> >
> >>> How about checking for the existing specific-SoC compatibles?
> >> What do you mean ?
> > Look for "fsl,mpc885-cpm-i2c" etc.  Or, if you didn't follow that
> > pattern (remember, I can't see your device tree!), look for
> > "fsl,mpc885-cpm" or "fsl,mpc866-cpm" in the parent node.  It's moot
> > though, if the device tree also needs to be modified to describe the
> > register used to relocate.
> >
> > -Scott
> >
> I'm not sure I understood your question.
> My full device tree below
[snip]
>          cpm@9c0 {
>              #address-cells = <1>;
>              #size-cells = <1>;
>              compatible = "fsl,mpc885-cpm", "fsl,cpm1";
[snip]
>              spi: spi@a80 {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  cell-index = <0>;
>                  compatible = "fsl,spi", "fsl,cpm1-spi";

"fsl,cpm1-spi" should come first.

You didn't follow the pattern most CPM devices use, of
"fsl,mpc885-<device>", but you could look in the cpm node above to
determine that it's an mpc885.

-Scott
