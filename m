Return-Path: <linuxppc-dev+bounces-27798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED31C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:32:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hp81Z4zpFz303F;
	Mon, 21 Sep 2026 13:32:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789961554;
	cv=none; b=I55EW0nnWUeIEuCm+Cxv2fzWNMEiealgkD8uaaC/ORfBJFf8NK5HUuqJcU6xoLqoB1t77AS7Lw6Efbgu9uC4Tz+esZ6LYeh2zm5xk37xHOL7msEpEBzE7EfQzovkW6nCfpl4CCErc+v7NywbwH8FqM8eznJ456acSTYCGXg2Ag7mcjKpYk+0gUcWZ5EQGdwA6qNOCplAvxxNEeMe/BH9K5ZUxBajPDhjWbz1Sq/urEDLFJqoKedFbxpEK0kY8giAmwTdndzbf4IGBTYQK9qU3IiXQjib0sDDE/G1CEwLUZyrwW/sxjXjFd6ObRZtGrYarQAcn9ZwYJ5hQNWSm6zTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789961554; c=relaxed/relaxed;
	bh=UD4No+EruQul7ET9JW/N7gMYIgjwFx+Ie00+K2rqG6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m53ZhHiZpmLdyEuDk/IYmQbmYHMc9wwevubcxNC1vsHLQslzpOEPjvq3EvcZlH90zDFO1jmejGG6PHVn3L2b4KyGZ5ju2Di94LigAld1B0XqyGNSX9ZEs1ZZaeoFrunIQK/c4Q4vGxWnRpHHkeJF4Wes/F+979k+EKWkMaXWPEG83hjZTAHT2slwXekwPrOiUDQ2EFc6cV9wfFnveUGm4xEAqYKcox8CG6fHkX3C2XqlbPZ3Lr1pJbMMOAsMDyoqOyD/oKehkGnMj0Cc6hSRcpyAjKq3w8ADV3IPZe1DSqmg7BLEx44AQ4rHG/LSC7Z2usKxxGmj0+tgOlLBEwjZ3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CxZlxW1t; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CxZlxW1t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hp81Y65ySz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 13:32:33 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L15SUD4167854;
	Mon, 21 Sep 2026 03:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UD4No+EruQul7ET9J
	W/N7gMYIgjwFx+Ie00+K2rqG6Y=; b=CxZlxW1t+CU4IpWMt73fRrwnaSF8ShIjV
	B1RWNLfR0XllTx8dySpnCEQ4i1DfvWRBlGndUYX/Hw+98LMOVW/quEooyZCyiK0s
	JjZMI9k7iPUML2+SY94ibaRSirQC8c6PHtnyyWQXjWcJMAMDIXRjtsA/mIRHybev
	nrSqFPjyqqlzBv9vZiMJD37NxsSIuwqkcdjXjeQ2WTUNGysLwFYwLnVDqXxl1slj
	NA2BqpRb1oYs9/DQT8eLT2OUCjLvNTDmoh7CZk4dvq0MI5RTCTyYiqqWHVFMI1pE
	WbEfwHSbKdeNYbGy0CSd76s8CSGhKjsGU7mAUsLGefPAKdm78idbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduxewe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:32:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L0lUkI429134;
	Mon, 21 Sep 2026 03:32:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjkknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:32:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L3W3lY27787888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 03:32:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92DE58051;
	Mon, 21 Sep 2026 03:32:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C98A5805C;
	Mon, 21 Sep 2026 03:32:03 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com (unknown [9.61.133.32])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 03:32:03 +0000 (GMT)
From: Haren Myneni <haren@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, maddy@linux.ibm.com, robh@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, saravanak@kernel.org,
        ritesh.list@gmail.com, tyreld@linux.ibm.com, hbabu@us.ibm.com,
        haren@linux.ibm.com
Subject: [PATCH v2 2/2] powerpc/pseries/dlpar: Remove DT entries if failure from CPU ADD notifier
Date: Sun, 20 Sep 2026 20:31:56 -0700
Message-ID: <20260921033156.991481-2-haren@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921033156.991481-1-haren@linux.ibm.com>
References: <20260921033156.991481-1-haren@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _Ia5yKu_41bbxrv7eiznnOiRQYuKUMzi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA0MSBTYWx0ZWRfX6jeDLp8mUQV3
 vcvnK2YVK7UIkPr7RVcOXYjqaXNAj8wCN72boklBFpsWwAWK8m7XO6wwTtQY+7b8tqdZUpB3bns
 qsKFsDAsp2NeatGsSEpIUbwfHIiONUQ=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0a535 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=r6zhGCe8PwBrag2BmykA:9
X-Proofpoint-GUID: 00WUA8JME8QoOiSJ7B2gJ2LG2haWd5w8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA0MSBTYWx0ZWRfX7BkEXY6cCGs8
 V/H8jDZbLr3UtSfN1+0MPvTJ+1WrhbpQBNbNTgh6wwEMHP4aye/htRe9/tRktHeXxXJOzyFVYmz
 PEQzK1Dg9OCK/8xAOKf8+270ZTNjmOT5WgMhkQXBDH1bnHvu/bdJ15hY0jQJGgJk1wB9uQNawfY
 p1Ry5AthiMSyA+j7+wfYt15ukEUqqRkEpUts+fyclL62EY3cWKX7wQD9jX6Vf+VXyHDdoUoxR6v
 ZyRMZTyn/tHStQoN90JpueS2SDxT1aWaspJAa9fe5joW2mmM0FNCB9iF6yYW01a6tq/tJqUvh1W
 5RREXwY2O3CE0IL8dZz+ACCxRNYknYFMPkRVh9HVISqQZMokkfhAr/d0oj0oBtxe4RjmQJJC8kT
 EHGLOWYHEe7iqo8iSW2v2KyJFUtHMgLE7k1ntsN2maMXwn2+bUc916Mtf69Mcy4n52/ZKUNS1FJ
 CGZ0NavyG6XIoFZzLRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210041

For CPU ADD, the device tree entries are retrieved with
configure-connector RTAS call and attached to the device tree.
Then the CPU is added as part of DT node notification. If the CPU
ADD notifier returns failure, the corresponding CPU node entries
should be deleted from the device-tree. See pseries_add_processor()
for the possible failure cases.

The current code does not remove CPU node entries during CPU ADD
notifier failure and causing the following issues:
- Can not add this CPU later since already present in the
  device-tree.
- Trying to free memory allocated to CPU node without detaching
  the node and it causes freeing its sibling node (existing CPU
  nodes).

This patch fixes this issue by calling of_detach_node_no_notify()
for the failure from CPU ADD notifier which removes CPU node
entries without calling CPU REMOVE notifier.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
v2:
- Check dn before detach node as pointed by Sashiko AI review.

 arch/powerpc/platforms/pseries/dlpar.c       | 9 ++++++---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 6 +++---
 arch/powerpc/platforms/pseries/mobility.c    | 2 +-
 arch/powerpc/platforms/pseries/pmem.c        | 2 +-
 arch/powerpc/platforms/pseries/pseries.h     | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index f4d33b8dffd8..01a9849773cd 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -247,15 +247,18 @@ int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 	return 0;
 }
 
-int dlpar_detach_node(struct device_node *dn)
+int dlpar_detach_node(struct device_node *dn, bool notify)
 {
 	struct device_node *child;
 	int rc;
 
 	for_each_child_of_node(dn, child)
-		dlpar_detach_node(child);
+		dlpar_detach_node(child, notify);
 
-	rc = of_detach_node(dn);
+	if (notify)
+		rc = of_detach_node(dn);
+	else
+		rc = of_detach_node_no_notify(dn);
 	if (rc)
 		return rc;
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bc6926dbf148..15122aab05b2 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -602,8 +602,8 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 			dn, rc, drc_index);
 
 		rc = dlpar_release_drc(drc_index);
-		if (!rc)
-			dlpar_free_cc_nodes(dn);
+		if (!rc && dn)
+			dlpar_detach_node(dn, false);
 
 		return saved_rc;
 	}
@@ -616,7 +616,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		pr_warn("Failed to online cpu %pOFn, rc: %d, drc index: %x\n",
 			dn, rc, drc_index);
 
-		rc = dlpar_detach_node(dn);
+		rc = dlpar_detach_node(dn, true);
 		if (!rc)
 			dlpar_release_drc(drc_index);
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index b5c2abd12432..e0e4ef04c679 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -112,7 +112,7 @@ static int delete_dt_node(struct device_node *dn)
 	}
 
 	pr_debug("removing node %pOFfp\n", dn);
-	dlpar_detach_node(dn);
+	dlpar_detach_node(dn, true);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 0f1d45f32e4a..b60a01745137 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -85,7 +85,7 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
 	pr_debug("Attempting to remove %pOF, drc index: %x\n", dn, drc_index);
 
 	/* * NB: tears down the ibm,pmemory device as a side-effect */
-	rc = dlpar_detach_node(dn);
+	rc = dlpar_detach_node(dn, true);
 	if (rc)
 		return rc;
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 3968a6970fa8..6f80e58e6186 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -50,7 +50,7 @@ extern void dlpar_free_cc_property(struct property *);
 extern struct device_node *dlpar_configure_connector(__be32,
 						struct device_node *);
 extern int dlpar_attach_node(struct device_node *, struct device_node *);
-extern int dlpar_detach_node(struct device_node *);
+extern int dlpar_detach_node(struct device_node *, bool);
 extern int dlpar_acquire_drc(u32 drc_index);
 extern int dlpar_release_drc(u32 drc_index);
 extern int dlpar_unisolate_drc(u32 drc_index);
-- 
2.55.0


