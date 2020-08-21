Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9BBC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 08:08:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E672078D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 08:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k+vhBnsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E672078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXvK64TmczDqbG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 18:08:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=k+vhBnsu; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXvHM12bJzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 18:06:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07L82ntc038124; Fri, 21 Aug 2020 04:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r3EjfRYxrjpEOzggI2FCd59ZKKGvDErSVmG+fBCdwyo=;
 b=k+vhBnsu6D2xJfKTS4rU2SzAVNOu3+fcIKl8bYyfi5TPTWjlE7us7JVZGNevrPgUBt7C
 tohMVUT0uldmGmKOFU4inai3piyJZ4Y1sslI75pDr/qTADe+j+rp2x3Za51Lx2eqDIiL
 V0lbSYV8Z4zzapyAu03uKrhHN3MolOiV3NsUSQspP54TfMKFiwA8yhOCfAbOpowfc5aA
 HRSchUvgAIgLP8wOckmDstMLETGzdKWPIPKofbGwWmCQ9YrhQLlTzdF9OuXQfXwK8WI4
 TfuPIwitJa+vn1ChvI/9f3BPCFVow1l8kc3w/bE07QV3szqjbwj7l0Y0idnlHdV3ayiA MQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3327xtv6f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 04:06:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L86AKY027364;
 Fri, 21 Aug 2020 08:06:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 3304um435j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 08:06:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07L86NtN10617154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2020 08:06:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CCD8AE045;
 Fri, 21 Aug 2020 08:06:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58831AE04D;
 Fri, 21 Aug 2020 08:06:21 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.47.231])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2020 08:06:21 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf/hv-24x7: Move cpumask file to top folder of
 hv-24x7 driver
Date: Fri, 21 Aug 2020 13:36:10 +0530
Message-Id: <20200821080610.123997-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-21_05:2020-08-19,
 2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210070
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
Cc: kjain@linux.ibm.com, suka@us.ibm.com, maddy@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 792f73f747b8 ("powerpc/hv-24x7: Add sysfs files inside hv-24x7
device to show cpumask") added cpumask file as part of hv-24x7 driver
inside the interface folder. Cpumask file suppose to be in the top
folder of the pmu driver inorder to make hotplug works.

This patch fix that issue and create new group 'cpumask_attr_group'
to add cpumask file and make sure it added on top folder.

command:# cat /sys/devices/hv_24x7/cpumask
0

Fixes: 792f73f747b8 ("powerpc/hv-24x7: Add sysfs files inside hv-24x7
device to show cpumask")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-hv_24x7    |  2 +-
 arch/powerpc/perf/hv-24x7.c                           | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
index f7e32f218f73..e82fc37be802 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -43,7 +43,7 @@ Description:	read only
 		This sysfs interface exposes the number of cores per chip
 		present in the system.
 
-What:		/sys/devices/hv_24x7/interface/cpumask
+What:		/sys/devices/hv_24x7/cpumask
 Date:		July 2020
 Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:	read only
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index cdb7bfbd157e..6e7e820508df 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1128,6 +1128,15 @@ static struct bin_attribute *if_bin_attrs[] = {
 	NULL,
 };
 
+static struct attribute *cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group cpumask_attr_group = {
+	.attrs = cpumask_attrs,
+};
+
 static struct attribute *if_attrs[] = {
 	&dev_attr_catalog_len.attr,
 	&dev_attr_catalog_version.attr,
@@ -1135,7 +1144,6 @@ static struct attribute *if_attrs[] = {
 	&dev_attr_sockets.attr,
 	&dev_attr_chipspersocket.attr,
 	&dev_attr_coresperchip.attr,
-	&dev_attr_cpumask.attr,
 	NULL,
 };
 
@@ -1151,6 +1159,7 @@ static const struct attribute_group *attr_groups[] = {
 	&event_desc_group,
 	&event_long_desc_group,
 	&if_group,
+	&cpumask_attr_group,
 	NULL,
 };
 
-- 
2.18.2

