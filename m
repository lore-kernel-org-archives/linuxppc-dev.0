Return-Path: <linuxppc-dev+bounces-19422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0200AFB519B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 06:16:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqbYY2t6Nz2ygf;
	Tue, 07 Apr 2026 16:16:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775542577;
	cv=none; b=FptacJOPOPyp/zLGmFejXxevsRtIeYwtXZ9zfbeTgF3buG7cnb+czV3uLnRiJhlWeVnoR6/aITgSduXO6PZOY1ydrVsgbN6Zeu/CB+vsrfTlh3Rw3PMBIBcSkmj4OZxGI3kSdn4Tqtter9czKIzxCx+9s1ivvOTl3sUlXDKiGyIGweaGbafq+ocKqrFM3/Gq5/4j+26MqXJeikzP9eKwyoSgoHEBqjw9+Qp1zkfl5fRil3r3DRa++1GZIPWjTLMut+G0sWX9XUvpuuBpejM+vlkVDHkwCwZO4QyEhVXIuJRtVGAa2kOTyZMKdIcwPafuugtvJHW8EaI2FivHY05DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775542577; c=relaxed/relaxed;
	bh=pFPLcGNZKJ/mrhvjdUgm2uzxrDvr5GSOei+oUkfWNUE=;
	h=From:Date:Message-ID:To:Cc:Subject; b=EAyhB5861X6CsjYqU6VRX/tQ5REmq6f5f4ThCLPurDPqulk7wBoVdih3/qdj6rAZjmWP4ZEjIOibRK+aZmQZUXSDVBAu965f3UuzeM29zc9sUuoiMJJyEZB3TORyT6+d8x5wCTyACaUW4lLuDLHIJkRVi8Kg4+RYouoXm6bcvdXE1y7ZGTPO1KuoUFg3AlOzN7UzLaZbOZM6IDwS0yjd5RMOdKbmoC3NWwrcFXi5WH6YYACuf8aPpD8kolYvNNo1mQ+PVJeHglF06/ZNe2Vsj0ho9XUONh8CffFY8xq6A9+niqWECi4ZTbzX1xPZuxK2SpoKYU7dAeyYKpKF++MRBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqbYW6zwZz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 16:16:14 +1000 (AEST)
Received: from 0001-powerpc-pseries-energy.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACnT2slodRpxuh7DA--.48957S2;
	Tue, 07 Apr 2026 14:16:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 14:09:10 +0800
Message-ID: <20260407153003.3-powerpc-pseries-energy-pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/pseries/energy: validate H_BEST_ENERGY list counts
X-CM-TRANSID:qwCowACnT2slodRpxuh7DA--.48957S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UKFyDuFWUCF1kuFWxWFg_yoW8Xr1UpF
	Z8KFZrKF48Kryxt3yxtF1kGryUu34DKrW8X3y0ya43Awn8Xr1FqrnruryFqrs7GrW8Gwn3
	ZFsFg3WvvFZxAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhtxDUUUUU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
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

get_best_energy_list() reads a one-page u32 array from H_BEST_ENERGY and
trusts retbuf[0] as the number of entry pairs stored there. Counts above
the number of pairs that fit in one page make the loop walk past the page
through buf_page[2 * i + 1].

Reject impossible entry counts before indexing the returned buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 2c661b798235..575216989539 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -184,6 +184,7 @@ static int drc_index_to_cpu(u32 drc_index)
 #define FLAGS_MODE1	0x004E200000080E01UL
 #define FLAGS_MODE2	0x004E200000080401UL
 #define FLAGS_ACTIVATE  0x100
+#define BEST_ENERGY_LIST_MAX_ENTRIES	(PAGE_SIZE / (sizeof(u32) * 2))
 
 static ssize_t get_best_energy_list(char *page, int activate)
 {
@@ -208,6 +209,11 @@ static ssize_t get_best_energy_list(char *page, int activate)
 		return -EINVAL;
 	}
 
+	if (retbuf[0] > BEST_ENERGY_LIST_MAX_ENTRIES) {
+		free_page((unsigned long)buf_page);
+		return -EINVAL;
+	}
+
 	cnt = retbuf[0];
 	for (i = 0; i < cnt; i++) {
 		cpu = drc_index_to_cpu(buf_page[2*i+1]);
-- 
2.50.1 (Apple Git-155)



