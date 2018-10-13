Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCEAC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 22:06:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F64A2077C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 22:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F64A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Xf1m4zG9zF3Sg
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 09:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XdzZ2pBzzF3F1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 09:04:58 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9DM3vlv004277
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 18:04:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n3k6dgr6k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 18:04:55 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sat, 13 Oct 2018 16:04:55 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 13 Oct 2018 16:04:53 -0600
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9DM4qIi63504544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 13 Oct 2018 15:04:52 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B25A6A047;
 Sat, 13 Oct 2018 16:04:52 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F15056A04F;
 Sat, 13 Oct 2018 16:04:51 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Oct 2018 16:04:51 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 39FB720FBAB7;
 Sat, 13 Oct 2018 17:04:51 -0500 (CDT)
Subject: [PATCH] hotplug/cpu: Extend start/stop cpumap lock scope
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Sat, 13 Oct 2018 17:04:51 -0500
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101322-0016-0000-0000-00000941EC81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102243; UDB=6.00570436; IPR=6.00882288; 
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 22:04:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101322-0017-0000-0000-000040B204DB
Message-Id: <20181013220403.6835.72398.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-13_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130207
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

The PPC mobility code may receive DLPAR CPU add/remove requests
to perform CPU changes at any time, including during LPAR migration
or RTAS requests or SMT changes.  When the operations are received
concurrently, there is an opportunity for DLPAR CPU remove requests
and other requests to overlap, and for one of the requests to be
interrupted after some shared state has been modified.  This patch
changes the duration for which cpu maps updates are suppressed
during DLPAR CPU operations made by 'drmgr' are suppressed to
reduce the period in which changes to shared state may occur.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 2f8e621..fce46c56 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -356,7 +356,6 @@ static int dlpar_online_cpu(struct device_node *dn)
 
 	nthreads = len / sizeof(u32);
 
-	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
@@ -378,7 +377,6 @@ static int dlpar_online_cpu(struct device_node *dn)
 			printk(KERN_WARNING "Could not find cpu to online "
 			       "with physical id 0x%x\n", thread);
 	}
-	cpu_maps_update_done();
 
 out:
 	return rc;
@@ -523,7 +521,6 @@ static int dlpar_offline_cpu(struct device_node *dn)
 
 	nthreads = len / sizeof(u32);
 
-	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
@@ -559,7 +556,6 @@ static int dlpar_offline_cpu(struct device_node *dn)
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to offline with physical id 0x%x\n", thread);
 	}
-	cpu_maps_update_done();
 
 out:
 	return rc;
@@ -811,6 +807,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 	drc_index = hp_elog->_drc_u.drc_index;
 
 	lock_device_hotplug();
+	cpu_maps_update_begin();
 
 	switch (hp_elog->action) {
 	case PSERIES_HP_ELOG_ACTION_REMOVE:
@@ -835,6 +832,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		break;
 	}
 
+	cpu_maps_update_done();
 	unlock_device_hotplug();
 	return rc;
 }
@@ -850,7 +848,9 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (rc)
 		return -EINVAL;
 
+	cpu_maps_update_begin();
 	rc = dlpar_cpu_add(drc_index);
+	cpu_maps_update_done();
 
 	return rc ? rc : count;
 }
@@ -871,7 +871,9 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
+	cpu_maps_update_begin();
 	rc = dlpar_cpu_remove(dn, drc_index);
+	cpu_maps_update_done();
 	of_node_put(dn);
 
 	return rc ? rc : count;

