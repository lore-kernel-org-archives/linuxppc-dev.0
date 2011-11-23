Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3D8611007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 03:47:49 +1100 (EST)
Received: by vbal1 with SMTP id l1so1597057vba.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 08:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111114054144.23410.65704.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054144.23410.65704.stgit@suzukikp.in.ibm.com>
Date: Wed, 23 Nov 2011 11:47:46 -0500
Message-ID: <CA+5PVA6uVpB6XUFkjUABJCcVjubFiWWEQgmuMijTQpdAiN7PdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] [booke] Rename mapping based RELOCATABLE to
 DYNAMIC_MEMSTART for BookE
From: Josh Boyer <jwboyer@gmail.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2011 at 12:41 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wro=
te:
> The current implementation of CONFIG_RELOCATABLE in BookE is based
> on mapping the page aligned kernel load address to KERNELBASE. This
> approach however is not enough for platforms, where the TLB page size
> is large (e.g, 256M on 44x). So we are renaming the RELOCATABLE used
> currently in BookE to DYNAMIC_MEMSTART to reflect the actual method.
>
> The CONFIG_RELOCATABLE for PPC32(BookE) based on processing of the
> dynamic relocations will be introduced in the later in the patch series.
>
> This change would allow the use of the old method of RELOCATABLE for
> platforms which can afford to enforce the page alignment (platforms with
> smaller TLB size).

I'm OK with the general direction, but this touches a lot of non-4xx
code.  I'd prefer it if Ben took this directly on whatever final
solution is done.

> I haven tested this change only on 440x. I don't have an FSL BookE to ver=
ify
> the changes there.
>
> Scott,
> Could you please test this patch on FSL and let me know the results ?

Scott, did you ever get around to testing this?  In my opinion, this
shouldn't go in without a Tested-by: from someone that tried it on an
FSL platform.

> Suggested-by: Scott Wood <scottwood@freescale.com>
>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: =A0 =A0 Scott Wood <scottwood@freescale.com>
> Cc: =A0 =A0 Kumar Gala <galak@kernel.crashing.org>
> Cc: =A0 =A0 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: =A0 =A0 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
> ---
>
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 50 ++++++++++++++++---------
> =A0arch/powerpc/configs/44x/iss476-smp_defconfig | =A0 =A02 +
> =A0arch/powerpc/include/asm/kdump.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 ++-
> =A0arch/powerpc/include/asm/page.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04=
 +-
> =A0arch/powerpc/kernel/crash_dump.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +-
> =A0arch/powerpc/kernel/head_44x.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 ++
> =A0arch/powerpc/kernel/head_fsl_booke.S =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/powerpc/kernel/machine_kexec.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/powerpc/kernel/prom_init.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +
> =A0arch/powerpc/mm/44x_mmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +
> =A010 files changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d7c2d1a..8d4f789 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -363,7 +363,8 @@ config KEXEC
> =A0config CRASH_DUMP
> =A0 =A0 =A0 =A0bool "Build a kdump crash kernel"
> =A0 =A0 =A0 =A0depends on PPC64 || 6xx || FSL_BOOKE
> - =A0 =A0 =A0 select RELOCATABLE if PPC64 || FSL_BOOKE
> + =A0 =A0 =A0 select RELOCATABLE if PPC64
> + =A0 =A0 =A0 select DYNAMIC_MEMSTART if FSL_BOOKE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Build a kernel suitable for use as a kdump capture ker=
nel.
> =A0 =A0 =A0 =A0 =A0The same kernel binary can be used as production kerne=
l and dump
> @@ -841,23 +842,36 @@ config LOWMEM_CAM_NUM
> =A0 =A0 =A0 =A0int "Number of CAMs to use to map low memory" if LOWMEM_CA=
M_NUM_BOOL
> =A0 =A0 =A0 =A0default 3
>
> -config RELOCATABLE
> - =A0 =A0 =A0 bool "Build a relocatable kernel (EXPERIMENTAL)"
> +config DYNAMIC_MEMSTART

OK, so my one bikeshed comment here.

We add DYNAMIC_MEMSTART for 32-bit, and we have RELOCATABLE for
64-bit.  Then throughout almost the rest of the patch, all we're doing
is duplicating what RELOCATABLE already did (e.g. if ! either thing).
It works, but it is kind of ugly.

Instead, could we define a helper config variable that can be used in
place of that construct?  Something like:

config NONSTATIC_KERNEL (or whatever)
    bool
    default n

...

config DYNAMIC_MEMSTART
    <blah>
    select NONSTATIC_KERNEL

...

config RELOCATABLE
    <blah>
    select NONSTATIC_KERNEL


Then you can do this kind of thing:

       default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !(NONSTATIC_KER=
NEL)

#if defined(CONFIG_CRASH_DUMP) && !(defined(CONFIG_NONSTATIC_KERNEL))

instead of this:

       default "0x02000000" if PPC_STD_MMU && CRASH_DUMP &&
!(RELOCATABLE || DYNAMIC_MEMSTART)
#if defined(CONFIG_CRASH_DUMP) && !(defined(CONFIG_RELOCATABLE) || \
                                   defined(CONFIG_DYNAMIC_MEMSTART))

while still allowing for differences between RELOCATABLE and DYNAMIC_MEMSTA=
RT.

Thoughts?

josh
