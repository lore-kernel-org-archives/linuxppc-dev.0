Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dMg5SqZzF201
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:31 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id s18so9986940wrg.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:30 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 00/19] powerpc/ppc32: make W=1 compilation errors free
Date: Thu, 22 Mar 2018 21:19:46 +0100
Message-Id: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is another batch for warnings treated as error on ppc32. Tested with:

$ make ARCH=powerpc ppc32_defconfig
$ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- W=1

Using:

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516

Mathieu Malaterre (19):
  powerpc/powermac: Mark variable x as unused
  powerpc/powermac: Mark variable x as unused
  powerpc: Mark variables as unused
  powerpc/kvm: Mark variable tmp unused
  powerpc/chrp/setup: Add attribute unused and make some functions
    static
  powerpc: Make function btext_initialize static
  powerpc/powermac: Make some functions static
  powerpc/tau: Make some function static
  powerpc/chrp/pci: Make some functions static
  powerpc/chrp/time: Make some functions static, add missing header
    include
  powerpc/powermac: Move pmac_pfunc_base_install prototype to header
    file
  powerpc/powermac: Add missing prototype for note_bootable_part()
  powerpc/52xx: Add missing functions prototypes
  powerpc/altivec: Add missing prototypes for altivec
  powerpc: Add missing prototype
  powerpc/powermac: Add missing include of header pmac.h
  powerpc/32: Add a missing include header
  powerpc: Add a missing include header
  powerpc/tau: Synchronize function prototypes and body

 arch/powerpc/include/asm/mpc52xx.h           |  6 +++---
 arch/powerpc/include/asm/pmac_pfunc.h        |  1 +
 arch/powerpc/include/asm/rheap.h             |  3 +++
 arch/powerpc/kernel/btext.c                  |  2 +-
 arch/powerpc/kernel/irq.c                    |  2 +-
 arch/powerpc/kernel/kvm.c                    |  2 +-
 arch/powerpc/kernel/pci_32.c                 |  1 +
 arch/powerpc/kernel/prom_init.c              |  4 ++--
 arch/powerpc/kernel/setup-common.c           |  6 ------
 arch/powerpc/kernel/setup.h                  |  6 ++++++
 arch/powerpc/kernel/tau_6xx.c                | 15 +++++++++------
 arch/powerpc/kernel/vecemu.c                 |  1 +
 arch/powerpc/lib/xor_vmx.h                   | 14 ++++++++++++++
 arch/powerpc/platforms/chrp/pci.c            |  8 ++++----
 arch/powerpc/platforms/chrp/setup.c          | 10 +++++-----
 arch/powerpc/platforms/chrp/time.c           |  6 ++++--
 arch/powerpc/platforms/powermac/bootx_init.c |  2 +-
 arch/powerpc/platforms/powermac/pci.c        | 10 +++++-----
 arch/powerpc/platforms/powermac/setup.c      |  1 +
 arch/powerpc/platforms/powermac/smp.c        |  1 -
 arch/powerpc/platforms/powermac/time.c       |  4 +++-
 arch/powerpc/platforms/powermac/udbg_scc.c   |  2 +-
 22 files changed, 67 insertions(+), 40 deletions(-)

-- 
2.11.0
