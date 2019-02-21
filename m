Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66506C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:48:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D518B20665
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="l4+7LG6A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8xtgTxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D518B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qRr6HRwzDqPB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="l4+7LG6A"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="r8xtgTxB"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9m4RLCzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:44 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5404B220D0;
 Thu, 21 Feb 2019 04:36:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=tq/uYvjK6K2rr
 yCtaH/i03liKnHzLrIx4TwZPHaWGUs=; b=l4+7LG6A7b/xOrClgpInPzAo04W37
 iiKSzeTPKTrMJyuabl1ccqVIQ8nP6z8SZzHDsbSDMyePdy4dCnbKnJaaFCThe4C4
 w72O5L9n8daDxGAIUT/sREHMtq7r/saiyeOhbn9FZnWi9q9VFIMFoKRc1ALMeT2Y
 32TA+nzeaZaHEtQ6HVsT5UlKSAeK7uZACzjURDWt+GGJer9Cqa1VCYgK6qCdf7hk
 fKKyf/sK+lqsYaF1hgzWYo3osqelVIjl+xsP7dgoQuZssd6gSrzslSf6RJ5INLpk
 viA3dAdOxJcMJC1/3DWdzGBCDtZLHcH5+WLus4oFEH+eFk6brr5e+o/GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=tq/uYvjK6K2rryCtaH/i03liKnHzLrIx4TwZPHaWGUs=; b=r8xtgTxB
 9xF18QG8OKTHiuo6bSYRt6rUPdxD7mkbpIcpJ/PJQeaShpbjGwyeOQvfGOOMTaio
 0v3Y8lSAUPUtUJucBtss7RO7SgcFGWZ9ZEapVbNsX8UjNkYtP2o2dNpbBSzEuiDt
 BosZG0xIbXoXQ+KFsoORyJkdqozKHiEe7IUdQm26494AwgL0+1Pq/ZO44+vGd2/Q
 24Kmn8Mjis/9dT5xYh8W7o/cbzLrdm9+GcDPiaba4JIQmSmSV6cICcNd5XN+5QCK
 wlAUgCuZ+xuMYgGGmPFCibBNFz5IRirfUmjQ5SZ8IBtxpItM5TJ+ge2J0YUUqZdB
 Z/QhqSQg6mZQlw==
X-ME-Sender: <xms:KnFuXDNNfTCmr9ua0YTDWGkKIAmSd2E14KfjnEYrtarBJ7Lg_8ZBNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:KnFuXKSdZF_1kNnYhSYsa0J3yyBL7FnzUA5q-m_QPIMdQt5pNq-smA>
 <xmx:KnFuXFCAp513WB-uXeTZLDto8Lld_1mmYpfAT1w_94BF7tWufvBgTA>
 <xmx:KnFuXJgh7R-aThdxg1z18yIsAzjvqSN-4C4R83CjQZoQmE1WzqYENQ>
 <xmx:KnFuXNFqF82Gqw65JOhw6C7PYL4JfPqIRaKd7h4c6MA-8jCzysL-oA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8B2F610331;
 Thu, 21 Feb 2019 04:36:39 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/7] powerpc/lib: Refactor __patch_instruction() to use
 __put_user_asm()
Date: Thu, 21 Feb 2019 20:36:00 +1100
Message-Id: <20190221093601.27920-7-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
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
index 506413a2c25e..42fdadac6587 100644
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
2.20.1

