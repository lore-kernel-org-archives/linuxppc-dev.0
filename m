Return-Path: <linuxppc-dev+bounces-25783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDC7C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 04:12:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLBlX2Qlgz2yYq;
	Thu, 13 Aug 2026 14:12:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786593294;
	cv=none; b=bFqMB+d/3xr8SkPpvWlvoioDKz7VeHRBVVrx4HYvlKRf9dwl/xaPH8xQ/Dg4U8gjY/eOjFi2ada5xJzzin5G3gj9o5FkrZWjI37tzCCz2EZ8fAZSOkX0GLB9+FVJsFFRjgHeKDQPaCbj0114HNKvkMYz1exO2JXpc5L6sGafG0nqRpySauZsQWNfdSjJmue1mM+ffvK4xHiGhCfraBJRkIB/q1L2CeQoDAXvbGD3oqojHl3iXXKqFxIlhtYw+jd3a0Nz4K9DNCwOWttcDnw2n+fApsQBHOfTosilK9+y7gKo3Mc7lbItgAbMQPDN7QVdsuP6sPXo57cwq9ExzXx2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786593294; c=relaxed/relaxed;
	bh=d+JF/QdCp/YGwziSDfvx8ACBaTvCb3qFjJDgLKNtC+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EV99ygXW/n2YcI2cM36MH05DBI3nlb4aZ/cftXtYU01Rz9t/1wrolBqkGyRb5cBmXqob+IanhmmZU/qrYCPO5G9IfVO11t8qNszF0oSww0AfCayaEDLOMvTQ+cVpcj+2dMhU3hDb7A6GX/4uaqGwKHDq4QvaLrP64nS46PxXDSeb0o/wRJuIUCWVbNUjZeINAHN+fcCZWn5J/iW3HNcCSy59XP2G/QfqaHCJPEW5HxmDnzXmxQopYo88IcT7C4OPU8tYzJ1VD7o4f588xErJHLPUegwpgWTW5EVDvLqScBKnAaPZNLE7KM7iwr9dIM9yG3eX2Vz7ym3cbSZJmow+1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLBMH5122z2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 13:54:49 +1000 (AEST)
X-UUID: 8cef2c6c96ca11f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6b5a7f39-697a-4c76-a509-e284d0666df2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6dfb34799cb659e073501ba4c448852e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8cef2c6c96ca11f1aa26b74ffac11d73-20260813
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1999809351; Thu, 13 Aug 2026 11:53:31 +0800
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
Subject: [PATCH] powerpc/pseries/pci: Fix misleading VF limit error message
Date: Thu, 13 Aug 2026 11:53:23 +0800
Message-Id: <20260813035323.245229-1-yijiangshan@kylinos.cn>
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
message prints that limit but labels it "Configurable VFs". Print
each limit with its own message so both are reported when both are
exceeded.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 arch/powerpc/platforms/pseries/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index d11a64a086c1..1e1903bf3f1d 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -133,10 +133,12 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
 	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
-		dev_err(&pdev->dev,
-			"Num VFs %x > %x Configurable VFs\n",
-			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
-			MAX_VFS_FOR_MAP_PE : max_config_vfs);
+		if (max_config_vfs < num_vfs)
+			dev_err(&pdev->dev, "Num VFs %x > %x Configurable VFs\n",
+				num_vfs, max_config_vfs);
+		if (num_vfs > MAX_VFS_FOR_MAP_PE)
+			dev_err(&pdev->dev, "Num VFs %x > %x PE mapping limit\n",
+				num_vfs, MAX_VFS_FOR_MAP_PE);
 		return -EINVAL;
 	}
 
-- 
2.25.1


