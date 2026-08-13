Return-Path: <linuxppc-dev+bounces-25795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF0C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:38:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLG0T323mz2y1Y;
	Thu, 13 Aug 2026 16:38:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786603129;
	cv=none; b=PEP1qesUrJe+ERVtDdYa5WEn7Yn/tp5tzWgv5uCXeDsebhK4TC21+slrzk/Dlewr2+nUsMqNC9jtAzElX9JG6VlPh5P1jbz72drJF5z6Ve/e4p4CjVwCuvZBPxWP2zD4W8GzcrBVJkO4US+c5TARdJhQutLXo1HxiYgzL+jNB/OL+Czo3UzSAXRZ7zRAizP9pK+PPRGW92zjW1/S10RP6B6u+7F1+9htKrXqXrq4hxXYYUBBkcMbN7oAjpQOM7RV5uzM3jxnao008dC8HhBw7neS8OTBYTo5s+t0WJ5Lc0IaZFFpvggx0ibzAcXznhhClqoVKDfbkrZ7nDvTGLXKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786603129; c=relaxed/relaxed;
	bh=r1JfGWaG/FVzoYAXAQnEoYp+tdOOkH3W57+RESlp+bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RcMdJPmSG6ps8WUrSFQAv7hVVvKpcISwTlmS/EYliqJxk35JfHBmpft5L06jnKUf5Ov1cojsv1Uk4sZJ5T97tOvfb1JQHrXu0NLNBExcRdgMmeB4n02nPX90BV4h1DnfTMxKyCdiFSW6nHupCF7l6TcXw4FMqbHNWQGfqAYbbNnkYAlR/LwV/MoYS3OiP6BbNQMqBuhGPzosvtq//bUbfhY27J8WDDSWcl8xUrsIHkZqXMZvuhi5b2YpsMiZCkhl52MXaG945DbTTjHXLZnWKDa8cOCQbwg5x9lGJWoH8DqH3KKALa6Qr5dvnhBeeAqQKFiBT87Cyt7bGE1McA5vhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLG0R1SrJz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:38:46 +1000 (AEST)
X-UUID: 79913d6096e111f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cbc7acce-1ae8-4f9c-8152-1486d3a5b8cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f207862cbfb5466a5f0b9dcdbd9c18da,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79913d6096e111f1aa26b74ffac11d73-20260813
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1140670582; Thu, 13 Aug 2026 14:37:37 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	nayna@linux.ibm.com,
	gcwilson@linux.ibm.com,
	kees@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v2] powerpc/pseries/pci: Fix misleading VF limit error message
Date: Thu, 13 Aug 2026 14:37:31 +0800
Message-Id: <20260813063731.399598-1-yijiangshan@kylinos.cn>
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

When the number of requested VFs exceeds MAX_VFS_FOR_MAP_PE, the
message prints that limit but labels it "Configurable VFs". Report
the configurable VF limit and the PE mapping limit with separate
error messages.

Suggested-by: Christophe Leroy <chleroy@kernel.org>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
v2:
- rework as suggested by Christophe Leroy: split the two limit checks
  into separate blocks, each with its own dev_err and error return

 arch/powerpc/platforms/pseries/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index d11a64a086c1..6fc13f4a79a3 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -132,11 +132,14 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
-		dev_err(&pdev->dev,
-			"Num VFs %x > %x Configurable VFs\n",
-			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
-			MAX_VFS_FOR_MAP_PE : max_config_vfs);
+	if (max_config_vfs < num_vfs) {
+		dev_err(&pdev->dev, "Num VFs %x > %x Configurable VFs\n",
+			num_vfs, max_config_vfs);
+		return -EINVAL;
+	}
+	if (num_vfs > MAX_VFS_FOR_MAP_PE) {
+		dev_err(&pdev->dev, "Num VFs %x > %x PE mapping limit\n",
+			num_vfs, MAX_VFS_FOR_MAP_PE);
 		return -EINVAL;
 	}
 
-- 
2.25.1


