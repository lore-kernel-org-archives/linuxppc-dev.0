Return-Path: <linuxppc-dev+bounces-25573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48A5C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkQ703vxz3c6P;
	Fri, 07 Aug 2026 22:45:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073575;
	cv=none; b=n4bKF5e5RoEE6C9XAzX5EsZHBgiqViWOnMT1PYVYVMMzrm1IEVifuAC2/yZz578KE7kkFhdKrKKn/vRAMHbjF+6NUnE9vi7h7MpmqlbY3XZJIU4HCEuJURnDsXlayYwfi/3WUpFrwz7nEhb+4iQTGeEQ7ZivBvPREJJY0zOr2MZoIFjys6VmhEk5epBu0ANE4UP7ztvYJIjhqipyImIzOA6eDL8N+vfkwND3v+hutK0RvT4T5v9XLZcwRc8Y/xJ9nkT04bJkiwXygbI2guggoPuXRrAGoCD1dOqD5gBP78ZF18mGnFza7Vl1VSSGTpImlDtaHKJtn1UU1yo2AeOfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073575; c=relaxed/relaxed;
	bh=Rl5XSYdR7r5bFq/LDV6gBQqYpHdCG1HKrygfQwBkg6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0XZSjPjHn5p7KgxFuloS9UWM+ueWrxquU28eXPRM7mcrVYwjEy7Xn/jXKOwcT0F8NeFTqCtgQ36F+eXYwRMLqOxC6gmTto8NVLQO2+Hx5SUzLT7cAay+jtGSWqxLQVyoldgtNpSrK5Wz10wYW3+Fo9YqmHATFwzUF9k3APK3ifUC/+CCxPOUcGEv0NELXG7uB8Vwyijo6eT8dmtPTf9DlAp4Sg1ZF1bDTZXgfE9HuOnF4Lcv+R5fufHYv3CAyxu63+fHVbyaeEgdd2WpkdhRdAiXJ79532MxHl0CQ9pAvjCo7Pnwh+Q6aHeGMIblt9z746MGZdhmPA0G+t7BOkHZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV8d1Ps4z3bwf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:32:48 +1000 (AEST)
X-UUID: 7fe54e8e921011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:17bc8f88-179b-4294-825c-f8e819814ab2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:931868f0700bd6dfc3791efc2f9cf001,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fe54e8e921011f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1943659936; Fri, 07 Aug 2026 11:31:38 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 4/4] powerpc/iommu: fix debugfs name buffer for 64-bit it_index
Date: Fri, 07 Aug 2026 11:11:14 +0800
Message-ID: <prpppc04iommu.1786072274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1786072274.git.liuxixin@kylinos.cn>
References: <cover.1786072274.git.liuxixin@kylinos.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

iommu debugfs names sprintf() "%08lx" into char name[10]. The "8" in
%08lx is a minimum width, so a 64-bit it_index can need up to 16 hex
digits plus NUL.

Size the buffer for an unsigned long and use snprintf.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ee1b5cb557c9..e8f48aef7832 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -53,10 +53,11 @@
 
 static void iommu_debugfs_add(struct iommu_table *tbl)
 {
-	char name[10];
+	/* unsigned long hex + NUL; %08lx is a minimum width only */
+	char name[2 * sizeof(unsigned long) + 1];
 	struct dentry *liobn_entry;
 
-	sprintf(name, "%08lx", tbl->it_index);
+	snprintf(name, sizeof(name), "%08lx", tbl->it_index);
 	liobn_entry = debugfs_create_dir(name, iommu_debugfs_dir);
 
 	debugfs_create_file_unsafe("weight", 0400, liobn_entry, tbl, &iommu_debugfs_fops_weight);
@@ -70,9 +71,9 @@
 
 static void iommu_debugfs_del(struct iommu_table *tbl)
 {
-	char name[10];
+	char name[2 * sizeof(unsigned long) + 1];
 
-	sprintf(name, "%08lx", tbl->it_index);
+	snprintf(name, sizeof(name), "%08lx", tbl->it_index);
 	debugfs_lookup_and_remove(name, iommu_debugfs_dir);
 }
 #else
-- 
2.43.0


