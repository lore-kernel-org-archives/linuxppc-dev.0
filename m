Return-Path: <linus.walleij@linaro.org>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x8nmd6lQdzDql1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 21:45:20 +1000 (AEST)
Received: by mail-io0-x236.google.com with SMTP id h134so25777023iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 04:45:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500072810.2865.92.camel@kernel.crashing.org>
References: <20170714114629.1512-1-linus.walleij@linaro.org>
 <1500072810.2865.92.camel@kernel.crashing.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 15 Jul 2017 13:45:15 +0200
Message-ID: <CACRpkda9xaOLudWrDkjzFEm49-yVSxS-NGUe7SfzAnLy0wwihg@mail.gmail.com>
Subject: Re: [PATCH] machintosh: select defaults for cooling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 opensuse-ppc@opensuse.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 15, 2017 at 12:53 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-07-14 at 13:46 +0200, Linus Walleij wrote:
>> I have this pretty nasty problem when trying to boot up a fresh
>> openSuSE DVD on a PowerMac G5: the kernel by default does not have
>> CONFIG_WINDFARM_PM72 enabled, with the effect that the cooling
>> is not functioning.
>>
>> The BIOS on the PowerMac G5 reacts to this by, after a grace
>> period when the BIOS has waited for the OS to take over, increasing
>> the fan speeds so it sounds like an airplane is in the room, and
>> after another grace period simply cutting the power to the
>> machine. This is done not beacuse the cooling is not working, but
>> because the BIOS is not recieving handover of cooling from the
>> OS, so it panics and give up. The problem has been reported by
>> Linux users online.
>
> It's not actually the BIOS but the fan controller HW who does that.

OK then :)

Are you running this hardware BTW?

>> I think this will make install images work in the G5 Macs.
>
> Why is it not the job of the defconfig ? I was under the impression
> that just "selecting" like this was frowned upon ? I don't care much
> either way mind you, I'll let Michael decide what he wants to do.

I think nobody is happy with Kconfig really.

This relates to a recent Kconfig unmanageability discussion at
ksummit-discuss I'd say. The situation is not great, it is very hard
to make working configs and this patch is meant to help with that
using the crude tools we have.

I prefer to just think about making it easy to do the right thing.
And making Kconfig do the right thing without human
intervention, because humans just screw everything up.
As is proven by the openSuSE install media situation.

They simply have no clue what to enable to create an installable
powermac media, even though they obviously know their way
around ppc64, it's just too hard to get the Kconfig right.

So if I patch arch/arm/configs/g5_defconfig it starts working for me,
true.

But I would not be surprised if the distros just forget to sync their
configs with g5_defconfig so it doesn't help at all but instead I have
to go and poke everyone and their dog about it.

Debian obviously had this enabled in *their* defconfig, because that
installed just fine with their Jessue distro. They have since dropped
support for ppc64 yay.

An alternative option is to go in and patch
drivers/cpufreq/Kconfig.powerpc like that:

config CPU_FREQ_PMAC64
        bool "Support for some Apple G5s"
        depends on PPC_PMAC && PPC64
+        select WINDFARM
+        select WINDFARM_PM81
+        select WINDFARM_PM72
+        select WINDFARM_RM31
+        select WINDFARM_PM91
+        select WINDFARM_PM112
+        select WINDFARM_PM121

If that is preferred?

Yours,
Linus Walleij
