Return-Path: <linuxppc-dev+bounces-25576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF85C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkRS0sf4z3c71;
	Fri, 07 Aug 2026 22:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073575;
	cv=none; b=Rw2jE6eeZI5slo9uY2znHOhVJYGRi6p+hU7Aik3Oif6Za1rWR4QiIGwR1XFuxPkmda7zD//1WKQoRXhXfBkILfGjTZU7/hc8zXykZU/E5e7ioODRmkUnez6VibqwqIBdDQmYqSlbr1SlrB2oYm89YzYNpC01FxV0yinlXU+bDTjgsVU7qGVD5B4rFAQvBMczBUJoByT9j6Z0YsQJPwDJfWlgoQQ30XrzPDu+yy8d7C8LPRKieDzvCJD16JYCC6VSklANsTyjbHNAEs49iJ69lH1e/RiOCz4M55E3mx4oGHjAfzGP3cm6jCpYlivxFqa2Qo1DwAL2ODV5v6HrMw5QzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073575; c=relaxed/relaxed;
	bh=6/c4aya2VNetFt92rvnUKqcjYcdniWxQt+xUKYrnaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3BBF6+hQSMhjZL5Z4kSo8R2bM+ALYi/8TlbEJSWnX3RdubNqglQFclghTDsMoiUKxyVjF9k4tS3mvj5IHPTteDkfUWFeEVPki9bftJdHae9fpz6skPRfvy4EoV2F602Vr3h4Q46n/1JOqzhEl9wso7cSjWt4O1K8ci/ySzMxXVrsy+GxFs/1HXzL1jSwbeYe2iNsSY+mPYLkAOlufQ4PaM/0FNBnAyZCG9DbtZOZkaxuqzTzt+byTPqiAK5hNuo9TS6RrRPwgRyw/PYrfZ7zToKcjX3kFi9JxBr+gDHQZCFd3GVwqbEBk4+OVVtfN7FcJpZc812BaSpeGJx57vfcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV8b3HZjz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:32:46 +1000 (AEST)
X-UUID: 7d35d3b6921011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:239a4416-a78f-4cde-8a7a-971fdd4509ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:58481a91c5a73d8ca54b7e90130cdc05,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7d35d3b6921011f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2051555578; Fri, 07 Aug 2026 11:31:34 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 2/4] powerpc/powernv: opal-imc: fix debugfs name buffer size
Date: Fri, 07 Aug 2026 11:11:14 +0800
Message-ID: <prpppc02opali.1786072274.git.liuxixin@kylinos.cn>
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

char mode[16]/cmd[16] are too small for sprintf("imc_mode_%d") /
sprintf("imc_cmd_%d") when id is a full u32 (up to 20 bytes including NUL).

id comes from DT "chip-id" as u32. Enlarge the buffers and use snprintf.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index b3fd5c648dea..77de53d47cb6 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -51,7 +51,8 @@
 				    struct imc_pmu *pmu_ptr)
 {
 	static u64 loc, *imc_mode_addr, *imc_cmd_addr;
-	char mode[16], cmd[16];
+	/* "imc_mode_" / "imc_cmd_" + max u32 decimal + NUL */
+	char mode[20], cmd[20];
 	u32 cb_offset;
 	struct imc_mem_info *ptr = pmu_ptr->mem_info;
 
@@ -63,12 +64,12 @@
 	while (ptr->vbase != NULL) {
 		loc = (u64)(ptr->vbase) + cb_offset;
 		imc_mode_addr = (u64 *)(loc + IMC_CNTL_BLK_MODE_OFFSET);
-		sprintf(mode, "imc_mode_%d", (u32)(ptr->id));
+		snprintf(mode, sizeof(mode), "imc_mode_%u", ptr->id);
 		imc_debugfs_create_x64(mode, 0600, imc_debugfs_parent,
 				       imc_mode_addr);
 
 		imc_cmd_addr = (u64 *)(loc + IMC_CNTL_BLK_CMD_OFFSET);
-		sprintf(cmd, "imc_cmd_%d", (u32)(ptr->id));
+		snprintf(cmd, sizeof(cmd), "imc_cmd_%u", ptr->id);
 		imc_debugfs_create_x64(cmd, 0600, imc_debugfs_parent,
 				       imc_cmd_addr);
 		ptr++;
-- 
2.43.0


