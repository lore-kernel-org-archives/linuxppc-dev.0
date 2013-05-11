Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64C1D2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 09:26:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 0/4] enable the PACA_IRQ_EE_EDGE support for book3e
Date: Sun, 12 May 2013 07:26:20 +0800
Message-ID: <1368314784-971-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

In the current kernel, the external proxy works pretty well with the lazy
EE. But it still treat the external input interrupt as level sensitive
and would hard disable the irq while a interrupt occurs with irq soft
disabled. This patch series enables PACA_IRQ_EE_EDGE support for book3e
and will leave the irq still hard enabled while a external interrupt
occurs with soft irq disabled. This passed the boot test on T4240QDS
board.

---
Kevin Hao (4):
  powerpc/book3e: introduce external_input_edge exception handler for
    64bit kernel
  powerpc: move the patch_exception to a common place
  powerpc: use patch_exception to update the debug exception handler
  powerpc/fsl-book3e: enable the external_input_edge exception handler

 arch/powerpc/include/asm/code-patching.h |  7 +++++++
 arch/powerpc/include/asm/paca.h          |  1 +
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kernel/entry_64.S           |  2 ++
 arch/powerpc/kernel/exceptions-64e.S     | 26 +++++++++++++++++++++++---
 arch/powerpc/kernel/irq.c                | 12 ++++++------
 arch/powerpc/kernel/paca.c               |  3 +++
 arch/powerpc/kernel/setup_64.c           |  6 +-----
 arch/powerpc/lib/code-patching.c         | 15 +++++++++++++++
 arch/powerpc/mm/tlb_nohash.c             | 19 -------------------
 arch/powerpc/platforms/85xx/corenet_ds.c |  9 ++++++++-
 arch/powerpc/sysdev/mpic.c               |  8 ++++++++
 12 files changed, 75 insertions(+), 34 deletions(-)

Thanks,
Kevin
-- 
1.8.1.4
