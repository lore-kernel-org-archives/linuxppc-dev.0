Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632AC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:04:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DBA2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DBA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YcYv2M0TzF38T
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:04:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YcVg2hVkzF3K5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:01:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YcVg2BGHz9s5c; Mon, 15 Oct 2018 23:01:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YcVg1vYtz9s7W; Mon, 15 Oct 2018 23:01:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/uapi: Fix sigcontext definition to use
 user_pt_regs
Date: Mon, 15 Oct 2018 23:01:42 +1100
Message-Id: <20181015120143.1248-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: maddy@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

My recent patch to split pt_regs between user and kernel missed
the usage in struct sigcontext.

Because this is a user visible struct it should be using the user
visible definition, which when we're building for the kernel is called
struct user_pt_regs.

As far as I can see this hasn't actually caused a bug (yet), because
we don't use the sizeof() the sigcontext->regs anywhere. But we should
still fix it to avoid confusion and future bugs.

Fixes: 002af9391bfb ("powerpc: Split user/kernel definitions of struct pt_regs")
Reported-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/sigcontext.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/sigcontext.h b/arch/powerpc/include/uapi/asm/sigcontext.h
index 2fbe485acdb4..630aeda56d59 100644
--- a/arch/powerpc/include/uapi/asm/sigcontext.h
+++ b/arch/powerpc/include/uapi/asm/sigcontext.h
@@ -22,7 +22,11 @@ struct sigcontext {
 #endif
 	unsigned long	handler;
 	unsigned long	oldmask;
-	struct pt_regs	__user *regs;
+#ifdef __KERNEL__
+	struct user_pt_regs __user *regs;
+#else
+	struct pt_regs	*regs;
+#endif
 #ifdef __powerpc64__
 	elf_gregset_t	gp_regs;
 	elf_fpregset_t	fp_regs;
-- 
2.17.1

