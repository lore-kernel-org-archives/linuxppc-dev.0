Return-Path: <linuxppc-dev+bounces-28384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21429C9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htcdL74bhz2yqq;
	Mon, 28 Sep 2026 20:15:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790590534;
	cv=none; b=C4q4bMSqls+mzAid+hd6FivILs3hT0aDS0mIlDvI93/lBRyCbFK/mB9idlb3Ke+S3B5hhvgsQoOMCmMCPj1KmUWnTuWR2plc+5XvRCUhPARTlB2RYFOyyVpmF5MJUAiN8ghCQhjZdngH6bN5K+W3AoOq9vSGGWPZjESuU7eFJ6+gKKGoKqXEU9hcylUj3HZyRRxwzVr3AF+L9NeRUmL2deMHn708GNnX0dz1sFj9H/8ppZrIP3uJcIhN0fRbje4iJmk8A2Zq8Y1p0Rxg/+PqUPVc8iAJfgR7NQxmqiWMQklS2Eh9J80Exf46CCmzH+VvfrEJiZtlAz9kv/ZnhpiWew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790590534; c=relaxed/relaxed;
	bh=I9YWgdp3mCbRCKvgPqLXG3NX489SEVw7ADOKm78t1t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW+BixVL26pSSDP5YBisjqKFsW6nDil7mgrAX9Z2pQlu5YzHcFY8MfqANsx9mal/W+KGvjAVjGPYxBeTZtPyUgXeg7W/TIXLCAOW2YgpxifO2xHQ9zHm/hVQvAQnLZ9vBofmQjGPqEeNzJs8pi4beAMMWoJYjHHmS4e18WacERQak1MWskl8qZzWOtkDAM9+eASTrqSn7eLLfPLRHmhxNRKyh4bgd0Z0tLxs8MrFJzC+v167pZPF5TPtgpWAQDq57YWMOzRi28sY7T9bj8r9FGln0ZAQviDZO0fkvHp8nJfjfc9FVGEc1w86qdFw+NgzKgf2FiBPFOxuq00ZPFtM9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qbgtaWZV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qbgtaWZV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htcdK4lfLz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:15:32 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9ZbSY801872;
	Mon, 28 Sep 2026 10:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=I9YWgdp3mCbRCKvgPqLXG3NX489SEVw7ADOKm78t1
	t0=; b=qbgtaWZVNmU+C9w65tTS5Pguk/4bpNIvUIJp7XS8LC0ZKTNlDaAA6lSmk
	YNj9VTPiHNYYYAsblB5OOjKycMbvmbqlfcymSVPTYfNvJZ0vVt3Kzn4wWXIWM2Ve
	e5D0zVz6+n3btd6nleC58PakY83B2IGESl27nLE6io5WUfInVu49R6jml1CMXI/B
	lun1BKQ+zJOanQ/yIUZrwaymnFvnAXVRjwh0z9c0fOuloOheBv24FGEGSJ9oYBwS
	ttWB8jvElfVGeEEhGAXMuDNmid6i6dbncO9QA8v/ddb+cDkl4FhU/mVa071JgbH7
	eO8fXLNE3c5AAgkEVRXEsLkmlmFwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j50pwf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 10:15:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HXTe4136558;
	Mon, 28 Sep 2026 10:15:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhcpq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 10:15:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SAFHX545089218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 10:15:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3D82006C;
	Mon, 28 Sep 2026 10:15:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D90520067;
	Mon, 28 Sep 2026 10:15:14 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 10:15:13 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mkchauras@gmail.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH v5] ppc/fadump: collect dump when CPU_STATE_DATA is less than reserved
Date: Mon, 28 Sep 2026 15:46:46 +0530
Message-ID: <20260928101646.415278-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX2b48/DL15AVO
 jzH79/Zwynf/gq+61IdT4tnToAbC+JtgbzY0595NkqNPVqTDhigKOGYqgJEo1vPMoLL/k+4zvfd
 PceXFiCYYaN7+a3Z82Wlm1RkuLoH4J8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX6pUbEtvL3F1O
 1Yj1A18VxDGB49ABy+XS0r78bprRvZ/nz79L/EHzn+txHEwJYd7Tq7Hug/veAkI6D3lWuJJWnQt
 racSi4RS6MgAOHMMd8zJGothNdXwHuSJqAEbxd6tiIxn0jviIowDaolkWp2l+HlF0YvcgYebp5K
 MIkLYYL6dPkQaXS862B3r1wdI2C/Y04Xwm+/F+NuQZ1aSUgbonXcXSCMeX04vCl6BiBSdDG8YGP
 tbdP3gw2x4Uz+EOzu9G4e2Kgo8toh9w9ZPXXv/feJpiAkgTwwPQcXf2Yel/ZNE7wdpE5EEU5uMV
 VVpu+WTmECM5vQaZZKUUiuJBbHiT6pf59+WfbQ65fYReCZW/ll1V3NDnlsU4ptLQ6CBu1o9JMp8
 rP5uy08oBlORk/tXFilks6CpkhBLMsBoj2lBww5Siy2d6/fvFpuzqn9x0My8Vt54xHE2kHC9MKc
 6Tf+5ql5Zw4Vn8GTBlw==
X-Proofpoint-GUID: 16hvucQr_i2I5bML6FhShkO-5lFkN0ou
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba3e3a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rhl6VPSXp8Npg8hTsXYA:9
X-Proofpoint-ORIG-GUID: Z-8AifYGZ8GNAAvGoHw_VknlqIwA3DPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280040

During Fadump in Qemu VM, when maxcpus value is set to more than current
cpus, following failure is observed.

    [    0.045806] [      T1] rtas fadump: Dump taken by platform is
        incomplete (0)

This is because the CPU_STATE_DATA is allocated for maxcpus, while the
data is only filled for current cpus. As per current implementation
of Fadump, dumped_bytes and source_len for a region have to match,
Which is failing for qemu's case, Even tough the dumped bytes are
reported correctly for only the current cpus. After this /proc/vmcore
generatition also fails.

Allowing dumped_bytes to be lesser than or equal to allocated length, for
CPU_STATE_DATA Fadump region.

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/all/5e66daf4-3f55-4044-94a5-4f50bb040849@linux.ibm.com/T/#u
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---

Changelog:
v5:
    - rebase to master
    - fixed error message to incomplete/corrupted based on dumped size.

v4: https://lore.kernel.org/all/20260828094942.2439404-1-shivangu@linux.ibm.com/
    removed extra blank line.

v3: https://lore.kernel.org/all/20260827075803.2240934-1-shivangu@linux.ibm.com/
    removed extra variable.

v2: https://lore.kernel.org/all/20260826125626.2108771-1-shivangu@linux.ibm.com/
    Only allowing lesser size for CPU_STATE_DATE Fadump region.

v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/

---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 3bb4ac2ab6cc..9b9e09f3d900 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -459,6 +459,8 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 	/* Check if the dump data is valid. */
 	for (int i = 0; i < be16_to_cpu(fdm_active->header.dump_num_sections); i++) {
 		int type = be16_to_cpu(fdm_active->rgn[i].source_data_type);
+		uint64_t bytes_dumped = be64_to_cpu(fdm_active->rgn[i].bytes_dumped);
+		uint64_t source_len = be64_to_cpu(fdm_active->rgn[i].source_len);
 		int rc = 0;
 
 		switch (type) {
@@ -469,10 +471,20 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 				pr_err("Dump taken by platform is not valid (%d)\n", i);
 				rc = -EINVAL;
 			}
-			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
-				pr_err("Dump taken by platform is incomplete (%d)\n", i);
+
+			/*
+			 * Make sure that dump is collected for entire region.
+			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
+			 */
+			if (!(bytes_dumped == source_len ||
+			(type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len))) {
+				pr_err("Dump taken by platform is %s (%d)\n",
+					(bytes_dumped < source_len ? "incomplete" : "corrupted"), i);
+				pr_debug("type -> %d, bytes_dumped -> %llx, source_len -> %llx\n",
+					 type, bytes_dumped, source_len);
 				rc = -EINVAL;
 			}
+
 			if (rc) {
 				pr_warn("Region type: %u src addr: 0x%llx dest addr: 0x%llx\n",
 					be16_to_cpu(fdm_active->rgn[i].source_data_type),
@@ -482,7 +494,7 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
 			}
 			break;
 		case RTAS_FADUMP_PARAM_AREA:
-			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len ||
+			if (bytes_dumped != source_len ||
 			    fdm_active->rgn[i].error_flags != 0) {
 				pr_warn("Failed to process additional parameters! Proceeding anyway..\n");
 				fadump_conf->param_area = 0;
-- 
2.54.0


