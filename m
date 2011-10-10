Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CE7F2B6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:54:29 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
 by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9A9qoUM021545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:52:50 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9A9q9Q81761358
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:52:09 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9A9sRRw013556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:54:28 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 0/3] Kdump support for PPC440x
To: linux ppc dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Oct 2011 15:24:23 +0530
Message-ID: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Scott Wood <scottwood@freescale.com>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series implements CRASH_DUMP support for PPC440x. The
patches apply on top of power-next tree. This set also adds support
for CONFIG_RELOCATABLE on 44x.

I have tested the patches on Ebony and Virtex(QEMU Emulated). Testing
these patches would require latest snapshot of kexec-tools git tree and
(preferrably) the following patch for kexec-tools :

	http://lists.infradead.org/pipermail/kexec/2011-October/005552.html

---

Suzuki K. Poulose (3):
      [44x] Enable CRASH_DUMP for 440x
      [44x] Enable CONFIG_RELOCATABLE for PPC44x
      [powerpc32] Process dynamic relocations for kernel


 arch/powerpc/Kconfig              |   10 +-
 arch/powerpc/Makefile             |    1 
 arch/powerpc/include/asm/page.h   |   84 ++++++++++++++++
 arch/powerpc/kernel/Makefile      |    2 
 arch/powerpc/kernel/head_44x.S    |  111 ++++++++++++++++++---
 arch/powerpc/kernel/reloc_32.S    |  194 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S |    8 +-
 arch/powerpc/mm/init_32.c         |    7 +
 8 files changed, 396 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/kernel/reloc_32.S

-- 
Thanks
Suzuki
