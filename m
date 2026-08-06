Return-Path: <linuxppc-dev+bounces-25487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB17AC56207
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 15:18:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG9rZ44r9z3bww;
	Fri, 07 Aug 2026 01:17:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786029470;
	cv=none; b=nvCO22bg1X98UxuUVJT7LUdvjklVaZbKtZ60CCkw9gjeqgKMWA6GC4zY8f4fAaTaVBuKLNGlOtdpFj4yNaWS3sgZJfFxxUjchqzV35D28FDtp7Zvy4R2P8mO+dNLgNg6YX0TmmCOvtfoGDYbW24riSlLzzThBpYLuW5e6S3fUHydkuLtHxVuyjmOq7LioT46f0X4dYSRdab4sRWCkxeWmpMrhJJnl2VDAZIJTXqe37s0Muq3jsn18d9djhia9XolsPcqAnf1MQbp20CIOnsl5HfgyLvQyYm42iMcRqtNtQfYBYV8wWK1FnLWMhD/PQPWx+k0R1yesOBtYgPOBXfpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786029470; c=relaxed/relaxed;
	bh=4Oq6YBiVzwAW2GKqx8uHhCIEavuv8CbzARwV30oei6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOo2QvO8CYmrcFew+/gpeZcIOpTYU9KmfB2khJjQFE1yFh//2fC0ImyeufDgZTk4msveNxgpeYC3YN3xKjcIHZFfEl2NkVQ5HtrOCzR/BbKUtqm59+3hvTZULEwY0n4ZFa7Vhl23FhHSJuFiXRbSo8W9XlvqSMZEbsC6ym67juiQO4L4pxCsPplMdc62Vq3jF2bTUFn5l5TkWJ8HUYm7bH9GOpjpCieJZB+uKz/QLkYqUBjLIOgMHNbETrMEK0LIJ5qXvD3XU00FSBUaf/QeFCeBLHwyqYWDYEE8y+YIVFJ5J2XKKfF+pwtqTV4QX5cJGhlWEhqMEwfZD6DvgWbBHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/V09KsR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/V09KsR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG9rS6sLpz309r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E6F4243C7F;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB74C2BCFD;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786029460;
	bh=FsXcpIYOs0w8fAtVAyJEkoHOmC2YdXOKAfol/LybEx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R/V09KsR0hIvHyqnuqMxONvRlNEZJ5EBfBf1SzMZc2Ga4CJAuGnHfFma4NQZ9wJTK
	 ZvHMCZATA2AfO50gJOug80ShzqQ/ab3ekNo4tI7Mte+hXdG5AuR6/Y8K1M2Y4QhGwQ
	 C29sN3uUXT1T/n73gnF7jXbumAK/ocsucqDU7aw/vPJGUac75Q6lbMl0D195okGd1h
	 LKIzgLl6W3/UsvgNXE2CedGNsoWlNLa597JK9reoMdCZ0yLJeU3UPO2c2jJeyiFvRq
	 40Q49Smskvv6M4LgPfHKRyXOcBpiMm3lSOL6YvaXbg9vGRnw98weJA2684VLofWOte
	 j+YS+DX2OzcuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D0C5AC80;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 06 Aug 2026 10:17:34 -0500
Subject: [PATCH v5 4/7] scsi: ibmvfc: allocate asynchronous sub-queue
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ibmvfc-fpin-support-v5-4-13fd6f8a8f8b@linux.ibm.com>
References: <20260806-ibmvfc-fpin-support-v5-0-13fd6f8a8f8b@linux.ibm.com>
In-Reply-To: <20260806-ibmvfc-fpin-support-v5-0-13fd6f8a8f8b@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786029459; l=2503;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=5RuNy3ewl5Y+dwhrMNnUroVom0cpBS0889/aQRw9BCM=;
 b=O2TVx4DtdVUFoCtw1cVhQdxnL8xx6AGWr6s5zDZUbvq19acN6cJSzKuNbQzSLuTtAcwdDLCSQ
 ncLWojrmHDUBgFyMBkBTwTcp6dFmxIAiJQAtDQF0f+mn74t6mkEqtMk
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Allocate and initialize the asynchronous sub-queue required for receiving
full and extended FPIN events from VIOS.

Modify ibmvfc_alloc_channels() to allocate async_scrq using
ibmvfc_alloc_queue() with IBMVFC_SUB_CRQ_FMT format. Update error
handling to properly clean up async_scrq on allocation failures.

Update ibmvfc_channel_setup() to pass async_subq_handle to VIOS during
channel setup, and ibmvfc_channel_setup_done() to store the VIOS cookie
for the async sub-queue.

Modify ibmvfc_release_channels() to free async_scrq resources during
cleanup.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index aec953f29e55..06898a407d07 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6726,6 +6726,17 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 	if (!channels->scrqs)
 		return -ENOMEM;
 
+	channels->async_scrq = kzalloc_obj(*channels->async_scrq, GFP_KERNEL);
+	if (!channels->async_scrq) {
+		rc = -ENOMEM;
+		goto free_scrqs;
+	}
+
+	rc = ibmvfc_alloc_queue(vhost, channels->async_scrq,
+				IBMVFC_SUB_CRQ_FMT);
+	if (rc)
+		goto free_async;
+
 	for (i = 0; i < channels->max_queues; i++) {
 		scrq = &channels->scrqs[i];
 		rc = ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT);
@@ -6734,13 +6745,21 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 				scrq = &channels->scrqs[j - 1];
 				ibmvfc_free_queue(vhost, scrq);
 			}
-			kfree(channels->scrqs);
-			channels->scrqs = NULL;
+			ibmvfc_free_queue(vhost, channels->async_scrq);
 			channels->active_queues = 0;
-			return rc;
+			goto free_async;
 		}
 	}
 
+	return rc;
+
+free_async:
+	kfree(channels->async_scrq);
+	channels->async_scrq = NULL;
+free_scrqs:
+	kfree(channels->scrqs);
+	channels->scrqs = NULL;
+
 	return rc;
 }
 
@@ -6782,8 +6801,15 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
 
 		kfree(channels->scrqs);
 		channels->scrqs = NULL;
+
 		channels->active_queues = 0;
 	}
+
+	if (channels->async_scrq) {
+		ibmvfc_free_queue(vhost, channels->async_scrq);
+		kfree(channels->async_scrq);
+		channels->async_scrq = NULL;
+	}
 }
 
 static void ibmvfc_release_sub_crqs(struct ibmvfc_host *vhost)

-- 
2.55.0



