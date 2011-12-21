Return-Path: <jwboyer@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B03AEB7119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 07:11:47 +1100 (EST)
Received: by wibhm4 with SMTP id hm4so2257293wib.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:11:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4=sc+QxqSp617BDBnOd+VfUis+r8QPJZLhRgee6Sy89A@mail.gmail.com>
References: <CA+5PVA4=sc+QxqSp617BDBnOd+VfUis+r8QPJZLhRgee6Sy89A@mail.gmail.com>
Date: Wed, 21 Dec 2011 15:11:40 -0500
Message-ID: <CA+5PVA4Npj98=gkzW+3AxUfrgfwU-PJWii=JRucFjLMkrHM-5g@mail.gmail.com>
Subject: Re: Please pull 'next' branch of 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Artem Bityutskiy <dedekind@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2011 at 11:23 AM, Josh Boyer <jwboyer@gmail.com> wrote:
> Hi Ben,
>
> This is the relocatable series from Suzie that has been brewing for quite=
 a
> while. =A0I also included a small fix for currituck that I hit when I was=
 building
> various kernels.
>
> NOTE: To build anything config that includes the NDFC driver, you need th=
e fix
> Tony posted and is in linux-next to the ndfc driver. =A0I didn't include =
it here
> since it is already queued up in the MTD tree.
>

I've added Suzie's patch from today to change the WARN to INFO in the boot
wrapper thing.  Updated tree info below.

josh

The following changes since commit 3f53638c805f75989f4b4be07efcfd173cdd5e2d=
:

  powerpc: Fix old bug in prom_init setting of the color (2011-12-19
14:41:25 +1100)

are available in the git repository at:
  git://git.infradead.org/users/jwboyer/powerpc-4xx.git next

Josh Boyer (1):
      powerpc/44x: Fix build error on currituck platform

Suzuki Poulose (8):
      powerpc: Rename mapping based RELOCATABLE to DYNAMIC_MEMSTART for Boo=
kE
      powerpc/44x: Enable DYNAMIC_MEMSTART for 440x
      powerpc: Process dynamic relocations for kernel
      powerpc: Define virtual-physical translations for RELOCATABLE
      powerpc/44x: Enable CONFIG_RELOCATABLE for PPC44x
      powerpc/44x: Enable CRASH_DUMP for 440x
      powerpc/boot: Change the load address for the wrapper to fit the kern=
el
      powerpc/boot: Change the WARN to INFO for boot wrapper overlap messag=
e

 arch/powerpc/Kconfig                          |   45 +++++-
 arch/powerpc/Makefile                         |    6 +-
 arch/powerpc/boot/wrapper                     |   20 +++
 arch/powerpc/configs/44x/iss476-smp_defconfig |    3 +-
 arch/powerpc/include/asm/kdump.h              |    4 +-
 arch/powerpc/include/asm/page.h               |   89 ++++++++++-
 arch/powerpc/kernel/Makefile                  |    2 +
 arch/powerpc/kernel/crash_dump.c              |    4 +-
 arch/powerpc/kernel/head_44x.S                |  105 +++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S          |    2 +-
 arch/powerpc/kernel/machine_kexec.c           |    2 +-
 arch/powerpc/kernel/prom_init.c               |    2 +-
 arch/powerpc/kernel/reloc_32.S                |  208 +++++++++++++++++++++=
++++
 arch/powerpc/kernel/vmlinux.lds.S             |    8 +-
 arch/powerpc/mm/44x_mmu.c                     |    2 +-
 arch/powerpc/mm/init_32.c                     |    7 +
 arch/powerpc/platforms/44x/currituck.c        |    2 +-
 arch/powerpc/relocs_check.pl                  |   14 ++-
 18 files changed, 496 insertions(+), 29 deletions(-)
 create mode 100644 arch/powerpc/kernel/reloc_32.S
