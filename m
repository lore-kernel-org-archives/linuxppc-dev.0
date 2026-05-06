Return-Path: <linuxppc-dev+bounces-20513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF56CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 09:06:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Tyl2DtXz30Sx;
	Wed, 06 May 2026 19:06:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778058399;
	cv=none; b=I4F3ZKOmlaaFwKJv6ieJEvSTtbunXHrdMYneB02ozjz9P0vECOVvMhDKOyOTOXLZVATfG2dE5DOCizSgtAJ1NBUOo3s0kRo0Tc043e+VyEdagpBJzSD3dEdyy9h1ZbtHevBX8g9Sx5v82hejT481WI+0gAN2E6IwSPT7QNGzpkdeSy0tY5TG//KU5RUS6Osn40pSx9ICU6RmiaMERWvMBaBpn87LxwLNES1LqTxXMKWCt0c4pEnVxd5teQWdmWn6XrdLHeX0sDeypbzs1FORBLDFrzkwKGf/jlbOOnW8+R3/ZmTxR0WMePf4mu2iLTB0kEECdAXD4p8IlOqv3GG+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778058399; c=relaxed/relaxed;
	bh=fca4Z87N77h6CF+xskmQZ8FX2ytJtrXFqslQ4+o6snA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2wpUFHrFnWfzuj7wXN9S7X+701mIHO/5QUIFXtkcrf/UdytqijtdCbT14qxPtNqgYoQhxgkqalEYq7KlJTCf760CSFhSCXyaBeW/T8jKOtLlywvO7syxKej0Vi+9CkFhaegoO7yx1NK/QVeHAO91ZgZaSovlMceuNbEx/5G4xemFRBgdl5bcLPXpWZbeCGFo89r6CgPr6vdXG0acv28VxVPgPkSRtJ+FfiR3RYLstJTKp38T1odhZ6Cu2fSmRurFdV5ZSfO+BVBV3sWk+jqr8jwBK53f9XKa44ceTx+JAQ09Td1oJzJ2jxIxpumEhPpB7ReSdW+RfNx8Z1cECDSjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hDNNFAMI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hDNNFAMI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Tyk1l1Dz30Vy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:06:37 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6464niJu2492757;
	Wed, 6 May 2026 09:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fca4Z87N77h6CF+xs
	kmQZ8FX2ytJtrXFqslQ4+o6snA=; b=hDNNFAMIOXJMBkT+dbKosAtXZbkiEm2AU
	jb4IJO9Zvrdre56WaDGNpiDdkh5trQkllnEjOTM91le0T/5GjwDQNZVuEQwGCsaZ
	uUuDb7VnhrF1X/h9r1RhT3o8QkS4to6XNp7eBPy1agaAvF3gvcOxdwV8/w9mBN5z
	7ClGcpqzy49o4s7tF5qPSyQEkmeqiaUslb7hWSOIRp8SCvqV+ji0LXGvgG/XFuqm
	pK1/H/FQi5m/sHX/QrwJAIyQNzpM1n7XJma/45g/pybRfOGTWhU/WMzKZyXscvec
	k9r+Hr5JCFqHnN+mleG0e+roJxyzstdx1N1RnZyuOBxoQll9oHyjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6f7dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6468sY5I018111;
	Wed, 6 May 2026 09:06:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yd8gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64696Sqg57344388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 09:06:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 163322004B;
	Wed,  6 May 2026 09:06:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D47B420040;
	Wed,  6 May 2026 09:06:24 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 09:06:24 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: [PATCH 3/3] lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
Date: Wed,  6 May 2026 14:36:14 +0530
Message-ID: <335c6213a3620f561983f67332ee39ece927ef0e.1778057685.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1778057685.git.sayalip@linux.ibm.com>
References: <cover.1778057685.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb0498 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=3bI6KQ0BwHB4WGLmmHkA:9
X-Proofpoint-ORIG-GUID: BHIwcIAifCvlQbNFGXRzoW-2LHgaoUFM
X-Proofpoint-GUID: WPQNHz8BqwQBl0uM_ovwqqcivKUv6RoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4OCBTYWx0ZWRfXxqwqQZRzNIKE
 GQSjozyIpYPFcIDo+flANupeEL6VEPNEnZpBD9BWhrUkOkC4U0wOLVMqkITs0ukcjnh5ON+usai
 zHSEq1W49Jp6kCQH1SVFeI5jKb0/oOUjH78dC1Ry8gyfohiRM5blOXfEFefG2P1bkZh9QZQ7A7c
 qkR1M7rFXn2zuegJPL9beiS5Z+JrLIlF6s+gjftyHEFaFJFaRaSn9gfz0H2x6sJsWrgdiThyBAh
 XrqrLhPL5djPKHTavKjQPI3MbgGg7XegYEClXtGamD3RRc7C6tOGsD2frJG65rrKwOQxgXVgQQy
 RBl+G3aNFBSGWpXoOkX1ddfYwp3Q/WOPZHQgaDuvdRLTDv0+rXSgL3buXub8wMGoZnHf3NPhmFf
 lZewsPmq24e24HbnTHbwpHFzGJzsZSHirRrZxYzkoZBE7ll9mJqJZlIWpDDseQmg8RT64r3P9DF
 sf/HRBn54iN8yg826OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060088

Add a new LKDTM trigger (PPC_RADIX_TLBIEL) that executes a process-scoped
radix TLBIEL instruction to exercise the radix MMU behaviour and
associated machine check exception (MCE) handling paths.

This provides a way to validate MCE handling in radix mode. Currently,
there is no dedicated LKDTM test that exercises this path or allows
triggering radix-specific machine check behaviour for validation.

The test is only enabled on ppc64 systems with radix MMU
support and If radix is not active, the trigger is skipped and reported as
XFAIL.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 drivers/misc/lkdtm/Makefile             |  2 +-
 drivers/misc/lkdtm/powerpc.c            | 39 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 03ebe33185f9..4e58d16fc01e 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -11,7 +11,7 @@ lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= kstack_erase.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
-lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
+lkdtm-$(CONFIG_PPC_BOOK3S_64)	+= powerpc.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 
diff --git a/drivers/misc/lkdtm/powerpc.c b/drivers/misc/lkdtm/powerpc.c
index ef07e5201edf..3d56b56f5e0c 100644
--- a/drivers/misc/lkdtm/powerpc.c
+++ b/drivers/misc/lkdtm/powerpc.c
@@ -105,6 +105,31 @@ static void insert_dup_slb_entry_0(void)
 	preempt_enable();
 }
 
+static void tlbiel_va(unsigned long va,
+		      unsigned long pid,
+		      unsigned long ap,
+		      unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = pid << PPC_BITLSHIFT(31);
+
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	/*
+	 * Trigger an MCE by issuing radix tlbiel with an invalid operand combination.
+	 * Using PRS=1 (process-scoped) with kernel address does not correspond to
+	 * any valid process-scoped translation.
+	 * This results in an invalid tlbiel operation, causing hardware to
+	 * raise a machine check.
+	 */
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+			: : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+}
+
 static void lkdtm_PPC_SLB_MULTIHIT(void)
 {
 	if (!radix_enabled()) {
@@ -124,8 +149,22 @@ static void lkdtm_PPC_SLB_MULTIHIT(void)
 	}
 }
 
+static void lkdtm_PPC_RADIX_TLBIEL(void)
+{
+	unsigned long addr = PAGE_OFFSET;
+
+	if (radix_enabled()) {
+		pr_info("Injecting Radix TLB invalidation MCE\n");
+		tlbiel_va(addr, 0, 0, RIC_FLUSH_ALL);
+		pr_info("Recovered from radix tlbiel attempt\n");
+	} else {
+		pr_err("XFAIL: This test is for ppc64 and with radix mode MMU only\n");
+	}
+}
+
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(PPC_SLB_MULTIHIT),
+	CRASHTYPE(PPC_RADIX_TLBIEL),
 };
 
 struct crashtype_category powerpc_crashtypes = {
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 3245032db34d..d8180bbe31e8 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -86,3 +86,4 @@ FORTIFY_STR_MEMBER detected buffer overflow
 FORTIFY_MEM_OBJECT detected buffer overflow
 FORTIFY_MEM_MEMBER detected field-spanning write
 PPC_SLB_MULTIHIT Recovered
+#PPC_RADIX_TLBIEL Triggers unrecoverable MCE
-- 
2.52.0


