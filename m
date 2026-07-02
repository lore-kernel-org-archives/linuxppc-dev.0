Return-Path: <linuxppc-dev+bounces-23454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEEAC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 21:17:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grqTq56bgz2ydQ;
	Fri, 03 Jul 2026 07:17:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783027055;
	cv=none; b=JyCpZvOgfPSv67Xer9/t0O1yUmt8rrxpzggmQX941uCUcOzZh0EaDv72lJMaUqSvae/SzxB/sjbrYvqZefJo9A0D0r/g3y7g/iJSDKktE5SAXCyHhv52L5T87ane9nAHW1qb67u1ouMtYgwWfnuOJbdxUhZmhIcCBvX4H1q3VPCPCWxoI2q4Lg2P/mXO9///OKe3abyOOJNh+HE+Mvforrqlo0xDdg39rlWOc0DilCgakcfLm3Q+92llrAmrFwXC7UPz7s2obYA9N7pK6s0GpqwaxujntZnoJ4yzh+ZULykbuj8L29Cwn7+nzlz7WFzYGuzTo6H01nsH9YeI/bzoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783027055; c=relaxed/relaxed;
	bh=fdbhQEhhgd8YmJtNTQqroJJmTLAfWQpRu6N000lRrlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGH/gIxA48NzjWvW9kP+Lq5h7gtkGZ4csyhjDHKwjVvgt6kBiJdIxF7Xjt7q6FwKVMM590I2ZA0g7Xb6JdzgWciQYMmKHiDXRjZ13sWGr+rzaG931xzjprgK3Ftv31prW61PH0fTIEzvB9MjP5uBm43rE8chkzi/DGVFh7mgJFeVYrzc2dKiQjNAe2c+DwyqEQqGOa1cvGy9845K0SY6bkOTjjtsdROE8EuTYn2pWsKOd+qWPEGDiLfkN+ZW5uMa/0G9fWAts0JkOf+Yxpg6ecvpttlpstz/mon6VysLns1Gx/cOLjXNGP8CAUYUyoqJHkFoOxfQX541OfCa2owuAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aao4xjaY; dkim-atps=neutral; spf=pass (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aao4xjaY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grqTm0p3nz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 07:17:30 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783027031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdbhQEhhgd8YmJtNTQqroJJmTLAfWQpRu6N000lRrlo=;
	b=Aao4xjaY4Kqa1CusFpOdWSK8uzskctIuZ1JcZfkxdXahh6u85zxWeDo1a8SeSK16gYfHq6
	WwI9am568NfC9LLJh4L1G7jEl3ydOcwIPXuEwFH5aCkOLU60w2DIJJ23k6bDNbXzeQfSA5
	5+FzeUtXuuj5xCRDaE0P2R3cxDeylq8=
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
Subject: [PATCH 3/3] powerpc/boot: Fix treeboot-akebono CPU node lookup check
Date: Thu,  2 Jul 2026 23:15:57 +0200
Message-ID: <20260702211554.56923-6-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=thorsten.blum@linux.dev; h=from:subject; bh=9Sn25FnbiEMbxkyXXHqkcaiGtgo2gNftmAFG7WgBEzk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluV7kmenUxuv0t/Cyz6eX520KZkz6kfj5yN41v951k7 pTIpXu9OkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiXEWMDHPYv5dfKrzhkLZt gywXz62S7Vy3gl6ecCgQ+XQpIuxqoxXDb9apwdzhJmYb9LQvrr3a0FVom6rip7mxbaLQ7U/J/Rd 2cgMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fdt_node_offset_by_prop_value() returns a negative error code on
failure - fix the check accordingly.

Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/treeboot-akebono.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/treeboot-akebono.c b/arch/powerpc/boot/treeboot-akebono.c
index e3cc2599869c..1b529037480f 100644
--- a/arch/powerpc/boot/treeboot-akebono.c
+++ b/arch/powerpc/boot/treeboot-akebono.c
@@ -146,7 +146,7 @@ void platform_init(char *userdata)
 
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 					     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))

