Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmd1SLBzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:48 +1000 (AEST)
Message-Id: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/7] Prepare 8xx for CONFIG_STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:43 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie makes the PINning of ITLBs optional in the 8xx
in order to allow STRICT_KERNEL_RWX to work properly

Christophe Leroy (7):
  powerpc/8xx: Ensures RAM mapped with LTLB is seen as block mapped on
    8xx.
  powerpc/8xx: Remove macro that checks kernel address
  powerpc/32: Avoid risk of unrecoverable TLBmiss inside entry_32.S
  powerpc/8xx: Make pinning of ITLBs optional
  powerpc/8xx: Do not allow Pinned TLBs with STRICT_KERNEL_RWX or
    DEBUG_PAGEALLOC
  powerpc/8xx: mark init functions with __init
  powerpc/8xx: Reduce DTLB miss handler by one insn

 arch/powerpc/Kconfig           | 13 +++++-
 arch/powerpc/kernel/entry_32.S |  7 +++
 arch/powerpc/kernel/head_8xx.S | 96 +++++++++++++++++++++++++++++-------------
 arch/powerpc/mm/8xx_mmu.c      | 29 ++++++++++---
 4 files changed, 107 insertions(+), 38 deletions(-)

-- 
2.12.0
