Return-Path: <linuxppc-dev+bounces-19166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D36A10F6FDC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8sr3PtZz2yjm;
	Thu, 02 Apr 2026 03:03:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059408;
	cv=none; b=CzeH7U1biavaY2A1N4GpwdD6BP7f/93uVsURKMIOXL0LJqBXc/KXoo6opd2dg9sku4Z1N/35zVE4/KX8Hm970lWFKJE5rpIXNVe9tg5UlD2G5BzooUfeqPT7ualCOtux7N1NUEazz8VT/vnzrQrD+89nmR79NWBC0jfhrJQC74kvfKeUcVRBjl0G4qnTl/ub/Jhhg0zPbmsuroJ62G1qgtrAUx+nnlcN0skQmMK/5zapqF7JO3ma234Gz1BTuQuT+xZjOFR1GSk3NysbhtS145FPAaCt0mWhHoeC4goVLTMxraBfl9GwJO8xrApfqzaveEiyaxExH4JWGEve0o5ldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059408; c=relaxed/relaxed;
	bh=hpRbQCBwpuWelVmK7NXMYh9f67eC9mDhnleEtwviAiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6BgQJHYnZ7aQ0RBR+OCH3cPaUQaXijtJ1Bm0haYXPyNfmXW02RQ1bvEk0ePnCmwCOhLuDi/doxvIhxOHlnQ4nR3rmGIm/EzHauMsL14AyfE75EDrUghqy/GR5wmO21+oYNSyugdfoYDb6ebGVfJIIbcArLFp1WKezL7KhImrEYATulzZfdYymhn68Z7FRbY//jRDQ5JerVk6Fx8OlNEGG29AFso25Dnr7tSxRpiNhmOqZbMgAGe3ym+6vUhub5Lf8dvibZq6jfNhQ8xr1Mp7Uv97Uxmo2KPv9psydgTniy0gxk1c1UHcH1IvI0bmAHKqqEJ//WXvJ2joo3Y50X4YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6XTPz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3G2fFQc1pAxXhCw--.37201S2;
	Thu, 02 Apr 2026 00:03:17 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/rtas-proc: reject oversized sensor properties
Date: Thu,  2 Apr 2026 00:03:17 +0800
Message-ID: <20260401160317.88585-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3G2fFQc1pAxXhCw--.37201S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xXw43Gw4fCF18Kr43GFg_yoWDurb_C3
	ZxW3WkCw4vvr4Yv3ZrGF4DGFWDK3yUZFyqvr1ag3yxJ3saqr17JrWUAFn0yrn3Gr4kArWD
	C3Z5Xrykta4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUU
	UUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ppc_rtas_find_all_sensors() derives the number of RTAS sensors from the
firmware property length and then copies that many entries into the
fixed sensors.sensor[MAX_SENSORS] array. A longer-than-expected property
can therefore overrun the static sensor table.

Reject rtas-sensors properties that would exceed the fixed sensor table.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/kernel/rtas-proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index f38df72e64b8..97a7d76ecf77 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -437,6 +437,10 @@ static int ppc_rtas_find_all_sensors(void)
 	}
 
 	sensors.quant = len / 8;      /* int + int */
+	if (sensors.quant > ARRAY_SIZE(sensors.sensor)) {
+		pr_err("too many sensors reported: %u\n", sensors.quant);
+		return 1;
+	}
 
 	for (i=0; i<sensors.quant; i++) {
 		sensors.sensor[i].token = *utmp++;
-- 
2.50.1 (Apple Git-155)


