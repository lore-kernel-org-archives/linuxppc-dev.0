Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70FE42C0301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 20:19:56 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v1][PATCH 0/7] powerpc/book3e: support kexec and kdump
Date: Tue, 26 Feb 2013 17:19:35 +0800
Message-ID: <1361870382-743-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is used to support kexec and kdump on book3e.

Tested on fsl-p5040 DS.

v1:
------
* improve some patch head
* rebase on next branch with patch 7

Tiejun Chen (7):
      powerpc/book3e: support CONFIG_RELOCATABLE
      book3e/kexec/kdump: enable kexec for kernel
      book3e/kexec/kdump: create a 1:1 TLB mapping
      book3e/kexec/kdump: introduce a kexec kernel flag
      book3e/kexec/kdump: implement ppc64 kexec specfic
      book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
      book3e/kexec/kdump: recover "r4 = 0" to create the initial TLB

 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/include/asm/exception-64e.h |    8 ++++
 arch/powerpc/include/asm/page.h          |    2 +
 arch/powerpc/include/asm/smp.h           |    3 ++
 arch/powerpc/kernel/exceptions-64e.S     |   15 ++++++-
 arch/powerpc/kernel/head_64.S            |   47 +++++++++++++++++++--
 arch/powerpc/kernel/machine_kexec_64.c   |    6 +++
 arch/powerpc/kernel/misc_64.S            |   67 +++++++++++++++++++++++++++++-
 arch/powerpc/lib/feature-fixups.c        |    7 ++++
 arch/powerpc/platforms/85xx/smp.c        |   27 ++++++++++++
 10 files changed, 178 insertions(+), 6 deletions(-)

Thanks
Tiejun
