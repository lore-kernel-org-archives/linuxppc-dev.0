Return-Path: <linuxppc-dev+bounces-22102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B1CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWrGb64ylz2yNn;
	Fri, 05 Jun 2026 15:53:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780638839;
	cv=none; b=f3iebFDEcQKH+ZkRDASAp+UafmnSolPLGT4QHot32C5WjcPHaVMcH3MjbCWaFD5tfmNTbwhj6tOxxJhE8BLQKAv3V8+tDnoTfJR7+Gk5G63RNqUdmnTebLnrca0iSZLGVs/MJqBnAOhMt5RL2tEBNkyIwKZeComR1yHx+e+L+MmmFvHFpSpkjyqSwd/IvE9G9iw4BXgcqQxe34Ml5hbLP9nd8u8L62LAQsCUjQXZfDS5jnAQoSB2xuiZYO9OSXGc5NE2vTKih2lIAeZgDjuVtIwRKUlE3piVkgbQvSK390WpyRFFZjWQztQmK1F4nLlfqq+OAS3KyL2fh7FPdb5MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780638839; c=relaxed/relaxed;
	bh=BBV2NtrVSmJIG51CXXdZUvROxvOMLPswqlwCBWbxH8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbAr5e5yeciJr/RPk1i07ENs6g9xI4/4sjWiDo7rE4qKGDVOfxykNnrFoMfIeQttTzZLrdFREr6stlnzWheNiMpTQ2mfXKqVfcT9QZmk9hlK3CBPVzOnDwrI5l29zshzxoud+QZF214EO9DLMAAfZxa0KypbYJM8aLgkfb1zDzeQIcLDYnNMQ+G3pBDijHLpiL4UhwS9ZM1HNC+/J9+38CWPCULy1xVekSS8GlHV4QSkyy9Og7ofvWiX6cC2tjjZbJVu0AshZ3McCPDqOckNraHpz0EOhvWFLAuYqoqre8GJA2P+O6CG4Mz0SauUvR2ZzMyKt9pR+41zTFbYD8wabg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lLoNNJyG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lLoNNJyG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrGb006Sz3c3v;
	Fri, 05 Jun 2026 15:53:58 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Krstj2666058;
	Fri, 5 Jun 2026 05:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BBV2NtrVSmJIG51CX
	XdZUvROxvOMLPswqlwCBWbxH8I=; b=lLoNNJyGycqrzEXqKH/NB4qxlJBjj3LwB
	VPOLzBdDimOYFlUBUjs6R2s18F+uE48ux0JKx+Jco7MFgyScdvgFWBet/nu1PfdY
	tgnkBa5QwhpCjYia2zN0S1o+rDZNt3dIqSalkrwawzTTv8/ZPUcux/dVTTwE2O0i
	hQ3oXyjgL2qnD28yCbokvneNj0XbhYXVQuXEwYfE5sAe+igN665pDuY2IQatPRl3
	GZ4KX4yMzmhhDd5lSN6yv3zAhIHH8va1lMGaErsCFAqkdWaLsX8mttZfVnJHnkoo
	I3lgu39rBTFU8UTR9cvYqM19p3x6FRYB+87HeIgZF/jOrk98Jl7Xg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtjc5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6555dKjE017268;
	Fri, 5 Jun 2026 05:53:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh04fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6555rgHw30409102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 05:53:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 718132004B;
	Fri,  5 Jun 2026 05:53:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA9C20040;
	Fri,  5 Jun 2026 05:53:39 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.90.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 05:53:39 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        chleroy@kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
Date: Fri,  5 Jun 2026 11:22:45 +0530
Message-ID: <20260605055242.1757485-7-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605055242.1757485-5-srikar@linux.ibm.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com>
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
X-Proofpoint-GUID: NBfCI9doDRElpU2QTN54b_z3e2kdR5ya
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a22646b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7dv0z3e6AKYFnwaEaUMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1MSBTYWx0ZWRfX5mHqZ+CilHlQ
 J5Hn0qBzZqTB9hEiwIpcZYHrhmxBk6P/4Hie6nUUTgye1Zqt7eAecQ6QcRnEM0Kp7mVL0ONF87l
 1F21Sxl/WzXge9oCS3pWY142Z2Pv2ngWTQ/OemayglbMdcY4RQl2wur0giT1esiHyAHqqCKSPm+
 gn8qyHW4ben4TcblISUBdjUmms5/s8NSZYZVM7XEQK6sP6RjWaCJwIN8vrr0ytCcxzygdPuj0Qn
 UOMpmAE+Px1llhgHYJqtJ0G43I/HG2jADeTqF+xsHEREqosKJz2CepU03h3sQSww8lLTPDdL3FR
 A81cxStY9ZomzygpyZsv4qzwSFp0PBPPKWzq1Xi5Nm8Hr1WA5Cl9yLIA32CVH9fDG7IsySNR694
 0QVsn+nnGVNRG05QXALaNJo9cxECRtR7SNTRAW2Su+vVLkq4SFfqWJOF3Ok8iHFEEkT38OXHhR1
 VwyGdvSmSo/1sEMZHlw==
X-Proofpoint-ORIG-GUID: mw09OxhhgdyXAgOUoLbGUcqrHSmznLln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050051

Make cpu_to_coregroup_id() available outside PPC_SPLPAR so it can be
used by platforms that do not rely on the SPLPAR-specific VPHN path.

Keep the existing fallback behavior by returning the core ID when
coregroup information is unavailable.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog from v1:
- Handle comments from Christophe Leroy; Remove extern key word in
  declaration

 arch/powerpc/include/asm/topology.h | 15 +++++++--------
 arch/powerpc/mm/numa.c              | 22 ++++++++++++++++------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..385715f1ad56 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
 extern void unmap_cpu_from_node(unsigned long cpu);
 #endif /* CONFIG_HOTPLUG_CPU */
 
+int cpu_to_coregroup_id(int cpu);
 #else
 
 static inline int early_cpu_to_node(int cpu) { return 0; }
@@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
 static inline void unmap_cpu_from_node(unsigned long cpu) {}
 #endif /* CONFIG_HOTPLUG_CPU */
 #endif /* CONFIG_SMP */
-
-#endif /* CONFIG_NUMA */
-
-#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
-void find_and_update_cpu_nid(int cpu);
-extern int cpu_to_coregroup_id(int cpu);
-#else
-static inline void find_and_update_cpu_nid(int cpu) {}
 static inline int cpu_to_coregroup_id(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
 #endif
 }
 
+#endif /* CONFIG_NUMA */
+
+#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
+void find_and_update_cpu_nid(int cpu);
+#else
+static inline void find_and_update_cpu_nid(int cpu) {}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index c44a80d8fc11..9aa71eb7e96b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1428,6 +1428,21 @@ void find_and_update_cpu_nid(int cpu)
 	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
 }
 
+static int topology_update_init(void)
+{
+	topology_inited = 1;
+	return 0;
+}
+device_initcall(topology_update_init);
+
+#else
+static long vphn_get_associativity(unsigned long cpu,
+					__be32 *associativity)
+{
+	return -1;
+}
+#endif /* CONFIG_PPC_SPLPAR */
+
 int cpu_to_coregroup_id(int cpu)
 {
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
@@ -1453,10 +1468,5 @@ int cpu_to_coregroup_id(int cpu)
 	return cpu_to_core_id(cpu);
 }
 
-static int topology_update_init(void)
-{
-	topology_inited = 1;
-	return 0;
+	return coregroup_id;
 }
-device_initcall(topology_update_init);
-#endif /* CONFIG_PPC_SPLPAR */
-- 
2.43.0


