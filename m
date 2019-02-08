Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2FC282CC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:43:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305B42075C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305B42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wybW74s8zDqc7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ilande.co.uk
 (client-ip=82.165.15.123; helo=s16892447.onlinehome-server.info;
 envelope-from=mark.cave-ayland@ilande.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ilande.co.uk
Received: from s16892447.onlinehome-server.info (chuckie.co.uk [82.165.15.123])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wyNW6yT7zDqb9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 01:33:47 +1100 (AEDT)
Received: from host86-138-240-60.range86-138.btcentralplus.com
 ([86.138.240.60] helo=kentang.home)
 by s16892447.onlinehome-server.info with esmtpsa
 (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.76)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1gs7Dr-0000SG-12; Fri, 08 Feb 2019 14:33:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Date: Fri,  8 Feb 2019 14:33:19 +0000
Message-Id: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 86.138.240.60
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS guest
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Jan 2012 02:45:44 +0000)
X-SA-Exim-Scanned: Yes (on s16892447.onlinehome-server.info)
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

Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"
unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
guest to lockup and panic the kernel.

Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
32-bit KVM-PR once again without issue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce393df243aa..71bad4b6f80d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -176,7 +176,7 @@ static void __giveup_fpu(struct task_struct *tsk)
 
 	save_fpu(tsk);
 	msr = tsk->thread.regs->msr;
-	msr &= ~MSR_FP;
+	msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
 #ifdef CONFIG_VSX
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr &= ~MSR_VSX;
-- 
2.11.0

