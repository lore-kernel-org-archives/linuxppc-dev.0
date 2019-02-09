Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF62C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:16:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F292084D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F292084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xgH41wYFzDqV7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:16:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xgDt04JhzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xgDs4Bq4z8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xgDs3VHYz9sNJ; Sun, 10 Feb 2019 05:14:37 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=pc@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43xgDr5x1yz9sML
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 05:14:36 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x19IE4aU077909
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Feb 2019 13:14:34 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qhsfcyw0j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2019 13:14:34 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Sat, 9 Feb 2019 18:14:33 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 9 Feb 2019 18:14:31 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x19IEUHA19529934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Feb 2019 18:14:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 520B07805E;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33B3D7805C;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
From: Paul Clarke <pc@us.ibm.com>
To: linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics for
 POWER9
Date: Sat,  9 Feb 2019 13:14:25 -0500
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020918-8235-0000-0000-00000E59136A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158660; UDB=6.00604582; IPR=6.00939195; 
 MB=3.00025508; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-09 18:14:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020918-8236-0000-0000-000044677F9C
Message-Id: <20190209181429.23950-1-pc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-09_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902090132
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
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.ibm.com, cel@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[Note this is for POWER*9* and is different content than a
previous patchset for POWER*8*.]

The patches define metrics and metric groups for computation by "perf"
for POWER9 processors.

Paul Clarke (4):
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9

v2:
The content of these patches was sent previously, to LKML and
linux-perf-users, but never showed up at linux-perf-users, so
I split it into smaller patches and am resending.

 .../arch/powerpc/power9/metrics.json          | 1982 +++++++++++++++++
 1 file changed, 1982 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

-- 
2.17.1

