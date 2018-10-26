Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B27C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:40:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EF120834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjlO1SlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EF120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hDrk1sTnzF3FN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 17:40:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjlO1SlR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="UjlO1SlR"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hDlF684bzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 17:35:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 53916D5F;
 Fri, 26 Oct 2018 02:35:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Oct 2018 02:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=/kPt8X6IhK9BHJN3zncvf8Ngz718RdiG06SeoG0Pd+g=; b=UjlO1SlR
 vTPcbQ9QUjLxyX3BGle1FEbplRpco5Uhc8d4A3MqhDkdj5b9jN0gEhImTE0F6E6L
 owl6Yxp5NpnswesJ96IP9Fuc27j6yxZ4TGD5La9bE0kOz3YPQGeOgCHb9h67Emwy
 6ZNgK6SiLHufvIvw/TeNpfkmUI2vjI/rkcPG2TGQy1VseMmjO3QOqi/jH6EWCqJd
 0I5VBw8e6vzUUx5+3kj8FooO1/5OVRJl5GBQI2pDm0O4q3foAztZQZ/VERWRVUJ3
 8raz+vGiQyA5qE2KBONs6EtPK8s00+CjjIMKvq9wc0+qhAk3bcs5IZO6X2lX5hqS
 86XNFgR9orMRYQ==
X-ME-Sender: <xms:trXSWwEokaM0P4zu3FLvOY_9z_tP3_p4vUjUSBxPpCnJTiJ2KBxnrQ>
X-ME-Proxy: <xmx:trXSWw8Tsd_zIA8F4QbnMWtMWhj90FkylSiTqDA1MNAVvl8TQ8aLvA>
 <xmx:trXSWzSlQlcFpJq-qRotkJLTCNMpqI6-yfCStJPZPU2iGjrUgxhKcw>
 <xmx:trXSWykd3UTfc2D_QtjVL_rsAoNGeprA-dG8-OQbiitoVZE4gbCGAg>
 <xmx:trXSWzR2ZRf1n2KCCv3jEkp3_D4O8wSRsSi5jMZeFN_XoEarUxHZ6Q>
 <xmx:trXSWwNa7Hx_WIOux7yzDN61mILqPjL5eR2GzLSwvLLmw_p-_jTDwg>
 <xmx:trXSW46_Z7PIOhJmDmAEks3lQ_B9LfZY_3Rnjz61o2JZnlWU4HDp3Q>
Received: from crackle.ozlabs.ibm.com (pa49-195-157-6.pa.nsw.optusnet.com.au
 [49.195.157.6])
 by mail.messagingengine.com (Postfix) with ESMTPA id E6B22102E0;
 Fri, 26 Oct 2018 02:35:31 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc/futex: GUAP support for futex ops
Date: Fri, 26 Oct 2018 17:35:10 +1100
Message-Id: <20181026063513.30806-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026063513.30806-1-ruscur@russell.cc>
References: <20181026063513.30806-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wrap the futex operations in GUAP locks and unlocks.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/include/asm/futex.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 94542776a62d..3aed640ee9ef 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -35,6 +35,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	unlock_user_access();
 	pagefault_disable();
 
 	switch (op) {
@@ -62,6 +63,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	if (!ret)
 		*oval = oldval;
 
+	lock_user_access();
 	return ret;
 }
 
@@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	unlock_user_access();
         __asm__ __volatile__ (
         PPC_ATOMIC_ENTRY_BARRIER
 "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
@@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         : "cc", "memory");
 
 	*uval = prev;
+	lock_user_access();
         return ret;
 }
 
-- 
2.19.1

