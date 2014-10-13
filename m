Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 069BB1A0076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 02:55:11 +1100 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xdhxl-001jrt-Go
 for linuxppc-dev@lists.ozlabs.org; Mon, 13 Oct 2014 15:55:09 +0000
Message-ID: <543BF5AF.9010806@roeck-us.net>
Date: Mon, 13 Oct 2014 08:54:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/20] powerpc: Convert power off logic to pm_power_off
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2014 07:01 AM, Alexander Graf wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
>
> Today on PowerPC we set pm_power_off to invoke our generic full machine power
> off logic which then calls ppc_md.power_off to invoke machine specific power
> off.
>
> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
> this card house falls apart. That driver only registers itself if pm_power_off
> is NULL to ensure it doesn't override board specific logic. However, since we
> always set pm_power_off to the generic power off logic (which will just not
> power off the machine if no ppc_md.power_off call is implemented), we can't
> implement power off via the generic GPIO power off driver.
>
> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
> pm_power_off as was intended. Then individual drivers such as the GPIO power off
> driver can implement power off logic via that function pointer.
>
> With this patch set applied and a few patches on top of QEMU that implement a
> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
> machine after halt.
>
> Michael / Ben, you can find this patch set as a git branch at the URL below.
> When applying it, please use that one to ensure that Guenter can easily merge
> his work with my work.
>
>    git://github.com/agraf/linux-2.6.git pm_power_off-v2
>
> Alex
>
> ---
>
> v1 -> v2:
>
>    - fix typo in 47x
>    - put ppc_md static replacement setters into probe function
>
> Alexander Graf (20):
>    powerpc: Support override of pm_power_off
>    powerpc/xmon: Support either ppc_md.power_off or pm_power_off
>    powerpc/47x: Use pm_power_off rather than ppc_md.power_off
>    powerpc/52xx/efika: Use pm_power_off rather than ppc_md.power_off
>    powerpc/mpc8349emitx: Use pm_power_off rather than ppc_md.power_off
>    powerpc/corenet: Use pm_power_off rather than ppc_md.power_off
>    powerpc/85xx/sgy_cts1000: Use pm_power_off rather than
>      ppc_md.power_off
>    powerpc/celleb: Use pm_power_off rather than ppc_md.power_off
>    powerpc/cell/qpace: Use pm_power_off rather than ppc_md.power_off
>    powerpc/cell: Use pm_power_off rather than ppc_md.power_off
>    powerpc/chrp: Use pm_power_off rather than ppc_md.power_off
>    powerpc/6xx/gamecube: Use pm_power_off rather than ppc_md.power_off
>    powerpc/6xx/linkstation: Use pm_power_off rather than ppc_md.power_off
>    powerpc/6xx/wii: Use pm_power_off rather than ppc_md.power_off
>    powerpc/maple: Use pm_power_off rather than ppc_md.power_off
>    powerpc/powermac: Use pm_power_off rather than ppc_md.power_off
>    powerpc/powernv: Use pm_power_off rather than ppc_md.power_off
>    powerpc/ps3: Use pm_power_off rather than ppc_md.power_off
>    powerpc/pseries: Use pm_power_off rather than ppc_md.power_off
>    powerpc: Remove ppc_md.power_off
>

On another note, and maybe you discussed this separately: I don't really
see the value of having 20 separate patches here, other than creating
a lot of work for the maintainer. Wouldn't it be easier
to just have one patch instead ?

Sure, it would touch 20+ files instead of just one, but then you
could drop some of the workarounds you have to put in place just
to undo it at the end, and it is not as if the patches are really
independent of each other or as if there would be any benefit
in respect to the ability to bisect or merge into earlier versions
of the kernel.

I for my part don't plan for 20 patches when I convert it to
use the poweroff handler. Hope it is ok with everyone that it
will be just one patch.

Thanks,
Guenter
