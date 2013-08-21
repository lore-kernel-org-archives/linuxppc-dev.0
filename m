Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B642A2C0109
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 12:12:55 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/4] powerpc/e500: rework compiler flags
Date: Tue, 20 Aug 2013 21:12:38 -0500
Message-ID: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces the reverted "powerpc/e500: Update compilation flags with
core specific options" with a more multiplatform friendly approach
(on 64-bit) and hopefully without breaking anything this time. :-)

This patchset touches parts of code that are also touched by
http://patchwork.ozlabs.org/patch/261248/, so that patch is a
prerequisite.

Scott Wood (4):
  powerpc: Convert some mftb/mftbu into mfspr
  powerpc/85xx: Remove -Wa,-me500
  powerpc/booke64: Use appropriate -mcpu
  powerpc/e500: Set -mcpu flag for 32-bit e500

 arch/powerpc/Makefile                     | 18 +++++++++++++++++-
 arch/powerpc/boot/ppc_asm.h               |  3 +++
 arch/powerpc/boot/util.S                  | 10 +++++-----
 arch/powerpc/include/asm/ppc_asm.h        |  4 ++--
 arch/powerpc/include/asm/reg.h            | 15 ++++++++++-----
 arch/powerpc/include/asm/timex.h          |  4 ++--
 arch/powerpc/kernel/vdso32/gettimeofday.S |  6 +++---
 arch/powerpc/platforms/85xx/smp.c         |  6 ++++--
 arch/powerpc/platforms/Kconfig.cputype    | 13 +++++++++++++
 9 files changed, 59 insertions(+), 20 deletions(-)

-- 
1.8.1.2
