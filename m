Return-Path: <linuxppc-dev+bounces-23711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvkrN0L5Rz2xWY;
	Wed, 08 Jul 2026 00:58:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783436323;
	cv=none; b=hzFq78uZDz00g/JpfIhdbHE+T0CCbPy23f/cvP3kZqv7mgfxEmx1kkCKl0W4QRmn22KSZGLnAPJfBnRIm6m92MgdXzjGQlhD77Thcz5lQd0EuubVENXkwqJe/lTCVD/oMAFM5w1iM+JrpW3d/GU10PfP/qOEkkpBwmIEM917AK3+xKw0lvOyqd+XrFNufNGLwV1xmv+DtHZz4w77JSu4DtiZ9aFFLsGS8k7f1NPMxzHG+3gXuG2zj+kM41o+NgCUYA8sroY8oELhQhxFYTBqEz6Dopf8pgQc2YU9zkEGOU1re1TKi9Qdh+/wQnrGSuWm8QWxCbr/d0Vm0iA9kYQFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783436323; c=relaxed/relaxed;
	bh=y3xVuote9u3D9BR80HWLFb2zecWYnRZ4sk5LiXRI0YI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lat1yptJTPc6NcR5jIF1bJlDUk4u14UFig7w0xsbBk0RLTtXhUpPjIIGORJWZfJx+xUOgeDj9eQ2QGXu1Y2Uh/hAlpdmFXOvyqs/Bp+Q2Bom9Y66QSN0QeJlOwJ5FRaSNdimXGt80Uo/PWDd7HJcBOFpntEp5liluUajvpt2K6xYWhaIJN0b/LMpZgvhabldPEoCfAhE6via6EkBbqkcETMvVD5ClTWxo09xlvqOvBryWnJ7PuHZWRW+e+wKVCIiLQUC1EnUJLb+Sfiew1dFBvBEtLkRV0jLIJ3QsTLQfsIh/TOE3rRm7T5R58VKDSro3D5cYwHC7rv8s/Udcpk8+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfI6HzF2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfI6HzF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvkrL5R4lz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:58:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 24A35601EB;
	Tue,  7 Jul 2026 14:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EA51F000E9;
	Tue,  7 Jul 2026 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436319;
	bh=y3xVuote9u3D9BR80HWLFb2zecWYnRZ4sk5LiXRI0YI=;
	h=From:To:Cc:Subject:Date;
	b=dfI6HzF2IKlnSnYCYlYGAX1Mru9WuhG2EKUEyWYloiQK+VfDtqXBF6He7SzogTlLx
	 ZBktpeiXk1r6/JryEblxF7Wwh4Utc6dK0PNfFclIpTNJM6Hn1rC2MzybW0uY9NrbbE
	 xUoogzzHKP+WmFiG7CmsxYu+Liyk01MLLDRW3COJ/31eeX+AlPVkG7fFAaInpqZpV7
	 9ThfyhbZitkME77THpop1+9tgd3r8wMBeo6vXigfwGT9Aly8dPSyj7P8b3huzzQ2Tm
	 7qSpK52ShNMdp6RK1T1FniJQJtGmm+GxJuUfXC3pnwpvzf3LV+tz2ARBMyZ8+2Al2Q
	 1YBxhu2bMT4nQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 1/2] soc: fsl: qe_ports_ic: Use generic I/O helper instead of specific powerPC ones
Date: Tue,  7 Jul 2026 16:58:14 +0200
Message-ID: <b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=chleroy@kernel.org; h=from:subject:message-id; bh=arvLCYHqWrUHkcx055c37FRvAlzSr7XgCPww+FFNsX8=; b=kA0DAAoW3ZBwJryrz1MByyZiAGpNFAqhsGEuFtzI08+Th4P43Q0RY7aAxNfenMFmxeCOlYxFW oh1BAAWCgAdFiEEx/8LupiK9GVvlbov3ZBwJryrz1MFAmpNFAoACgkQ3ZBwJryrz1OaEAD/ZJLU jrGNaBWQSyj2qj4rPDOldJT+4j0T2Xya5+hWbGQA/0W1CqRSxmOPzQdin2BYVlmkdXFpiaXkTEx l5dP6JYsA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Use ioread32be() and iowrite32be() instead of in_be32() and out_be32()
to allow build on other platforms than powerPC.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 9b0bba64e91e4..33ca1ddafe18c 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -23,36 +23,39 @@ struct qepic_data {
 static void qepic_mask(struct irq_data *d)
 {
 	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	u32 val = ioread32be(data->reg + CEPIMR);
 
-	clrbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
+	iowrite32be(val & ~(1 << (31 - irqd_to_hwirq(d))), data->reg + CEPIMR);
 }
 
 static void qepic_unmask(struct irq_data *d)
 {
 	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	u32 val = ioread32be(data->reg + CEPIMR);
 
-	setbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
+	iowrite32be(val | 1 << (31 - irqd_to_hwirq(d)), data->reg + CEPIMR);
 }
 
 static void qepic_end(struct irq_data *d)
 {
 	struct qepic_data *data = irq_data_get_irq_chip_data(d);
 
-	out_be32(data->reg + CEPIER, 1 << (31 - irqd_to_hwirq(d)));
+	iowrite32be(1 << (31 - irqd_to_hwirq(d)), data->reg + CEPIER);
 }
 
 static int qepic_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	struct qepic_data *data = irq_data_get_irq_chip_data(d);
 	unsigned int vec = (unsigned int)irqd_to_hwirq(d);
+	u32 val = ioread32be(data->reg + CEPICR);
 
 	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
-		setbits32(data->reg + CEPICR, 1 << (31 - vec));
+		iowrite32be(val | 1 << (31 - vec), data->reg + CEPICR);
 		return 0;
 	case IRQ_TYPE_EDGE_BOTH:
 	case IRQ_TYPE_NONE:
-		clrbits32(data->reg + CEPICR, 1 << (31 - vec));
+		iowrite32be(val & ~(1 << (31 - vec)), data->reg + CEPICR);
 		return 0;
 	}
 	return -EINVAL;
@@ -69,7 +72,7 @@ static struct irq_chip qepic = {
 static int qepic_get_irq(struct irq_desc *desc)
 {
 	struct qepic_data *data = irq_desc_get_handler_data(desc);
-	u32 event = in_be32(data->reg + CEPIER);
+	u32 event = ioread32be(data->reg + CEPIER);
 
 	if (!event)
 		return -1;
-- 
2.54.0


