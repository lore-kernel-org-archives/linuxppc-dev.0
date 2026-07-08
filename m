Return-Path: <linuxppc-dev+bounces-23825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FB7C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLFv3hqKz2xll;
	Thu, 09 Jul 2026 00:34:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783521267;
	cv=none; b=hNGnH84AQNbDowBltTfdjYg7wrkpseoxQUvoBM5JBJTJtysZJWwKeSza+fdW9UAMu775F54t82nxY1ca87P2MoPGNn83mzkxlbkYFkYBRMELwh3PDnssghPTBjD+SdhWN/5sWHiIha3s/nsvkdvuxEMTywD5By6Pn9xkBVZFmua1mGx7aBL1mENhYUp6UUQm4AeuC296rJnUmPS6zSrHPRfeUgR3BbTngr4j8iO9tQ9XlTIMjAG+Pexy1r8CHe/jlcUo0ipMs7Ex+qY9BYVBYmlkS9mnonb/NrhtlZ1+K11McjNaOeM++8Wb1tyA8vLXpo/3kGIk5J9RSQbiXZ1jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783521267; c=relaxed/relaxed;
	bh=NAh2znViOXp3ufYaa0PnFC8jmmu7tKWqXM5Nq7eg4hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpO3kZ6NobRsNZlYv+xwEABYCIx7f9Ln7mn/HDc2k6fVhIfVrevh4BXHM4ba7zcDfTEKl0TKZDxp1GDBA7Ewyz/dkQbdw1hvyOQ8PuCavgDvUSzvu0hDyCs1tdTkzF3mz5dK/d3fdB1st1XipClVW2xjUV6+qpbSOWOcE2EW28OVb0hSSxszP9MDlCGm3lOJlb8kt7qo+Av2+Mkeo8KgnYCWSprUNwgCCLAeOQ42q/wnu69i2xqDzDenLjXA6+kQM7jK50MgC4ywbUAGahNp6WgpOgpGJoM989u/GcYT2h0kp7CDvuA7B2NdBBexhHIL6XQA/BxPMgpU5KSB37ICGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=clixqOkH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=clixqOkH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLFt5bKXz30D9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:34:26 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIH6H3748063;
	Wed, 8 Jul 2026 14:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NAh2znViOXp3ufYaa
	0PnFC8jmmu7tKWqXM5Nq7eg4hw=; b=clixqOkHcHUxf67kqwU0jvfHLkWf2eHcE
	6lXO/XL5jBAXk7V/DOPyleXocf0qkVKzkZupJZzTuSCBhpUFyMh6aBO9zOYmHFcR
	RLM0+v3/FAXNWb4d8SNmJUCVqnCwBmn+PoW4XIFn1vMyKD/qC2YevRVsIHhxbVDm
	iMn717lxPrI7BVXNkMgqw3YS22M8nlnyG2p5dskNNuKDW7quCOc4q7HENBPpV5T3
	yPO8ztlU6ZDZ4f4GlMH3KHe+D97ilZue5OGiobaJ8KkvPEfTa8FodjxqUIPup17Q
	6L2VYGmNHQ2/JnYNYx9eAQi31x3awG51Ugxi8KZF9ztEN2kiYYfYA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqvjsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJjDv017287;
	Wed, 8 Jul 2026 14:34:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq8myg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668EYFIL48562472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:34:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D63120043;
	Wed,  8 Jul 2026 14:34:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2DA720040;
	Wed,  8 Jul 2026 14:34:12 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:34:12 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 2/4] powerpc: move to 64-bit RTAS
Date: Wed,  8 Jul 2026 20:03:55 +0530
Message-ID: <20260708143357.673251-3-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX2qmfXSwI0/5v
 d+viMvjkzBeviMH7Bofac0FBxfrCKBS4rFn7EHfZCqE0w/pesIdmuLTZdmtTaxTScCEOnSVcx3k
 p4v8xGMAQRJkF+0UkhoMSrHWYjOxKAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX1RX/qzbzPGba
 fh2Xz6teqFgBdWcOgQdSTBYMsixhvQ+KJme+eHGHBKA0gDiz9Arpys3GoW98G1w/AyaPZxWnDe5
 PUaYcfteqYBOL7zqgiRvVAuetIr+QGFgMTHBe5Lz/wAyQ2EHRVtDJ1itgJOWMbBPtB5890liXrS
 eZed4sQWARzXpuhYXzkMfU+Rd8jMasYQAZ4ZYBxPPNwGIOej22tcSRWC3mXYIIn72Q1nmTsSkHF
 RoAEl6whkPG69XiXpj1Vs2eYr3EkzBruWJAirhK0VzpHlEw1Om5NOogFdp3Cvy64ZJCAL6zmA/5
 rp4yEqoLX2lflaU8ACrFj94Ep7fHW6R35C3ceWA4z1qG1pWdnIMWm6CY8o1jMrcIP4cA3EKKalZ
 U3S1AWCBheXP91zZg2O3fyRwp36QSj6Y/HRkMiKIbm5SbawS3xuKbW9epNG13dALv935P6R06/7
 ZXtYPv412BZX94s8gIw==
X-Proofpoint-GUID: Nk_i9m42rSQuv4nMV1ax1hWnUC1dD5_g
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e5fec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DK_zCW-mUeN1pVogSN8A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: _52vei3TrzAe1MA4NXpMEuMFN60udcoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140

Kdump kernels loaded at high addresses (above 4G) could not boot
because the kernel used 32-bit RTAS.

Until now, the kernel always used 32-bit RTAS, even for 64-bit kernels.
Before making an RTAS call, it clears the SF bit in MSR and uses LR as
the return address from RTAS. For kdump kernels loaded above 4G, RTAS
returns to a 32-bit truncated LR address, typically causing an exception
and kernel panic.

Fix this by switching to 64-bit RTAS support on systems where firmware
advertises "ibm,rtas-64-capable". The kernel instantiates 64-bit RTAS,
passes RTAS arguments using a 64-bit argument structure, and sets the
SF bit in MSR before entering RTAS. This ensures RTAS can correctly
return to addresses above 4G and allows high-address kdump kernels to
boot successfully.

If 64-bit RTAS is not supported or initialization fails, the kernel
continues to use 32-bit RTAS. In that case, high-address kdump kernels
will not be allowed (handled in upcoming patches), and RTAS calls will
continue to run with the SF bit cleared.

Changes made to support 64-bit RTAS:
- Detect firmware support using "ibm,rtas-64-capable"
- Initialize 64-bit RTAS in prom_init and add a new FDT property
  "linux,rtas-64"
- Read "linux,rtas-64" during boot and track RTAS mode using rtas_64
- Add 64-bit RTAS argument handling and return value conversion
- Prepare MSR appropriately for 32-bit or 64-bit RTAS calls

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/rtas-types.h |  8 +++++
 arch/powerpc/include/asm/rtas.h       |  2 ++
 arch/powerpc/kernel/prom_init.c       | 20 +++++++++--
 arch/powerpc/kernel/rtas.c            | 48 +++++++++++++++++++++++++--
 arch/powerpc/kernel/rtas_entry.S      | 17 +++++++++-
 5 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/asm/rtas-types.h
index 5d40d187b965..de794b3e0fbd 100644
--- a/arch/powerpc/include/asm/rtas-types.h
+++ b/arch/powerpc/include/asm/rtas-types.h
@@ -14,6 +14,14 @@ struct rtas_args {
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 } __aligned(8);
 
+struct rtas_args_64 {
+        __be64 token;
+        __be64 nargs;
+        __be64 nret;
+        __be64 args[16];
+        __be64 *rets;     /* Pointer to return values in args[]. */
+} __aligned(8);
+
 struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index d046bbd5017d..aaa4c3bc1d61 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -10,6 +10,8 @@
 #include <linux/time.h>
 #include <linux/cpumask.h>
 
+extern int rtas_64;
+
 /*
  * Definitions for talking to the RTAS on CHRP machines.
  *
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 53503937de0e..be7c5ea0b75d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1841,6 +1841,7 @@ static void __init prom_instantiate_rtas(void)
 	u32 base, entry = 0;
 	__be32 val;
 	u32 size = 0;
+	u32 rtas_64 = 0;
 
 	prom_debug("prom_instantiate_rtas: start...\n");
 
@@ -1865,15 +1866,24 @@ static void __init prom_instantiate_rtas(void)
 		return;
 	}
 
+	/* Check for rtas 64-bit support */
+	if (prom_getprop(rtas_node, "ibm,rtas-64-capable",
+			 &val, sizeof(val)) != PROM_ERROR) {
+		rtas_64 = 1;
+		prom_debug("Node ibm,rtas-64-capable: %x\n", val);
+	}
+
 	prom_printf("instantiating rtas at 0x%x...", base);
 
+	const char *method = rtas_64 ? "instantiate-rtas-64" : "instantiate-rtas";
+
 	if (call_prom_ret("call-method", 3, 2, &entry,
-			  ADDR("instantiate-rtas"),
-			  rtas_inst, base) != 0
-	    || entry == 0) {
+			  ADDR(method), rtas_inst, base) != 0 ||
+			  entry == 0) {
 		prom_printf(" failed\n");
 		return;
 	}
+
 	prom_printf(" done\n");
 
 	reserve_mem(base, size);
@@ -1884,6 +1894,9 @@ static void __init prom_instantiate_rtas(void)
 	val = cpu_to_be32(entry);
 	prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
 		     &val, sizeof(val));
+	val = cpu_to_be32(rtas_64);
+	prom_setprop(rtas_node, "/rtas", "linux,rtas-64",
+		     &val, sizeof(val));
 
 	/* Check if it supports "query-cpu-stopped-state" */
 	if (prom_getprop(rtas_node, "query-cpu-stopped-state",
@@ -1893,6 +1906,7 @@ static void __init prom_instantiate_rtas(void)
 	prom_debug("rtas base     = 0x%x\n", base);
 	prom_debug("rtas entry    = 0x%x\n", entry);
 	prom_debug("rtas size     = 0x%x\n", size);
+	prom_debug("rtas 64-bit   = 0x%x\n", rtas_64);
 
 	prom_debug("prom_instantiate_rtas: end...\n");
 }
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..b7b9bd0b5b43 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -45,6 +45,8 @@
 #include <asm/trace.h>
 #include <asm/udbg.h>
 
+int rtas_64;
+
 struct rtas_filter {
 	/* Indexes into the args buffer, -1 if not used */
 	const int buf_idx1;
@@ -569,6 +571,7 @@ static struct rtas_function rtas_function_table[] __ro_after_init = {
  */
 static DEFINE_RAW_SPINLOCK(rtas_lock);
 static struct rtas_args rtas_args;
+static struct rtas_args_64 rtas_args_64;
 
 /**
  * rtas_function_token() - RTAS function token lookup.
@@ -690,13 +693,48 @@ static const struct rtas_function *rtas_token_to_function(s32 token)
 	return NULL;
 }
 
+static void populate_rtas_args_64(struct rtas_args *args)
+{
+	int i;
+
+	rtas_args_64.token = cpu_to_be64((s64)(s32)be32_to_cpu(args->token));
+	rtas_args_64.nargs = cpu_to_be64((s64)(s32)be32_to_cpu(args->nargs));
+	rtas_args_64.nret  = cpu_to_be64((s64)(s32)be32_to_cpu(args->nret));
+	rtas_args_64.rets  = &rtas_args_64.args[be32_to_cpu(args->nargs)];
+
+	for (i = 0; i < be32_to_cpu(args->nargs); ++i)
+		rtas_args_64.args[i] = cpu_to_be64((s64)(s32)be32_to_cpu(args->args[i]));
+
+	for (i = 0; i < be32_to_cpu(args->nret); ++i)
+		rtas_args_64.rets[i] = 0;
+}
+
+static void rtas_args_copy_64_32(struct rtas_args *args)
+{
+	int i;
+
+	for (i = 0; i < (s32)be64_to_cpu(rtas_args_64.nret); ++i)
+		args->rets[i] = cpu_to_be32((s32)be64_to_cpu(rtas_args_64.rets[i]));
+}
+
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);
 
+static void _do_enter_rtas_64(struct rtas_args *args)
+{
+	populate_rtas_args_64(args);
+	enter_rtas(__pa(&rtas_args_64));
+	rtas_args_copy_64_32(args);
+}
+
 static void __do_enter_rtas(struct rtas_args *args)
 {
-	enter_rtas(__pa(args));
-	srr_regs_clobbered(); /* rtas uses SRRs, invalidate */
+	if (rtas_64)
+		_do_enter_rtas_64(args);
+	else
+		enter_rtas(__pa(args));
+
+	srr_regs_clobbered();
 }
 
 static void __do_enter_rtas_trace(struct rtas_args *args)
@@ -2078,7 +2116,7 @@ void __init rtas_initialize(void)
 int __init early_init_dt_scan_rtas(unsigned long node,
 		const char *uname, int depth, void *data)
 {
-	const u32 *basep, *entryp, *sizep;
+	const u32 *basep, *entryp, *sizep, *val;
 
 	if (depth != 1 || strcmp(uname, "rtas") != 0)
 		return 0;
@@ -2086,6 +2124,10 @@ int __init early_init_dt_scan_rtas(unsigned long node,
 	basep  = of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
 	entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
 	sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
+	val    = of_get_flat_dt_prop(node, "linux,rtas-64", NULL);
+
+	if (*val)
+		rtas_64 = 1;
 
 #ifdef CONFIG_PPC64
 	/* need this feature to decide the crashkernel offset */
diff --git a/arch/powerpc/kernel/rtas_entry.S b/arch/powerpc/kernel/rtas_entry.S
index 6ce95ddadbcd..df776f0103c9 100644
--- a/arch/powerpc/kernel/rtas_entry.S
+++ b/arch/powerpc/kernel/rtas_entry.S
@@ -54,6 +54,10 @@ _ASM_NOKPROBE_SYMBOL(enter_rtas)
 /*
  * 32-bit rtas on 64-bit machines has the additional problem that RTAS may
  * not preserve the upper parts of registers it uses.
+ *
+ * Note: In 64-bit RTAS, the SF bit is set so that RTAS can return
+ * correctly if the return address is above 4 GB. Everything else
+ * works the same as in 32-bit RTAS.
  */
 _GLOBAL(enter_rtas)
 	mflr	r0
@@ -113,7 +117,18 @@ __enter_rtas:
 	 * from the saved MSR value and insert into the value RTAS will use.
 	 */
 	extrdi	r0, r6, 1, 63 - MSR_HV_LG
-	LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)
+
+	LOAD_REG_ADDR(r7, rtas_64)	/* Load the address rtas_64 into r7 */
+	ld      r8, 0(r7)               /* Load the value of rtas_64 from memory into r8 */
+	cmpdi   r8, 0                   /* Compare r8 with 0 (check if rtas_64 is zero) */
+	beq     no_sf_bit               /* Branch to no_sf_bit if rtas_64 is zero */
+	LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI | MSR_SF)	/* r6 = ME|RI|SF */
+	b       continue
+
+no_sf_bit:
+	LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)		/* r6 = ME|RI (NO SF bit in MSR) */
+
+continue:
 	insrdi	r6, r0, 1, 63 - MSR_HV_LG
 
 	li      r0,0
-- 
2.52.0


