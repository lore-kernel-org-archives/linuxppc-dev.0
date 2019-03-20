Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B9C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:09:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97B218AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97B218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ppbh5KPJzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 12:09:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PpV95C2czDqPB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 12:04:49 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2L0wsJu118329
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:04:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbxdgw16k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:04:46 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 21 Mar 2019 01:04:44 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Mar 2019 01:04:41 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2L14gtw52625484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 01:04:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDB717805F;
 Thu, 21 Mar 2019 01:04:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 862E978060;
 Thu, 21 Mar 2019 01:04:42 +0000 (GMT)
Received: from linux-xej6.aus.stglabs.ibm.com (unknown [9.40.195.184])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2019 01:04:42 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Subject: [PATCH 3/4] ibmvfc: Byte swap status and error codes when logging
Date: Wed, 20 Mar 2019 14:56:53 -0500
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190320195654.4364-1-tyreld@linux.vnet.ibm.com>
References: <20190320195654.4364-1-tyreld@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032101-0004-0000-0000-000014F140A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177314; UDB=6.00615868; IPR=6.00958009; 
 MB=3.00026082; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 01:04:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032101-0005-0000-0000-00008AF8B937
Message-Id: <20190320195654.4364-3-tyreld@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-21_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210005
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Status and error codes are returned in big endian from the VIOS. The
values are translated into a human readable format when logged, but
the values are also logged. This patch byte swaps those values so
that they are consistent between BE and LE platforms.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 18ee2a8ec3d5..33dda4d32f65 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1497,7 +1497,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
 
 	scmd_printk(KERN_ERR, cmnd, "Command (%02X) : %s (%x:%x) "
 		    "flags: %x fcp_rsp: %x, resid=%d, scsi_status: %x\n",
-		    cmnd->cmnd[0], err, vfc_cmd->status, vfc_cmd->error,
+		    cmnd->cmnd[0], err, be16_to_cpu(vfc_cmd->status), be16_to_cpu(vfc_cmd->error),
 		    rsp->flags, rsp_code, scsi_get_resid(cmnd), rsp->scsi_status);
 }
 
@@ -2023,7 +2023,7 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 		sdev_printk(KERN_ERR, sdev, "%s reset failed: %s (%x:%x) "
 			    "flags: %x fcp_rsp: %x, scsi_status: %x\n", desc,
 			    ibmvfc_get_cmd_error(be16_to_cpu(rsp_iu.cmd.status), be16_to_cpu(rsp_iu.cmd.error)),
-			    rsp_iu.cmd.status, rsp_iu.cmd.error, fc_rsp->flags, rsp_code,
+			    be16_to_cpu(rsp_iu.cmd.status), be16_to_cpu(rsp_iu.cmd.error), fc_rsp->flags, rsp_code,
 			    fc_rsp->scsi_status);
 		rsp_rc = -EIO;
 	} else
@@ -2382,7 +2382,7 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 		sdev_printk(KERN_ERR, sdev, "Abort failed: %s (%x:%x) "
 			    "flags: %x fcp_rsp: %x, scsi_status: %x\n",
 			    ibmvfc_get_cmd_error(be16_to_cpu(rsp_iu.cmd.status), be16_to_cpu(rsp_iu.cmd.error)),
-			    rsp_iu.cmd.status, rsp_iu.cmd.error, fc_rsp->flags, rsp_code,
+			    be16_to_cpu(rsp_iu.cmd.status), be16_to_cpu(rsp_iu.cmd.error), fc_rsp->flags, rsp_code,
 			    fc_rsp->scsi_status);
 		rsp_rc = -EIO;
 	} else
@@ -3349,7 +3349,7 @@ static void ibmvfc_tgt_prli_done(struct ibmvfc_event *evt)
 
 		tgt_log(tgt, level, "Process Login failed: %s (%x:%x) rc=0x%02X\n",
 			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-			rsp->status, rsp->error, status);
+			be16_to_cpu(rsp->status), be16_to_cpu(rsp->error), status);
 		break;
 	}
 
@@ -3447,9 +3447,10 @@ static void ibmvfc_tgt_plogi_done(struct ibmvfc_event *evt)
 			ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 
 		tgt_log(tgt, level, "Port Login failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
-			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)), rsp->status, rsp->error,
-			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), rsp->fc_type,
-			ibmvfc_get_ls_explain(be16_to_cpu(rsp->fc_explain)), rsp->fc_explain, status);
+			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
+					     be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
+			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), be16_to_cpu(rsp->fc_type),
+			ibmvfc_get_ls_explain(be16_to_cpu(rsp->fc_explain)), be16_to_cpu(rsp->fc_explain), status);
 		break;
 	}
 
@@ -3620,7 +3621,7 @@ static void ibmvfc_tgt_adisc_done(struct ibmvfc_event *evt)
 		fc_explain = (be32_to_cpu(mad->fc_iu.response[1]) & 0x0000ff00) >> 8;
 		tgt_info(tgt, "ADISC failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
 			 ibmvfc_get_cmd_error(be16_to_cpu(mad->iu.status), be16_to_cpu(mad->iu.error)),
-			 mad->iu.status, mad->iu.error,
+			 be16_to_cpu(mad->iu.status), be16_to_cpu(mad->iu.error),
 			 ibmvfc_get_fc_type(fc_reason), fc_reason,
 			 ibmvfc_get_ls_explain(fc_explain), fc_explain, status);
 		break;
@@ -3832,9 +3833,10 @@ static void ibmvfc_tgt_query_target_done(struct ibmvfc_event *evt)
 
 		tgt_log(tgt, level, "Query Target failed: %s (%x:%x) %s (%x) %s (%x) rc=0x%02X\n",
 			ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-			rsp->status, rsp->error, ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)),
-			rsp->fc_type, ibmvfc_get_gs_explain(be16_to_cpu(rsp->fc_explain)),
-			rsp->fc_explain, status);
+			be16_to_cpu(rsp->status), be16_to_cpu(rsp->error),
+			ibmvfc_get_fc_type(be16_to_cpu(rsp->fc_type)), be16_to_cpu(rsp->fc_type),
+			ibmvfc_get_gs_explain(be16_to_cpu(rsp->fc_explain)), be16_to_cpu(rsp->fc_explain),
+			status);
 		break;
 	}
 
@@ -3960,7 +3962,7 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 		level += ibmvfc_retry_host_init(vhost);
 		ibmvfc_log(vhost, level, "Discover Targets failed: %s (%x:%x)\n",
 			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-			   rsp->status, rsp->error);
+			   be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
 		break;
 	case IBMVFC_MAD_DRIVER_FAILED:
 		break;
@@ -4025,7 +4027,7 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
 			ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
 		ibmvfc_log(vhost, level, "NPIV Login failed: %s (%x:%x)\n",
 			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
-						rsp->status, rsp->error);
+						be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
 		ibmvfc_free_event(evt);
 		return;
 	case IBMVFC_MAD_CRQ_ERROR:
-- 
2.12.3

