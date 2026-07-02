Return-Path: <linuxppc-dev+bounces-23452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3A2C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 21:17:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grqTq1KrSz2ySD;
	Fri, 03 Jul 2026 07:17:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783027055;
	cv=none; b=ci0yqEaum0qEtT53ZiyKjK/4t4NGxVUEnBDgOKLVbteCkVL4p0bBI/IR1I6WM5V74A9vKQVctBgRiIppodFcnIwb0OnNNZIzkrFV6vMbSSarSUKBXRkKwbf7lNVURgwTroVgLZRMLzrIWSzbe8+lNOkY08d6XEbe+m2NAVlWu7Ohi0hdnCW/UAAHo8abirZDzkXDOm/hpTuo/RhQ5JC8o6lV0x9/qexPL0QmCLlEH5mQHtwdwltxxiOmHViFfxHJeOlGp8wyUTJ3rxVZoyC9S3owIEw/GJTWzi8+DxayOgXGiLikIZoi3XM1zXubF1d42AzYBooyy5XNhHXrq/TwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783027055; c=relaxed/relaxed;
	bh=f1Ar2HUduM/o8dv/7zKI2qEEexDKrCvAlVxow2BIY4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL0Xf1CB285u9D8cEluM56aQJroq94CozPAZ3z8o3MQHONTjsIa7wFKyyNh+NAmNjuswyEtNi7no3fKUICwjdK1EprlAQdBsLkgvgt51S8F/CtVeP2m3SL4PWvq0FlnNSP7qkG/M49mG88Xb/FsNLGk7pHY3prBi3pb49ViAZsT9j9b6iH9g2mmz0QCuQaq0kHAQxiVYNIdtRm4P92ffJ5gxNQpRh57WjAseyW9uD+YF9NVx8owVGBYxr81kMTBZ9r7reuykdyfkiF7TwtVRU4LsyuoaAggP07AtUvhEHz3DE6/EaFlxdUEWSAsS87OOTHZGzzYU031bv9Fir4HPXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=StbRjrP3; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=StbRjrP3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grqTp208Jz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 07:17:33 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783027029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Ar2HUduM/o8dv/7zKI2qEEexDKrCvAlVxow2BIY4s=;
	b=StbRjrP3tLbQuEI1znli0fv3PsQ8cyPyqBxhxGmmRAS7/RsZONdr+G2j8sjZr3zhn2k+tp
	08AY4LBEBqSBI/vi62bPnfH38r4luPAnnY269SEzWrOKwkkhOJbaz1cTRe0beMhu5o1X++
	hHRBV74b+z2toWCKxf1KWAx7fTpEeZk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tony Breeds <tony@bakeyournoodle.com>,
	Alistair Popple <alistair@popple.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 2/3] powerpc/boot: Fix treeboot-currituck CPU node lookup check
Date: Thu,  2 Jul 2026 23:15:56 +0200
Message-ID: <20260702211554.56923-5-thorsten.blum@linux.dev>
In-Reply-To: <20260702211554.56923-4-thorsten.blum@linux.dev>
References: <20260702211554.56923-4-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=thorsten.blum@linux.dev; h=from:subject; bh=x6OaTBqcRgxbq91YEH4N5a2VZZTce4Tn9wV4pYrwKck=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluV7nSmxu3r8i8GvVq9UbrzBsu0x1+c0b2MS6cf/CVL n8zW2tbRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExkmwvD/+TW6ndKk1kXZp0S fbxaarKjheIT6abo1AsTn2+P4b29KJSR4drzokbR52fm9h2boJUhd/TPqddKk3Z4aV27OFv0k0/ jbmYA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fdt_node_offset_by_prop_value() returns a negative error code on
failure - fix the check accordingly.

Fixes: 228d55053397 ("powerpc/47x: Add support for the new IBM currituck platform")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/treeboot-currituck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/treeboot-currituck.c b/arch/powerpc/boot/treeboot-currituck.c
index d53e8a592f81..5b5363b74f9f 100644
--- a/arch/powerpc/boot/treeboot-currituck.c
+++ b/arch/powerpc/boot/treeboot-currituck.c
@@ -102,7 +102,7 @@ void platform_init(void)
 
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 	                                     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))

