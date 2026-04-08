Return-Path: <linuxppc-dev+bounces-19518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D7E10F9960
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:08:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frTz054qbz2ypm;
	Thu, 09 Apr 2026 03:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775668076;
	cv=none; b=Ri9JVi+efvyjOZzhTNUO8isYUHA9+iyPBevROoirr/3u5cTonIBLGlDFeR5dnYuB/2BhNu5r2CSGy2FASl2dBTDgUUUG4vaxf9famX4F5cNMlqnrQm8RmKVWIMa551z4IhCqVff3ZeGwHcBmTOu2p5GCAjFhUfG4ZHvb6IT6xWZ40RwdKmvh/jIsqA/akoph5Lz13J6sLSt9AFd5oUI9DyVcTr8Yva4Pi9XQs2MOLPXNFnPrXMLsgRgbYpqd9dsYyEdoQVHhPkmnWH0HisHuD0A6F0mdQCQF8UMd0Z3iBHUuPCU4yf72aWm8d5HgANXwJRt7KpU42+IiyIB+czOFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775668076; c=relaxed/relaxed;
	bh=wfyfBTtzXsRTsQfAr++s/Fpd+8/l99zGMEPoeZRv9b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJEXeKPnb6CmGWeXbIydF8fl97RJu9MOJ6MWVv+dkmWBAo3jWtpC/B6esWQn/hBYSCJVQSOqpPNtda+RItml2o/J/LIc6aXHuS3TLXjwmRGT3yZHTdQ3kVKcdbEMDpC+8JLVXuN9wKDc1Yj3rH44Ennc6kT9OuKm+Pz9+SmUNzc6QckeBZOl9WLvfBbb6gWQ4bKjnv+OlQZLwqUq7cmK3EdPTpNnfKVkyb13kcGuQZ1SCZNEqY5N3D4WzdT0w0AuG+x+sRLbur7ElKUe9mtkW34ZK2id1kXoRMRyHGy7yX3UvTxRN985cromHW91TKA09A84p6WdI1Us+Tg9e1JKKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Am6AMy4m; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Am6AMy4m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frTyw3wPtz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 03:07:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 89F124431A;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66046C2BC9E;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668069;
	bh=nPzT0/RuJBqZZlg+GeHIBkfDAhpQe+soZk67pjb3qbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Am6AMy4m7CLqnC+ba9Q+kwdPrqZiitEBYz9NBESR/LlaGk6VTgTaNIjjf0cnxt2P8
	 RgOPR3zM0pP/annF8maTEItxaoO5/VzGxJhgXWqL+dnyNgJ4TK2/s0rC0WpY94roRh
	 VQbqHQfxQFFJ10Eztc7tFYcmh/JejkROJaIxgiwKvJPPQatcKd1E14xEV7+PIH1sCK
	 +eyTrnJMjfqCOdmAwUa/O2ZodkiBbLoxGUKbOBPkiV3ck0u2Bii1kqlxMGI4DOGRU+
	 81zW2NBeKiFySgA+klciQ+n+o8m8r21+RWEG3Iff4+iHyjTAYRtT96Um7Mrge1mce/
	 SVY92ac1kN3vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83B10F9961;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 08 Apr 2026 12:07:43 -0500
Subject: [PATCH 2/5] ibmvfc: Add NOOP command support
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
Message-Id: <20260408-ibmvfc-fpin-support-v1-2-52b06c464e03@linux.ibm.com>
References: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
In-Reply-To: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775668068; l=5787;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=n0x38jb1bZNcxVTLqGeLg3JWwZ917lZAZQZ9f38BwC8=;
 b=YehqTVT50E6sV4zwteh8rEfJStiBCFGPtpJuVhLwWGKrLeEXW1qmoUz/Ko2nviIBgH+RBRc6j
 iUYVrgIs6EJCIJ1KwFUV3kcAGmz9HxumAJ4JQABAQofmjLKFm3uKmme
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

- Add VFC_NOOP command support
- Add KUnit tests for VFC_NOOP command
---
 drivers/scsi/ibmvscsi/ibmvfc.c       | 23 +++++++++++++----------
 drivers/scsi/ibmvscsi/ibmvfc.h       | 13 +++++++++++++
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 27 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 3ac376ba2c62..808301fa452d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -189,13 +189,6 @@ static long h_reg_sub_crq(unsigned long unit_address, unsigned long ioba,
 	return rc;
 }
 
-static int ibmvfc_check_caps(struct ibmvfc_host *vhost, unsigned long cap_flags)
-{
-	u64 host_caps = be64_to_cpu(vhost->login_buf->resp.capabilities);
-
-	return (host_caps & cap_flags) ? 1 : 0;
-}
-
 static struct ibmvfc_fcp_cmd_iu *ibmvfc_get_fcp_iu(struct ibmvfc_host *vhost,
 						   struct ibmvfc_cmd *vfc_cmd)
 {
@@ -1512,7 +1505,9 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
 	login_info->max_cmds = cpu_to_be32(max_cmds);
-	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+	login_info->capabilities =
+		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
+			    IBMVFC_CAN_USE_NOOP_CMD);
 
 	if (vhost->mq_enabled || vhost->using_channels)
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
@@ -3461,8 +3456,8 @@ EXPORT_SYMBOL_IF_KUNIT(ibmvfc_handle_async);
  * @evt_doneq:	Event done queue
  *
 **/
-static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
-			      struct list_head *evt_doneq)
+VISIBLE_IF_KUNIT void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
+					struct list_head *evt_doneq)
 {
 	long rc;
 	struct ibmvfc_event *evt = (struct ibmvfc_event *)be64_to_cpu(crq->ioba);
@@ -3520,6 +3515,13 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_VFC_NOOP) {
+		if (!ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err(vhost->dev,
+				"Received unexpected NOOP command from partner\n");
+		return;
+	}
+
 	/* The only kind of payload CRQs we should get are responses to
 	 * things we send. Make sure this response is to something we
 	 * actually sent
@@ -3540,6 +3542,7 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	list_move_tail(&evt->queue_list, evt_doneq);
 	spin_unlock(&evt->queue->l_lock);
 }
+EXPORT_SYMBOL_IF_KUNIT(ibmvfc_handle_crq);
 
 /**
  * ibmvfc_scan_finished - Check if the device scan is done.
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 29932284a4c9..cd0917f70c6d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -180,6 +180,7 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_HANDLE_FPIN		0x04
 #define IBMVFC_CAN_USE_MAD_VERSION	0x08
 #define IBMVFC_CAN_SEND_VF_WWPN		0x10
+#define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -226,6 +227,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_MAD_VERSION_CAP		0x20
 #define IBMVFC_HANDLE_VF_WWPN		0x40
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
+#define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
 	__be64 max_dma_len;
@@ -621,6 +623,7 @@ struct ibmvfc_trace_entry {
 enum ibmvfc_crq_formats {
 	IBMVFC_CMD_FORMAT		= 0x01,
 	IBMVFC_ASYNC_EVENT	= 0x02,
+	IBMVFC_VFC_NOOP		= 0x03,
 	IBMVFC_MAD_FORMAT		= 0x04,
 };
 
@@ -946,6 +949,13 @@ struct ibmvfc_host {
 			dev_err((vhost)->dev, ##__VA_ARGS__); \
 	} while (0)
 
+static inline int ibmvfc_check_caps(struct ibmvfc_host *vhost, unsigned long cap_flags)
+{
+	u64 host_caps = be64_to_cpu(vhost->login_buf->resp.capabilities);
+
+	return (host_caps & cap_flags) ? 1 : 0;
+}
+
 #define ENTER DBG_CMD(printk(KERN_INFO IBMVFC_NAME": Entering %s\n", __func__))
 #define LEAVE DBG_CMD(printk(KERN_INFO IBMVFC_NAME": Leaving %s\n", __func__))
 
@@ -960,6 +970,9 @@ struct ibmvfc_host {
 #ifdef VISIBLE_IF_KUNIT
 VISIBLE_IF_KUNIT void ibmvfc_handle_async(struct ibmvfc_async_crq *crq, struct ibmvfc_host *vhost);
 VISIBLE_IF_KUNIT struct list_head *ibmvfc_get_headp(void);
+VISIBLE_IF_KUNIT void ibmvfc_handle_crq(struct ibmvfc_crq *crq,
+					struct ibmvfc_host *vhost,
+					struct list_head *evt_doneq);
 #endif
 
 #endif
diff --git a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
index 1c238896049f..3359e4ebebe2 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
@@ -79,8 +79,35 @@ static void ibmvfc_handle_fpin_event_test(struct kunit *test)
 	}
 }
 
+/**
+ * ibmvfc_noop_test - unit test for VFC_NOOP command
+ * @test: pointer to kunit structure
+ *
+ * Return: void
+ */
+static void ibmvfc_noop_test(struct kunit *test)
+{
+	struct ibmvfc_host *vhost;
+	struct list_head *queue;
+	struct ibmvfc_crq crq;
+	struct list_head *headp;
+	LIST_HEAD(evtq);
+
+	headp = ibmvfc_get_headp();
+	queue = headp->next;
+	vhost = container_of(queue, struct ibmvfc_host, queue);
+
+	KUNIT_EXPECT_TRUE(test, ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD));
+
+	crq.valid = 0x80;
+	crq.format = IBMVFC_VFC_NOOP;
+	crq.ioba = cpu_to_be64(NULL);
+	ibmvfc_handle_crq(&crq, vhost, &evtq);
+}
+
 static struct kunit_case ibmvfc_fpin_test_cases[] = {
 	KUNIT_CASE(ibmvfc_handle_fpin_event_test),
+	KUNIT_CASE(ibmvfc_noop_test),
 	{},
 };
 

-- 
2.53.0



