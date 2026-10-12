Return-Path: <linuxppc-dev+bounces-29273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325FECA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 15:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3MXY3vt9z3bdq;
	Tue, 13 Oct 2026 02:56:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791820605;
	cv=none; b=XPFrmt/l4yHFTIJ0dokyUskhmATrZiHheK9nIg1z0KOAIqUX8OIaBDX7Amej3T7y/u2CpM1x7i2g18n7Pqgeq9NijZMZjHNqg3RDwu3aAgh2e2n44w4uppyeoQCTBXI7cyjia/KN/h41vtEjtpZZsXlmn73OnkS27C0/HuIuO5yArP1IYPoJVu6iD65Gqhrqlvw/rYKrZiY3OlpwNrA1n4+ulyDE8wxhvj1KTrkylrEe17bj4hrAMZRV51B8DkC8cF5NiGvZ9xJv4F3dfAoKs2NZZ+p/5CyxmgzgSkb0lAXfGV22CruvIadOOD2sQBkVyOVW2ZyOuOiar4hNuKoqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791820605; c=relaxed/relaxed;
	bh=p/1CbzogE0uACzgyIvPXejRWL13emiWfqsLVrwpn6GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOByVJ/jG9QH1MI+MQ8Ib8orrOOaG8HuQ9ApTpKS+wWjSNjONNhfrZyuEZ/N/aZ8vQhhC1YIThKbJBz4Vmqb4RxS2ZOD3eIe48Z00FFSfcVDJCnmh3pOAwiYane+yJt9bl/+bxIglJ3+UFh2OiBFPxoP2/EnGCYuuIEzwFi683LsEx/4FRhhHDwMLA3TxbfzQYo4yp058nJICO5+3k11KbR27hBrr25/VlqQIztQDv0w0GIY4eB1Z759GOwEjCnqI34GLRhRjv0ldsHHG0cdRUhqjIRtMcAG9diJl1KEfi/nBjNnfT62wkkdPC2jvW75RaDRiKEHwqD9Wz/IaKyaAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tn+TP6o/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tn+TP6o/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3MXX3nC8z3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 02:56:44 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiK5u664557;
	Mon, 12 Oct 2026 15:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=p/1CbzogE0uACzgyIvPXejRWL13emiWfqsLVrwpn6
	GI=; b=Tn+TP6o/btBIZeYx3WfiSfJBoD8M5tV0sgOnrNil4ROibISpZLnabz2eM
	gnftgXAPMvpTL5+AgcO2ubNNHTWDynt7ZI8ZreKsV2iqNFycfdPXZ/GLE1fqLsIk
	HaN/c18+tRzkKyacSd08avNwm3z1Bmarmc9NRmdujiUnyF8QZuE+JnwPCuA5NWVg
	BhWqn1DCzZy6WtW/iRWr5yV5vuowOCHYqpirWiep0JY7kXU97brTtKsPx96PsW2f
	5tuZg7fdkulM+CsCGghCICN3TZ93J3ZJxmnjOX+4VTPkc7GvVgp7ltBbCIbp7eky
	styTfn+Nu4IaUJc+mGrmSo7tBo7EQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w1ch3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:56:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFo2Ga1519777;
	Mon, 12 Oct 2026 15:56:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnv33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:56:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFuRB741091472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:56:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A29FA20049;
	Mon, 12 Oct 2026 15:56:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6719520040;
	Mon, 12 Oct 2026 15:56:25 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.111.24.104])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:56:25 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        Samir Mulani <samir@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pseries/hotplug: Add CPU-to-node mappings for all present CPUs
Date: Mon, 12 Oct 2026 21:25:49 +0530
Message-ID: <20261012155549.557256-2-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX8/J/iEy6BizF
 o+6DEht232O1fnlVTTqDkYnrX2X1rLQAfeVYV+k8qOKKRj9Nn/Nxnh80hxKUL07zBhIStiafIg3
 8pOd1JIyMOJwMUmhVKFMpx0A6UxgRKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX92xShyhueUe+
 HzHIV5dWQG9Sg1kQIO4HS5L8rjbjYzTXLfNuPFC06BhxkhpZor+x3KdlDrshKihsFsRP8gq1D2m
 3vtIbYx0EZTyE4n2hGWCB2YQozWGsCOT0bGwkk39apVkU7RqCNRzHvo0QKADDBqRXcMFZD88MPJ
 1UaO24NU4DH38icehm89aESUo+UtrywpuqOCtLNVGGTfFnCFCABIlmNyEZrY4AOH1RXmMeEd+y2
 4ksjIDzWMpeNVL+ZMrV00Q4A2BDazuV7BJm9VAB3+mBBP1QKHPYglD9BQpuZlb+N6YZp0NuarLd
 aiQciVjqZBDPa1LvpL9v50nFbMYRGIt+s1VRafyw92CEe3bZr5xFshimZfisqY5AbKUqtUQOoHC
 rWS92EEU7UcsU9il01mloiFBAtj+DQZ7jiVLlSH1LJmErb+wptUCqr9RXaT13+Lmz8PH6yebW6v
 rWcITSb7IErVH4nK8gw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd0330 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1fnlYXJgojCpgBqSObwA:9
X-Proofpoint-ORIG-GUID: J2EDGii9-ZfR0zQNa_vMe303D77Np5XZ
X-Proofpoint-GUID: kCoXKPNGlw59eoCCDhnc01PEroamWMBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120062

When cores are added while the system is running in a lower SMT mode,
some threads of those cores remain offline. Moving the system to a
higher SMT mode later fails to online those threads.

For example, on a system with four cores:

  1. ppc64_cpu --smt=off
  2. nproc
       expected: 4
  3. ppc64_cpu --smt
       expected/actual: "SMT is off"
  4. drmgr -c cpu -a -q 4
  5. ppc64_cpu --smt
       expected/actual: "SMT is off"
  6. ppc64_cpu --smt=8
  7. ppc64_cpu --smt
       expected: SMT=8
       actual:   SMT=1: 4-7; SMT=8: 0-3
  8. nproc
       expected: 64
       actual:   36

Post commit d1099e2276df ("powerpc/pseries: Honour current SMT state
when DLPAR onlining CPUs"), when new CPUs are added, the CPU-to-node
mapping is currently updated only for CPUs that are immediately onlined.
CPUs that are made present but remain offline due to the current SMT
mode therefore do not get a CPU-to-node mapping.

When those CPUs are subsequently onlined after switching to a higher
SMT mode, the online operation fails because the required CPU-to-node
mapping is missing.

Update the CPU-to-node mapping before applying the SMT restrictions so
that all newly present CPUs have a node mapping, including CPUs that
remain offline in the current SMT mode.

Fixes: d1099e2276df ("powerpc/pseries: Honour current SMT state when DLPAR onlining CPUs")
Reported-by: Samir Mulani <samir@linux.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bc6926dbf148..b5dc942eec63 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -402,6 +402,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
 
+			find_and_update_cpu_nid(cpu);
 			if (!topology_is_primary_thread(cpu)) {
 				if (cpu_smt_control != CPU_SMT_ENABLED)
 					break;
@@ -410,7 +411,6 @@ static int dlpar_online_cpu(struct device_node *dn)
 			}
 
 			cpu_maps_update_done();
-			find_and_update_cpu_nid(cpu);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc) {
 				dlpar_offline_cpu(dn);
-- 
2.43.7


