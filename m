Return-Path: <linuxppc-dev+bounces-26063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4347C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 08:12:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT3YW1M2Rz2yr2;
	Mon, 24 Aug 2026 18:12:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787559151;
	cv=none; b=RqThlTBCKcLWv5gIwZNZ4yY8lMjUSJnHRjteTXvRWQMLKHOII1Sjx64cntt0P5zAuTuHMBjhnlqtTpLBpl6YAo3M4xOa9uGuvxD5kJcvsTZUHzR37XS0oZhluHYt6Gi+MbMYU6OpAesn1CwTlx4nEXxxDBB1BD1zs7Zc7TIBM9lTpdQuluySRFCZBkv5rfHa4Iwrih8JGOaogH25Wjznv/QMEQCVsHggDfzwQiX72nNKvF+wNm+Vy0eZCkOu/TcOWidnBICQuRgE8wVGOPCdXjtqCM/v4Tjqj3Zrpd9hAoXOUSoAuBUBtbJ5mERk2SuYun8lw5TzbFUnkKYe7v8pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787559151; c=relaxed/relaxed;
	bh=PvDbZEcTA4pzPPQQgOHb0UTcspz2yF8Emmo4s8S5U6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbLUQfn4Z5eKR46AFlBCuQ6HRqdVJmilXFkJXs3KUWCyGwAZye+4jtgIvH4u174ZA9tOCjoPXBUExD+gFGzrEvFqCC7EyhZBqPJ5jekW0oEu1960cYegkn9I1UWEC2I/p9y/Nqdc5wFfH30+K0FR+rUtkDmkSrZ0BErAlZ4V0MJsUoKrWgUwzCmvaMMQ5PeodOfAVNnAAhUJ8zGlcncMN+rACJXdvrrD0ZD9h1tfl9/syj5rVaL/pWGaiA28sx92Ilah+mzEyQdVYV3yKHwnqHaVfw59Ao050xPizoQEAVKLqYumQrow0psqczfVWJYkxgntCRrssZv5SgydIqrZIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MLcIfQ0q; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MLcIfQ0q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT3YT2jySz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 18:12:28 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5WUjW1015859;
	Mon, 24 Aug 2026 08:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PvDbZEcTA4pzPPQQg
	OHb0UTcspz2yF8Emmo4s8S5U6A=; b=MLcIfQ0qVyKlRavw+sYo0t0WH7rPrnJgs
	C6VPIhxLvAbgtRe+ct2L0NbfokmZVNzTIRYWy2a9PLseTNLX+dsqh9eqDNxnGjTT
	4N6v2y60qykqwIpmP5kA3wfM9EHog9meUG5srGSGo6ulpjBRoUqGhUr11Wmr3lE2
	izydjwyBgfaqL59nI9HI9TFwUKGWTvTRIMjmNEyv7icOKRMZ03yoWkxf/fxYPnzC
	uIVXbHG2L4ew9u0IFzKFkt2GTy6oIucI+gEV7Y317er8tI7rosdqwHDJQACRcHSj
	5FTKOwnDmRyBtchti96s+5xL6S+hDAfZXh1tC6q6zQjzWHII997cA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwyuhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8BKuT011526;
	Mon, 24 Aug 2026 08:12:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxvgjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8CEVi45089260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:12:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7195520043;
	Mon, 24 Aug 2026 08:12:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 952B120040;
	Mon, 24 Aug 2026 08:12:11 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:12:11 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 3/4] powerpc/kdump: consider high crashkernel memory if enabled
Date: Mon, 24 Aug 2026 13:42:01 +0530
Message-ID: <20260824081202.264913-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
References: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX/yUkBi1vTOux
 Y9m3DHXjwJYqz3B5oAquNeyA/rfuc9F7r8cjMf0tnFWi/hJnI0kcOZvwEjjfwy8iTpStDlSzVbD
 rLMkEWLLtX6wrpEqdfeyazpH6yWx6/A=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8bfce3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5drhEcaFPg1l9RF2bN8A:9
X-Proofpoint-ORIG-GUID: V8LyIuv4rrWMJ7upBui9WxmtJs_KeDpo
X-Proofpoint-GUID: w6eveYsQGw3k9ZwEXlz3q86SPJtgSkcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX9ZDjz9mE5mx5
 ivo6rLL01Da23p6CsZyanmPO8/w8C72nHlSuN/rt5LuBJ/QKb6iUTBVwySiq8wzmfPrZG3nhnTm
 9cUpvFvi0tjaRzHDBW5XGEXduVtXCD8kjpm4EUB9Ng4y5/ZttguY1zFRfVI+sWEkl2tdsnHSnaO
 mmvrbpmlL8W/J5rLJ9hxRc8XT6OEhN9YcMA8OndW1BSyaDca4BWSPw58zjmM88SGq751dR6bZgp
 VRXCCZRX/OiFYXiBfr1g3w2bwP1m0D41K0t+rAiTEZM6SD0I1s2nxTO7um/W1CbL+OTgte6f4vV
 FWu42XExpl7yzavXuKH4tlRnxidbBC4Y0Qdj209Xjjep8c06NTUmAnNgmBTloY2KnTDfxMHNM2F
 BHidr7ZrG7w2xdm8sljjrtoC2G6yse9l9490R+ooUdYEV2gX2bIRnau2VFE9dKXg4pww7zT2DiL
 3HwBJNp+eU3+NbvLu4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240070

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
2.55.0


