Return-Path: <linuxppc-dev+bounces-22284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18526CD8CAA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 18:30:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ0w94n8mz3bs0;
	Tue, 09 Jun 2026 04:30:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780943433;
	cv=none; b=Ty0nHxN1oMyoHXA4R/eRDCVSQt8cUmopt8gum/ApOOJXDM/YMkZy8vwVZGYvsaovXD0xMje7PiuFydtMu6/JLsugEp0RqdWYdArVaVlE/WmCc2TU1Iq3jj8GuLd+/q3Bbb+rxe5XAm0j9YS1AcQtDY9D755SFtqxffFo7SjwUOXKu6RdhOkCapWEH4hh7ZPfSzBmiR4FV34ctcagWedXGC6UmqG+hGYi/XwHYhylWM4bnEUbsK/PY3GQAvhc1fclblABcdaRDoR4y/WWHRDBjgUnVignKM2uktv7znlx1MwUgA05GyQ+5kLnBiuBLKWE5SVdRVHiuEZq6g8x1kvgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780943433; c=relaxed/relaxed;
	bh=9bgu0Zwm3pYz+b6eUZD/MJxWAlKbeV52ZzJlo9sz5T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDlOti6y/AYPaebe9bTfJpoowD21U6rgmNQV4ZO5a+oQxmcIxIdwANNZs0MSgJXOrUvyF0pPkKrDbABbDixoEMfQZvo74RntNJV39uk/XAP4Q6n38z3m72AW90L5JCp4QY8OLT/aXq+yD8zl4d9h/ibmUdu2RmelKGtbFwxi56blLFsohSOdjocGEtTTRFvxFzV2Z0CT7q5TPKyLvHPlRvd7X0oT/ylI82cXe8WtJvkYpnGu5682oDwuVmONVARISSJxqyMITVFznn1F2tJbTMvVkXWIiL55Lmax+D1qR41g/TtS+cpEgNwM3EnGMZDSUMAddvPuDhvY5YSjeP1coQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hta6CqAh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hta6CqAh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ0w34YCpz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:30:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 50DEA601E8;
	Mon,  8 Jun 2026 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4063C4AF17;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780943424;
	bh=8/EY0NOHHy8eX+qz/4HA9u/TVExATrYs5NIzD8L0QTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hta6CqAhxsPBf4gwMV+sT8kL7RxymxnRgab/ME5l3Pe+NS0s5IAKXTxtsR4r6VvNt
	 IU3GMsL4P7c4xRdgJEnJww3FcbNe76QYxYtlWiyYvIJsyUY8jkkM171o+YVTCKCY6g
	 EsRBBr6tgBYmi3UEPWw2tGqhoGuLHWvkv+l6DRTcTjvsbGuJykMAJ0M3tRWTuABiQH
	 rLZcJFIg6V4IjQHnUfQuSCdIvMO3bJXYfY1VUWslKc2kNnb9LvF/vUiQpHG4/m/ux+
	 +1QPIFtA5HiwRBFEUrFWL2wI9ZIkeDw3L9+tmngenfslLgFAs/V+hwQEx/WY7XrjBj
	 5Um4d/jzM9byw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA0CD6E79;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 08 Jun 2026 13:30:20 -0500
Subject: [PATCH v2 5/7] ibmvfc: allocate asynchronous sub-queue
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
Message-Id: <20260608-ibmvfc-fpin-support-v2-5-d41f540fba5c@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
In-Reply-To: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780943423; l=2552;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=WZU0TiQHIfrATphYf2jr66JLZ5y9tryV6E3XG2zppIE=;
 b=nWCwY/Gaspg7WA0psfLZHY2NuOMDXWuDl+dLWUWEYYdS4gJkdVPFYe7pUJLHXH5YMoIPkeU8m
 5+KyrI5Vlf6C4313XdDy51CcLOyFUrpOw74R6CX3SFEHJqCZ/TDhGjv
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Allocate and set up the asynchronous sub-queue for asynchronous
events, as required for full and extended FPIN support.
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index a18861808325..ad1f5636e879 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5352,6 +5352,8 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 			for (i = 0; i < active_queues; i++)
 				scrqs->scrqs[i].vios_cookie =
 					be64_to_cpu(setup->channel_handles[i]);
+			scrqs->async_scrq->vios_cookie =
+				be64_to_cpu(setup->asyncSubqHandle);
 
 			ibmvfc_dbg(vhost, "Using %u channels\n",
 				   vhost->scsi_scrqs.active_queues);
@@ -5402,6 +5404,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 		setup_buf->num_scsi_subq_channels = cpu_to_be32(num_channels);
 		for (i = 0; i < num_channels; i++)
 			setup_buf->channel_handles[i] = cpu_to_be64(scrqs->scrqs[i].cookie);
+		setup_buf->asyncSubqHandle = cpu_to_be64(scrqs->async_scrq->cookie);
 	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
@@ -6369,6 +6372,24 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 	if (!channels->scrqs)
 		return -ENOMEM;
 
+	channels->async_scrq = kzalloc_obj(*channels->async_scrq, GFP_KERNEL);
+
+	if (!channels->async_scrq) {
+		kfree(channels->scrqs);
+		channels->scrqs = NULL;
+		return -ENOMEM;
+	}
+
+	rc = ibmvfc_alloc_queue(vhost, channels->async_scrq,
+				IBMVFC_SUB_CRQ_FMT);
+	if (rc) {
+		kfree(channels->scrqs);
+		channels->scrqs = NULL;
+		kfree(channels->async_scrq);
+		channels->async_scrq = NULL;
+		return rc;
+	}
+
 	for (i = 0; i < channels->max_queues; i++) {
 		scrq = &channels->scrqs[i];
 		rc = ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT);
@@ -6380,6 +6401,9 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 			kfree(channels->scrqs);
 			channels->scrqs = NULL;
 			channels->active_queues = 0;
+			ibmvfc_free_queue(vhost, channels->async_scrq);
+			kfree(channels->async_scrq);
+			channels->async_scrq = NULL;
 			return rc;
 		}
 	}
@@ -6418,6 +6442,10 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
 
 		kfree(channels->scrqs);
 		channels->scrqs = NULL;
+
+		ibmvfc_free_queue(vhost, channels->async_scrq);
+		channels->async_scrq = NULL;
+
 		channels->active_queues = 0;
 	}
 }

-- 
2.54.0



