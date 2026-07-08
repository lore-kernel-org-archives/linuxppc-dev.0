Return-Path: <linuxppc-dev+bounces-23826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A64C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLG130slz3054;
	Thu, 09 Jul 2026 00:34:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783521273;
	cv=none; b=U8nzk9hH+yFtHvKA8HHBu4q0nPtD1Q4GGBSs2UUs9UkmQfzdbywKaJvYCwU3fZr+su/BcGPohXXQBE7P3rU0uolOYdWHl80FjL7i3dHuh58EY9hRVVH+LuzJ77l3b19ywzikmI6QK3t34R5+LRwrrFUEABGxYTBEvK9qzOnYJIcYS7WRm5YOMgx5hmYCfHvI+bUo+rDNoWg0157p+4rF4TpzOC8XXmt+l25s4rHtUgYkmesqan2B1El0FXwH+Rh5oQIN8Q2wAbBB+O1gxK63eZhVWZDzGkdYQH2SAV4oIhBc6+cGrP3AHwgkAHlYVInGjwHwuu+RvfHEGZaYdHzMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783521273; c=relaxed/relaxed;
	bh=0FifmRLjv3mcpwXc8zUf33LuX+s05pTpQ/qzgvPSiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzI2S4tlZmqYCevayqqCOVi9SZrtzI3zR+iuGDtM/iQY7MIwv1rX7T6KogHGwmv1vLaqI0TXGtY4CSJsu+tBjOYbGizrhlAp22xVEvaZJ+dkEOsUCk0hrmVHF5Ie2wP8S0sJUDec/kwyYrpKQ5v+Kh+gHpAQqbrIifeeSm3GzkxYvT9FU1vZjuiZkE7FtzZeadO72N3Pp2mP97wikRgd4/R1BNSUC0RW3WBbQt5+T2dX4MkmBihxHQhVROGGh9m4tGcD16qDJv1RWbFR0ukRqKKRaIaxElg2ZxEsTukOPrrzlkgGCVPFenKdtDz79sk5ZXSd203vqkwCWcLWnVMdCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hi0opsSG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hi0opsSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLG02KtVz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:34:32 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CJ41F3390596;
	Wed, 8 Jul 2026 14:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0FifmRLjv3mcpwXc8
	zUf33LuX+s05pTpQ/qzgvPSiuk=; b=hi0opsSGAOSxNQxEdJGO20R+hUThcGW/t
	SyG5MrybbVhV2UWOtmm0RAblq2h2/8zI2vs0pe2lKwBrAF7kQruNzcNA1yNpSSJW
	cN7Vlv4KnR/oH78dPxLocNI5gHf1xepzXVme2ctEwhgJPq71xuwquiJ12k2VXa8a
	W5RZ/oGR3Ffk1NHuOz2DDq5GZmS2cjr3M82yvSs6bYel159s/UcAd6MmcGetIJib
	hDkEWb2JEn6QPN9BaNpk67+pT2cDHtMAmpn49OJc2rxkvtt5NlFSlqQ0ONoDuoAz
	rqOYjQ1AZ039KI8y6eXXb31hPfrW/BSVEMKQYNN4emInMtVpwVtHA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknmcr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJhlM032251;
	Wed, 8 Jul 2026 14:34:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hgauk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668EYJVR11796928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:34:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA26320043;
	Wed,  8 Jul 2026 14:34:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D6A20040;
	Wed,  8 Jul 2026 14:34:16 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:34:16 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 3/4] powerpc/kdump: consider high crashkernel memory if enabled
Date: Wed,  8 Jul 2026 20:03:56 +0530
Message-ID: <20260708143357.673251-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e5ff0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=5drhEcaFPg1l9RF2bN8A:9
X-Proofpoint-GUID: tMosu9Tylf9zvTKlCh2oJI6A8K8EgV3p
X-Proofpoint-ORIG-GUID: aG-polKFNu5BRopzkgSUYNmvMxJpP98O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX1upcZ3a2Ist9
 /JU4VrJyB8AIgpPDQZSYbxXXdfTGcVxN50y2OkpC27zNjHjx+EWzYLi3gXKCLPr7BjMPGS9jNRr
 UGGzzQOU6R8byeWvtvu4rgTz+I1VQIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX6pURLy6zRJfM
 7Jau+89nOEi9otVK/j+sAtyYtt8GTQY/TOoAvH1HG3corPLlU2aUo5hUFvK4s/wWGQ9tMzg4AlN
 q4BDsn+lN/+STCo00ENA2/ZwqAeabw/S2CBx9gxguQhUMmR2SHzJtQg9Y4QPAtI++eV9vxeKPCe
 VikjGT/opdq0VJ2UsdBK6xDcOk20mJQdAWCxCTAY277k5T5EADLCZ518oGZY6U5n+HYmu7Smk9c
 oAfXYgUWprokt4EQOurP/lkGvS5owWjcsJGXHI3IUNgxFVdAOBjrI3qG0D+N+TY2tPyjtNoYIsW
 8RyxDRZvtcFWhDU+24goEJy2aZ+ZL0mENn6hOXQC/BAtxaJcru++X4HKIho16cT6ofiMMcgIvBg
 apy13g5+0rcPKLh9hSbKI1o6Mi78UbxJzcCqJqpcyjPAA7vBbBZFvtDdAGVUxSGubs+KUW9Vz0V
 5dUMNgoAOXqS+X0CYEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140

The next patch adds high crashkernel reservation support on powerpc, so
kdump setup is updated to handle high crashkernel while loading the kdump
kernel.

With high crashkernel reservation, the crashkernel is split into two
regions: low crashkernel and high crashkernel. To ensure kdump loads
properly with the split reservation, the following changes are made:

 - Load the kdump image in high memory if enabled
 - Include both low and high crashkernel regions in usable memory
   ranges for the kdump kernel
 - Exclude both low and high crashkernel regions from crashkernel memory
  to prevent them from being exported through /proc/vmcore

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/elf_64.c       | 10 +++++++---
 arch/powerpc/kexec/file_load_64.c |  5 +++--
 arch/powerpc/kexec/ranges.c       | 24 +++++++++++++++++++++---
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index ea50a072debf..85a6e92f1160 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -52,9 +52,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (IS_ENABLED(CONFIG_CRASH_DUMP) && image->type == KEXEC_TYPE_CRASH) {
 		/* min & max buffer values for kdump case */
 		kbuf.buf_min = pbuf.buf_min = crashk_res.start;
-		kbuf.buf_max = pbuf.buf_max =
-				((crashk_res.end < ppc64_rma_size) ?
-				 crashk_res.end : (ppc64_rma_size - 1));
+
+		if (crashk_low_res.end)
+			kbuf.buf_max = pbuf.buf_max = crashk_res.end;
+		else
+			kbuf.buf_max = pbuf.buf_max =
+					((crashk_res.end < ppc64_rma_size) ?
+					crashk_res.end : (ppc64_rma_size - 1));
 	}
 
 	ret = kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &kernel_load_addr);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..701d226cd23f 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -731,6 +731,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 	int i, nr_ranges, ret;
 
 #ifdef CONFIG_CRASH_DUMP
+	uint64_t crashk_start;
 	/*
 	 * Restrict memory usage for kdump kernel by setting up
 	 * usable memory ranges and memory reserve map.
@@ -750,8 +751,8 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 		 * Ensure we don't touch crashed kernel's memory except the
 		 * first 64K of RAM, which will be backed up.
 		 */
-		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_END + 1,
-				      crashk_res.start - BACKUP_SRC_SIZE);
+		crashk_start = crashk_low_res.end ? crashk_low_res.start : crashk_res.start;
+		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_END + 1, crashk_start - BACKUP_SRC_SIZE);
 		if (ret) {
 			pr_err("Error reserving crash memory: %s\n",
 			       fdt_strerror(ret));
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 867135560e5c..1b08c05ab5a8 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -524,9 +524,20 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 	 * Also, crashed kernel's memory must be added to reserve map to
 	 * avoid kdump kernel from using it.
 	 */
-	ret = add_mem_range(mem_ranges, 0, crashk_res.end + 1);
-	if (ret)
-		goto out;
+	if (crashk_low_res.end) {
+		ret = add_mem_range(mem_ranges, 0, crashk_low_res.end + 1);
+		if (ret)
+			goto out;
+
+		ret = add_mem_range(mem_ranges, crashk_res.start,
+				    crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out;
+	} else {
+		ret = add_mem_range(mem_ranges, 0, crashk_res.end + 1);
+		if (ret)
+			goto out;
+	}
 
 	for (i = 0; i < crashk_cma_cnt; i++) {
 		ret = add_mem_range(mem_ranges, crashk_cma_ranges[i].start,
@@ -609,6 +620,13 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 	if (ret)
 		goto out;
 
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_low_res.start,
+						      crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
+
 	for (i = 0; i < crashk_cma_cnt; ++i) {
 		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_cma_ranges[i].start,
 					      crashk_cma_ranges[i].end);
-- 
2.52.0


