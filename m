Return-Path: <linuxppc-dev+bounces-29066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52FBCA600D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:06:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0zwk5kNTz30Vb;
	Fri, 09 Oct 2026 06:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791486358;
	cv=none; b=Fg3Wy33HB+ugzgMoTXk/bLkTOMYTtpBggYSSNdlESwVedxeojr4Ly/mDQaCON/s0UcJU32ZIAxbRm+g7bVOZwWIVO2iezcHBfzex33oYQ8ZK/DYu2yM/cOvzjw+URh22CcjBz0lpIhlxFc6gNpKUi8WWtEl66mmmHUmQfdnS+R9uoAApv0W8U8UIxzuR835YrURSK10md40VEBBE1ETuGN7CjbRegWMYfiol1aHAYlxrkjjE/ll0jOZyoEuPCzrfSipnVCH7Ixq4OIfIlQlSMbip6WlYp+ddz17AHwFgR33rkNxO+MF3jWTOKEDy4c2zI6qIHYQrspTes+O8I2JPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791486358; c=relaxed/relaxed;
	bh=hyPNBzj+MCfzXMl6uxcoDgY0937hSaWt4Ly4Pq8v4VA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQr01It3gbH+7v0y/YQqgLf9NBkdNGXKexjBoFggLKYNV5LMh/CyC6LFR+JumUYeEiQTy3YWVZkm6QJJVCylUnOr32PmIHlV/lIY/YmGRFiJ7iAwiddn1HxTVXeI2Wk6r4u2PzG9M+9qcbRIJNYtTe1LOFa8wHc940oJKMIgJ0P53woXHszttlrkTmlZ/sdJshsBBwQJ20JQ/CEdou597iBjkfs8yg/FD4X2IfeDDmMLQAyAB3SP32bTKZxKi64nKLdh1vARF7xdF1L4cMSF73AvfjSDdp6wNhPtR+yqNZ12gHQdXXxtyjrc9ANS0SPyUinbc/YVeeo/mSl7qeY4bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0zwj373tz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:05:55 +1100 (AEDT)
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADHk0GL6cdqPDARCg--.13716S2;
	Fri, 09 Oct 2026 03:05:47 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/opalcore: fix device node leak on incompatible dump node
Date: Fri,  9 Oct 2026 03:05:49 +0800
Message-Id: <20261008190549.2800467-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:rQCowADHk0GL6cdqPDARCg--.13716S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrKw4kWw43tw1xCw43GFg_yoWkKFc_Kw
	n2v3srCr4kJr4v9w4qka1rGrnFkasrWrW5tr4Iq3W2yayaq3W3GwnrtrW5G3WUGrZ2yrW5
	GF4DGa9xWa4S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUg3l8UUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMOA2rHpl2XiwAAsD

opalcore_config_init() gets a reference on the "/ibm,opal/dump" device
node with of_find_node_by_path(), but when the node is not compatible
with "ibm,opal-dump" it warns and returns without dropping that
reference, leaking the node. Every other exit path, including the
adjacent of_get_property() failure, releases it.

Release the device node reference before returning from that error path.

Fixes: 6f713d18144c ("powerpc/opalcore: export /sys/firmware/opal/core for analysing opal crashes")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 arch/powerpc/platforms/powernv/opal-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 32662d30d70f..fbf4677e811d 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -455,6 +455,7 @@ static void __init opalcore_config_init(void)
 
 	if (!of_device_is_compatible(np, "ibm,opal-dump")) {
 		pr_warn("Support missing for this f/w version!\n");
+		of_node_put(np);
 		return;
 	}
 
-- 
2.25.1


