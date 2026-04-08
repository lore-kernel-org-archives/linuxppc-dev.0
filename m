Return-Path: <linuxppc-dev+bounces-19516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A87D10F995A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frTyx2Yc8z2yjn;
	Thu, 09 Apr 2026 03:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775668073;
	cv=none; b=eLlBDs3i9uOy6DgQ+sXBeSK6DKXJk83aq+57YG/K30XhzmnCJ+iCWDk27mNQ0fxOJK8scrEz0xJefmb5mQuffXPiMAtj5gT+JboPG3xxwoDlJbp0QrZUbsFW07bBVkSbydJE2Ft/XH1EpQkPEiXLPMeB0pSHBDUmtWlGQfBu6bTUeMDSNIx+ATtVjDgPd+R0i56usmo+jZe5Oqeq/hPvotn30mXcxjyKqoNpDoDo2Mn0Onrsxe1mJxkERl/eMX7tnBQgMlGlS/H79sUSwe/i3iaOsLzMLIx+B8uPOvFEJl5UwUjf9m6gwrTIdissp3RCuOl+kaI/SJ/bxPpnQEs07w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775668073; c=relaxed/relaxed;
	bh=w07MUTiTXNHHkVOBsl0MnjIHGs6edOD7xSxZz20i0Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtysVxUkBAtxfGuUh0cba1R+g9sByHhxft0P0PsihTKbqqJbz/VZLhdcIw4//qbmRFVFqn8pbfF2BHiVRb5NUXu5rI5Y3FZsP3vgLKOGqoJPilwHaud2G/7DPuzf8+pbtSUMoqHAKQ5yCFNlI6qccMXryv95hHbTzCHBo3KZSSC/oyMgT+0BAu4QLl5SFBIfb03mpYxR/VISV2xsmTgy1Z5vxb0m4SPtH7ls1xDF3pjvwSYeEa2GSatdbqkVzhM24KSQ5i3d338rUje5Qwv/ZuAa0GYL2dXJID+gGUuYFpKmKqDP29Qxy/AkBArTZEHjPfotYdwAUuMxTW3WBSCssA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kz5Gw/ZM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kz5Gw/ZM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frTyv6TCsz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 03:07:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 954BF443FE;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79757C2BCB0;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668069;
	bh=ImWMoB/rnm1FclghGraQ/e8MyN35n7tNJtP8/fXzR9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kz5Gw/ZMqUqOM80f932tb7gcvTZkhU9a74kBB/StL/kcET/Px5UiDXntqZIpV4814
	 PK5AN7fXmTB3EyJTHWRHf1izLabBRsXdJeX6LOqovr2LCWbqjzwlmoNQLaSzG2JY37
	 vH8XN+4BeDMeQpOtYm1CN9krkzERvmVrnsxi/h9Rotnqx64VZlYTo/Uuje9iDZxT+H
	 VUT4+gbv7VPXEiv3wqLTI1K4zX7Ol60FnpaxZBLNq0wPv7efemfEy+0HZlMxjS7Cv3
	 toG1/tnY+yefCxTS4V7t8URCfN+d8aCYdv3aqph8eHH5jDT7rB6oUEbVkPqvJ7vwsL
	 ZxF0usJT9t1xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF2810F9962;
	Wed,  8 Apr 2026 17:07:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 08 Apr 2026 12:07:44 -0500
Subject: [PATCH 3/5] ibmvfc: make ibmvfc login to fabric
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
Message-Id: <20260408-ibmvfc-fpin-support-v1-3-52b06c464e03@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775668068; l=6364;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=Cbt/rfPik4XB8M92YhjaqQXiYCRxYwBJ6PtbbYpBhuo=;
 b=PXjs5+PHKlzRHjXbLUSryG+lUh5EBrAAbuiDita0EbTjLRL/t6LJedUzoIHU9xDcXXxT1naLW
 LWJZM0Iqw8qA+RDwk8neWFD38h7cMPjLzGzXIoNZtyBn8j6A0+EavPp
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Make ibmvfc login to fabric when NPIV login returns SUPPORT_SCSI or
SUPPORT_NVMEOF capabilities.
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 100 ++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ibmvscsi/ibmvfc.h |  20 +++++++++
 2 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 808301fa452d..803fc3caa14d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5205,6 +5205,89 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
 }
 
+static void ibmvfc_fabric_login_done(struct ibmvfc_event *evt)
+{
+	struct ibmvfc_fabric_login *rsp = &evt->xfer_iu->fabric_login;
+	u32 mad_status = be16_to_cpu(rsp->common.status);
+	struct ibmvfc_host *vhost = evt->vhost;
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	ENTER;
+
+	switch (mad_status) {
+	case IBMVFC_MAD_SUCCESS:
+		vhost->logged_in = 1;
+		vhost->fabric_capabilities = rsp->capabilities;
+		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
+		ibmvfc_free_event(evt);
+		break;
+
+	case IBMVFC_MAD_FAILED:
+		if (ibmvfc_retry_cmd(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)))
+			level += ibmvfc_retry_host_init(vhost);
+		else
+			ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+		ibmvfc_log(vhost, level, "Fabric Login failed: %s (%x:%x)\n",
+			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
+						be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
+		ibmvfc_free_event(evt);
+		LEAVE;
+		return;
+
+	case IBMVFC_MAD_CRQ_ERROR:
+		ibmvfc_retry_host_init(vhost);
+		fallthrough;
+
+	case IBMVFC_MAD_DRIVER_FAILED:
+		ibmvfc_free_event(evt);
+		LEAVE;
+		return;
+
+	default:
+		dev_err(vhost->dev, "Invalid fabric Login response: 0x%x\n", mad_status);
+		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
+		ibmvfc_free_event(evt);
+		LEAVE;
+		return;
+	}
+
+	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
+	wake_up(&vhost->work_wait_q);
+
+	LEAVE;
+}
+
+static void ibmvfc_fabric_login(struct ibmvfc_host *vhost)
+{
+	struct ibmvfc_fabric_login *mad;
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
+	int level = IBMVFC_DEFAULT_LOG_LEVEL;
+
+	if (!evt) {
+		ibmvfc_log(vhost, level, "Fabric Login failed: no available events\n");
+		return;
+	}
+
+	ibmvfc_init_event(evt, ibmvfc_fabric_login_done, IBMVFC_MAD_FORMAT);
+	mad = &evt->iu.fabric_login;
+	memset(mad, 0, sizeof(*mad));
+	if (vhost->scsi_scrqs.protocol == IBMVFC_PROTO_SCSI)
+		mad->common.opcode = cpu_to_be32(IBMVFC_FABRIC_LOGIN);
+	else if (vhost->scsi_scrqs.protocol == IBMVFC_PROTO_NVME)
+		mad->common.opcode = cpu_to_be32(IBMVFC_NVMF_FABRIC_LOGIN);
+	else {
+		ibmvfc_log(vhost, level, "Fabric Login failed: unknown protocol\n");
+		return;
+	}
+	mad->common.version = cpu_to_be32(1);
+	mad->common.length = cpu_to_be16(sizeof(*mad));
+
+	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
+
+	if (ibmvfc_send_event(evt, vhost, default_timeout))
+		ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
+}
+
 static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_host *vhost = evt->vhost;
@@ -5251,8 +5334,12 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 		return;
 	}
 
-	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
-	wake_up(&vhost->work_wait_q);
+	if (ibmvfc_check_caps(vhost, (IBMVFC_SUPPORT_SCSI | IBMVFC_SUPPORT_NVMEOF))) {
+		ibmvfc_fabric_login(vhost);
+	} else {
+		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
+		wake_up(&vhost->work_wait_q);
+	}
 }
 
 static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
@@ -5443,9 +5530,12 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
 	vhost->host->can_queue = be32_to_cpu(rsp->max_cmds) - IBMVFC_NUM_INTERNAL_REQ;
 	vhost->host->max_sectors = npiv_max_sectors;
 
-	if (ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPORT_CHANNELS) && vhost->do_enquiry) {
-		ibmvfc_channel_enquiry(vhost);
-	} else {
+	if (ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPORT_CHANNELS)) {
+		if (vhost->do_enquiry)
+			ibmvfc_channel_enquiry(vhost);
+	} else if (ibmvfc_check_caps(vhost, (IBMVFC_SUPPORT_SCSI | IBMVFC_SUPPORT_NVMEOF)))
+		ibmvfc_fabric_login(vhost);
+	else {
 		vhost->do_enquiry = 0;
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
 		wake_up(&vhost->work_wait_q);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index cd0917f70c6d..4f680c5d9558 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -138,6 +138,8 @@ enum ibmvfc_mad_types {
 	IBMVFC_CHANNEL_ENQUIRY	= 0x1000,
 	IBMVFC_CHANNEL_SETUP	= 0x2000,
 	IBMVFC_CONNECTION_INFO	= 0x4000,
+	IBMVFC_FABRIC_LOGIN	= 0x8000,
+	IBMVFC_NVMF_FABRIC_LOGIN	= 0x8001,
 };
 
 struct ibmvfc_mad_common {
@@ -227,6 +229,8 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_MAD_VERSION_CAP		0x20
 #define IBMVFC_HANDLE_VF_WWPN		0x40
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
+#define IBMVFC_SUPPORT_NVMEOF		0x100
+#define IBMVFC_SUPPORT_SCSI		0x200
 #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
@@ -590,6 +594,19 @@ struct ibmvfc_connection_info {
 	__be64 reserved[16];
 } __packed __aligned(8);
 
+struct ibmvfc_fabric_login {
+	struct ibmvfc_mad_common common;
+	__be64 flags;
+#define IBMVFC_STRIP_MERGE	0x1
+#define IBMVFC_LINK_COMMANDS	0x2
+	__be64 capabilities;
+	__be64 nport_id;
+	__be16 status;
+	__be16 error;
+	__be32 pad;
+	__be64 reserved[16];
+} __packed __aligned(8);
+
 struct ibmvfc_trace_start_entry {
 	u32 xfer_len;
 } __packed;
@@ -709,6 +726,7 @@ union ibmvfc_iu {
 	struct ibmvfc_channel_enquiry channel_enquiry;
 	struct ibmvfc_channel_setup_mad channel_setup;
 	struct ibmvfc_connection_info connection_info;
+	struct ibmvfc_fabric_login fabric_login;
 } __packed __aligned(8);
 
 enum ibmvfc_target_action {
@@ -921,6 +939,8 @@ struct ibmvfc_host {
 	struct work_struct rport_add_work_q;
 	wait_queue_head_t init_wait_q;
 	wait_queue_head_t work_wait_q;
+	__be64 fabric_capabilities;
+	unsigned int login_cap_index;
 };
 
 #define DBG_CMD(CMD) do { if (ibmvfc_debug) CMD; } while (0)

-- 
2.53.0



