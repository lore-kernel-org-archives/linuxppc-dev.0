Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTxpy43ntzDqh9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:45:30 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rTxpy18PKz9t1B
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 16:45:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5F6hnYj065455
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 02:45:28 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jfmpgd48-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 02:45:28 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 15 Jun 2016 16:45:26 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2C15F2BB0055
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 16:45:24 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5F6jO2X10289434
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 16:45:24 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5F6jNTh002854
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 16:45:24 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 2/2] powerpc: tm: Always reclaim in start_thread() for exec()
 class syscalls
Date: Wed, 15 Jun 2016 16:44:57 +1000
In-Reply-To: <20160615064457.8369-1-cyrilbur@gmail.com>
References: <20160615064457.8369-1-cyrilbur@gmail.com>
Message-Id: <20160615064457.8369-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Userspace can quite legitimately perform an exec() syscall with a
suspended transaction. exec() does not return to the old process,
rather it load a new one and starts that, the expectation therefore is
that the new process starts not in a transaction. Currently exec() is
not treated any differently to any other syscall which creates
problems.

Firstly it could allow a new process to start with a suspended
transaction for a binary that no longer exists. This means that the
checkpointed state won't be valid and if the suspended transaction
were ever to be resumed and subsequently aborted (a possibility which
is exceedingly likely as exec()ing will likely doom the transaction)
the new process will jump to invalid state.

Secondly the incorrect attempt to keep the transactional state while
still zeroing state for the new process creates at least two TM Bad
Things. The first triggers on the rfid to return to userspace as
start_thread() has given the new process a 'clean' MSR but the suspend
will still be set in the hardware MSR. The second TM Bad Thing
triggers in __switch_to() as the processor is still transactionally
suspended but __switch_to() wants to zero the TM sprs for the new
process.

This is an example of the outcome of calling exec() with a suspended
transaction. Note the first 700 is likely the first TM bad thing
decsribed earlier only the kernel can't report it as we've loaded
userspace registers. c000000000009980 is the rfid in
fast_exception_return()

Bad kernel stack pointer 3fffcfa1a370 at c000000000009980
Oops: Bad kernel stack pointer, sig: 6 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 2006 Comm: tm-execed Not tainted
4.6.0-rc3cyrilb769744c1efb74735f687b36ba6f97b5668e0f515 #1
task: c0000000fbea6d80 ti: c00000003ffec000 task.ti: c0000000fb7ec000
NIP: c000000000009980 LR: 0000000000000000 CTR: 0000000000000000
REGS: c00000003ffefd40 TRAP: 0700   Not tainted
(4.6.0-rc3cyrilb769744c1efb74735f687b36ba6f97b5668e0f515)
MSR: 8000000300201031 <SF,ME,IR,DR,LE,TM[SE]>  CR: 00000000  XER: 00000000
CFAR: c0000000000098b4 SOFTE: 0
PACATMSCRATCH: b00000010000d033
GPR00: 0000000000000000 00003fffcfa1a370 0000000000000000 0000000000000000
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR12: 00003fff966611c0 0000000000000000 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
NIP [c000000000009980] fast_exception_return+0xb0/0xb8
LR [0000000000000000]           (null)
Call Trace:
Instruction dump:
f84d0278 e9a100d8 7c7b03a6 e84101a0 7c4ff120 e8410170 7c5a03a6 e8010070
e8410080 e8610088 e8810090 e8210078 <4c000024> 48000000 e8610178 88ed023b
---[ end trace 4d79afb454bb5313 ]---

------------[ cut here ]------------
Kernel BUG at c000000000043e80 [verbose debug info unavailable]
Unexpected TM Bad Thing exception at c000000000043e80 (msr 0x201033)
Oops: Unrecoverable exception, sig: 6 [#2]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 2006 Comm: tm-execed Tainted: G      D
4.6.0-rc3cyrilb769744c1efb74735f687b36ba6f97b5668e0f515 #1
task: c0000000fbea6d80 ti: c00000003ffec000 task.ti: c0000000fb7ec000
NIP: c000000000043e80 LR: c000000000015a24 CTR: 0000000000000000
REGS: c00000003ffef7e0 TRAP: 0700   Tainted: G      D
(4.6.0-rc3cyrilb769744c1efb74735f687b36ba6f97b5668e0f515)
MSR: 8000000300201033 <SF,ME,IR,DR,RI,LE,TM[SE]>  CR: 28002828  XER: 00000000
CFAR: c000000000015a20 SOFTE: 0
PACATMSCRATCH: b00000010000d033
GPR00: 0000000000000000 c00000003ffefa60 c000000000db5500 c0000000fbead000
GPR04: 8000000300001033 2222222222222222 2222222222222222 00000000ff160000
GPR08: 0000000000000000 800000010000d033 c0000000fb7e3ea0 c00000000fe00004
GPR12: 0000000000002200 c00000000fe00000 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 c0000000fbea7410 00000000ff160000
GPR24: c0000000ffe1f600 c0000000fbea8700 c0000000fbea8700 c0000000fbead000
GPR28: c000000000e20198 c0000000fbea6d80 c0000000fbeab680 c0000000fbea6d80
NIP [c000000000043e80] tm_restore_sprs+0xc/0x1c
LR [c000000000015a24] __switch_to+0x1f4/0x420
Call Trace:
Instruction dump:
7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0 7c0122a6 f80304b8
4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8 7c0123a6 4e800020
---[ end trace 4d79afb454bb5314 ]---

Fixes: bc2a940 ("powerpc: Hook in new transactional memory code")
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea8a28f..b0c58a3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1509,6 +1509,14 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 		current->thread.regs = regs - 1;
 	}
 
+	/*
+	 * Clear any transactional state, we're exec()ing. The cause is
+	 * not important as there will never be a recheckpoint so it's not
+	 * user visible.
+	 */
+	if (MSR_TM_SUSPENDED(mfmsr()))
+		tm_reclaim_current(0);
+
 	memset(regs->gpr, 0, sizeof(regs->gpr));
 	regs->ctr = 0;
 	regs->link = 0;
-- 
2.8.3
