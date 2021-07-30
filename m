Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F9C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 11:43:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA4E61052
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 11:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFA4E61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gblrq6Fxgz3cQC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 21:43:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AX4PmDXF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AX4PmDXF; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GblrK0vKBz301g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jul 2021 21:42:40 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA0B56103B;
 Fri, 30 Jul 2021 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627645357;
 bh=nRa9TJJxTAW4vDwwhA6VyorL4FVC9dzFn9iKflCLVG4=;
 h=From:To:Cc:Subject:Date:From;
 b=AX4PmDXFu2OLhlDawWaxLNHParYoTGmSJs27Idg5FL5pTfeInPD7rwiKgXxtrPeI+
 YnwXvpvboeOTSnmX/9f+mJ3pK9gkCHjGs1oOX1FEqc/IlpAEENMFlPxjozGkEsqeRe
 +SJcWyl4yBDUBIX9BWRzNcVNNGHxZAwrWROd3Slwwzk9h7ai3tQmQ+Rw3tJslJOoEA
 JDxgIz+qYcifZf5UFEZ2HUVKcEEErOFWHEP3BSmqPcUWWS0MWvPMPstHVDuFBYfJrV
 n3N3cwwEGzSKSNAO4b1VbXellnqtPpwftg22Q3+Z80kzZ2DcYa8RZJu3CXAzO/vKm4
 W5of3aDkiQuZQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
Date: Fri, 30 Jul 2021 12:42:31 +0100
Message-Id: <20210730114231.23445-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linuxppc-dev@lists.ozlabs.org,
 Robin Murphy <robin.murphy@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
introduced a set_memory_encrypted() call to swiotlb_exit() so that the
buffer pages are returned to an encrypted state prior to being freed.

Sachin reports that this leads to the following crash on a Power server:

[    0.010799] software IO TLB: tearing down default memory pool
[    0.010805] ------------[ cut here ]------------
[    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!

Nick spotted that this is because set_memory_encrypted() is issuing an
ultracall which doesn't exist for the processor, and should therefore
be gated by mem_encrypt_active() to mirror the x86 implementation.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/powerpc/platforms/pseries/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 1d829e257996..87f001b4c4e4 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
@@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
-- 
2.32.0.554.ge1b32706d8-goog

