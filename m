Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC0C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 18:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72242089A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 18:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72242089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PBPc4GgvzF3CF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 04:58:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PBMX0J2pzDrTf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 04:56:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91ItC57116509
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 14:56:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2murknsppb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 14:56:20 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 1 Oct 2018 14:56:20 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 14:56:17 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91IuHBQ46989484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 18:56:17 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05A1628059;
 Mon,  1 Oct 2018 14:53:57 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBAC728058;
 Mon,  1 Oct 2018 14:53:56 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 14:53:56 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 6FB702007B8D;
 Mon,  1 Oct 2018 13:56:16 -0500 (CDT)
Subject: [PATCH] powerpc/mobility: Extend start/stop topology update scope
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Mon, 01 Oct 2018 13:56:16 -0500
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100118-0040-0000-0000-000004796617
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009804; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096428; UDB=6.00566942; IPR=6.00876470; 
 MB=3.00023577; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 18:56:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100118-0041-0000-0000-000008816FFC
Message-Id: <20181001185603.11373.61650.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010180
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The PPC mobility code may receive RTAS requests to perform PRRN
topology changes at any time, including during LPAR migration
operations.  In some configurations where the affinity of CPUs
or memory is being changed on that platform, the PRRN requests
may apply or refer to outdated information prior to the complete
update of the device-tree.  This patch changes the duration for
which topology updates are suppressed during LPAR migrations from
just the rtas_ibm_suspend_me / 'ibm,suspend-me' call(s) to cover
the entire 'migration_store' operation to allow all changes to
the device-tree to be applied prior to accepting and applying any
PRRN requests.

For tracking purposes, pr_info notices are added to the functions
start_topology_update() and stop_topology_update() of 'numa.c'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c                |    4 ----
 arch/powerpc/mm/numa.c                    |    6 ++++++
 arch/powerpc/platforms/pseries/mobility.c |    5 +++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8afd146..28d8b57 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -981,8 +981,6 @@ int rtas_ibm_suspend_me(u64 handle)
 		goto out;
 	}
 
-	stop_topology_update();
-
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
@@ -994,8 +992,6 @@ int rtas_ibm_suspend_me(u64 handle)
 	if (atomic_read(&data.error) != 0)
 		printk(KERN_ERR "Error doing global join\n");
 
-	start_topology_update();
-
 	/* Take down CPUs not online prior to suspend */
 	cpuret = rtas_offline_cpus_mask(offline_mask);
 	if (cpuret)
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b5a71ba..0ade0a1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1518,6 +1518,10 @@ int start_topology_update(void)
 		}
 	}
 
+	pr_info("Starting topology update%s%s\n",
+		(prrn_enabled ? " prrn_enabled" : ""),
+		(vphn_enabled ? " vphn_enabled" : ""));
+
 	return rc;
 }
 
@@ -1539,6 +1543,8 @@ int stop_topology_update(void)
 		rc = del_timer_sync(&topology_timer);
 	}
 
+	pr_info("Stopping topology update\n");
+
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 23fb9ac..49ebefd 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -373,6 +373,8 @@ static ssize_t migration_store(struct class *class,
 	if (rc)
 		return rc;
 
+	stop_topology_update();
+
 	do {
 		rc = rtas_ibm_suspend_me(streamid);
 		if (rc == -EAGAIN)
@@ -383,6 +385,9 @@ static ssize_t migration_store(struct class *class,
 		return rc;
 
 	post_mobility_fixup();
+
+	start_topology_update();
+
 	return count;
 }
 

