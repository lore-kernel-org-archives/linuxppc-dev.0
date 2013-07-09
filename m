Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DA772C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 18:02:43 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v3][PATCH 0/8] powerpc/book3e: support kexec and kdump
Date: Tue, 9 Jul 2013 16:03:19 +0800
Message-ID: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
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

v3:

* add one patch to rename interrupt_end_book3e with __end_interrupts
  then we can have a unique lable for book3e and book3s.
* add some comments for "book3e/kexec/kdump: enable kexec for kernel"
* clean "book3e/kexec/kdump: introduce a kexec kernel flag"

v2:
* rebase on merge branch

v1:
* improve some patch head
* rebase on next branch with patch 7

----------------------------------------------------------------
Tiejun Chen (8):
      powerpc/book3e: rename interrupt_end_book3e with __end_interrupts
      powerpc/book3e: support CONFIG_RELOCATABLE
      book3e/kexec/kdump: enable kexec for kernel
      book3e/kexec/kdump: create a 1:1 TLB mapping
      book3e/kexec/kdump: introduce a kexec kernel flag
      book3e/kexec/kdump: implement ppc64 kexec specfic
      book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
      book3e/kexec/kdump: recover "r4 = 0" to create the initial TLB

 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/include/asm/exception-64e.h |   11 +++
 arch/powerpc/include/asm/page.h          |    2 +
 arch/powerpc/include/asm/smp.h           |    1 +
 arch/powerpc/kernel/exceptions-64e.S     |   26 +++++-
 arch/powerpc/kernel/head_64.S            |   48 +++++++++-
 arch/powerpc/kernel/machine_kexec_64.c   |  148 +++++++++++++++++-------------
 arch/powerpc/kernel/misc_64.S            |   67 +++++++++++++-
 arch/powerpc/platforms/85xx/smp.c        |   33 ++++++-
 9 files changed, 257 insertions(+), 81 deletions(-)

 arch/powerpc/kernel/exceptions-64e.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Tiejun
