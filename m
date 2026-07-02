Return-Path: <linuxppc-dev+bounces-23444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C6CC43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 18:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grl5b5p9Vz2yks;
	Fri, 03 Jul 2026 03:59:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783015187;
	cv=none; b=JiaC0hK43/dJ3CxhBdPnE3HMw1I7nI+mvJ0U4K3a7sUN/Tc0Rs+joqQvf2pL7itw+fx4ezP5PFy32bVAGaej7DHw8irGPun3SukmwSi5EdIMkfGhasEwIlpU4HHJ8x6PqH+5C9faOc8MmyfsbpLbXWAaVfo53KpHQvtDTpMdSIe25++Nlsmm8qr+6MSWmqvM/4x/ia/OGr4ZaLbltO5vMrh+5saNYrhDMjpaa5+AyR30tmiI6wuveh7PDa/VwClFSpdN33hvCxaHqexQK3zhW+WI/MJ6w7HpR1IqHjiCXn9eH5xZZu3abnNDYmVAXAesz5PzaQvF+EcJER9NtU3qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783015187; c=relaxed/relaxed;
	bh=6xK8bPgqYEH0nwI7JYDO1dc7vm0t3Bs7auTogpIxw4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nacb4q8cEirH0fIp+dr0txIsQ5pLUPMqx4cehl4VAppZCwrXS+cbpndM9HgmqLRnIrdPpjsK9MnLi5nGvJdMXYXgzdja0dEHFsj8cn42kdKMummXJk8JvfmQuAtXHd3Cvuc9PDuk+izJUoT26wyeOQWMGNTfet3mNsqB+viKwXSWJ85a5umNbfKArxmims73mR4kuf+2SAtEF3TI8Y8EXgy9LZUm2tPwCf8/eAFEpU2hPJpGUuFMlVQJIMVhaqWaVhdhQKEdLtFLy/VYqJsl25uarSyY4Ny4t+yWqmd0lYIxtorH9XS/5zfUfqtTVX4tJenovrSzZXygeE8xukFvzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CRLcW1ay; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CRLcW1ay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grl5V6wyjz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 03:59:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8959E43E5B;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB14C2BCF7;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783015179;
	bh=nyZGkqA9jE+Wt5WQfH4jQjx/9FB7V+NCYg0TeF4oThs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CRLcW1ayt89LnoGkj38ROM14kAVCcYBk54flXGZmEpqsCLIf8K3BLxs2caoa+MZn0
	 vOfrKnFqBomwnHOvM3oW3uuM49O4fEudwXS+nFoZLkirvkyzkWnbgzNdy/lv0U+Rqq
	 WJPVyC4JZMsR1B9EDLWftCcgRlNGWHiEbPxBtQ1EBo2U7MO/PD4ehAbut7z0D+KR74
	 m0DznXk4pe1KeMdz9qczehqoyBe15hB5ltkjHPX8T8OO/MDgnSgHi+1z4wPaOeO9ia
	 ltaFVxeuztmZUTliNemMvPRo5NHpdVYOqle9eiirMcPLTZLLpcJLBPxlEoXEwLoKLh
	 VHIc7vUbpk94A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEDC43327;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 02 Jul 2026 12:59:35 -0500
Subject: [PATCH v3 5/8] ibmvfc: allocate asynchronous sub-queue
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
Message-Id: <20260702-ibmvfc-fpin-support-v3-5-d95b9547cf88@linux.ibm.com>
References: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
In-Reply-To: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783015177; l=2700;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=uDOxMbB8uvBIOoiFSNqV1PpDlUddjOkPBOQ0/akLTHo=;
 b=U3EHwHUhQzKgBD2RJ1nYjYkcnSEph6/JMTis4U3ZmRoLwaBfXfQ2yLJs4Vzed428NTOGNr/SU
 ODpiWf+ssFtCPwU8ekK8VfnzDdfR8xm/7NH4WD7/EOitaRoC8AVJ57Q
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Allocate and set up the asynchronous sub-queue for asynchronous
events, as required for full and extended FPIN support.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 6dd1e726d9b9..804887fb5635 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5371,6 +5371,8 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 			for (i = 0; i < active_queues; i++)
 				scrqs->scrqs[i].vios_cookie =
 					be64_to_cpu(setup->channel_handles[i]);
+			scrqs->async_scrq->vios_cookie =
+				be64_to_cpu(setup->async_subq_handle);
 
 			ibmvfc_dbg(vhost, "Using %u channels\n",
 				   vhost->scsi_scrqs.active_queues);
@@ -5421,6 +5423,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 		setup_buf->num_scsi_subq_channels = cpu_to_be32(num_channels);
 		for (i = 0; i < num_channels; i++)
 			setup_buf->channel_handles[i] = cpu_to_be64(scrqs->scrqs[i].cookie);
+		setup_buf->async_subq_handle = cpu_to_be64(scrqs->async_scrq->cookie);
 	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
@@ -6388,6 +6391,17 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
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
@@ -6396,13 +6410,21 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
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
 
@@ -6437,6 +6459,10 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
 
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



