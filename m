Return-Path: <linuxppc-dev+bounces-24023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65550C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 19:17:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxhR61d0Fz3bwk;
	Sat, 11 Jul 2026 05:17:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783711026;
	cv=none; b=DV4xHKWKNj8nBW0jtbe304H7qx2erDRutdyYc3GN1bMwirPGlZI8L1rX6Wl8TfsIVmRQTf83EZA+hqdxxEwuPh6dVX3ukmx6t8xm3gwjuJso8aivd+N7+Bne7slgqhdcU6rLYFBwkmhygRsIaqBIjYvZ7IJZN/EudiwJiXOtZ7Z5v4M+JlRG5kdR5FR00146IpjFOSfReTgbTcvxWZKNeiczSb29Q6gRlYDaisrrvgO+ltqMLpgd5dIBbrlcPvUTFElkdCTZOYhLZCqnX2R9HGu4sIJIAyuXnaOdf0OSlJiFY09OWDHFXp4vfPOtCt9rMphf56IUy9dnJG9fmeHclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783711026; c=relaxed/relaxed;
	bh=bESLXaO2Cbm0XupV5h3J2kZyRBSwz30DgVkluiuipLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsogMBaFxSkcoJ8lDjscriXlTAWuqnWnlKqlOXnWt6c+fhbSvz50nG+kgH0L4SGbnNkpv5cOtKoRrxyE05ipmGDo+skkmwa8O+Wcoi5ozP5QWlK3nLEw3L31G89QyFQyX12EgYcRIg+15qXh/YmmXLHSE91kPBQfycyqJy7WPmIsopUmpmb8LZnv5yqycfO9fe23fk4Vn/FLjDbtgMmqL2PdgQtwWVW6/TtW32rhtgcaT23OIqihdV5h0d91sDBayok65b2UEXcmWKzayC7MoyHLvGJFtX6EkahFb7daNA83J4kBm+xoUF19CfaY8wreAX3+IyS1TxS4L6us/adofg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bFMnNejA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bFMnNejA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxhR04w1Zz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 05:17:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1225443DB4;
	Fri, 10 Jul 2026 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE802C2BCFB;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783711017;
	bh=TGyZgCVxY7zCWMJhLl/6htn+DkBY8VNoc8ZMkzpRyBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bFMnNejAJht2t5eyztZygG41CckDK464ZrB2nlSbi5fHfMm+5xWbB0zve0F727KD0
	 05mSC7fkQXgfKnL4aNTkne0SHmAUEOmNNPhXk9GEMD3wLxEuMllLkOMhpC0R3NhD+r
	 sNf3Xec4P9ER4zaOY946hxWD56WeeJ6+w8MZVgl5yPpnclXqtFXYFWVQ4xn9KZ1xjh
	 cqh6d55SMtSNlMZPavSRVwp9UM/L76GkaaKWeqgNY1P/WFQ3RH1ewAJb4OnY+KOirV
	 5dS99LItP5YKbNqYqEauXqXlxMDtCcDN+PSB+zXpdEJMIDwfK1RP2HOpc6eFuY7/h4
	 sUQgg9hi3yS5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D23C43458;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Fri, 10 Jul 2026 14:16:45 -0500
Subject: [PATCH v4 5/8] ibmvfc: allocate asynchronous sub-queue
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
Message-Id: <20260710-ibmvfc-fpin-support-v4-5-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783711016; l=3317;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=rBhgYJ2t1uiM0cxoYETJDBMpf2C9qi2TrIr+jFCPyOo=;
 b=PTTbtttGusvoi9hV+KxMJoAo6D2KQ9TbW26oq2WCfpA5E5An/pJCL9kAUuhRdQluT30am0Rsb
 l4dQwNx1snrDsgoIxD4z+TTsgC48OTfjxHv/o6XIRK6qA/EYcCT64R7
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
 drivers/scsi/ibmvscsi/ibmvfc.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index c95e78d729ed..586847ff3336 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5375,6 +5375,9 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 			for (i = 0; i < active_queues; i++)
 				scrqs->scrqs[i].vios_cookie =
 					be64_to_cpu(setup->channel_handles[i]);
+			if (scrqs->async_scrq)
+				scrqs->async_scrq->vios_cookie =
+					be64_to_cpu(setup->async_subq_handle);
 
 			ibmvfc_dbg(vhost, "Using %u channels\n",
 				   vhost->scsi_scrqs.active_queues);
@@ -5425,6 +5428,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 		setup_buf->num_scsi_subq_channels = cpu_to_be32(num_channels);
 		for (i = 0; i < num_channels; i++)
 			setup_buf->channel_handles[i] = cpu_to_be64(scrqs->scrqs[i].cookie);
+		setup_buf->async_subq_handle = cpu_to_be64(scrqs->async_scrq->cookie);
 	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
@@ -6392,6 +6396,17 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
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
@@ -6400,13 +6415,21 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
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
 
@@ -6441,8 +6464,15 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
 
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



