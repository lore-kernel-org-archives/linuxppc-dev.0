Return-Path: <linuxppc-dev+bounces-25178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EA2C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 12:29:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBQNq37JRz2yY1;
	Fri, 31 Jul 2026 22:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785491243;
	cv=none; b=ZBlAlXvuk04P4rqlQR5VTLy0oSHjSHruzCuS4woe61t+sAVUHwC7yo4zVwzB5x3aSD5EO8ByUD9hJwfu/K1MqM0DYVFR+lZbOlHQoOxl80kvYBB8izGVg3ung93pRnXMIj4/gLZIb1Iqau7eDfpPNoje35AGHUS0g0rATnoIFCjy6ymqJ5ZHH9KBZm3V0DtHwpiHVpf8JY7gsKnqyAjdVNbiAHNelhJ16gLJOduDyRSUbJms4nOsX+XZtob4XYwVqlUnUPAIUHL5Lp+vNyS9FdgcgfxCuEniF1pbPsxUEGwtlzBQVHvszoc4x04/d85QcGwP8b0ZvmVcAb+yLFzAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785491243; c=relaxed/relaxed;
	bh=jlSrGSedAAayxwu1C9FgtVVzuEuZ9KiTh6/ixYnC0tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cj2oc8jQI+wUOt6Ku+P/LX2s/nzJ3KoggFlIWewE4oNXbhLsLbaKM4nUp2Iy1STzQb5pVAUdzQEgPunpYYRbpVmpDSlPpfes52bBk/mVKIvnAKFsw3xfhlUpjXR15OFR9ogvbsUw0196gGaw7MGS5oTSAmUdO9BZvyGB5JDs0WnGBz3dle3REHXjOOIjZwf2oMgGJzMYZYtSvG2pKgTkAyYGFly4NnOCKYio5eVZ6ghL3Hd09RW+H2iEyaosVrn7JxWif62+23hGhSEsOTMshSVW/TKul5UfzXRFREjX+qvXgVIL4vxTc3A8nNbTCfux1vvsKVtP82WWa5FNda/g7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=gonglinkai@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=gonglinkai@kylinos.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 259 seconds by postgrey-1.37 at boromir; Fri, 31 Jul 2026 19:47:22 AEST
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBLp21C4qz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 19:47:21 +1000 (AEST)
X-UUID: ab2162be8cc411f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c5e3ad0e-fa7e-4ae1-80f4-13abab061e71,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f20477fa42b52889a09d091fca34325e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab2162be8cc411f1aa26b74ffac11d73-20260731
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 85603811; Fri, 31 Jul 2026 17:46:13 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>,
	Maxim Kochetkov <fido_max@inbox.ru>,
	Saravana Kannan <saravanak@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()
Date: Fri, 31 Jul 2026 17:46:08 +0800
Message-Id: <20260731094608.1883391-1-gonglinkai@kylinos.cn>
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

qe_ic_of_init() ignored the return value of platform_driver_register()
and always returned success. Propagate the error to the initcall.

Fixes: be7ecbd240b2 ("soc: fsl: qe: convert QE interrupt controller to platform_device")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/soc/fsl/qe/qe_ic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 943911053af6..bccc7d612009 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -473,7 +473,6 @@ static struct platform_driver qe_ic_driver =
 
 static int __init qe_ic_of_init(void)
 {
-	platform_driver_register(&qe_ic_driver);
-	return 0;
+	return platform_driver_register(&qe_ic_driver);
 }
 subsys_initcall(qe_ic_of_init);
-- 
2.25.1


