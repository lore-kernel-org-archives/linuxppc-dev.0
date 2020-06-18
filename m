Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:13:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD520853
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 02:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0mgQUdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nQTc4D65zDqDf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:13:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=B0mgQUdX; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nP8t4GLVzDqx2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 11:14:06 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D493E20EDD;
 Thu, 18 Jun 2020 01:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442844;
 bh=h0D9f8SfqSG5dRuYkwYsO4LqVWOjWOhzRu88NoAcVDM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B0mgQUdXH1YhS7ALLNxoMWYoc7vSmwHM7Vrm926wdv4TlqNd4J1orz9cHsLIHrJ00
 u/e5voSyP4rjYWsYrs+y1Y7S+Jj+K98nDBpaHz0rQ03MZQ8JHxNIEypybjkiZ20HMA
 Y0Nr5VXHiuKmmUkdGqpKf40FY0n2YuaEU6OqKxl8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 277/388] powerpc/32s: Don't warn when mapping RO
 data ROX.
Date: Wed, 17 Jun 2020 21:06:14 -0400
Message-Id: <20200618010805.600873-277-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 4b19f96a81bceaf0bcf44d79c0855c61158065ec ]

Mapping RO data as ROX is not an issue since that data
cannot be modified to introduce an exploit.

PPC64 accepts to have RO data mapped ROX, as a trade off
between kernel size and strictness of protection.

On PPC32, kernel size is even more critical as amount of
memory is usually small.

Depending on the number of available IBATs, the last IBATs
might overflow the end of text. Only warn if it crosses
the end of RO data.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/6499f8eeb2a36330e5c9fc1cee9a79374875bd54.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 39ba53ca5bb5..a9b2cbc74797 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -187,6 +187,7 @@ void mmu_mark_initmem_nx(void)
 	int i;
 	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
 	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
 	unsigned long size;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
@@ -201,9 +202,10 @@ void mmu_mark_initmem_nx(void)
 		size = block_size(base, top);
 		size = max(size, 128UL << 10);
 		if ((top - base) > size) {
-			if (strict_kernel_rwx_enabled())
-				pr_warn("Kernel _etext not properly aligned\n");
 			size <<= 1;
+			if (strict_kernel_rwx_enabled() && base + size > border)
+				pr_warn("Some RW data is getting mapped X. "
+					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
 		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
 		base += size;
-- 
2.25.1

