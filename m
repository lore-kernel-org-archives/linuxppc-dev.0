Return-Path: <linuxppc-dev+bounces-25912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41463C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 20:28:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP4CY6W7Yz2ykc;
	Tue, 18 Aug 2026 06:28:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786998489;
	cv=none; b=jJV37WkbU69MUeWldB+OJC4pfcFawrwhsLofrsAgFjWRc9vBV8oVCLz41bU0TS6wtCK7HCVFXFDWXxZFzC4EHWIgnHng/5TUDLsvNS8oprY5+3JkNKrZ2/liAUE8ckh0BSg7e9mQD1zDkUhHHLtHmllJ3SchXSgUHR3xK6qGphlVxgOKCiyAkxUGx5EMJxTYOgvHHezy+U6D7IkwaZ/BgU3gKePBb/dJG4nAbmuVmYXFV3KN6kHFjMBmRIksV2noMnZFm6u0n/YNg5p3EtGodbPHShdax4JaqgOokZEUGkz7JVITiJcnq/XfvCGrbwSLJYDrCDKPWXl5JASEHVL5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786998489; c=relaxed/relaxed;
	bh=kQ9QGqIqak+H4H2OQPm9opvhLoopsZAb10nv7ETfhJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfPzbL9EQie/+JfFUKIQ2tgtl3gPzpUodOPclNfn1CYFdY4y2sO6jc5faG6g0nkBQLHvaJfNaGShjUQ1drvjxzdt4RhMgd5R8+leld343DEL/cGs/prhHoFQvnjloBIChwAFVsGHbfDYc2H14Y4A1e37NJjmEfZasZR+5ft2queTnTW3yOIkf3Rf/bocbP9pcoYLCCnj8YytL95LtlS28m+8LkTkv+oHVZfiRhfttF+EsP+1bkOgu76dAsxYB9t5q/GJ6ZME7aySXFC2rabIHAU3b7Of6viseKVfApdZrzAef0BdLm1Wj7YrK6hkwQizIgsI7OshPeRJ5WqyxAg/hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G8cOjpar; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G8cOjpar;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP4CR60Mkz2yRZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 06:28:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E726F601E0;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87999C2BCF4;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786998480;
	bh=HwmWfEDHvET2VABRqB2+L7uM+jxA3WMPRe4ZJvrflZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G8cOjparchmZQ27bDjr6H6Zpj15G+qi36rgFkVW2gDt6EbRwponnX8JW9i23XwEwb
	 uVKJN71+Q3U+4XSCaavHgcOCcv+qGovVFutQGPW6aQqaWKE11UpfCNzKHMDQx3ApC8
	 6e+ojpwjJSwZ3qjDPvFIN2rSBvsfdxFqavIZn/XPkEwkKXILVexvXMj0LGumCWqNis
	 3H+eLofhDEx5kOG2HvSSLY7pz4fhScHk0fqnA5e1yCFG4Iz9/t+EiszNSA0Avh6k8L
	 fbU6EHiPOjK3lbPffQzqXghnrctDXX3iYAFs/cE/7oTmUZck65dn0iUGysjCiMv1f1
	 VL7jxIXDlc74w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69976C5DF7E;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 17 Aug 2026 15:27:55 -0500
Subject: [PATCH v6 2/8] scsi: ibmvfc: Add NOOP command support
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
Message-Id: <20260817-ibmvfc-fpin-support-v6-2-62a2d525e70d@linux.ibm.com>
References: <20260817-ibmvfc-fpin-support-v6-0-62a2d525e70d@linux.ibm.com>
In-Reply-To: <20260817-ibmvfc-fpin-support-v6-0-62a2d525e70d@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786998478; l=2488;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=9SEbwhnfSVQdalnJewp+335AWlDv08Etc/f1IY3q92c=;
 b=1Ll5s9Ouf3E7OwQQH6Lbk036WFAuUT3qfwh8ooBIh/3hD8pJsLjitPA2eihfYKiBqu/EBKYB3
 zK0Bzq4ptZTAOqQsIGj61OlM0/WDXVGd8UxpLQUlWiPohFDmxaBZsFT
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add support for VFC_NOOP messages from VIOS to enable keep-alive
functionality between the client and server.

Define the VFC_NOOP CRQ format and add handling in both the main CRQ
handler (ibmvfc_handle_crq) and sub-CRQ handler (ibmvfc_handle_scrq).
Log unexpected NOOP messages if received before VIOS advertises support
during NPIV login.

Set the IBMVFC_CAN_USE_NOOP_CMD capability bit during NPIV login to
inform VIOS that the client can handle NOOP commands.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 1ac730c0a8a6..3aac4fd2c5c3 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1562,7 +1562,9 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
 	login_info->max_cmds = cpu_to_be32(max_cmds);
-	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+	login_info->capabilities =
+		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
+			    IBMVFC_CAN_USE_NOOP_CMD);
 
 	if (vhost->mq_enabled || vhost->using_channels) {
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
@@ -3657,6 +3659,14 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_NOOP) {
+		if (vhost->state == IBMVFC_ACTIVE &&
+		    !ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err_ratelimited(vhost->dev,
+					    "Received unexpected NOOP command from partner\n");
+		return;
+	}
+
 	/* The only kind of payload CRQs we should get are responses to
 	 * things we send. Make sure this response is to something we
 	 * actually sent
@@ -4185,9 +4195,15 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost
 	case IBMVFC_CRQ_CMD_RSP:
 		break;
 	case IBMVFC_CRQ_XPORT_EVENT:
+	case IBMVFC_NOOP:
 		return;
 	default:
-		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->valid);
+		dev_err(vhost->dev, "Got an invalid message type 0x%02x\n", crq->valid);
+		return;
+	}
+
+	if (unlikely(!evt)) {
+		dev_err(vhost->dev, "Received null event\n");
 		return;
 	}
 

-- 
2.55.0



