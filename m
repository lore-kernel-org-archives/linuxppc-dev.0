Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC9C71130
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EE42083C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE42083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ycdl43FYzF3K6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:07:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YcVh3VdgzF3K5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:01:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YcVh1x3Pz9s5c; Mon, 15 Oct 2018 23:01:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YcVh0wk3z9sBq; Mon, 15 Oct 2018 23:01:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/aout: Fix struct user definition to use
 user_pt_regs
Date: Mon, 15 Oct 2018 23:01:43 +1100
Message-Id: <20181015120143.1248-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015120143.1248-1-mpe@ellerman.id.au>
References: <20181015120143.1248-1-mpe@ellerman.id.au>
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

I'm pretty sure this is dead code, it's only used by the a.out core
dump code, and we don't support a.out. We should remove it.

But while it's in the tree it should be using the ABI version of
pt_regs which is called user_pt_regs in the kernel, because the whole
struct is written to the core dump and so its size shouldn't change.

Note this isn't a uapi header so we don't need an ifdef.

Fixes: 002af9391bfb ("powerpc: Split user/kernel definitions of struct pt_regs")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/user.h b/arch/powerpc/include/asm/user.h
index 5c0e082eae7b..99443b8594e7 100644
--- a/arch/powerpc/include/asm/user.h
+++ b/arch/powerpc/include/asm/user.h
@@ -31,7 +31,7 @@
  *	to write an integer number of pages.
  */
 struct user {
-	struct pt_regs	regs;			/* entire machine state */
+	struct user_pt_regs regs;		/* entire machine state */
 	size_t		u_tsize;		/* text size (pages) */
 	size_t		u_dsize;		/* data size (pages) */
 	size_t		u_ssize;		/* stack size (pages) */
-- 
2.17.1

