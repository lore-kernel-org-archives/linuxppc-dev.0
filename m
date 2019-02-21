Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C70C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 11:15:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069D32084F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 11:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069D32084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444sMM6j7rzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444sKD0zVgzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 22:13:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444sKB5z6Hz9s4Y;
 Thu, 21 Feb 2019 22:13:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: sstep: Add tests for compute type
 instructions
In-Reply-To: <df7e1d69a6ac2ec3db8bb5481431d8ad8a28157a.1550645549.git.sandipan@linux.ibm.com>
References: <cover.1550645549.git.sandipan@linux.ibm.com>
 <df7e1d69a6ac2ec3db8bb5481431d8ad8a28157a.1550645549.git.sandipan@linux.ibm.com>
Date: Thu, 21 Feb 2019 22:13:19 +1100
Message-ID: <87r2c15r8w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: naveen.n.rao@linux.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 ravi.bangoria@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sandipan Das <sandipan@linux.ibm.com> writes:
> This enhances the current selftest framework for validating
> the in-kernel instruction emulation infrastructure by adding
> support for compute type instructions i.e. integer ALU-based
> instructions. Originally, this framework was limited to only
> testing load and store instructions.
>
> While most of the GPRs can be validated, support for SPRs is
> limited to LR, CR and XER for now.
>
> When writing the test cases, one must ensure that the Stack
> Pointer (GPR1) or the Thread Pointer (GPR13) are not touched
> by any means as these are vital non-volatile registers.
>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  arch/powerpc/lib/Makefile                     |   3 +-
>  arch/powerpc/lib/test_emulate_step.c          | 167 +++++++++++++++++-
>  .../lib/test_emulate_step_exec_instr.S        | 150 ++++++++++++++++
>  3 files changed, 315 insertions(+), 5 deletions(-)
>  create mode 100644 arch/powerpc/lib/test_emulate_step_exec_instr.S

Hi Sandipan,

Thanks for the exceptionally well written asm, I wish all our asm code
was that neat and well commented :)

I'd like to get this merged today so I tweaked it slightly when
applying to use the new patch_site helpers we added recently, see diff
below.

cheers


diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 1c13b3bebeca..9992c1ea7a1d 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -865,14 +865,14 @@ static int __init emulate_compute_instr(struct pt_regs *regs,
 static int __init execute_compute_instr(struct pt_regs *regs,
 					unsigned int instr)
 {
-	extern unsigned int exec_instr_execute[];
 	extern int exec_instr(struct pt_regs *regs);
+	extern s32 patch__exec_instr;
 
 	if (!regs || !instr)
 		return -EINVAL;
 
 	/* Patch the NOP with the actual instruction */
-	patch_instruction(&exec_instr_execute[0], instr);
+	patch_instruction_site(&patch__exec_instr, instr);
 	if (exec_instr(regs)) {
 		pr_info("execution failed, instruction = 0x%08x\n", instr);
 		return -EFAULT;
diff --git a/arch/powerpc/lib/test_emulate_step_exec_instr.S b/arch/powerpc/lib/test_emulate_step_exec_instr.S
index 84cef7d78d9d..1580f34f4f4f 100644
--- a/arch/powerpc/lib/test_emulate_step_exec_instr.S
+++ b/arch/powerpc/lib/test_emulate_step_exec_instr.S
@@ -8,6 +8,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/ppc_asm.h>
+#include <asm/code-patching-asm.h>
 #include <linux/errno.h>
 
 /* int exec_instr(struct pt_regs *regs) */
@@ -78,10 +79,9 @@ _GLOBAL(exec_instr)
 	REST_GPR(12, r31)
 	REST_NVGPRS(r31)
 
-	.global	exec_instr_execute
-exec_instr_execute:
 	/* Placeholder for the test instruction */
 1:	nop
+	patch_site 1b patch__exec_instr
 
 	/*
 	 * Since GPR3 is overwritten, temporarily restore it back to its
