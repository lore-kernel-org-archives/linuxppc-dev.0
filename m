Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253FC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 13:38:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D765207D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 13:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YvUnAb8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D765207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Rv3B2664zDqVF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 23:38:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Rv0R5yy6zDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 23:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YvUnAb8I; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49Rv0Q5vf8z9sT4; Wed, 20 May 2020 23:36:06 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49Rv0Q4FBTz9sT6; Wed, 20 May 2020 23:36:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589981766;
 bh=Y38ltW/knpNzyS67p+mpw9CKT73OKO21MCqAfFpB9PE=;
 h=From:To:Subject:Date:From;
 b=YvUnAb8ISfrQbnOmUdocuQhQswZqXRfIgtP17L4yOwB/ETdUJrNGYXV1W05UDaqEY
 YsuydnISVkA3VU7cAyRabD8jT1sNv3RK8Lk1NUM6meBah2i5RotFuyvth8PBoSQdB0
 Cks6OpTUTZzAfV/KctmY5UZwXGZT4xyB+NJLBoW+7wETo+unrAaOoJvcLi5jIGYTa1
 goJQJLKxKGdQf3OD2Ag63LILK/BRytLXxTXLkii/D8beASWPGJCX6WvKhkC/zXwA9f
 x3vLj9BboDp5xe1MjnN7bBIQUy6Q1WMnRHGnaNCz6RRu+T0SKTI03/9uRRXvcSTX21
 T/pVyk6hsYiOA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Disable STRICT_KERNEL_RWX
Date: Wed, 20 May 2020 23:36:05 +1000
Message-Id: <20200520133605.972649-1-mpe@ellerman.id.au>
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

Several strange crashes have been eventually traced back to
STRICT_KERNEL_RWX and its interaction with code patching.

Various paths in our ftrace, kprobes and other patching code need to
be hardened against patching failures, otherwise we can end up running
with partially/incorrectly patched ftrace paths, kprobes or jump
labels, which can then cause strange crashes.

Although fixes for those are in development, they're not -rc material.

There also seem to be problems with the underlying strict RWX logic,
which needs further debugging.

So for now disable STRICT_KERNEL_RWX on 64-bit to prevent people from
enabling the option and tripping over the bugs.

Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a9260..d13b5328ca10 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -130,7 +130,7 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
-	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
-- 
2.25.1

