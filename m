Return-Path: <linuxppc-dev+bounces-24106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8E7C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:18:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzH1B3TStz2xlv;
	Mon, 13 Jul 2026 19:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783934318;
	cv=none; b=UEu6KA8kmSIeFyaxWXdGi5KGmQdSFnluN7iK1Pby6fcQ19ZJTZgto0QMY4NbkC+EtyEqrafyNEt/7OoonvHBFLAwHbPNgWqCyMSoCSv2JJ2Y/a2NWr8N1XuaJDog/J1/nhjFGhNTzHxVMeEdN7CBTpVwlQknc19GqfjyjsPVgXQ5XH4lGzRQ3DmFB7nl7Zu7FR1hMydSOHXdgDOF9UGhQmE8NJjtnzPU0RTkLoWNBnAIIH9rVyqjALwicQQS0D9Les1TRIedTc/P6Knl9a6IBXpVHOqnNJAZI5Iwv95/4YUR6YY6qgDyQMIBVQJ39XOH+njCbj07R7lAgfESz9gVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783934318; c=relaxed/relaxed;
	bh=sFpT67XLroRUR1tvK6l4iM6XlbsDUuWFj6EH23CJ/oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3T1n0bIp0VWANtTRmjbKAErYq7yFJtqzhgto5GT7Q5Y79NjBcEdLTupbzNZnmpi1Ho3GAjIN0x4QniUwvfI4WEMQQnLQbnSkxIZOX30xTbkxFAHeAvOVFUFHIOTws0l6HoJc5WP6n7Y9BcqxJySacNbp65oqJ+a5SzfJHx947n88TR37Dtx68m2EpCV8+vscuWI9df3WqLeeA3Fgx7i6C40JTsaYTDSo5olRF2VHwYNOzWOCT3BRp7Cxh34HaumrF7uUFh7YnFv07+qP02Sx3DEa/RLb4qav937uT8lksvivEqN3itQFn2JJvdstpQtGZUwsF4e20mBW7oD40eXAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TfVF6Lf1; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TfVF6Lf1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzH176dQVz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 19:18:34 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783934295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sFpT67XLroRUR1tvK6l4iM6XlbsDUuWFj6EH23CJ/oc=;
	b=TfVF6Lf1EWDOMhw4OdXNN4PHjn2bwnY1/EKxUg6iRwcQrRosRlpcF66iEtFrKwG3sKY3Yv
	Ck8H/voD973T/BjYJSwAfAx7KiYme4Yzurl3pFTXaWBlLsF6611+PNhdRntHcuir8In6EC
	4+feGSMExwihBfmMoAAwgnVXwDp3E0c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/ps3: Remove unused struct table in setup_areas()
Date: Mon, 13 Jul 2026 11:17:33 +0200
Message-ID: <20260713091731.97212-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=thorsten.blum@linux.dev; h=from:subject; bh=0QllfgppfNv919iu5jYMesoTAu561AihBZ3Gb2mToeg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkha7Ujnpi0Ma52XuKcfcGq7Jyjv9m2STeP/9R98Of8k /DNj39M7ihlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJbJjI8D/BwCP66BZRi4/N x9+u2cHGcD2bw0rTcfaplbrzCzWuK/xnZDi+TG2X764th8PbforsDJ2x3muF4DL/FXFfVgl9viq 29QcjAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local table structure is not used - remove it.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Drop the %0 change because it is valid kernel-doc markup (Amit)
- v1: https://lore.kernel.org/r/20260712151300.3664-3-thorsten.blum@linux.dev/
---
 arch/powerpc/platforms/ps3/spu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index e817def7f424..2c785bc72565 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -190,8 +190,6 @@ static void spu_unmap(struct spu *spu)
 
 static int __init setup_areas(struct spu *spu)
 {
-	struct table {char* name; unsigned long addr; unsigned long size;};
-
 	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
 					      sizeof(struct spe_shadow),
 					      pgprot_noncached_wc(PAGE_KERNEL_RO));

