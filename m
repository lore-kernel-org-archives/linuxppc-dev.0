Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 697661007DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:01 +1100 (EST)
Received: from /spool/local by e23smtp09.au.ibm.com with XMail ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 25 Oct 2011 12:48:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9PBroxD2535530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:53:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9PBrnJW019321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:53:50 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 0/5] Kdump support for PPC440x
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 25 Oct 2011 17:23:45 +0530
Message-ID: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series implements:

 * Generic framework for relocatable kernel on PPC32, based on processing 
   the dynamic relocation entries.
 * Relocatable kernel support for 44x
 * Kdump support for 44x. Doesn't support 47x yet, as the kexec 
   support is missing.

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

Suzuki K. Poulose (5):
      [boot] Change the load address for the wrapper to fit the kernel
      [44x] Enable CRASH_DUMP for 440x
      [44x] Enable CONFIG_RELOCATABLE for PPC44x
      [ppc] Define virtual-physical translations for PIE relocations
      [ppc] Process dynamic relocations for kernel


 arch/powerpc/Kconfig              |   18 +++
 arch/powerpc/Makefile             |    1 
 arch/powerpc/boot/wrapper         |   20 ++++
 arch/powerpc/include/asm/page.h   |   85 ++++++++++++++++
 arch/powerpc/kernel/Makefile      |    2 
 arch/powerpc/kernel/head_44x.S    |  110 ++++++++++++++++++++-
 arch/powerpc/kernel/reloc_32.S    |  194 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S |    8 +-
 arch/powerpc/mm/init_32.c         |    7 +
 9 files changed, 434 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/kernel/reloc_32.S

--
Suzuki Poulose
