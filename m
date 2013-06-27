Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53EA42C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 12:01:22 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc: enable the relocatable support for fsl booke
 32bit kernel
Date: Thu, 27 Jun 2013 10:00:32 +0800
Message-ID: <1372298434-20220-1-git-send-email-haokexin@gmail.com>
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

Currently the fsl booke 32bit kernel is using the DYNAMIC_MEMSTART relocation
method. But the RELOCATABLE method is more flexible and has less alignment
restriction. So enable this feature on this platform and use it by
default for the kdump kernel.

These patches have passed the kdump boot test on a p2020rdb board.

Kevin Hao (2):
  powerpc: enable the relocatable support for the fsl booke 32bit kernel
  powerpc/fsl_booke: enable the relocatable for the kdump kernel

 arch/powerpc/Kconfig                          |  5 +-
 arch/powerpc/include/asm/mmu-book3e.h         |  5 ++
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  8 ++-
 arch/powerpc/kernel/head_fsl_booke.S          | 92 +++++++++++++++++++++++++--
 arch/powerpc/mm/fsl_booke_mmu.c               | 30 ++++++++-
 5 files changed, 127 insertions(+), 13 deletions(-)

-- 
1.8.1.4
