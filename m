Return-Path: <linuxppc-dev+bounces-21067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5852CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpVx0Xf3z3cmW;
	Mon, 18 May 2026 16:56:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779087384;
	cv=none; b=Mk8m08zPPJZIBGhaj5vlilr3khgRNiwYsxBNoDj4B1oI8KSpJUaRcMyCSzWtM6cyf3x0oJtjHZxehdfMNQVj2Fa9EKWaosJJ98NuwOGVvB8m/kIEYBPUWPSAasB2K5lJV2PuW1/LtMb9idX8FuU2eY7jult0NoKfeZX3xlpFMxmlKovKJ9VBPmTfJgM1RBhbyR3d86ndSvix6QgWbEB5cN4PfJQfdobWt14S90R0KA7sf42e343kydxmiRo+Fs44OslmsPRfGwcR0vbH/VpgeQwyEGjFodobwHwd+Q6NoNEbdiaV+05NtnyR58D8df6h5j+9ftNM0RvGljUtBAwBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779087384; c=relaxed/relaxed;
	bh=z+1oz7zi+NlABdprCG4BMxUuC4Hdpj6OLnQAy8OpVgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqWyRqPPru826SO/paTV4TYjkoDIBrZlgE5xVh3r+hvQHPNtk+w0CpbL9sSHoXHE/s9eZ5Ju1mjI7QhZ3aD5UCWf075uxkIPTjssgjNamJlQFPjA4+2qKS80j/Yx8U/tab3TxIFN3AHrv7AcaWYdVCB1nBRR61GAbojFBAPGeRRCCd5Roq8KTVdNZ46Pj1jFRRoXnI64eYYhDEjKKNwsdoE1P06PyvvbPAgA/L5jv0HT4LTu1F9v1xtd0n8I+2YHjePCjLIDo/pK+oY4UCCi7D29jIRN2r5aaJt1pCF1pwit1dGu85DCzT03IntklCSahbpaQ1/qhD4uS6Fdb11jDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gGwZD7yx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gGwZD7yx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpVw0c2Cz3c7H
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:56:23 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4LODA3644508;
	Mon, 18 May 2026 06:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z+1oz7zi+NlABdprC
	G4BMxUuC4Hdpj6OLnQAy8OpVgY=; b=gGwZD7yxA3ikpCRCpFD0fkky1CBJgn84U
	6TOmojz+ahmpHY1SWRVkNlM7KXn+13KhlIkuvF2HI+EncvXT7ZwECYIiPhOlvYlT
	tJWWJb0Wx0rD/uKX/K1JXerP19ztCrtL7JN/bC1fi2nmA9iFQq24AFBMd7Z83nHU
	Sq3cP9H0mfKBzeLhIRGf7Xchghh92BeqHz11YbIAnG5VYWYWbHSJg7GfisT9x8nC
	gHF/jBe4CDCybo9GNcO3mDr11t68IsvngcGG/41+rZH1bU5Il+uAjLmxQjahfoCb
	/P0wxAhHHtJc/fONSKtPNAPx0fhlFB0caT7TfptuJgrJ+zlNM99Wg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xpnsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I6s813012626;
	Mon, 18 May 2026 06:56:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxvbw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I6uHQG45875460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 06:56:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398212004E;
	Mon, 18 May 2026 06:56:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0DFC2004B;
	Mon, 18 May 2026 06:56:15 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 06:56:15 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v2 2/2] lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
Date: Mon, 18 May 2026 12:26:05 +0530
Message-ID: <85c9b59217bcecb3c7af52e9d5b175266771d7de.1778975974.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1778975974.git.sayalip@linux.ibm.com>
References: <cover.1778975974.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2MiBTYWx0ZWRfX0G2DIAuct+nT
 INMJoP/u98GHcRjjd9Bzv3cmlVfT5l7C5ORTn3B0vlhjeLVlhhDhNfcO4pFuKzXf+hciJUHRb/V
 FK4pzQD394fjeUoqoMHbH0saAB5ymB2XzxBPfuTcyekMPnUIJmA1VIJSdFMml6ZONTVE6lqXIyM
 2bHPCB0MpLkzQuKWcm+Re/i+sBV7KJ8vIHR8ouJIzy0PBcwvrUDrk5vm8N1fzehwkRbyeFSg89+
 UB3+KjM9+IFinc8WFCXLVFvV0iAxRbdy6x+cUAdTFR94Uouj7x4VAJY0XDJn6o633qEffqJsK2p
 RKPyBk/bBzK7Xw62VQJJSYpz6z1pegxYoS+Z9YcVEYFhnz/NjbQ3yPPpI5fHkKFD8C+7qL0Rhyq
 dJOxu8hOpjo+GQLNsZkytP+U5Ux8mkY/3Ax8v6jmXyNCoX2D7avfRydASDaWNgFt0b38cMFS+cv
 MdEf1AAGDr4mJ5ETQcA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ab815 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=n7fScqo8HIbXo42xH70A:9
X-Proofpoint-ORIG-GUID: S6WLtmbGkJy1donmR_qqp_r6IHuLkjll
X-Proofpoint-GUID: 66AbxRP30H7i-kTnbhmuivLHd1GQy0_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180062

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
 drivers/misc/lkdtm/core.c               |  2 +-
 drivers/misc/lkdtm/powerpc.c            | 44 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 4 files changed, 47 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..ededa32d6744 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -96,7 +96,7 @@ static const struct crashtype_category *crashtype_categories[] = {
 	&stackleak_crashtypes,
 	&cfi_crashtypes,
 	&fortify_crashtypes,
-#ifdef CONFIG_PPC_64S_HASH_MMU
+#ifdef CONFIG_PPC_BOOK3S_64
 	&powerpc_crashtypes,
 #endif
 };
diff --git a/drivers/misc/lkdtm/powerpc.c b/drivers/misc/lkdtm/powerpc.c
index ef07e5201edf..6eaac79ea26b 100644
--- a/drivers/misc/lkdtm/powerpc.c
+++ b/drivers/misc/lkdtm/powerpc.c
@@ -5,6 +5,7 @@
 #include <linux/vmalloc.h>
 #include <asm/mmu.h>
 
+#ifdef CONFIG_PPC_64S_HASH_MMU
 /* Inserts new slb entries */
 static void insert_slb_entry(unsigned long p, int ssize, int page_size)
 {
@@ -104,9 +105,35 @@ static void insert_dup_slb_entry_0(void)
 
 	preempt_enable();
 }
+#endif /* CONFIG_PPC_64S_HASH_MMU */
+
+static __always_inline void tlbiel_va(unsigned long va,
+				      unsigned long pid,
+				      unsigned long ap,
+				      unsigned long ric)
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
+	 * The combination of RIC = 2 with IS = 0 (Invalidation selector specified
+	 * in the RB register) is invalid.
+	 * This invalid combination causes hardware to raise a machine check.
+	 */
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+			: : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+}
 
 static void lkdtm_PPC_SLB_MULTIHIT(void)
 {
+#ifdef CONFIG_PPC_64S_HASH_MMU
 	if (!radix_enabled()) {
 		pr_info("Injecting SLB multihit errors\n");
 		/*
@@ -122,10 +149,27 @@ static void lkdtm_PPC_SLB_MULTIHIT(void)
 	} else {
 		pr_err("XFAIL: This test is for ppc64 and with hash mode MMU only\n");
 	}
+#else
+	pr_err("XFAIL: This test requires CONFIG_PPC_64S_HASH_MMU\n");
+#endif
+}
+
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
 }
 
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


