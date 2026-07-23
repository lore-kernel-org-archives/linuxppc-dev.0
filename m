Return-Path: <linuxppc-dev+bounces-24695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7546AC44532
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5C9K191bz2y32;
	Thu, 23 Jul 2026 10:46:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784767573;
	cv=none; b=Zc0omwn47lqrBxbfIR02lGO7IAo44IcZJCR+hvUOOKZlQiUgNj/7mJ89wX4pu9knzwxKzl9fw6/MyjVPtjCM5CQZcNsmyKSal2ui69xMOb8UScSp8kyeB9XgSBfpDn7zOgDn2+wD97xyMKmMQ88ZIcva6AuBsuNYKcEvO0SSdD3P6LXm/MTPQD7JvZAGurLJf5U5VigUo732tHTRPU1S5vTL/Eewh9az5b/xcJE6z/ojVJDJCi3hdvxL3xcCj1E0X6xipETLRVag25vFgiS1xejdzcfuB/m3Mrk2F69X8U7rqoqYvPYPjpfS1PvaKc1ox/LRG6tlc48UFBIqaCaUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784767573; c=relaxed/relaxed;
	bh=5O8MITsENqMPmEPL0vBvdhdCIo4OvkcMe0CzPrVv/K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axo6aL6iIOlYF1eMsYZw/QD4AIXSeRN6TIEUjLEWMTdOx3IG6b4rTo16TEPs/K9lSByn6ZDdjcrpiXhXD6py0ylC75tbxLLU6AJAxtrpBGSJw2C1GEvyD0TrkQoCg/+3vnu0Brq2bi3OCg5ECPD6u5EO/Fz6jkXFXyggvig+13ytNtnS7CN/XRLtH3WH/w+N2XEb83EPwSWvGsvIKUUvbMzeLiunJ5quLbfz7xSwVKNDooN369i/i/K/HOPFJkjDVLo0swxfpPXBf/vedRlsRc+Zm5lIakBH//OSjWeXJ5wyM6BRAMgbT2Y9LSGWP4mO4/S8O5Ve6VatG4GFN8rJnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CVP5F+kf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CVP5F+kf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5C9J3D37z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:46:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBeMC3019593;
	Thu, 23 Jul 2026 00:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5O8MITsENqMPmEPL0
	vBvdhdCIo4OvkcMe0CzPrVv/K4=; b=CVP5F+kfGcj6iBccLpz9d9F03JFJACKir
	76v3JYCccws4aDHykOc9RhQkJlx/9/xDZhWaSE7pEJwMzgsUYKwxF+6q3fspiCJJ
	8MG7KBxxjPutkcaLDaSaKO3A2pGzMcyW9I5WMShgjT5d1iitXdP73MYnKNuQvD2H
	S5rcmXyd8XCd5tV3WVLg2OgzHj7bzK2/1t2XrAYpzr3G+W07MdRHityNSD0MHHiM
	duy15lxo/b4twQVn7n05o07sC7fN4HK1b7ggRkZMPu05z71uv67uAYmCnIz0VdmY
	Sfmm/yIWOUizdlsftVw65qc+aq2Tr7Jf/kYdLiKeoelnAaK+F88Nw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77amx6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnxOw026539;
	Thu, 23 Jul 2026 00:02:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq9x35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N02D1J29491866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8DF158061;
	Thu, 23 Jul 2026 00:02:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E4C58056;
	Thu, 23 Jul 2026 00:02:13 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:13 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 27/33] ibmvfc: declare global function definitions
Date: Wed, 22 Jul 2026 17:01:43 -0700
Message-ID: <20260723000149.969416-28-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723000149.969416-1-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wp8bTUywUbW-Ce2SAt6wdDSdFnxraDbv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXxN7uvuNdJVCy
 4P81vm3OpF6BW35UOEDLIGua0QWAKwZxEs97+z9I/a1TbnICYsmctyU2NBPzZyB5BgXbivel426
 cwwF9Z41zZVk48Zw+1/KcMxKLszbhHs=
X-Proofpoint-GUID: Wp8bTUywUbW-Ce2SAt6wdDSdFnxraDbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfXz7pF25cmKK6O
 deOJlg6E6VGuwe8n/qj1VqTs4kLXJuZGRolHD1/oP+Or2yS/s5KnPzGf2t9NyAFk8VefPWKfwDP
 VMMnRQhiEgpaJIFD5Pb2zXqADkwNa6WJU7ILd43FhwtMqfYYDLevywl6h5V10jtQUU3jKG1nPtV
 1ykimPg0uJLmjxMsWAmirXGaQigyOctWMrb3Xnd/H8SoeSk5LyUmRFQy/jDJZBnvi7EXETJRllh
 79se7/Aoz/T3w6lCyprTR55dIapFFysKcYkRfP+fMnWNfBH8xjFbzyS4vGss7BU/ZuKEjgfJczd
 jY/hGtPQL248EaQtePT5XH20/2J9gnfmDeliJh1aqaMUxBdRQtnLv3FRsi6rk3o5/7aMYZFIe3W
 aKk+a3HleARB/k8a+70f0C4rhmXyp8sFCNP8ZxOIMm675BzoVVt7p7s6N2QL1ghAZ876XiLQJlu
 ZeDl7oH7FPsK+XH6pww==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a615a08 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AEPiXkB1DSZsRdhttTEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220234

Some common functions will require visibility by both SCSI and NVMe
protocols. Make common ibmvfc helper routines available to the NVMe
support code.

Remove static from the core event allocation, event initialization,
event free, target release, command error, and event send helpers, and
declare them in ibmvfc.h. This allows ibmvfc-nvme.c to reuse the
existing event and target infrastructure.

No functional change is intended.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 22 ++++++----------------
 drivers/scsi/ibmvscsi/ibmvfc.h      | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 6156f10871ac..206cc9508dda 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -206,13 +206,6 @@ static long h_reg_sub_crq(unsigned long unit_address, unsigned long ioba,
 	return rc;
 }
 
-static int ibmvfc_check_caps(struct ibmvfc_host *vhost, unsigned long cap_flags)
-{
-	u64 host_caps = be64_to_cpu(vhost->login_buf->resp.capabilities);
-
-	return (host_caps & cap_flags) ? 1 : 0;
-}
-
 static int ibmvfc_nvme_active(struct ibmvfc_host *vhost)
 {
 	return (ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NVMEOF) &&
@@ -354,7 +347,7 @@ static int ibmvfc_get_err_index(u16 status, u16 error)
  * Return value:
  *	error description string
  **/
-static const char *ibmvfc_get_cmd_error(u16 status, u16 error)
+const char *ibmvfc_get_cmd_error(u16 status, u16 error)
 {
 	int rc = ibmvfc_get_err_index(status, error);
 	if (rc >= 0)
@@ -1076,7 +1069,7 @@ static int ibmvfc_valid_event(struct ibmvfc_event_pool *pool,
  * @evt:	ibmvfc_event to be freed
  *
  **/
-static void ibmvfc_free_event(struct ibmvfc_event *evt)
+void ibmvfc_free_event(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_event_pool *pool = &evt->queue->evt_pool;
 	unsigned long flags;
@@ -1410,7 +1403,7 @@ static void ibmvfc_set_rport_dev_loss_tmo(struct fc_rport *rport, u32 timeout)
  * @kref:		kref struct
  *
  **/
-static void ibmvfc_release_tgt(struct kref *kref)
+void ibmvfc_release_tgt(struct kref *kref)
 {
 	struct ibmvfc_target *tgt = container_of(kref, struct ibmvfc_target, kref);
 	mempool_free(tgt, tgt->vhost->tgt_pool);
@@ -1588,7 +1581,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
  *
  * Returns a free event from the pool.
  **/
-static struct ibmvfc_event *__ibmvfc_get_event(struct ibmvfc_queue *queue, int reserved)
+struct ibmvfc_event *__ibmvfc_get_event(struct ibmvfc_queue *queue, int reserved)
 {
 	struct ibmvfc_event *evt = NULL;
 	unsigned long flags;
@@ -1612,9 +1605,6 @@ static struct ibmvfc_event *__ibmvfc_get_event(struct ibmvfc_queue *queue, int r
 	return evt;
 }
 
-#define ibmvfc_get_event(queue) __ibmvfc_get_event(queue, 0)
-#define ibmvfc_get_reserved_event(queue) __ibmvfc_get_event(queue, 1)
-
 /**
  * ibmvfc_locked_done - Calls evt completion with host_lock held
  * @evt:	ibmvfc evt to complete
@@ -1639,7 +1629,7 @@ static void ibmvfc_locked_done(struct ibmvfc_event *evt)
  * @done:	Routine to call when the event is responded to
  * @format:	SRP or MAD format
  **/
-static void ibmvfc_init_event(struct ibmvfc_event *evt,
+void ibmvfc_init_event(struct ibmvfc_event *evt,
 			      void (*done) (struct ibmvfc_event *), u8 format)
 {
 	evt->cmnd = NULL;
@@ -1764,7 +1754,7 @@ static void ibmvfc_timeout(struct timer_list *t)
  *
  * Returns the value returned from ibmvfc_send_crq(). (Zero for success)
  **/
-static int ibmvfc_send_event(struct ibmvfc_event *evt,
+int ibmvfc_send_event(struct ibmvfc_event *evt,
 			     struct ibmvfc_host *vhost, unsigned long timeout)
 {
 	__be64 *crq_as_u64 = (__be64 *) &evt->crq;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index d8c2e5f1fdec..ece1f379c269 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -1021,6 +1021,23 @@ struct ibmvfc_host {
 	struct completion nvme_delete_done;
 };
 
+struct ibmvfc_event *__ibmvfc_get_event(struct ibmvfc_queue *queue, int reserved);
+#define ibmvfc_get_event(queue) __ibmvfc_get_event(queue, 0)
+#define ibmvfc_get_reserved_event(queue) __ibmvfc_get_event(queue, 1)
+
+void ibmvfc_init_event(struct ibmvfc_event *evt, void (*done) (struct ibmvfc_event *), u8 format);
+void ibmvfc_free_event(struct ibmvfc_event *evt);
+void ibmvfc_release_tgt(struct kref *kref);
+int ibmvfc_send_event(struct ibmvfc_event *evt, struct ibmvfc_host *vhost, unsigned long timeout);
+const char *ibmvfc_get_cmd_error(u16 status, u16 error);
+
+static inline int ibmvfc_check_caps(struct ibmvfc_host *vhost, unsigned long cap_flags)
+{
+	u64 host_caps = be64_to_cpu(vhost->login_buf->resp.capabilities);
+
+	return (host_caps & cap_flags) ? 1 : 0;
+}
+
 static inline struct ibmvfc_host *ibmvfc_channels_to_vhost(struct ibmvfc_channels *channels)
 {
 	if (channels->protocol == IBMVFC_PROTO_SCSI)
-- 
2.55.0


