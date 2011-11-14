Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4A7DB71CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 17:17:52 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 14 Nov 2011 11:47:50 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAE6Hjn51847402
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 11:47:45 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAE6HhHq003833
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 17:17:44 +1100
Message-ID: <4EC0B287.6010708@in.ibm.com>
Date: Mon, 14 Nov 2011 11:47:43 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 0/8] Kdump support for PPC440x
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Josh Poimboeuf <jpoimboe@us.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Don't know what happened to the Cover message. Resending this again ]

The following series implements:

  * Generic framework for relocatable kernel on PPC32, based on processing
    the dynamic relocation entries.
  * Relocatable kernel support for 44x
  * Kdump support for 44x. Doesn't support 47x yet, as the kexec
    support is missing.

Changes from V2:

  * Renamed old style mapping based RELOCATABLE on BookE to DYNAMIC_MEMSTART.
    Suggested by: Scott Wood
  * Added support for DYNAMIC_MEMSTART on PPC440x
  * Reverted back to RELOCATABLE and RELOCATABLE_PPC32 from RELOCATABLE_PPC32_PIE
  * Ensure the modified instructions are flushed and the i-cache invalidated at
    the end of relocate(). - Reported by : Josh Poimboeuf

Changes from V1:

  * Splitted patch 'Enable CONFIG_RELOCATABLE for PPC44x' to move some
    of the generic bits to a new patch.
  * Renamed RELOCATABLE_PPC32 to RELOCATABLE_PPC32_PIE and provided options to
    retained old style mapping. (Suggested by: Scott Wood)
  * Added support for avoiding the overlapping of uncompressed kernel
    with boot wrapper for PPC images.

The patches are based on -next tree for ppc.

I have tested these patches on Ebony, Sequoia and Virtex(QEMU Emulated).
I haven't tested the RELOCATABLE bits on PPC_47x yet, as I don't have access
to one. However, it should work fine there as we only depend on the runtime
address and the XLAT entry setup by the boot loader. It would be great if
somebody could test these patches on a 47x.

---

Suzuki K. Poulose (8):
       [boot] Change the load address for the wrapper to fit the kernel
       [44x] Enable CRASH_DUMP for 440x
       [44x] Enable CONFIG_RELOCATABLE for PPC44x
       [ppc] Define virtual-physical translations for RELOCATABLE
       [ppc] Process dynamic relocations for kernel
       [44x] Enable DYNAMIC_MEMSTART for 440x
       [booke] Rename mapping based RELOCATABLE to DYNAMIC_MEMSTART for BookE
       [44x] Fix typo in KEXEC Kconfig dependency


  arch/powerpc/Kconfig                          |   39 ++++-
  arch/powerpc/Makefile                         |    6 -
  arch/powerpc/boot/wrapper                     |   20 ++
  arch/powerpc/configs/44x/iss476-smp_defconfig |    2
  arch/powerpc/include/asm/kdump.h              |    5 -
  arch/powerpc/include/asm/page.h               |   89 ++++++++++-
  arch/powerpc/kernel/Makefile                  |    2
  arch/powerpc/kernel/crash_dump.c              |    4
  arch/powerpc/kernel/head_44x.S                |  100 ++++++++++++
  arch/powerpc/kernel/head_fsl_booke.S          |    2
  arch/powerpc/kernel/machine_kexec.c           |    2
  arch/powerpc/kernel/prom_init.c               |    2
  arch/powerpc/kernel/reloc_32.S                |  207 +++++++++++++++++++++++++
  arch/powerpc/kernel/vmlinux.lds.S             |    8 +
  arch/powerpc/mm/44x_mmu.c                     |    2
  arch/powerpc/mm/init_32.c                     |    7 +
  16 files changed, 470 insertions(+), 27 deletions(-)
  create mode 100644 arch/powerpc/kernel/reloc_32.S

--
Suzuki
