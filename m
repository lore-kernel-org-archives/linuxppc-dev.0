Return-Path: <linuxppc-dev+bounces-25113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26267C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9qZZ2B9wz2yYd;
	Thu, 30 Jul 2026 23:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785417638;
	cv=none; b=Ma7FliqkJeu7T8sJUuvWnbu57cGiKqhFTaSN6S0z9JhI0bQbvZPZHk95VIScFh0sXmKP7itM67lcbmkxYsLi5OGNG61YUkYsScHGfKC8pFWQEFVJBvLstdPzthSEghGrCGIBWa+5zWoCKKkSMFvSzLmKKkhZkLhYiYIyHf+Vlq4fKR5qIs09BKMNnJ9q4nNN8Gkx/pIsv9vaCzynoijbWrq91pccoQqN5YY/8H6dQCGpPprUXcixKwxczktlMO0E3HVnMU4wi0ZgLVYn9JX2M+oFogaqsQElnE0I0LETazhz2NXCY6FgRGwjHXrADOtgfHRGAIlMLU/moT7VBbrPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785417638; c=relaxed/relaxed;
	bh=uv0kAIL1LmhYJ4Q2+6EB2NTZQ1HT4I90lli19kiqKZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLZe6edFXXuam79SAlJVJpvHh9kXSx4l1dA2VRowJnu+cq88D9y7mxoLGgvk8TodYP7o2VvJhgHqlI6CEHflzNG31XE2zaBfBq5jKJpPnbHtDBF2bPtezhv9RP/a80FvvekrR4l/KRhYgD8KJvQBTfsAi6RxGQlMVZ0woLoom+l8j/u4OK5P59MoAtt0HdtFu8yPeYCq/pTWRu9vuGGJA2zvB2l1i1cXm5Z2gN5MOv5pBxkt8gIdRzad9evqCoC+hpNeNTi45FLdGyjh2V37/wEN/cRHw+8Xl/WDGK8nRCBK01MrBeX4e7Fod/ZDAUg2y8tVYYJjRRTHYDlOfJxqgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DxpNFXk7; dkim-atps=neutral; spf=pass (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DxpNFXk7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9qZW1l6Wz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:20:34 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785417614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uv0kAIL1LmhYJ4Q2+6EB2NTZQ1HT4I90lli19kiqKZY=;
	b=DxpNFXk7/c0HiltsfhtxIhvMqW7OvPl5lmXo+qLujMrhfCnKXTpORnbWa/pyDXKGWTZRJp
	bjQZ4bODATuRaHCeItL6wujqVJuLKau5DWOxxt4/seoM8kYHefzQfca3VPOC4AQr4F3W5b
	CB53j48EiYieui6X/zp3y/a+rndbqx0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec: Simplify kdump_extra_elfcorehdr_size()
Date: Thu, 30 Jul 2026 15:19:40 +0200
Message-ID: <20260730131940.597739-2-thorsten.blum@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=thorsten.blum@linux.dev; h=from:subject; bh=ktNtVREVtvw14E9oPcdTjRFe7oEzP1Nq9rcvXAgNTus=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnZ/jmbZ36/ecfVM/OAqc3BM4q3gyyDc7e7Cn4u+fshZ WFa+xajjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIQzZGht7zyyPUXsZc6fix ucPwde5hbr3/z58ZSyl/yLvPdq91iQbDX8HWwI12uz9VBEdUyez18Fpsc47juXB5iXhV0Levct/ 4mAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Return the size directly and drop the extra_sz variable to simplify
kdump_extra_elfcorehdr_size(). The two warning paths now fall through
to the existing return 0 at the end of the function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kexec/file_load_64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index c3503d698428..d0c544079e03 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -377,16 +377,12 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
 {
 #if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
-	unsigned int extra_sz = 0;
-
 	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
 		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
 	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
 		pr_warn("Configured crash mem ranges may not be enough\n");
 	else
-		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
-
-	return extra_sz;
+		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
 #endif
 	return 0;
 }

