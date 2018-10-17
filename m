Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A49ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:59:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C47214D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVLBvMP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C47214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zjj71zMnzF3Xy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 17:59:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVLBvMP7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="LVLBvMP7"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZjY13hy3zF3VM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:52:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id D874BC30;
 Wed, 17 Oct 2018 02:44:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=FyGuQQluEHtYaLjm6Fp31LJB5QQKOSsAieMkzhZVIl0=; b=LVLBvMP7
 nOX79WxALSLj+XcSGPejqYJC9S/U9mmAJMOaSSkl+RAGqQGt0WArBVPq0TGsfXBG
 ps14mxtT25Q8w8WhAVmpp1Gbdtyr9KU9w82cYLVTYmzVDU0Al/MKyCMkwEw/4nX6
 f9hb/FXLbMsaNKZPQoEz5PzwH7nsTK95Xd37oXt0r4dpHRhlYaOdQzta+PbSle0K
 sL2LAtRz5nkjFnDdyfV0Ehrh1pyeE1JagmbzyH1loSa3E0QRhCnfmD/O8rf3b0dN
 3CVYaz0dmlR1GML230scs3q1q0IZ0Zs4/w2QGPWt3EwkAcRVhX0rJGfCv8MgiGYR
 mQp5UOxr2spLqw==
X-ME-Sender: <xms:X9rGW6ZYyw8OBdkZtLfqnxIA_aGTjY4jS2XSnZ9Q9q-0lK41FY8J7w>
X-ME-Proxy: <xmx:X9rGW0BQdEfQ6hjdLn7GNS3_sMQhNXT4HT8_GXKRP6nBZzd-3v0Exg>
 <xmx:X9rGW1BAAKYyHLG395fXtr6VEICB6lsZYAENLuUtqZ0q1WzYrmtaxw>
 <xmx:X9rGW9x6lC1CCb68cmizB6svC274Wsg1jeJGcdpX2MNFQspaXFenUA>
 <xmx:X9rGW_ijrtZphss7kMGtkS5nZMvvrommX5cV6OuQdqVWel2cS-F9hw>
 <xmx:X9rGW3a_i6bHwNWXpZC45bsM1anLy5LA4H1i5FazxFNw64jm_2bw9Q>
 <xmx:X9rGW23FfxDxgCR9D7Nr44rSQcMIvJ0HnnTYbSQAP9ui7nqjmGuMPw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2F087102ED;
 Wed, 17 Oct 2018 02:44:44 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc/futex: KHRAP support for futex ops
Date: Wed, 17 Oct 2018 17:44:20 +1100
Message-Id: <20181017064422.26119-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017064422.26119-1-ruscur@russell.cc>
References: <20181017064422.26119-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wrap the futex operations in KHRAP locks and unlocks.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/include/asm/futex.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 94542776a62d..e0f4227cfd32 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -34,7 +34,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
 	int oldval = 0, ret;
+	unsigned long amr;
 
+	amr = unlock_user_access();
 	pagefault_disable();
 
 	switch (op) {
@@ -62,6 +64,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	if (!ret)
 		*oval = oldval;
 
+	lock_user_access(amr);
 	return ret;
 }
 
@@ -71,10 +74,12 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	int ret = 0;
 	u32 prev;
+	unsigned long amr;
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	amr = unlock_user_access();
         __asm__ __volatile__ (
         PPC_ATOMIC_ENTRY_BARRIER
 "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
@@ -95,6 +100,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         : "cc", "memory");
 
 	*uval = prev;
+	lock_user_access(amr);
         return ret;
 }
 
-- 
2.19.1

