Return-Path: <SRS0=xy+f=GZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2D6238EE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2D6238EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMZqr1vkLzDrg4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 21:14:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMZdT346YzDrdT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2021 21:05:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DMZdG4THgz9vBmm;
 Fri, 22 Jan 2021 11:05:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HmvJJTgS_C-x; Fri, 22 Jan 2021 11:05:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DMZdG3RDHz9vBml;
 Fri, 22 Jan 2021 11:05:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A889B8B818;
 Fri, 22 Jan 2021 11:05:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3nCgHEcowuoo; Fri, 22 Jan 2021 11:05:23 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FBD38B773;
 Fri, 22 Jan 2021 11:05:23 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3015F66AAE; Fri, 22 Jan 2021 10:05:23 +0000 (UTC)
Message-Id: <cover.1611309841.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 00/14] powerpc/32: Reduce head complexity and re-activate
 MMU earlier
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Fri, 22 Jan 2021 10:05:23 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series is a first step on the way to C syscall/exception entry/exit.

This series aims at reducing exception/syscall prologs complexity.
It also brings earlier MMU re-activation.

This series is based on Nick's v6 series "powerpc: interrupt wrappers".
It takes benefit of the removal of traps arguments (patches 2-7 of that series).
I have squashed those patches as second patch of my series in order to
please test robots. My series cleanly applies on top of entire Nick's series.

v2 has been reworked in order to apply to all PPC32, including BOOKE and 40x.

At the time being, we have two pathes in the prologs: one for
when we have VMAP stack and one when we don't.

When VMAP stack is supported, there is special prolog code to
allow accessing stack with MMU on.

That code that accesses VM stack with MMU on is also able to access
linear memory, so it can also access non VM stack with MMU on.

CONFIG_VMAP_STACK as been on by default on 6xx and 8xx for several
kernel releases now, so it is known to work.

On the 8xx, null_syscall runs in 292 cycles with VMAP_STACK and in
296 cycles without VMAP stack.
On the 832x, null_syscall runs in 224 cycles with VMAP_STACK and in
213 cycles without VMAP stack.

By removing the old non VMAP stack code, and using the same prolog
regardless of the activation of VMAP stacks, we make the code a lot
simplier and reduce the number of test cases.

BOOKE has MMU always on, so there is no change needed for that.
To allow removal of the old non VMAP stack code, only 40x need
to get adapted to support earlier MMU activation. That's what
patches 3-8 are for.

Once this is done, we easily go one step further and re-activate
Instruction translation at the same time as data translation.

At the end, null_syscall runs in 286 cycles on the 8xx and in 216
cycles on the 832x

Changes in v2:
- Implemented early MMU activation also on 40x
- Added BOOKE in the loop
- Removed the patches that replace r11 by r1 all over the place (too
much churn for very small benefit for now)

Christophe Leroy (14):
  powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is
    selected
  NOT TO BE MERGED - Squash of patches 2-7 of v6 series "powerpc:
    interrupt wrappers"
  powerpc/40x: Don't use SPRN_SPRG_SCRATCH0/1 in TLB miss handlers
  powerpc/40x: Change CRITICAL_EXCEPTION_PROLOG macro to a gas macro
  powerpc/40x: Save SRR0/SRR1 and r10/r11 earlier in critical exception
  powerpc/40x: Reorder a few instructions in critical exception prolog
  powerpc/40x: Prepare for enabling MMU in critical exception prolog
  powerpc/40x: Prepare normal exception handler for enabling MMU early
  powerpc/32: Preserve cr1 in exception prolog stack check
  powerpc/32: Use LOAD_REG_IMMEDIATE() to load MSR values
  powerpc/32: Always enable data translation in exception prolog
  powerpc/32: Enable instruction translation at the same time as data
    translation
  powerpc/32: Remove msr argument in EXC_XFER_TEMPLATE()
  powerpc/32: Use fast instructions to change MSR EE/RI when available

 arch/powerpc/include/asm/asm-prototypes.h     |   4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/bug.h                |   7 +-
 arch/powerpc/include/asm/debug.h              |   3 +-
 arch/powerpc/include/asm/hw_irq.h             |  46 +++++
 arch/powerpc/include/asm/processor.h          |   4 +-
 arch/powerpc/kernel/asm-offsets.c             |   2 -
 arch/powerpc/kernel/entry_32.S                | 128 ++++----------
 arch/powerpc/kernel/exceptions-64e.S          |   5 +-
 arch/powerpc/kernel/exceptions-64s.S          | 164 +++++------------
 arch/powerpc/kernel/fpu.S                     |   2 -
 arch/powerpc/kernel/head_32.h                 | 167 ++++--------------
 arch/powerpc/kernel/head_40x.S                | 161 +++++++++--------
 arch/powerpc/kernel/head_8xx.S                |  26 +--
 arch/powerpc/kernel/head_book3s_32.S          |  52 ++----
 arch/powerpc/kernel/head_booke.h              |  20 +--
 arch/powerpc/kernel/idle_6xx.S                |  12 +-
 arch/powerpc/kernel/idle_e500.S               |   4 +-
 arch/powerpc/kernel/process.c                 |   7 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/kernel/vector.S                  |   2 -
 arch/powerpc/mm/book3s32/Makefile             |   4 +-
 arch/powerpc/mm/book3s32/hash_low.S           |  14 --
 arch/powerpc/mm/book3s64/hash_utils.c         |  79 ++++++---
 arch/powerpc/mm/book3s64/slb.c                |  11 +-
 arch/powerpc/mm/fault.c                       |  18 +-
 arch/powerpc/platforms/8xx/machine_check.c    |   2 +-
 27 files changed, 354 insertions(+), 593 deletions(-)

-- 
2.25.0

