Return-Path: <linuxppc-dev+bounces-23047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9759BC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:11:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpbWc600Rz2yZZ;
	Mon, 29 Jun 2026 16:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782713484;
	cv=none; b=TLZGTNz1OdtQDhjxgQ+Uu5avaRPFVU2RpceG9+TG6rSXDAxd0tHJk5dtW1igL9crl1ipvEhs7j5FmeOd2ThY7ZcXRcrSNg4MurDho+8QIERoIE+AwoaVo3CbAvKCzBbAwHrWfpWG9SAIrcXI54bMGJbES6ePN5n3MRpfsU6ASQrFoD8wfytLuPWaa0lFUE2QiExMZIoadJRF+8SxKI2GixVp0n4bdyEo+rnqMWMuMjpdIC4oMeB4uZzhe4O9SpBqddi47zQlHkaHihc59qC+xlkqKwjuZ223UmaiJcnMTmfqZhZGMhNBotB2JnC+ej2PnelTVTT1UIUGlW3l0QqADw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782713484; c=relaxed/relaxed;
	bh=tIKvbUiPmYfFGEIAUtVecoRHpTttmT8MZO704z2E19U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2ECWsly1EC23UXbT6rahBaraKwlZmxOZdT8T17yVnYqaZEKqQOfxZnelQp7YdKccNMM7PTNe5ULWPCGQ4/GzmUKu5nOpCLdcPJeWrRP1PjzLk6IxHpjl++4BtIDxfx/XITLXB0pT4HbjfgYM9U3Lox+SLUD8IvBQDU6mck5w0QRYOTrZpiv7wvAo+owO8uXGMJNWIncII79intNvW58hC+sHQmB67m6/aqeGAW2gE4KGwskRfdN9j3ExpoE+D/M4qpqrghnPyQprIRYnaSdoX7EE4PO3ECb6tRRj58d0JZ5qMdOQ36xv+6Tj82RGPZl43LHtXFKlFjChkMv1ZVGNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EUBHNAsV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EUBHNAsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpbWZ5lRpz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 16:11:22 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3IMb52098884;
	Mon, 29 Jun 2026 06:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tIKvbUiPmYfFGEIAU
	tVecoRHpTttmT8MZO704z2E19U=; b=EUBHNAsVLTD2kqVPHrINpAaFrFLSphmYF
	KKPdGN/JqSKXgkwV9UX3E+YzrwNJE13jEQ65NfMsHUQ0+kC85P+Nw62rCORSCtfB
	y8Ep0wUsuHYDZfyr17GZrZFJVI0LMU6PzLO5z7RJ1WvL06bc/+LptGjeydT2GgNa
	jM7lFN+iEs4NKYbuBC8nqMiXserPVVME7ZydhJ80Eq3pcXm7I+glXXKX47k8HdA8
	zvVJYdtNVaYTASHmz7Jdxd4TgPLBLhdmlMGbanJm5+Itmt0+2m0/J1uiSBMAV0/E
	6ScNLd71SaQC8+OPJl19w0kOEksPXEsEI2xguR5AHva++ymPc0MXg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdqsnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T64dCg026687;
	Mon, 29 Jun 2026 06:11:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq48xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T6BGTD31392498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 06:11:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AC420049;
	Mon, 29 Jun 2026 06:11:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C673C20040;
	Mon, 29 Jun 2026 06:11:14 +0000 (GMT)
Received: from dhcp-9-123-15-26.bl1-in.ibm.com (unknown [9.123.15.26])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 06:11:14 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        shivani@linux.ibm.com, tshah@linux.ibm.com
Subject: [RFC 3/3] powerpc/perf: Add DTS-based event constraints
Date: Mon, 29 Jun 2026 11:40:22 +0530
Message-ID: <20260629061101.43119-4-shivani@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260629061101.43119-1-shivani@linux.ibm.com>
References: <20260629061101.43119-1-shivani@linux.ibm.com>
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
X-Proofpoint-GUID: SjkdUoradBDYWPLeBKSk9M4pA7K4jXcm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfXwstkhr1BAf5h
 7H9AV/d7Iws8jhAxzW6pvCaH0IzNMN45ajqLB+Iw16nlhwl47cwQ8OmnmXXHp4XbyLM2GLck1xO
 FLCr++LhcyCY8z9k8l8tzsXQszzOipw=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a420c88 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IRTuDXuqDS2-8YcwQYEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX+U6n7t5s3GKm
 V2R5emzUHLi0BB/uzCqc47Zkvc2GW33NKGhMw0sKSUgxxQP9GOIE+QSqb7oYc9sh2KBHnsYVsYm
 DoKQUVmoLB4HdVeVl2QWu5UDZ9OjEQOYUXGTB020ordBprIYOtQ3ZBVC/VBsWqSUokPK+upsFgi
 nD2RwzP2K3K5656OjP+JJ2zhyrxrF8grodgwufwkCBvcQ/Lme9+LObIu6TdP2mXCqzfdmkpSK9V
 jgqwcAryXvufrtznNHheAyt9TfXUv/ZlDNMexgYwm3ufBGRJb2k40jRoCRsV+XfM7wmxAfTeTsX
 xWsOR9jF18XoaHPWsqaKjJI/tKiAlFf8MuxvXbirVyw5izyp3H8+3N0rrY2uW8NUjxHA48yISrH
 ntavIhAQ+tTltKdb8cTtDbj80XEv5EGp8DQxUw2OzfyKEJUdc6MSZyTesSZaLCZP3Melyg8zS+n
 hvvrRDfnJC9UhWXbksQ==
X-Proofpoint-ORIG-GUID: SjkdUoradBDYWPLeBKSk9M4pA7K4jXcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290047

Add support for describing PMU event constraints in the device
tree.

Parse constraint definitions from the constraints node and use
them to build PMU scheduling constraints at runtime. Implement
isa207_get_constraint_dts() to validate event combinations and
derive constraint masks and values from the device tree
description.

The constraint system handles:
- PMC restrictions (e.g., PMC5 for instructions, PMC6 for cycles)
- Maximum counter limits
- Cache selector requirements
- EBB (Event-Based Branch) and BHRB (Branch History Rolling Buffer)
  dependencies
- Threshold, sampling, and L1 qualifier constraints
- Radix scope and fabric match constraints
- NC (Next Counter) increment logic

Constraints are conditionally applied based on event properties
(marked events, threshold events, L1 events, BHRB requests) and
CPU features (ARCH_31 for radix scope).

The parse_constraints() function reads constraint definitions from
DTS nodes including pmc-constraints, sample, threshold, cache, ebb,
bhrb, l1-qualifier, fab-match, radix-scope, and nc. Each constraint
field specifies event masks, shifts, constraint masks, and shifts
to build the final constraint value.

This allows PMU constraint information to be described in DTS
rather than being hardcoded in the PMU implementation.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---
 arch/powerpc/include/asm/dts_pmu.h |  53 +++++++++
 arch/powerpc/perf/Makefile         |   1 +
 arch/powerpc/perf/dts_pmu.c        | 177 ++++++++++++++++++++++++++++-
 arch/powerpc/perf/isa207-common.c  | 141 +++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h  |   2 +
 5 files changed, 370 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dts_pmu.h b/arch/powerpc/include/asm/dts_pmu.h
index 1309a45ce604..5632c4f8f748 100644
--- a/arch/powerpc/include/asm/dts_pmu.h
+++ b/arch/powerpc/include/asm/dts_pmu.h
@@ -7,6 +7,13 @@
 #define MAX_MMCR   5
 #define MAX_DTS_EVENTS 32
 #define MAX_PMU_COUNTERS 6
+#define DTS_COND_ALWAYS      0
+#define DTS_COND_MARKED      1
+#define DTS_COND_THRESHOLD   2
+#define DTS_COND_L1          3
+#define DTS_COND_BHRB        4
+#define DTS_COND_CACHE       5
+#define DTS_COND_RADIX       6
 
 struct dts_field_map {
 	u32 bits_start, bits_end;
@@ -21,9 +28,55 @@ extern int field_count;
 
 extern u32 mmcr_regs_sprs[MAX_MMCR];
 extern int mmcr_count;
+extern struct dts_constraint_map *constraint_maps;
+extern int constraint_map_count;
 
 int compute_mmcr_dts(u64 event[], int n_ev,
 			unsigned int hwc[], struct mmcr_regs *mmcr,
 			struct perf_event *pevents[], u32 flags);
 
+struct dts_constraint_field {
+	u64 event_mask, constraint_mask;
+	u32 event_shift, constraint_shift, condition;
+};
+
+struct dts_constraint_map {
+	struct dts_constraint_field field;
+};
+
+struct restricted_counter {
+	u32 pmc;
+	u64 event;
+};
+
+struct dts_threshold_constraints {
+	bool supported;
+	struct dts_constraint_field thresh_sel, thresh_cmp, thresh_ctl;
+};
+
+struct dts_nc_constraints {
+	u64 mask;
+	u32 shift, increment;
+};
+
+struct dts_pmu_constraints {
+	u32 max_counter;
+
+	struct restricted_counter restricted[8];
+	int num_restricted;
+
+	bool require_cache_selector_zero;
+	u32 cache_selector_mask;
+
+	bool require_pmc_for_ebb, bhrb_requires_ebb;
+
+	struct dts_constraint_field sample, ebb, bhrb, l1_qualifier,
+				    fab_match, radix_scope, cache_group,
+				    cache_pmc4, l2l3_group;
+
+	struct dts_threshold_constraints threshold;
+	struct dts_nc_constraints nc;
+};
+
+extern struct dts_pmu_constraints dts_constraints;
 #endif
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 537f4b87cffe..7b474bd0d090 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -9,6 +9,7 @@ obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
 				   isa207-common.o power8-pmu.o power9-pmu.o \
 				   generic-compat-pmu.o power10-pmu.o bhrb.o \
 				   dts_pmu.o
+
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
diff --git a/arch/powerpc/perf/dts_pmu.c b/arch/powerpc/perf/dts_pmu.c
index 39107af6d467..0faea573f144 100644
--- a/arch/powerpc/perf/dts_pmu.c
+++ b/arch/powerpc/perf/dts_pmu.c
@@ -14,10 +14,13 @@
 
 extern void unregister_power_pmu(struct power_pmu *pmu);
 static u32 pmu_dts_nr_pmc;
+struct dts_pmu_constraints dts_constraints;
 struct dts_field_map pmcsel_map;
 struct dts_field_map pmc_map;
 struct dts_field_map field_maps[MAX_FIELDS];
 int field_count;
+struct dts_constraint_map *constraint_maps;
+int constraint_map_count;
 
 u32 mmcr_regs_sprs[MAX_MMCR];
 int mmcr_count;
@@ -32,6 +35,172 @@ static struct pmu_dts_event *dts_events[MAX_DTS_EVENTS];
 static struct attribute *pmu_dts_events_attrs[MAX_DTS_EVENTS + 1];
 static int dts_event_count;
 
+/* Constraints Structure */
+static void parse_constraint_field(struct device_node *np,
+				struct dts_constraint_field *field)
+{
+	u32 val32[2] = {0};
+
+	if (!np)
+		return;
+
+	/* initialize */
+	field->event_mask = 0;
+	field->event_shift = 0;
+	field->constraint_mask = 0;
+	field->constraint_shift = 0;
+
+	/* event-mask */
+	if (!of_property_read_u32(np, "event-mask", &val32[0]))
+		field->event_mask = val32[0];
+
+	/* event-shift */
+	of_property_read_u32(np, "event-shift", &field->event_shift);
+
+	/* constraint-mask */
+	if (!of_property_read_u32_array(np, "constraint-mask", val32, 2))
+		field->constraint_mask = ((u64)val32[0] << 32) | val32[1];
+	else if (!of_property_read_u32(np, "constraint-mask", &val32[0]))
+		field->constraint_mask = val32[0];
+
+	/* constraint-shift */
+	of_property_read_u32(np, "constraint-shift", &field->constraint_shift);
+
+	of_property_read_u32(np, "condition", &field->condition);
+
+	if (constraint_maps && constraint_map_count < 16) {
+		memcpy(&constraint_maps[constraint_map_count].field,
+					field, sizeof(*field));
+		constraint_map_count++;
+	}
+}
+
+static void parse_constraints(struct device_node *pmu_np)
+{
+	struct device_node *np;
+	struct device_node *child;
+	int i = 0;
+
+	constraint_maps = kcalloc(16, sizeof(*constraint_maps), GFP_KERNEL);
+
+	constraint_map_count = 0;
+
+	np = of_get_child_by_name(pmu_np, "constraints");
+	if (!np)
+		return;
+
+	/* PMC constraints */
+	child = of_get_child_by_name(np, "pmc-constraints");
+
+	if (child) {
+		of_property_read_u32(child,
+					"max-counter", &dts_constraints.max_counter);
+
+		for_each_child_of_node(child, child) {
+			of_property_read_u32(child, "pmc",
+					&dts_constraints.restricted[i].pmc);
+
+			of_property_read_u64(child, "valid-events",
+					&dts_constraints.restricted[i].event);
+			i++;
+		}
+
+		dts_constraints.restricted[0].event = 0x500fa;
+		dts_constraints.restricted[1].event = 0x600f4;
+		dts_constraints.num_restricted = i;
+	}
+
+	/* sample */
+	child = of_get_child_by_name(np, "sample");
+
+	if (child)
+		parse_constraint_field(child, &dts_constraints.sample);
+
+	/* threshold */
+	child = of_get_child_by_name(np, "threshold");
+
+	if (child) {
+		dts_constraints.threshold.supported =
+				of_property_read_bool(child, "supported");
+
+		parse_constraint_field(of_get_child_by_name(child, "thresh-sel"),
+					&dts_constraints.threshold.thresh_sel);
+
+		parse_constraint_field(of_get_child_by_name(child, "thresh-cmp"),
+					&dts_constraints.threshold.thresh_cmp);
+
+		parse_constraint_field(of_get_child_by_name(child, "thresh-ctl"),
+					&dts_constraints.threshold.thresh_ctl);
+	}
+
+	/* cache */
+	child = of_get_child_by_name(np, "cache");
+
+	if (child) {
+		of_property_read_u32(child, "cache-selector-mask",
+					&dts_constraints.cache_selector_mask);
+
+		dts_constraints.require_cache_selector_zero =
+					of_property_read_bool(child, "require-cache-selector-zero");
+
+		/* cache-group */
+		parse_constraint_field(of_get_child_by_name(child, "cache-group"),
+					&dts_constraints.cache_group);
+
+		/* cache-pmc4 */
+		parse_constraint_field(of_get_child_by_name(child, "cache-pmc4"),
+					&dts_constraints.cache_pmc4);
+
+		/* l2l3-group */
+		parse_constraint_field(of_get_child_by_name(child, "l2l3-group"),
+					&dts_constraints.l2l3_group);
+	}
+
+	/* ebb */
+	child = of_get_child_by_name(np, "ebb");
+
+	if (child) {
+		parse_constraint_field(child, &dts_constraints.ebb);
+
+		dts_constraints.require_pmc_for_ebb =
+					of_property_read_bool(child, "require-pmc");
+	}
+
+	/* bhrb */
+	child = of_get_child_by_name(np, "bhrb");
+
+	if (child) {
+		parse_constraint_field(child, &dts_constraints.bhrb);
+
+		dts_constraints.bhrb_requires_ebb =
+					of_property_read_bool(child, "requires-ebb");
+	}
+
+	/* others */
+	parse_constraint_field(of_get_child_by_name(np, "l1-qualifier"),
+					&dts_constraints.l1_qualifier);
+
+	parse_constraint_field(of_get_child_by_name(np, "fab-match"),
+					&dts_constraints.fab_match);
+
+	parse_constraint_field(of_get_child_by_name(np, "radix-scope"),
+					&dts_constraints.radix_scope);
+
+	/* NC */
+	child = of_get_child_by_name(np, "nc");
+
+	if (child) {
+		of_property_read_u64(child, "mask",
+					&dts_constraints.nc.mask);
+
+		of_property_read_u32(child, "shift",
+					&dts_constraints.nc.shift);
+
+		of_property_read_u32(child, "increment",
+					&dts_constraints.nc.increment);
+	}
+}
+
 static ssize_t pmu_dts_event_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -124,8 +293,7 @@ static struct power_pmu dts_pmu = {
 	.group_constraint_mask  = CNST_CACHE_PMC4_MASK,
 	.group_constraint_val   = CNST_CACHE_PMC4_VAL,
 	.compute_mmcr           = dts_compute_mmcr,
-	// .config_bhrb         = power10_config_bhrb,
-	// .bhrb_filter_map     = power10_bhrb_filte-r_map,
+	.get_constraint         = isa207_get_constraint_dts,
 	.get_alternatives       = dts_get_alternatives,
 	.get_mem_data_src       = isa207_get_mem_data_src,
 	.get_mem_weight         = isa207_get_mem_weight,
@@ -134,9 +302,7 @@ static struct power_pmu dts_pmu = {
 					PPMU_ARCH_31 | PPMU_HAS_ATTR_CONFIG1 |
 					PPMU_P10,
 	.attr_groups            = pmu_dts_attr_groups,
-	//.bhrb_nr              = 32,
 	.capabilities           = PERF_PMU_CAP_EXTENDED_REGS,
-	//.check_attr_config    = power10_check_attr_config,
 };
 
 /* Device Tree match */
@@ -175,6 +341,9 @@ static int pmu_dts_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* For format parsing */
+	parse_constraints(np);
+
 	if (of_property_read_u32(np, "nr_pmc", &pmu_dts_nr_pmc)) {
 		pr_err("pmu_dts: nr_pmc not found in %s\n", np->full_name);
 		return -EINVAL;
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index f912432fd6db..1d93f9e5c5f2 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -748,6 +748,147 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 	return 0;
 }
 
+static void apply_constraint(u64 event,
+			struct dts_constraint_field *field,
+			unsigned long *mask,
+			unsigned long *value)
+{
+	u64 extracted;
+
+	extracted = (event >> field->event_shift) & field->event_mask;
+	*mask |= field->constraint_mask;
+	*value |= (extracted << field->constraint_shift);
+}
+
+static bool constraint_enabled(struct dts_constraint_map *m, u64 event)
+{
+	switch (m->field.condition) {
+
+	case DTS_COND_ALWAYS:
+		return true;
+
+	case DTS_COND_MARKED:
+		return is_event_marked(event);
+
+	case DTS_COND_THRESHOLD:
+		return event_is_threshold(event);
+
+	case DTS_COND_L1:
+		return (event & EVENT_IS_L1);
+
+	case DTS_COND_BHRB:
+		return (event & EVENT_WANTS_BHRB);
+
+	case DTS_COND_RADIX:
+		return cpu_has_feature(CPU_FTR_ARCH_31);
+
+	default:
+		return false;
+	}
+	return false;
+}
+
+int isa207_get_constraint_dts(u64 event,
+			      unsigned long *maskp,
+			      unsigned long *valp,
+			      u64 event_config1)
+{
+	unsigned int pmc, unit, cache, ebb;
+	unsigned long mask = 0;
+	unsigned long value = 0;
+	u64 base_event;
+	int i, valid = 0;
+
+	pmc = (event >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+	unit = (event >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
+	cache = (event >> EVENT_CACHE_SEL_SHIFT) & EVENT_CACHE_SEL_MASK;
+	ebb = (event >> EVENT_EBB_SHIFT) & EVENT_EBB_MASK;
+	base_event = event & ~EVENT_LINUX_MASK;
+
+	/* max counter */
+	if (pmc > dts_constraints.max_counter)
+		return -1;
+
+	/* restricted counters */
+	if (pmc >= 5) {
+		valid = 0;
+
+		for (i = 0;
+			i < dts_constraints.num_restricted;
+			i++) {
+
+			if (dts_constraints.restricted[i].pmc == pmc &&
+					dts_constraints.restricted[i].event == base_event) {
+				valid = 1;
+				break;
+			}
+		}
+
+		if (!valid)
+			return -1;
+	}
+
+	/* cache selector */
+	if (dts_constraints.require_cache_selector_zero &&
+			(cache & dts_constraints.cache_selector_mask))
+		return -1;
+
+	/* EBB */
+	if (dts_constraints.require_pmc_for_ebb && !pmc && ebb)
+		return -1;
+
+	/* BHRB */
+	if ((event & EVENT_WANTS_BHRB) &&
+	    dts_constraints.bhrb_requires_ebb && !ebb)
+		return -1;
+
+	/* PMC */
+	if (pmc) {
+		mask |= CNST_PMC_MASK(pmc);
+		value |= CNST_PMC_VAL(pmc);
+
+		if (pmc >= 5)
+			goto post_general_constraints;
+	}
+
+	/* NC */
+	if (pmc <= 4) {
+		mask |= dts_constraints.nc.mask;
+
+		value |=
+			(dts_constraints.nc.increment << dts_constraints.nc.shift);
+	}
+
+	/* cache / l2l3 */
+	if (unit >= 6 && unit <= 9) {
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			apply_constraint (event, &dts_constraints.l2l3_group,
+				&mask, &value);
+		} else {
+			apply_constraint (event, &dts_constraints.cache_group,
+				&mask, &value);
+
+			if (pmc == 4)
+				mask |= dts_constraints.cache_pmc4.constraint_mask;
+		}
+	}
+
+post_general_constraints:
+
+	for (i = 0; i < constraint_map_count; i++) {
+		if (!constraint_enabled(&constraint_maps[i], event))
+			continue;
+
+		apply_constraint(event, &constraint_maps[i].field,
+				&mask, &value);
+	}
+
+	*maskp = mask;
+	*valp = value;
+
+	return 0;
+}
+
 int compute_mmcr_dts(u64 event[], int n_ev,
 			unsigned int hwc[], struct mmcr_regs *mmcr,
 			struct perf_event *pevents[], u32 flags)
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index e9a7c5a39ec2..99cf1a7bac20 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -278,6 +278,8 @@
 #define REM				P(REMOTE, REMOTE)
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp, u64 event_config1);
+int isa207_get_constraint_dts(u64 event, unsigned long *maskp,
+				unsigned long *valp, u64 event_config1);
 int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], struct mmcr_regs *mmcr,
 				struct perf_event *pevents[], u32 flags);
-- 
2.54.0


