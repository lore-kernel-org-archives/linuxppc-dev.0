Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysBR35p8fzF0HB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 19:21:35 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 1so511545pla.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 00:21:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH v3] powerpc/64s: ISAv3 initialize MMU registers before setting
 partition table
Date: Wed,  6 Dec 2017 18:21:14 +1000
Message-Id: <20171206082114.30302-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec can leave MMU registers set when booting into a new kernel, PIDR
in particular. The boot sequence does not zero PIDR, so it only gets
set when CPUs first switch to a userspace processes (until then it's
running a kernel thread with effective PID = 0).

This leaves a window where a process table entry and page tables are
set up due to user processes running on other CPUs, that happen to
match with a stale PID. The CPU with that PID may cause speculative
accesses that address quadrant 0, which will result in cached
translations and PWC for that process, on a CPU which is not in the
mm_cpumask and so they will not get invalidated properly.

The most common result is the kernel hanging in infinite page fault
loops soon after kexec (usually in schedule_tail, which is usually the
first non-speculative quardant 0 access to a new PID) due to a stale
PWC. However being a stale translation error, it could result in
anything up to security and data corruption problems.

Fix this by zeroing out PIDR at boot and kexec.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v3: do the register clearing in the early CPU setup code, suggested by
    Michael Ellerman, which already clears LPID.

 arch/powerpc/kernel/cpu_setup_power.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 610955fe8b81..679bbe714e85 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -102,6 +102,7 @@ _GLOBAL(__setup_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PID,r0
 	mfspr	r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE  | LPCR_HEIC)
 	or	r3, r3, r4
@@ -126,6 +127,7 @@ _GLOBAL(__restore_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_PSSCR,r0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PID,r0
 	mfspr   r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE | LPCR_HEIC)
 	or	r3, r3, r4
-- 
2.15.0
