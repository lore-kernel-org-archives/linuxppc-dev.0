Return-Path: <linuxppc-dev+bounces-26145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C1C61DC6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVzbq3zz1z2y2L;
	Thu, 27 Aug 2026 21:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787829671;
	cv=none; b=Y94Tl7zdbCt9yZdn9EOOVd4Jb3S3rxaiaGk1K107lSivrCOr14avqOQgElCdoDUv61ivQy5q6BDUwHzMLL5r8IlUGhVs3Wj50UHbXYD1ILsJU2q90aR7hFDbLBZJSQmso2S9O35cnBTl1LHXP2hMiUPzwZxxdq/+YRHm9WerqNARa4AgcBEbglqNX3mPHGQc+evW+UHFeScSVDo9NbgDNeFhLuzV0dOo9mP+h+HzDqzTlShPBDEYyuYZjZrY1RamS90OCI/s4yYcc43qCtTKj1E1q7a0mQZLeCr7FpySx8PwxPoNdI+TQgws5qFISBnOOCy2UoEuMnnsYf3GV5uJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787829671; c=relaxed/relaxed;
	bh=G+EJF4VycVNW4dQeq5vgulgjlvSit3NOpyYWBllNXVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMhOE+J7JsAGlOUtHULUE4XnEFgHfgZTFG1LpOvM49OoJVhlA8GR/LWrVnPyELldCYPRKdKQzVvkS2n14lqYxAdWcBVDTaItHobKd6/bqTwuLZml92tdmOElSO7upqfspanUca1/BDReY9oxc+Waik7bOY6Dn3qHW/NT0Y68KuYatXtz7bFBgOASxDUGr2ozkuqpPttjWb1p3uEdXC6+51KZPDsFMIMG50MFmPLPfIwC6FflsdAa1q52PMrQWGNcjrvnp5hgadSNtQOObWAsRooI+qaXxszHkcmUV4OvLqCj+fWiEvtbIWWHOW/ML41zjRIjxKU/W+1hcn7bOlLV6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrhZRWuv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=falakreyaz@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrhZRWuv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=falakreyaz@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVzbp0WP7z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 21:21:08 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d6d28aa26cso14349235ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787829666; x=1788434466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+EJF4VycVNW4dQeq5vgulgjlvSit3NOpyYWBllNXVY=;
        b=OrhZRWuvvX9LJuWPnG+CV0XuomYyL9YTCzhRrTOUFS7idd/UtsPQ11tfg6KCODaKbb
         nyYRRVXNo06da1truaNz+O7EqueK65F+504+J20NLP+M6IP7stsRWyeMKz6DGTTcUlYG
         AkBFO6FINAiDVy0f4OtUOYts6dkiKm0U6lIgfn6C8R14bP1FwV/Wxr7Az/RLMNTasZr9
         Y4H71QwYrSuQ5eOdxszEI+5iDgAVDSwYFo3bfbvsuPkkpqNa/5VNsaaN9b0rGPPe4qgd
         MI7+IwyhYH6VcewRhXi7rqdXWhF2DQl1gQMhLeNTRj9fL7Z0p5MmMv0CiEIoKx4zDj2u
         hNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787829666; x=1788434466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+EJF4VycVNW4dQeq5vgulgjlvSit3NOpyYWBllNXVY=;
        b=P60Wr1VeYCGVN7+Tg+4/JVmQocP6rGAx/fd5gxXBedfj4VW/yd+durnlQgEMLS5mQY
         g0qHNXYcY5X2dGGBgj+Zj9vro3g+xubprSY0q9DdJuvanY7MUz0weQrIFAF0vP2kUa2Z
         TEWpgIxZ+k3Ue3bXnjKdHm+hqBFJoIxoN5RtkYPMcPLtJPdIj4HxAng2/YcJSRhQJzk8
         tZmY2IonF9dYwkx2/WplzT99G7SncizHu+7EcKmeobDB2Iv1jIQIX6xYuTLFMufndHKu
         5sJxTShfpkqartZf0wx4Wc3TufzpegA/F+VMaOheXjhevBpPjkKYWfcAuPR0TqXOsk3W
         wj9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVONz49PdbgjVLFHleh4aawblt0hMS49HQDAn9gTa+QUCrIAlCn+JwWbxke+vq5/BlFGcx+/sMcTA/7UI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k+jpUVdjorqGDvSi8VlzzD56Te9vPiTZ7hLljzRK0dB5Ra0Zep
	F7ujbLKb0K2+2hl3xcOiWQMaXxyDt+uTP8oynYa6/KirritVSAe0b8KX
X-Gm-Gg: AR+sD10e/PtM8FYNixJqlkTLU2NRz+eMgjm/oK3VcygDSYb5vrKOgzUg/G4RmN2raZd
	GcYCPIy8tRXToh6RlJ3CsdaMw8i2bb5XkQRw4HVfUt8l79zcMPsoOZyGSVCuyBDexSU285R13oA
	U2c3nLY0ajmaBL5Epnc8d/83miQvhg+en3H6UutXQNdLx3uR0fJCZ20IIe3afGV8wpSla+OR2h2
	Bu6/Wr6TB5PhikvJ7xAWHxlyGFHGMsj2b+er2yIeFP+buFGtU9u+rbV/eWTQnO62mlAta+vuz3H
	7rafYN9GeQAaE4Ai1dF7e0U3RT7am6wf8q8suzGnUZYR5NsHczoMGKXHFTLf4LVt6Xe8xlbng+K
	yP7NvF6NqpcMjCsqfTkiYnWPMvwjGMH+YXoPo1WKuhjU3Taoxcts2C3/5TMsquOLhrI/pBq+eoi
	zY+wzUgLOQ3uahfHDTy+2mf4XBKXZKdMfNjX5vlOnO3oaop6h1XcqsZicN14eE90hTyv3cR4J+r
	CvzNQ5GZsjgOqZUBwI8utle9BMco2rGPAIytzOK
X-Received: by 2002:a17:90b:4f49:b0:395:4de9:b30 with SMTP id 98e67ed59e1d1-3966d1baf30mr26872063a91.5.1787829666315;
        Thu, 27 Aug 2026 04:21:06 -0700 (PDT)
Received: from baaz.tail58d41.ts.net ([2401:4900:8853:c223:d8cf:ffee:2034:18a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm16423327c88.6.2026.08.27.04.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:21:05 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] scsi: ibmvfc: fix kernel-doc name for ibmvfc_scsi_relogin()
Date: Thu, 27 Aug 2026 16:50:37 +0530
Message-ID: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit e0fca728a89f ("scsi: ibmvfc: delete NVMe/FC targets as well as
SCSI") renamed ibmvfc_relogin() to ibmvfc_scsi_relogin() but left the
kernel-doc comment referring to the old name, so a W=1 build warns:

  drivers/scsi/ibmvscsi/ibmvfc-core.c:1901: warning: expecting prototype
  for ibmvfc_relogin(). Prototype was for ibmvfc_scsi_relogin() instead

Update the kernel-doc comment to use the current function name.

Fixes: e0fca728a89f ("scsi: ibmvfc: delete NVMe/FC targets as well as SCSI")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608271026.iMLmrwz4-lkp@intel.com/
Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 93b9f699c2e53..d1956552698e0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1894,7 +1894,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
 }
 
 /**
- * ibmvfc_relogin - Log back into the specified device
+ * ibmvfc_scsi_relogin - Log back into the specified device
  * @sdev:	scsi device struct
  *
  **/
-- 
2.55.0


