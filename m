Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYF3d8RzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYF1J2hz9sNc
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:49 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 00/17] powerpc: Do alignment fixups using analyse_instr etc.
Date: Wed, 30 Aug 2017 14:12:23 +1000
Message-Id: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series extends the instruction emulation infrastructure in
arch/powerpc/lib/sstep.c and uses it for emulating instructions when
we get an alignment interrupt.  The advantage of this is that we only
have to add the new POWER9 instructions in one place, and it fixes
several bugs in alignment interrupt handling that have been identified
recently.

With this, analyse_instr() and emulate_step() handle almost all load
and store instructions in Power ISA v3.00 -- all except the atomic
memory operations (lwat, stwat, etc.).  We now always use the largest
possible aligned memory accesses (up to 8 bytes) to emulate unaligned
accesses.  If we get a fault, the faulting address is accurately
recorded in regs->dar.  We also can now access FP/VMX/VSX registers
directly if they are live, without having to spill them all to the
thread_struct and the reload them all later.  There are also various
other fixes in the series.

This version is based on the current powerpc next branch.

Paul.

 arch/powerpc/Kconfig                  |    4 -
 arch/powerpc/include/asm/ppc-opcode.h |   10 +-
 arch/powerpc/include/asm/sstep.h      |   90 +-
 arch/powerpc/kernel/align.c           |  774 +-----------
 arch/powerpc/lib/Makefile             |    3 +-
 arch/powerpc/lib/ldstfp.S             |  307 ++---
 arch/powerpc/lib/quad.S               |   62 +
 arch/powerpc/lib/sstep.c              | 2139 +++++++++++++++++++++++----------
 8 files changed, 1802 insertions(+), 1587 deletions(-)
