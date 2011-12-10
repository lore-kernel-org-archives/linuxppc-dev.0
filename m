Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1CB211007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 16:02:05 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Sat, 10 Dec 2011 10:32:00 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBA51tZ04481136
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 10:31:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBA51t9W025067
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 10:31:55 +0530
Message-ID: <4EE2E7C0.2040102@in.ibm.com>
Date: Sat, 10 Dec 2011 10:31:52 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/7] Kudmp support for PPC440x
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/11 17:13, Suzuki K. Poulose wrote:
> The following series implements:
>
>   * Generic framework for relocatable kernel on PPC32, based on processing
>     the dynamic relocation entries.
>   * Relocatable kernel support for 44x
>   * Kdump support for 44x. Doesn't support 47x yet, as the kexec
>     support is missing.
>
> Changes from V3:
>
>   * Added a new config - NONSTATIC_KERNEL - to group different types of relocatable
>     kernel. (Suggested by: Josh Boyer)
>   * Added supported ppc relocation types in relocs_check.pl for verifying the
>     relocations used in the kernel.
>
> Changes from V2:
>
>   * Renamed old style mapping based RELOCATABLE on BookE to DYNAMIC_MEMSTART.
>     Suggested by: Scott Wood
>   * Added support for DYNAMIC_MEMSTART on PPC440x
>   * Reverted back to RELOCATABLE and RELOCATABLE_PPC32 from RELOCATABLE_PPC32_PIE
>     for relocation based on processing dynamic reloc entries for PPC32.
>   * Ensure the modified instructions are flushed and the i-cache invalidated at
>     the end of relocate(). - Reported by : Josh Poimboeuf
>
> Changes from V1:
>
>   * Splitted patch 'Enable CONFIG_RELOCATABLE for PPC44x' to move some
>     of the generic bits to a new patch.
>   * Renamed RELOCATABLE_PPC32 to RELOCATABLE_PPC32_PIE and provided options to
>     retained old style mapping. (Suggested by: Scott Wood)
>   * Added support for avoiding the overlapping of uncompressed kernel
>     with boot wrapper for PPC images.
>
> The patches are based on -next tree for ppc.
>
> I have tested these patches on Ebony, Sequoia and Virtex(QEMU Emulated).
> I haven't tested the RELOCATABLE bits on PPC_47x yet, as I don't have access
> to one. However, RELOCATABLE should work fine there as we only depend on the
> runtime address and the XLAT entry setup by the boot loader. It would be great if
> somebody could test these patches on a 47x.
>
>
> ---

Updated diffstats:

Suzuki K. Poulose (7):
       [boot] Change the load address for the wrapper to fit the kernel
       [44x] Enable CRASH_DUMP for 440x
       [44x] Enable CONFIG_RELOCATABLE for PPC44x
       [ppc] Define virtual-physical translations for RELOCATABLE
       [ppc] Process dynamic relocations for kernel
       [44x] Enable DYNAMIC_MEMSTART for 440x
       [booke] Rename mapping based RELOCATABLE to DYNAMIC_MEMSTART for BookE


  arch/powerpc/Kconfig                          |   46 +++++-
  arch/powerpc/Makefile                         |    6 -
  arch/powerpc/boot/wrapper                     |   20 ++
  arch/powerpc/configs/44x/iss476-smp_defconfig |    2
  arch/powerpc/include/asm/kdump.h              |    4
  arch/powerpc/include/asm/page.h               |   89 ++++++++++-
  arch/powerpc/kernel/Makefile                  |    2
  arch/powerpc/kernel/crash_dump.c              |    4
  arch/powerpc/kernel/head_44x.S                |  105 +++++++++++++
  arch/powerpc/kernel/head_fsl_booke.S          |    2
  arch/powerpc/kernel/machine_kexec.c           |    2
  arch/powerpc/kernel/prom_init.c               |    2
  arch/powerpc/kernel/reloc_32.S                |  207 +++++++++++++++++++++++++
  arch/powerpc/kernel/vmlinux.lds.S             |    8 +
  arch/powerpc/mm/44x_mmu.c                     |    2
  arch/powerpc/mm/init_32.c                     |    7 +
  arch/powerpc/relocs_check.pl                  |    7 +
  17 files changed, 489 insertions(+), 26 deletions(-)
  create mode 100644 arch/powerpc/kernel/reloc_32.S


Thanks
Suzuki
