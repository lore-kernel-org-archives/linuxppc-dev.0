Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0C861A0184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 19:41:36 +1100 (AEDT)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30B03140096
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2014 19:41:35 +1100 (AEDT)
Message-ID: <54476DBB.4020500@suse.de>
Date: Wed, 22 Oct 2014 10:41:31 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux@roeck-us.net
Subject: Re: [PATCH] powerpc: Convert power off logic to pm_power_off
References: <1413952677-31662-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1413952677-31662-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 22.10.14 06:37, Michael Ellerman wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
> 
> Today on powerpc we set pm_power_off to invoke our generic full machine power
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
> Signed-off-by: Alexander Graf <agraf@suse.de>
> [mpe: Squash into one patch and update changelog based on cover letter]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/machdep.h               |  1 -
>  arch/powerpc/kernel/setup-common.c               |  6 +--
>  arch/powerpc/platforms/44x/ppc476.c              |  2 +-
>  arch/powerpc/platforms/52xx/efika.c              |  3 +-
>  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c   |  8 ++--
>  arch/powerpc/platforms/85xx/corenet_generic.c    |  2 +-
>  arch/powerpc/platforms/85xx/sgy_cts1000.c        |  4 +-
>  arch/powerpc/platforms/cell/celleb_setup.c       |  4 +-
>  arch/powerpc/platforms/cell/qpace_setup.c        |  2 +-
>  arch/powerpc/platforms/cell/setup.c              |  2 +-
>  arch/powerpc/platforms/chrp/setup.c              |  3 +-
>  arch/powerpc/platforms/embedded6xx/gamecube.c    |  3 +-
>  arch/powerpc/platforms/embedded6xx/linkstation.c |  4 +-
>  arch/powerpc/platforms/embedded6xx/wii.c         |  3 +-
>  arch/powerpc/platforms/maple/setup.c             |  4 +-
>  arch/powerpc/platforms/powermac/setup.c          |  3 +-
>  arch/powerpc/platforms/powernv/setup.c           |  4 +-
>  arch/powerpc/platforms/ps3/setup.c               |  2 +-
>  arch/powerpc/platforms/pseries/setup.c           | 59 ++++++++++++------------
>  arch/powerpc/sysdev/fsl_soc.c                    |  2 +-
>  arch/powerpc/xmon/xmon.c                         |  3 +-
>  21 files changed, 66 insertions(+), 58 deletions(-)
> 
> 
> Hi guys, how does this look?
> 
> If it's OK I'll put it in a topic branch for Guenter.

Looks good to me. Thanks for doing the cleanup :).


Alex
