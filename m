Return-Path: <SRS0=DuU+=4I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716BFC11D04
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 10:13:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293FA20801
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 10:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293FA20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NVmG533HzDqj1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 21:13:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NVRN5dHpzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 20:58:56 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01K9npNg090000
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 04:58:53 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y93kfu2kh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 04:58:52 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Thu, 20 Feb 2020 09:58:51 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 09:58:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01K9vp8f41287938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 09:57:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 117C6A4040;
 Thu, 20 Feb 2020 09:58:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98361A4051;
 Thu, 20 Feb 2020 09:58:44 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 09:58:44 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/papr_scm: Implement support for
 DSM_PAPR_SCM_HEALTH
Date: Thu, 20 Feb 2020 15:28:05 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220095805.197229-1-vaibhav@linux.ibm.com>
References: <20200220095805.197229-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022009-0012-0000-0000-000003888D56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022009-0013-0000-0000-000021C5238F
Message-Id: <20200220095805.197229-9-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_02:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 mlxlogscore=955 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200072
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
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Michael Ellerman <ellerman@au1.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The DSM 'DSM_PAPR_SCM_HEALTH' should return a 'struct
nd_papr_scm_dimm_health_stat' containing information in dimm health back
to user space in response to ND_CMD_CALL. We implement this DSM by
implementing a new function papr_scm_get_health() that queries the
DIMM health information and then copies these bitmaps to the package
payload whose layout is defined by 'struct papr_scm_ndctl_health'.

The patch also handle cases where in future versions of 'struct
papr_scm_ndctl_health' may want to return more health
information. Such payload envelops will contain appropriate version
information in 'struct nd_papr_scm_cmd_pkg.payload_version'. The patch
takes care of only returning the sub-data corresponding to the payload
version requested. Please see the comments in papr_scm_get_health()
for how this is done.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 29f38246c59f..bf81acb0bf3f 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -415,6 +415,74 @@ static int cmd_to_func(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 	return pkg->hdr.nd_command;
 }
 
+/*
+ * Fetch the DIMM health info and populate it in provided papr_scm package.
+ * Since the caller can request a different version of payload and each new
+ * version of struct nd_papr_scm_dimm_health_stat is a proper-subset of
+ * previous version hence we return a subset of the cached 'struct
+ * nd_papr_scm_dimm_health_stat' depending on the payload version requested.
+ */
+static int papr_scm_get_health(struct papr_scm_priv *p,
+			       struct nd_papr_scm_cmd_pkg *pkg)
+{
+	int rc;
+	size_t copysize;
+	/* Map version to number of bytes to be copied to payload */
+	const size_t copysizes[] = {
+		[1] =
+		sizeof(struct nd_papr_scm_dimm_health_stat_v1),
+
+		/*  This should always be preset */
+		[ND_PAPR_SCM_DIMM_HEALTH_VERSION] =
+		sizeof(struct nd_papr_scm_dimm_health_stat),
+	};
+
+	rc = drc_pmem_query_health(p);
+	if (rc)
+		goto out;
+	/*
+	 * If the requested payload version is greater than one we know
+	 * aboute, return the payload version we know about and let
+	 * caller/userspace handle the mess.
+	 */
+	if (pkg->payload_version > ND_PAPR_SCM_DIMM_HEALTH_VERSION)
+		pkg->payload_version = ND_PAPR_SCM_DIMM_HEALTH_VERSION;
+
+	copysize = copysizes[pkg->payload_version];
+	if (!copysize) {
+		dev_dbg(&p->pdev->dev, "%s Unsupported payload version=0x%x\n",
+			__func__, pkg->payload_version);
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	if (pkg->hdr.nd_size_out < copysize) {
+		dev_dbg(&p->pdev->dev, "%s Payload not large enough\n",
+			__func__);
+		dev_dbg(&p->pdev->dev, "%s Expected %lu, available %u\n",
+			__func__, copysize, pkg->hdr.nd_size_out);
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	dev_dbg(&p->pdev->dev, "%s Copying payload size=%lu version=0x%x\n",
+		__func__, copysize, pkg->payload_version);
+
+	/* Copy a subset of health struct based on copysize */
+	memcpy(papr_scm_pcmd_to_payload(pkg), &p->health, copysize);
+	pkg->hdr.nd_fw_size = copysize;
+
+out:
+	/*
+	 * Put the error in out package and return success from function
+	 * so that errors if any are propogated back to userspace.
+	 */
+	pkg->cmd_status = rc;
+	dev_dbg(&p->pdev->dev, "%s completion code = %d\n", __func__, rc);
+
+	return 0;
+}
+
 int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
@@ -460,6 +528,11 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		*cmd_rc = 0;
 		break;
 
+	case DSM_PAPR_SCM_HEALTH:
+		call_pkg = nd_to_papr_cmd_pkg(buf);
+		*cmd_rc = papr_scm_get_health(p, call_pkg);
+		break;
+
 	default:
 		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd_in);
 		*cmd_rc = -EINVAL;
-- 
2.24.1

