Return-Path: <linuxppc-dev+bounces-22103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF6CD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:54:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWrGg00rfz3brr;
	Fri, 05 Jun 2026 15:54:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780638842;
	cv=none; b=CzVAla3xV1jiXDl2YEpNZlV93rgPyRM9WuMwmcf0E0bZG8/VqXVasf/W6ILV/jktQqI0Blp6E4mqW30r5fyQEt3p2bQfqzH3n4rO3WCveG0O68zAfej5q4fYurMFf/lyQ8H1to9vZTZ2qfcFuplQqLLQJiTerQ5s5hjvETX2ugs3vwso956iFZegC24SkmZELUUogsWN8zl6CjaepWvwEmYWbxr5zUTLZFvyZRMbmPtU5ajAoc09nfXTfLOm1FCjOwyapv9DhL9skK0RzDAtgcl0II138UiRYmz/XMqtkZQpLiRbIlYqd/MsUD5pglK84dEbkMGw+Qs1WUbq4lyybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780638842; c=relaxed/relaxed;
	bh=2Bz+PNrW4rPIWc/iKgUjb9kwae5glIwvtoOn4uaavqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU7d1oNOtAaQqCJGNBz8dDoY76TkpMC5Vs+cIJOs3fFOpwUOsa0mfNq3Bw4YYNj9FsHB7jqkuAOZEwpiKaJVhHjciJRHg4PQzwf4zDDOI/6mDmpcl94jQHp9reml76ZkLVGjFSATmGTy11ur/vcc3aimaWqYC0RLeSCbvpWXZt9AB6dPL63QriLmQcS5irVz8dNCNTGQlpuFUUH2NK7nhNyLcXs+eFcZ6aQU2tDE0fzEvtSYY2xtpRPfTUur2KSnpOrff+V0MGg2ED9NZvdOU9NH7H/f+CHqM5vASD1phSWRpTtYJTPNdbKptmx0zOViZJeahNN3Z+rKWDckQR3IIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jaA4uSTG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jaA4uSTG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrGf0Z88z3br5;
	Fri, 05 Jun 2026 15:54:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654MXqbQ987831;
	Fri, 5 Jun 2026 05:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Bz+PNrW4rPIWc/iK
	gUjb9kwae5glIwvtoOn4uaavqw=; b=jaA4uSTGt8jWnnsT944SqXQUEMlhEVpHr
	4CIPQ/RbXvZepRyv4oLpngfDeW5ED7LwT9i7G9f4mazv0etoSi/xiu9VCv4cERz1
	1leichwgxrEhmkwEZ+F0vejRHGuUsmLzbI5bSwhZi2dpzFtzEKHSDhj1QZlRgKhC
	IJqGSzZHI/Cj1j8DyLWDX1qCP7t4CEJjJOlKeR57cbyyIrVrel7CgAcQT1HFZBOE
	k4NQYVldNgCYpCbiNzF4iYBFzTg7ntir0Iml27+4LzwILMUai/I2BXmViCQ7+wPA
	UcnmgppcmST4y6UJhLI08DEPUuOKayVlu0oll9eyhkqcuNe3h1jGA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtjc65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6555d6DY016879;
	Fri, 5 Jun 2026 05:53:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qrhkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6555rjde48890136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 05:53:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E30220043;
	Fri,  5 Jun 2026 05:53:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2232920040;
	Fri,  5 Jun 2026 05:53:43 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.90.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 05:53:42 +0000 (GMT)
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
Subject: [PATCH v2 3/3] powerpc/numa: Support coregroup on PowerNV
Date: Fri,  5 Jun 2026 11:22:46 +0530
Message-ID: <20260605055242.1757485-8-srikar@linux.ibm.com>
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
X-Proofpoint-GUID: 7h9dWhNVRjIGn_VIGop97f1ZVogUkFlh
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a22646e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=u_kndASixH3PHailIgsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1MSBTYWx0ZWRfX5ZeiBUf/zjBf
 sT5vojZQ1sdg22Jp0ghCK89Ry2kB7Ht7hhpPDVspNhMYVekB9P8M8LRd4ENG6spqZIhJz6t9sDt
 oBirXXlPkz1gBsfj5HyeHHEy3kkD6vErve6vPrT+zsSTnmaqcisHzVrW78ja7/5Q12V7pzvQNW4
 hJBxXuj6TE263lMI/4CKBzTN+WBFAVL8cKRgoSexUalCtKvAQblFUA1nQqjIxifUuzUTDLSaWIP
 Wvq2spB/8Q6Fj3DN+uOwd00pVCyRP1MnlTAK/3AnzgGJivlDxs9ZXQZE0/hhPfVl4MQoykWDq8g
 XH/EkoUVHimCDkvQf6nVAMYDsH4qqbVNDV3aS3frfKTFJe6wWLbefT/JJ6m+WzdVu0jMI7H2UzG
 XMpP8b0uCwE1nNWda+bmsz3NnBzd8uJsD9gj+ab1tzFDCxLllzr5L5YqWOm6ozIkjod30f/UEUE
 3JGt/g8i9Fu91v1SC9A==
X-Proofpoint-ORIG-GUID: uhMS6rhFLMmNEU6yaBgAHNo0e8NFnWIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050051

Coregroup support on powerpc has so far been limited to PowerVM LPARs.
However, PowerNV can also support coregroups when firmware exposes the
required coregroup information through the associativity hierarchy.

Detect coregroup support by checking whether primary_domain_index is the
penultimate domain in the CPU node's ibm,associativity property. On
PowerNV, a non-penultimate primary_domain_index indicates that firmware
provides an additional level for coregroup information.

This keeps the logic compatible with PowerVM systems, where
primary_domain_index is likewise not the penultimate associativity
domain.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
- Handle comments from Christophe Leroy; make code more flat

 arch/powerpc/mm/numa.c | 56 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9aa71eb7e96b..e97b624203ea 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
 	return 0;
 }
 
+/*
+ * If hierarchy extends beyond primary_domain_index + 1, then next
+ * level corresponds to coregroup.
+ */
+static int detect_and_enable_coregroup(const __be32 *associativity, int index)
+{
+	if (!associativity || index == -1)
+		goto out;
+
+	index = of_read_number(associativity, 1);
+
+	if (index > primary_domain_index + 1) {
+		coregroup_enabled = 1;
+		return index;
+	}
+out:
+	coregroup_enabled = 0;
+	return -1;
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *memory, *pci;
-	int default_nid = 0;
-	unsigned long i;
+	int default_nid = 0, index = 0;
 	const __be32 *associativity;
+	unsigned long i;
 
 	if (numa_enabled == 0) {
 		pr_warn("disabled by user\n");
@@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
 	 */
 	for_each_present_cpu(i) {
 		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
-		struct device_node *cpu;
 		int nid = NUMA_NO_NODE;
 
 		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
@@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
 		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
 			nid = associativity_to_nid(vphn_assoc);
 			initialize_form1_numa_distance(vphn_assoc);
+			index = detect_and_enable_coregroup(vphn_assoc, index);
 		} else {
+			struct device_node *cpu;
 
 			/*
 			 * Don't fall back to default_nid yet -- we will plug
@@ -948,6 +969,7 @@ static int __init parse_numa_properties(void)
 			associativity = of_get_associativity(cpu);
 			if (associativity) {
 				nid = associativity_to_nid(associativity);
+				index = detect_and_enable_coregroup(associativity, index);
 				initialize_form1_numa_distance(associativity);
 			}
 			of_node_put(cpu);
@@ -1445,7 +1467,9 @@ static long vphn_get_associativity(unsigned long cpu,
 
 int cpu_to_coregroup_id(int cpu)
 {
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int coregroup_id = cpu_to_core_id(cpu);
+	struct device_node *cpunode = NULL;
+	const __be32 *associativity;
 	int index;
 
 	if (cpu < 0 || cpu > nr_cpu_ids)
@@ -1454,19 +1478,31 @@ int cpu_to_coregroup_id(int cpu)
 	if (!coregroup_enabled)
 		goto out;
 
-	if (!firmware_has_feature(FW_FEATURE_VPHN))
-		goto out;
+	if (firmware_has_feature(FW_FEATURE_VPHN)) {
+		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
 
-	if (vphn_get_associativity(cpu, associativity))
+		if (vphn_get_associativity(cpu, tmp))
+			goto out;
+
+		associativity = tmp;
+
+	} else {
+		cpunode = of_get_cpu_node(cpu, NULL);
+		if (!cpunode)
+			goto out;
+
+		associativity = of_get_associativity(cpunode);
+	}
+	if (!associativity)
 		goto out;
 
 	index = of_read_number(associativity, 1);
 	if (index > primary_domain_index + 1)
-		return of_read_number(&associativity[index - 1], 1);
+		coregroup_id = of_read_number(&associativity[index - 1], 1);
 
 out:
-	return cpu_to_core_id(cpu);
-}
+	if (cpunode)
+		of_node_put(cpunode);
 
 	return coregroup_id;
 }
-- 
2.43.0


