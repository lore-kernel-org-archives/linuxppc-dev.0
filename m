Return-Path: <SRS0=kzwA=44=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75BC10F27
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 09:44:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973532146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 09:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973532146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48cnB12s8rzDqdw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 20:44:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ego@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48cn222g6hzDq8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2020 20:38:02 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02B9Wscw099100; Wed, 11 Mar 2020 05:37:56 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ypvjtun99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2020 05:37:56 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02B9Z7IL010910;
 Wed, 11 Mar 2020 09:37:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04wdc.us.ibm.com with ESMTP id 2ypjxr3sk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2020 09:37:55 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02B9bsFN39846296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 09:37:54 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 580C86E054;
 Wed, 11 Mar 2020 09:37:54 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 000ED6E053;
 Wed, 11 Mar 2020 09:37:53 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.122.202])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2020 09:37:53 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 6573E2E340C; Wed, 11 Mar 2020 15:07:47 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nathan Lynch <nathanl@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v3 5/6] Documentation: Document sysfs interfaces purr, spurr,
 idle_purr, idle_spurr
Date: Wed, 11 Mar 2020 15:07:40 +0530
Message-Id: <1583919461-27405-6-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583919461-27405-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1583919461-27405-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-11_02:2020-03-10,
 2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110061
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Add documentation for the following sysfs interfaces:
/sys/devices/system/cpu/cpuX/purr
/sys/devices/system/cpu/cpuX/spurr
/sys/devices/system/cpu/cpuX/idle_purr
/sys/devices/system/cpu/cpuX/idle_spurr

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2e0e3b4..bc07677 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -580,3 +580,42 @@ Description:	Secure Virtual Machine
 		If 1, it means the system is using the Protected Execution
 		Facility in POWER9 and newer processors. i.e., it is a Secure
 		Virtual Machine.
+
+What: 		/sys/devices/system/cpu/cpuX/purr
+Date:		Apr 2005
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	PURR ticks for this CPU since the system boot.
+
+		The Processor Utilization Resources Register (PURR) is
+		a 64-bit counter which provides an estimate of the
+		resources used by the CPU thread. The contents of this
+		register increases monotonically. This sysfs interface
+		exposes the number of PURR ticks for cpuX.
+
+What: 		/sys/devices/system/cpu/cpuX/spurr
+Date:		Dec 2006
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	SPURR ticks for this CPU since the system boot.
+
+		The Scaled Processor Utilization Resources Register
+		(SPURR) is a 64-bit counter that provides a frequency
+		invariant estimate of the resources used by the CPU
+		thread. The contents of this register increases
+		monotonically. This sysfs interface exposes the number
+		of SPURR ticks for cpuX.
+
+What: 		/sys/devices/system/cpu/cpuX/idle_purr
+Date:		Mar 2020
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	PURR ticks for cpuX when it was idle.
+
+		This sysfs interface exposes the number of PURR ticks
+		for cpuX when it was idle.
+
+What: 		/sys/devices/system/cpu/cpuX/idle_spurr
+Date:		Mar 2020
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	SPURR ticks for cpuX when it was idle.
+
+		This sysfs interface exposes the number of SPURR ticks
+		for cpuX when it was idle.
-- 
1.9.4

