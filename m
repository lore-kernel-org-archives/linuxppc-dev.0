Return-Path: <SRS0=7n8X=KI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0154FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 14:08:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7C2611AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 14:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7C2611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fgtn33Wnfz3bwT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 00:08:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GOMNRQP4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GOMNRQP4; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fgtm82sg6z2yZ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 00:08:07 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fgtm532bxz9sWC; Fri, 14 May 2021 00:08:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1620914885;
 bh=5VzLkyf3gtPo2l/sVZ4e1rFU3fq+Kx6VwTTXij1wrjo=;
 h=From:To:Subject:Date:From;
 b=GOMNRQP4SQl1rjfcj2RZHXB/3e50waErPL6RprzHJYHwhBMMsEPelSa/eb4KltNT7
 Xe0jhag04DEd/dM8N2gLmGnjhwspQetacmy/dBWxxu1ZdaPivQZEhSIfI5GlOSt25+
 eMUPElB9HBJXWJDGTbLilh+LXEvwBEFTdopm+1TIOEwc9rTz4Gab8sKadyUQtpDggN
 a5c09Di9uC100z+IQQxL4xZrsChPskvuSBBI1+FvITPrJTYv8oel/yozp7yGA5g6Cp
 S9nrDmdrRIDgJjLJvgsu0JMp8E0FRnOt0bBjE6dzxafPXaFcUKLp9gYufM/v81TfXI
 EXAlkec/ycvOg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/64s: Fix entry flush patching w/strict RWX & hash
Date: Fri, 14 May 2021 00:07:59 +1000
Message-Id: <20210513140800.1391706-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The entry flush mitigation can be enabled/disabled at runtime. When this
happens it results in the kernel patching its own instructions to
enable/disable the mitigation sequence.

With strict kernel RWX enabled instruction patching happens via a
secondary mapping of the kernel text, so that we don't have to make the
primary mapping writable. With the hash MMU this leads to a hash fault,
which causes us to execute the exception entry which contains the entry
flush mitigation.

This means we end up executing the entry flush in a semi-patched state,
ie. after we have patched the first instruction but before we patch the
second or third instruction of the sequence.

On machines with updated firmware the entry flush is a series of special
nops, and it's safe to to execute in a semi-patched state.

However when using the fallback flush the sequence is mflr/branch/mtlr,
and so it's not safe to execute if we have patched out the mflr but not
the other two instructions. Doing so leads to us corrputing LR, leading
to an oops, for example:

  # echo 0 > /sys/kernel/debug/powerpc/entry_flush
  kernel tried to execute exec-protected page (c000000002971000) - exploit attempt? (uid: 0)
  BUG: Unable to handle kernel instruction fetch
  Faulting instruction address: 0xc000000002971000
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
  CPU: 0 PID: 2215 Comm: bash Not tainted 5.13.0-rc1-00010-gda3bb206c9ce #1
  NIP:  c000000002971000 LR: c000000002971000 CTR: c000000000120c40
  REGS: c000000013243840 TRAP: 0400   Not tainted  (5.13.0-rc1-00010-gda3bb206c9ce)
  MSR:  8000000010009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48428482  XER: 00000000
  ...
  NIP  0xc000000002971000
  LR   0xc000000002971000
  Call Trace:
    do_patch_instruction+0xc4/0x340 (unreliable)
    do_entry_flush_fixups+0x100/0x3b0
    entry_flush_set+0x50/0xe0
    simple_attr_write+0x160/0x1a0
    full_proxy_write+0x8c/0x110
    vfs_write+0xf0/0x340
    ksys_write+0x84/0x140
    system_call_exception+0x164/0x2d0
    system_call_common+0xec/0x278

The simplest fix is to change the order in which we patch the
instructions, so that the sequence is always safe to execute. For the
non-fallback flushes it doesn't matter what order we patch in.

Fixes: bd573a81312f ("powerpc/mm/64s: Allow STRICT_KERNEL_RWX again")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups.c | 56 ++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 0aefa6a4a259..b49bb41e3ec5 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -325,6 +325,28 @@ static int __do_entry_flush_fixups(void *data)
 	if (types & L1D_FLUSH_MTTRIG)
 		instrs[i++] = 0x7c12dba6; /* mtspr TRIG2,r0 (SPR #882) */
 
+	/*
+	 * If we're patching in or out the fallback flush we need to be careful about the
+	 * order in which we patch instructions. That's because it's possible we could
+	 * take a page fault after patching one instruction, so the sequence of
+	 * instructions must be safe even in a half patched state.
+	 *
+	 * To make that work, when patching in the fallback flush we patch in this order:
+	 *  - the mflr		(dest)
+	 *  - the mtlr		(dest + 2)
+	 *  - the branch	(dest + 1)
+	 *
+	 * That ensures the sequence is safe to execute at any point. In contrast if we
+	 * patch the mtlr last, it's possible we could return from the branch and not
+	 * restore LR, leading to a crash later.
+	 *
+	 * When patching out the fallback flush (either with nops or another flush type),
+	 * we patch in this order:
+	 *  - the branch	(dest + 1)
+	 *  - the mtlr		(dest + 2)
+	 *  - the mflr		(dest)
+	 */
+
 	start = PTRRELOC(&__start___entry_flush_fixup);
 	end = PTRRELOC(&__stop___entry_flush_fixup);
 	for (i = 0; start < end; start++, i++) {
@@ -332,15 +354,16 @@ static int __do_entry_flush_fixups(void *data)
 
 		pr_devel("patching dest %lx\n", (unsigned long)dest);
 
-		patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
-
-		if (types == L1D_FLUSH_FALLBACK)
-			patch_branch((struct ppc_inst *)(dest + 1), (unsigned long)&entry_flush_fallback,
-				     BRANCH_SET_LINK);
-		else
+		if (types == L1D_FLUSH_FALLBACK) {
+			patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
+			patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_branch((struct ppc_inst *)(dest + 1),
+				     (unsigned long)&entry_flush_fallback, BRANCH_SET_LINK);
+		} else {
 			patch_instruction((struct ppc_inst *)(dest + 1), ppc_inst(instrs[1]));
-
-		patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
+		}
 	}
 
 	start = PTRRELOC(&__start___scv_entry_flush_fixup);
@@ -350,15 +373,16 @@ static int __do_entry_flush_fixups(void *data)
 
 		pr_devel("patching dest %lx\n", (unsigned long)dest);
 
-		patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
-
-		if (types == L1D_FLUSH_FALLBACK)
-			patch_branch((struct ppc_inst *)(dest + 1), (unsigned long)&scv_entry_flush_fallback,
-				     BRANCH_SET_LINK);
-		else
+		if (types == L1D_FLUSH_FALLBACK) {
+			patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
+			patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_branch((struct ppc_inst *)(dest + 1),
+				     (unsigned long)&scv_entry_flush_fallback, BRANCH_SET_LINK);
+		} else {
 			patch_instruction((struct ppc_inst *)(dest + 1), ppc_inst(instrs[1]));
-
-		patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_instruction((struct ppc_inst *)(dest + 2), ppc_inst(instrs[2]));
+			patch_instruction((struct ppc_inst *)dest, ppc_inst(instrs[0]));
+		}
 	}
 
 
-- 
2.25.1

