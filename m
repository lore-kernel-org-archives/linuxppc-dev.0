Return-Path: <linuxppc-dev+bounces-21556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192FCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:26:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLlL3PYcz2xLs;
	Wed, 27 May 2026 17:26:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779866782;
	cv=none; b=U/uF4XtVzZZ6gzeszdVZ17nobrh5t6HdPFwEkLhCeQ77nmlKpZWr1ZmDgLyq1aSMZUejoTf1MPPEgQ1Mqf2+6G2h6qmGM3aJo9GMtrg9ZCXGxLVfYMnBqq51HLG/Av5Hu0srika2C/vjx2MYFNLVGZJzgVKmVtlkXDMR/aLWh05f+Y5hHtc+eHSqLIVq4khKtFWj0uNjkd4USrF65i2H1WtoMXEi0f+b0S/LOmAWDaFkp0kdQu7ea5l50CvWQYQs83hRKtR8QZgT0Y5t6eOAn+XthvN2aW2PCzhWHU1Kb0to5qTLBGQWRNm1UohTMlFjaeEBHGMtmTTvSRmBwikGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779866782; c=relaxed/relaxed;
	bh=7BkrSip0CuyLy13h7baplQZNYO9chFx3erDj1KT6m3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko3md38ubF/0h7Gr8fOytIxrH1FEURPhQ3VvtXaXfqascnNd4IeKMEr9Ks3+AVm7Jv/fv4G8PTPMF9a6TUK0im/u2M9nRYbsUVaqHFNhkB0jSsO/lr8xHqvUsmH32sPnTLz6Gm8ubAh927WIrpe6kOKAbzrI8lfeEYHEAj+uA/ynn8GqlCjcHhY6C53wui3vIYF2jR3ncKt21p0oFrxW0WH7LjyzvECcFtxgh3EJMjoE0kvLNdsluX4WAtx0+0E2gGX+/a4hk6468d1GcdbsYkMkFF0p2fpF0KSWYe7eEpLPkznSsq5VckzMaq/7Gvb+wcTafTi07HiCy9ZqtZ5Qqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IdffYN0j; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IdffYN0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLlK441hz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:26:21 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4doB272315;
	Wed, 27 May 2026 07:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7BkrSip0CuyLy13h7
	baplQZNYO9chFx3erDj1KT6m3A=; b=IdffYN0jsmmRz7JXQj1rmf5OJaOQVayQJ
	Ox11GKjGzwQFSQ6xKm7r7ktuAjHzMNAAjjoL0wF0miN+G7WYwLTyRn9xccNGoBz7
	On8qDVMFGGBsLVjWq/F9IRLW3Hggegi/EPyCvIq0HjpJtohO8EW3Q+xVDmkwu+lz
	SnDl5TnejBMzpaKwEItQmdv6iTvhC8jHT/+axrIRDcENh4e1tAyloAexlESVJ1vd
	Z4qErj17HqF1nSAPkdYTTdyRaeKopXthuheQ5zB2NZPbUNo6sIU+BjzNHyDyrTRv
	LpeqVMkG7qgUA+H8BtVsTsN7epDWmHyhNzwa2JYUv+lxF/U9T3FDw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq6y86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7OLKW025759;
	Wed, 27 May 2026 07:26:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1wcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R7PxNg45285664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:25:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615082004B;
	Wed, 27 May 2026 07:25:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2741120043;
	Wed, 27 May 2026 07:25:55 +0000 (GMT)
Received: from dhcp-9-123-0-29.bl1-in.ibm.com (unknown [9.123.0.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:25:54 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2 2/5] powerpc/pseries: Add RTAS error injection buffer infrastructure
Date: Wed, 27 May 2026 12:54:30 +0530
Message-ID: <20260527072433.94510-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-GUID: LR6wZqV4erxc8L5uFk8Nu20X8-9EMCpv
X-Proofpoint-ORIG-GUID: j-PAedMJOBLj3FEgbugFWhTTNcbtZv5d
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a169c8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wGYcmt_NxZN9edKSF48A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2NyBTYWx0ZWRfX8jh1EvCkwoCh
 Yf6uJmRJvcpUTrC03PZ0DCmdzAOgUWazkHDpFZeZB0gTygOEdrD/3fyqZk1Qvfm0yU87Vo/CPPB
 fBHR7brKjhfOxlZ6Z5uuT+WYmMoVTrKAhtAZRHWUVyngG2GU1IeWFCdW54KfvEvP0KzJmQoDdle
 rR6Qq1V5eR0lwICwtrZlGX0I58PpvRHxPg4+8yd/1xB2S3m3UBCIQrY219K9awrtHimEWywLdnw
 76YozdSy4IoSabZZTjdOJk8hiOs0bPUYnEAMqzBmnovdcm3By+pWyCBSwgu4k4VdNK+BPGi5MEe
 tMjgIqLb+oeBLdDDkb20zF8jLPunoM8mmjVETQJpkCodfSi4qcergUDiooV/aN8x/n4P1YRhhVU
 rQTI03uX0j/zLrhAe8vGfd7eVWIqNYcc0uxxLMNgOWgz0eGxxWSgcqSXL4yegf28Gk2jfrneuF2
 xjzifiOKwIwsAxHULMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270067

Adds global infrastructure required by the injection engine:
 - a 1KB aligned RTAS working buffer in rtas.c
 - a spinlock to serialize buffer access
 - UAPI definitions for error-injection tokens (added to eeh.h)

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/rtas.h     | 21 +++++++++++++++++++++
 arch/powerpc/include/uapi/asm/eeh.h | 18 ++++++++++++++++++
 arch/powerpc/kernel/rtas.c          | 12 ++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index d046bbd5017d..82512f822c7a 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -519,6 +519,27 @@ int rtas_get_error_log_max(void);
 extern spinlock_t rtas_data_buf_lock;
 extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
 
+/*
+ * RTAS Error Injection Buffer (PAPR-compliant)
+ * ============================================
+ *
+ * 1KB aligned, zero-initialized buffer for ibm,errinjct RTAS work area.
+ * Protected by rtas_errinjct_buf_lock for concurrent access safety.
+ *
+ * PAPR Requirement: ibm,errinjct requires a caller-allocated buffer passed
+ * via physical address. Buffer must accommodate largest error type layouts:
+ * - IOA bus error (64-bit): 8x32-bit words (32 bytes)
+ * - All other types: <=4x32-bit words (16 bytes)
+ *
+ * Usage:
+ * prepare_errinjct_buffer() -> spin_lock() -> rtas_call() -> spin_unlock()
+ *
+ * Alignment: SZ_1K ensures PAPR firmware requirements and cache-line safety.
+ */
+#define RTAS_ERRINJCT_BUF_SIZE 1024
+extern spinlock_t rtas_errinjct_buf_lock;
+extern char rtas_errinjct_buf[RTAS_ERRINJCT_BUF_SIZE];
+
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
index 3b5c47ff3fc4..86645cab2827 100644
--- a/arch/powerpc/include/uapi/asm/eeh.h
+++ b/arch/powerpc/include/uapi/asm/eeh.h
@@ -41,4 +41,22 @@
 #define EEH_ERR_FUNC_DMA_WR_TARGET	19
 #define EEH_ERR_FUNC_MAX		19
 
+/* RTAS PCI Error Injection Token Types */
+#define RTAS_ERR_TYPE_FATAL                     0x1
+#define RTAS_ERR_TYPE_RECOVERED_RANDOM_EVENT    0x2
+#define RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT   0x3
+#define RTAS_ERR_TYPE_CORRUPTED_PAGE            0x4
+#define RTAS_ERR_TYPE_CORRUPTED_SLB             0x5
+#define RTAS_ERR_TYPE_TRANSLATOR_FAILURE        0x6
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR             0x7
+#define RTAS_ERR_TYPE_PLATFORM_SPECIFIC         0x8
+#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_START    0x9
+#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_END      0xA
+#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_START    0xB
+#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_END      0xC
+#define RTAS_ERR_TYPE_CORRUPTED_TLB_START       0xD
+#define RTAS_ERR_TYPE_CORRUPTED_TLB_END         0xE
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64          0xF
+#define RTAS_ERR_TYPE_UPSTREAM_IO_ERROR         0x10
+
 #endif /* _ASM_POWERPC_EEH_H */
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index a2dd94eed9d0..c110965ea1d9 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -769,6 +769,18 @@ EXPORT_SYMBOL_GPL(rtas_data_buf);
 
 unsigned long rtas_rmo_buf;
 
+/*
+ * RTAS Error Injection Buffer - Global Definitions
+ * Global 1KB buffer and spinlock for ibm,errinjct RTAS service.
+ * Exported for pseries EEH error injection usage.
+ */
+
+DEFINE_SPINLOCK(rtas_errinjct_buf_lock);
+EXPORT_SYMBOL_GPL(rtas_errinjct_buf_lock);
+
+char rtas_errinjct_buf[1024] __aligned(SZ_1K);
+EXPORT_SYMBOL_GPL(rtas_errinjct_buf);
+
 /*
  * If non-NULL, this gets called when the kernel terminates.
  * This is done like this so rtas_flash can be a module.
-- 
2.54.0


