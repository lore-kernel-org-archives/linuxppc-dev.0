Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E31C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:03:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008852081C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuDg/L9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008852081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CvDC4H1MzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 18:03:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuDg/L9e";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="QuDg/L9e"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cv9F6gjPzDqst
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:00:33 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 40F7A2073F;
 Mon, 10 Dec 2018 02:00:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 10 Dec 2018 02:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=WuMQsQw9Zm0J7cVhI10l8/CcKE+X5cLFWxbKFpS/UJo=; b=QuDg/L9e
 Q64EqnGq1IN8xkIO93lt5qVLlsUiTqWcdu+BYqmCzDKkSjLQPlFRMUsKGChi/n+y
 /J6U2lSdzhT8oJC54vSFHABa8ENq7bqsALGQa78PmBN7UFIZx+t9Xw1unn86nBkR
 ylLEnQoZzZRQ0b5/JfK/jqiGvEwMtSdo8PK6VjMais9LbBJrUp6x9b6Vn8KPfoU3
 JU9vpk5WTyLThE/pFtkOJFCUJZTp2MLDPrYsdDo36AOQ897VWMRo8k51R7jS4Yxp
 djh7jNAv/INJpBill76EdbO8JMS9kt0tQb7aIDA4hGx2hnBVX5Mk+NtSkvMLy7zQ
 JMctXFVsKonz+w==
X-ME-Sender: <xms:Dw8OXJDdMksa85-J49pcH4oZ162Lh5d9-dnOqgAtMFrnpzRblDEpZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggedguddtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
 fedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvffufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhr
 sehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrg
 hmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushht
 vghrufhiiigvpedu
X-ME-Proxy: <xmx:Dw8OXIdabWFJCMurM8mUSSokELvkLiIguyB44GmRPdEL9RiXDTk-pQ>
 <xmx:Dw8OXEbUPjGVUX-3uJfzdHO_kJeRuPYD8sX2oy3Pn3isv8GgqSWS-Q>
 <xmx:Dw8OXOJj4VdX1P4qFb7JLbDSwZ8cC0T7OOe0VPlmCsqf3iIF0cL0HQ>
 <xmx:Dw8OXOgbagBZCzkMGGWF9yNHOj9sPouJbwNpJs_BGzIXNkAfLxjGlQ>
 <xmx:Dw8OXI-XVw3lRE2M7ESxo_wk7qvlOaA_AIIcTJvWOYlmQv1fkTlqSQ>
 <xmx:Dw8OXHFBXjnOyw2jOoeXWs35wat99P59Fh2xVijPv1gxPr8drTNJAA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5267DE4445;
 Mon, 10 Dec 2018 02:00:28 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc/lib: Refactor __patch_instruction() to use
 __put_user_asm()
Date: Mon, 10 Dec 2018 18:00:43 +1100
Message-Id: <20181210070044.27503-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210070044.27503-1-ruscur@russell.cc>
References: <20181210070044.27503-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com,
 Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

__patch_instruction() is called in early boot, and uses
__put_user_size(), which includes the locks and unlocks for KUAP,
which could either be called too early, or in the Radix case, forced to
use "early_" versions of functions just to safely handle this one case.

__put_user_asm() does not do this, and thus is safe to use both in early
boot, and later on since in this case it should only ever be touching
kernel memory.

__patch_instruction() was previously refactored to use __put_user_size()
in order to be able to return -EFAULT, which would allow the kernel to
patch instructions in userspace, which should never happen.  This has
the functional change of causing faults on userspace addresses if KUAP
is turned on, which should never happen in practice.

A future enhancement could be to double check the patch address is
definitely allowed to be tampered with by the kernel.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/lib/code-patching.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 89502cbccb1b..15e8c6339960 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -26,9 +26,9 @@
 static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 			       unsigned int *patch_addr)
 {
-	int err;
+	int err = 0;
 
-	__put_user_size(instr, patch_addr, 4, err);
+	__put_user_asm(instr, patch_addr, err, "stw");
 	if (err)
 		return err;
 
-- 
2.19.2

