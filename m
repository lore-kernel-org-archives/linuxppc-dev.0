Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4582C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:24:22 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <mikey@neuling.org>,
 <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>, <agraf@suse.de>
Subject: [PATCH 0/2] powerpc: allow kvm to use kerel debug framework
Date: Thu, 4 Jul 2013 11:45:44 +0530
Message-ID: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <bharat.bhushan@freescale.com>

This patchset moves the debug registers in a structure, which allows
kvm to use same structure for debug emulation.

Note: Earilier a patchset "https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-June/108132.html"
was sent which is a bunch of six patches. That patchset is divided into two parts:
	1) powerpc specific changes (These 2 patches are actually have those changes)
	2) KVM specific changes (will send separate patch on agraf repository)

Bharat Bhushan (2):
  powerpc: remove unnecessary line continuations
  powerpc: move debug registers in a structure

 arch/powerpc/include/asm/processor.h |   38 +++++----
 arch/powerpc/include/asm/reg_booke.h |    8 +-
 arch/powerpc/kernel/asm-offsets.c    |    2 +-
 arch/powerpc/kernel/process.c        |   42 +++++-----
 arch/powerpc/kernel/ptrace.c         |  154 +++++++++++++++++-----------------
 arch/powerpc/kernel/ptrace32.c       |    2 +-
 arch/powerpc/kernel/signal_32.c      |    6 +-
 arch/powerpc/kernel/traps.c          |   35 ++++----
 8 files changed, 147 insertions(+), 140 deletions(-)
