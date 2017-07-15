Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x93L85H58zDqm0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 07:56:48 +1000 (AEST)
Message-ID: <1500155793.2865.105.camel@kernel.crashing.org>
Subject: Re: [PATCH] machintosh: select defaults for cooling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 opensuse-ppc@opensuse.org, stable <stable@vger.kernel.org>
Date: Sun, 16 Jul 2017 07:56:33 +1000
In-Reply-To: <CACRpkda9xaOLudWrDkjzFEm49-yVSxS-NGUe7SfzAnLy0wwihg@mail.gmail.com>
References: <20170714114629.1512-1-linus.walleij@linaro.org>
 <1500072810.2865.92.camel@kernel.crashing.org>
 <CACRpkda9xaOLudWrDkjzFEm49-yVSxS-NGUe7SfzAnLy0wwihg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-15 at 13:45 +0200, Linus Walleij wrote:
> 
> > It's not actually the BIOS but the fan controller HW who does that.
> 
> OK then :)
> 
> Are you running this hardware BTW?

A pm_72 ? No but I might still be able to find one somewhere in the lab
if needed (not sure).

> > > I think this will make install images work in the G5 Macs.
> > 
> > Why is it not the job of the defconfig ? I was under the impression
> > that just "selecting" like this was frowned upon ? I don't care much
> > either way mind you, I'll let Michael decide what he wants to do.
> 
> I think nobody is happy with Kconfig really.
> 
> This relates to a recent Kconfig unmanageability discussion at
> ksummit-discuss I'd say. The situation is not great, it is very hard
> to make working configs and this patch is meant to help with that
> using the crude tools we have.

Yup.

> I prefer to just think about making it easy to do the right thing.
> And making Kconfig do the right thing without human
> intervention, because humans just screw everything up.
> As is proven by the openSuSE install media situation.
> 
> They simply have no clue what to enable to create an installable
> powermac media, even though they obviously know their way
> around ppc64, it's just too hard to get the Kconfig right.
> 
> So if I patch arch/arm/configs/g5_defconfig it starts working for me,
> true.
> 
> But I would not be surprised if the distros just forget to sync their
> configs with g5_defconfig so it doesn't help at all but instead I have
> to go and poke everyone and their dog about it.
> 
> Debian obviously had this enabled in *their* defconfig, because that
> installed just fine with their Jessue distro. They have since dropped
> support for ppc64 yay.
> 
> An alternative option is to go in and patch
> drivers/cpufreq/Kconfig.powerpc like that:
> 
> config CPU_FREQ_PMAC64
>         bool "Support for some Apple G5s"
>         depends on PPC_PMAC && PPC64
> +        select WINDFARM
> +        select WINDFARM_PM81
> +        select WINDFARM_PM72
> +        select WINDFARM_RM31
> +        select WINDFARM_PM91
> +        select WINDFARM_PM112
> +        select WINDFARM_PM121
> 
> If that is preferred?

Not really. I don't like also how we end up selecting etc... based on
CPUFREQ... I wouldn't mind select'ing cpufreq itself but then we end up
having to pull i2c etc..

In the end, your defaults are probably be way to go but make them just
default y, the dependency on CPUFREQ should be sufficient. Or will that
screw up with modules ?

Cheers,
Ben.
