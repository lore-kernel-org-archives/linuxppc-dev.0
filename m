Return-Path: <linuxppc-dev+bounces-26167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2057C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWYXL6WxSz2xlw;
	Fri, 28 Aug 2026 19:50:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787910610;
	cv=none; b=XqOqEbv79xGSSBVeVRd8xfi+Knf2NiCgFny383320tesG35jy5S0BlMD7KL01gZv98FJmOgmT/O5TWifRRNvmWwkT/WfbzATJhT3MMVW7q0wXLKJwP8gDEhYPy5zZNce2ogF0ygNo2uxb1GebWcjtBg611IQ8iQtP4e7qvV9csvzsl949Ro9BG9oJJ0AQFHzx7dX0HvjSDmEhzlTFV8V2+ubI43MJQPt6N6GVv8U3WOPq5mbOUTvI2dg2V3bj9nyidhnveCqY/z9s799upa+OldAHp1K2aVm18rBkMPRi7+GzW+Ad8HEIIWDGK0YusHCIov659UL7V7kLr4BD1eojg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787910610; c=relaxed/relaxed;
	bh=qZ1V6t9QfzZ4nnkm5491DXcQ4wLpf96/3fT5NzMoyQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn94hev9yB+7CDqFz0cc40MU2QOUbyFeCkZy11ASUzFJtVAgA9LplZLkVGjOlVQOzZAChF+81G+uY4AIKJa3+hm2RIuHunyfjzH4HQmbyuYDxDI46i5aLA8+jGWLhhaKo14Lc2jq9G2Npd1a67KjZk3/XvcBb1uPqQFVnVkXdLSvZ49bYBtY5FsD75LU2gbBCOkbk4Aji2SEo8dDD59uJRazerIDojZB8riSMA5/PwogIf6J0Y2pD7y8BDPzdVX/oLCPYKhy8wStuHwfwwkIzDWzBRHIuLRD54TRlLQw7CNZS86+JFAEQDwlWzidASWoyyEaNsiPC9lbtrFWvmBftQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EX9tIVC1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EX9tIVC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWYXK4f8Hz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 19:50:08 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S6Vh8v1212073;
	Fri, 28 Aug 2026 09:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qZ1V6t9QfzZ4nnkm5491DXcQ4wLpf96/3fT5NzMoy
	Q8=; b=EX9tIVC1fTsCmgQsumj63o4Iz9y0TVaF48OKHJ47qSyknAppyMifI3jO9
	+IzBfifAmx0Z6pU+Gr+8hV6j71vz1+uUw58rFNRdVyKy7aIMZXVVYIL4HlkFVG4Q
	+WGpeDkFJ2C3iW/seTwJgHtNdgSwglqK9Kw7EYWUGk4qaD9CG1c5mLDHRlbNHXyE
	u4F1SEgxYb1cw942QnyPO2IBuJVRhO3N0KM4j8eHWQNcwyXAi63rX01t8+wHePWS
	Gy3AbNGTf0kXWrbABK/Dgqd1wpUySanIq5qlWH1dgQNQcmO295HI+kvGZVIE5i/+
	LCcVJFa8CBPm5nxbtDCf3C18G4Gmw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5bdwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 09:49:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S9fM3E027024;
	Fri, 28 Aug 2026 09:49:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyn563-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 09:49:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67S9nrfR37487090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 09:49:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832442004D;
	Fri, 28 Aug 2026 09:49:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C502820040;
	Fri, 28 Aug 2026 09:49:50 +0000 (GMT)
Received: from shivang.com (unknown [9.124.217.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 09:49:50 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        shivangu@linux.ibm.com
Subject: [PATCH v4] ppc/fadump: collect dump when CPU_STATE_DATA is less than reserved
Date: Fri, 28 Aug 2026 15:19:42 +0530
Message-ID: <20260828094942.2439404-1-shivangu@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Vq_0DtqVm4p4l34lVzAYD_9cyYWqtUxg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MSBTYWx0ZWRfX5jw5mdyos265
 CuSEjIy9qr/C25Xz4mi15V488LTqLGLIGNZXgb3fPkg86F31XBBs/BmdYTfGTSrGWn3yETBgFSv
 OAQLHO31aUqPUlK0hl46Nl9EwFrLui8=
X-Proofpoint-GUID: poxDmCLbVCjrpjpvb3uvZwU8FXppZPZv
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a9159c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=txW4givL1YqAei2gHI0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MSBTYWx0ZWRfX6DZrTQ8vdH5r
 dMz/ZMzy7P7P07uZ64zP1zFWbICJZEKt+5BY+dZZjQNyXPJJwrswlihYfJ4L0eTnSlPhcpSDkFd
 mi/Io/M9rFgODe7KNVW1y5evYo4nNGN4jY4HQVMnAhrkUjP3ARULMGxm3hQO6wX2bmSfa8ZtEH3
 +Hy3iTky9e27coqTlyLxY+P+yN1COM82i2wBHdC9a9F2zBKiVOk6IPf4iURkRVpcw8BGoJk42xl
 Kf7SdSIRIppIDKHUJ/tZTUDgmXNvLomntq4ePTIatlPkoN1myM2gqC9cKjnkuxCt4Uo1bgPog8R
 zeNFcLakn9rZ16rw+TCKrA6BA/x7WprNayH8wtp+xrUgj9wW+ihsJThmXvZWux8j1hZeBumylPr
 gj86vgdgQwbnqJr5atTg/RxOgE6/n8icQMLllejsAAFDEMxPvpNrUJlbrkAsdMIdmc5DIdu28Wk
 Zsy2O5EScGN+Y9C3tOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280081

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
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---

Changelog:
v4:
    removed extra blank line.

v3: https://lore.kernel.org/all/20260827075803.2240934-1-shivangu@linux.ibm.com/
    removed extra variable.

v2: https://lore.kernel.org/all/20260826125626.2108771-1-shivangu@linux.ibm.com/
    Only allowing lesser size for CPU_STATE_DATE Fadump region.

v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/

---
 arch/powerpc/platforms/pseries/rtas-fadump.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 3bb4ac2ab6cc..838e97c24308 100644
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
+
+			/*
+			 * Make sure that dump is collected for entire region.
+			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
+			 */
+			if (!(bytes_dumped == source_len ||
+			(type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len))) {
+
 				pr_err("Dump taken by platform is incomplete (%d)\n", i);
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


