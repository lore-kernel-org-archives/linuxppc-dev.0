Return-Path: <linuxppc-dev+bounces-23049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4A0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:11:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpbWg2VD1z2yh4;
	Mon, 29 Jun 2026 16:11:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782713487;
	cv=none; b=bJUpk/BHrIEJnEf1491pSqlNYg67TjKMYI9sbYoJl6C4uXixwWJEXwV6JztmiAp/CxCs4PVieOuiZccPLjaO6X2pdIegPnb10kRdTmrZYVtEon0LfmK4JBysInHE7KqYnNKU5w/xYih4HMC2zLzU8VRO+ng7MyZ+8BD23Upjb5BXpTuJFrQfC1m33/zlI+CrWCrQXsuAiU1bVckzzQ9N9rG0nACDgxup1aOor3lMUT+gE2ULApieHpSgKatg6kzsvmAarRAme8cO0n4O6cPtBCcIShGo+pXUQg0xAh3I+QDaZ6ynlYuwEAlXtwMK6v4RFSOOk/kmeOFOmdL04zCN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782713487; c=relaxed/relaxed;
	bh=PUzqbwL73PP2B/iVe2PVXcttAqvBu27+NvoD+/z1xK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1VM1ibOVTMbOgqhJgosT5tgFRcgm7Qi8YJd7eSdzx+G76XWBoLuzQOALBVmXtTzTwyV6cmcTN8b0e0dyerW7NMlYoQa1H09AOkzpCsnS/zjf710odHOHytURP6z4Os8B6ookllcxY39wIexMscv82iEb+jVrtTSP/tv/FvTIO2XJLv/VrNHUi6zxtsSDYXIyulv+nAHKhso8/wpRsuFGA3C9HAR8w4mz7tGt0me3D3spqigr8BQYRVPEvct0wGL/02qWKY60eVAfIuAYY30Ki/eMQXhuJHRM21foLUj+gf5y8A1fo6GLpZlDJlkaqClkI9dA8FBY+642nvHr57lRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X694PY7A; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X694PY7A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpbWZ4h8dz2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 16:11:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3JTOM1993607;
	Mon, 29 Jun 2026 06:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PUzqbw
	L73PP2B/iVe2PVXcttAqvBu27+NvoD+/z1xK8=; b=X694PY7AAtOX4MyXz2AXdc
	Kb6/8LsTlI+QJ4HP9D+nKXyDp1JEQ5iuHBHi6z1gLS2/UPIWfmmV9dqwkvaDivs+
	yQzH8eA4RfIOzwpF/5epY4zUBXJAsnMFr6tcyBuggiTUcctXdpf+BIZiCTWmY3Hs
	Xzd9LgraEX57aURuiofX93Yuuo2sWnwdt6Hg0JBH74CRIOAS7qbc5q663O74ITzL
	1KDXq3l2LejqarAovgDQH5ecfOrsLLdQlA5OZsYWNxwjURvSniUxQct20TzMbceV
	39yMaaJDEjUFL31XnnWteHsr2y1x8VBzoPnntM7cl78u/K/cAgdXN79QSbRq0fbw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26reqk51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T64gj1000519;
	Mon, 29 Jun 2026 06:11:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sujv3b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T6BE3D49807668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 06:11:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7732220049;
	Mon, 29 Jun 2026 06:11:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2494720040;
	Mon, 29 Jun 2026 06:11:13 +0000 (GMT)
Received: from dhcp-9-123-15-26.bl1-in.ibm.com (unknown [9.123.15.26])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 06:11:12 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        shivani@linux.ibm.com, tshah@linux.ibm.com
Subject: [RFC 2/3] powerpc/perf: Add DTS-based MMCR computation
Date: Mon, 29 Jun 2026 11:40:21 +0530
Message-ID: <20260629061101.43119-3-shivani@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a420c87 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CYhDoN-Q6M2LgkGTzS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vrEXBY2CW5hn4UVOx1alVzUe1fC8LI4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfXxDJr/HujwX93
 7G4654H0OTp74feZjv9Od/z9t1CLqvgPN84HPiVtifp2HFYGcnwaN3uYi29HxDiXcvIMFMTlH1I
 R29b+yL5u1r2JU1w9YvEEkMZOuR70wdn5HvrYDtzYVIK3ICnoTbReJKxWkhdmeXP7gMk6Hk5uVO
 ajwL8ygVZu9PUhonjwdQ9eP/CJLqk0Wy2sL1drYgl5vf50KvrPsDy0xGYNYFaLyFedXgQYqE+jY
 OHytu6VpLb6zdDWlYSx8mzGCpbNN1jtE3CLQDIPY5uy0AVEV4+VpGhUuJMiYcDzO/wroTgU270h
 sKachGkEPrk8MAt7+RbB8tQkSATm0Rolo9/4bpfvat1pzA7cayJ80YeUzIzIfqmOAEM0F4FzrCp
 pA/ojF9tmgvfdFOThoUjGm83QLEJFxGi90ghnfEiYsVkJrNLf3NS2L3Ttgk10F2dKz7zSzsCDKV
 fF0Q8ZYRmnWrtUP802A==
X-Proofpoint-GUID: vrEXBY2CW5hn4UVOx1alVzUe1fC8LI4W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfXy/Bkn8gyV/as
 NMboR/0AzpbOWuc9Mmw3Rf8PxhgsHzcmlt8G5eItq2OIpkzas1T5n8TdsV8itAtWaTDpvrX1aYs
 Dh3Woy3u1qUqaonaavDaIfqADAK1kfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290047

Add support for computing MMCR register values from event
descriptions provided in the device tree.

Parse the evt_code_format node to build mappings between event
code fields and MMCR programming fields. Use these mappings to
generate MMCR register values dynamically from the event code.

This allows event encodings and MMCR programming information to
be described in the device tree rather than being hardcoded in
the PMU implementation.

Add compute_mmcr_dts() to isa207-common.c to compute MMCR register
values dynamically from event codes described in the device tree.

The function extracts PMC and field values from the event code using
field_maps[], which are populated by parsing the evt_code_format node
in the DTS during pmu_dts_probe(). Each field entry captures the bit
range in the event code, the target MMCR register, and the shift
position to use when programming the register.

For non-PMC, non-MMCRA fields, the shift is computed either using a
per-PMC target_field_shift formula (target_field_base - pmc *
target_field_shift) or a fixed pgm_start offset. MMCRA and PMC fields
always use the fixed pgm_start path.

MMCR2 privilege filtering (FCP, FCS, FCH) is applied per-event based
on perf_event attr exclude_* flags.

Wire up the DTS PMU to use dts_compute_mmcr() as its compute_mmcr
callback, and carry the ISA207 constraint fields, alternatives,
memory data source and weight helpers, and PPMU flags to match the
Power10 PMU profile.

Also temporarily comment out the duplicate compute_mmcr call site and
the surrounding mtspr block in power_pmu_enable() while the DTS path
is brought up; these will be restored once the transition is complete.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---
 arch/powerpc/include/asm/dts_pmu.h |  17 ++++
 arch/powerpc/perf/dts_pmu.c        | 118 +++++++++++++++++++++++++++-
 arch/powerpc/perf/isa207-common.c  | 120 +++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h  |   2 +
 4 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dts_pmu.h b/arch/powerpc/include/asm/dts_pmu.h
index 791dda370de8..1309a45ce604 100644
--- a/arch/powerpc/include/asm/dts_pmu.h
+++ b/arch/powerpc/include/asm/dts_pmu.h
@@ -3,10 +3,27 @@
 
 #include <linux/types.h>
 
+#define MAX_FIELDS 17
 #define MAX_MMCR   5
 #define MAX_DTS_EVENTS 32
 #define MAX_PMU_COUNTERS 6
 
+struct dts_field_map {
+	u32 bits_start, bits_end;
+	u32 target_field_base, target_field_shift;
+	u32 pgm_start, mmcr;
+	bool use_target_field_shift, is_pmc;
+	char name[32];
+};
+
+extern struct dts_field_map field_maps[MAX_FIELDS];
+extern int field_count;
+
 extern u32 mmcr_regs_sprs[MAX_MMCR];
 extern int mmcr_count;
+
+int compute_mmcr_dts(u64 event[], int n_ev,
+			unsigned int hwc[], struct mmcr_regs *mmcr,
+			struct perf_event *pevents[], u32 flags);
+
 #endif
diff --git a/arch/powerpc/perf/dts_pmu.c b/arch/powerpc/perf/dts_pmu.c
index 67eabd5ec6e5..39107af6d467 100644
--- a/arch/powerpc/perf/dts_pmu.c
+++ b/arch/powerpc/perf/dts_pmu.c
@@ -10,10 +10,14 @@
 #include <linux/string.h>
 #include <asm/reg.h>
 #include <asm/dts_pmu.h>
-
+#include "isa207-common.h"
 
 extern void unregister_power_pmu(struct power_pmu *pmu);
 static u32 pmu_dts_nr_pmc;
+struct dts_field_map pmcsel_map;
+struct dts_field_map pmc_map;
+struct dts_field_map field_maps[MAX_FIELDS];
+int field_count;
 
 u32 mmcr_regs_sprs[MAX_MMCR];
 int mmcr_count;
@@ -84,10 +88,55 @@ static const struct attribute_group *pmu_dts_attr_groups[] = {
 	NULL,
 };
 
+static int dts_compute_mmcr(u64 event[], int n_ev,
+					unsigned int hwc[], struct mmcr_regs *mmcr,
+					struct perf_event *pevents[], u32 flags)
+{
+	int ret;
+
+	ret = compute_mmcr_dts(event, n_ev, hwc, mmcr, pevents, flags);
+	if (!ret)
+		mmcr->mmcr0 |= MMCR0_C56RUN;
+	return ret;
+}
+
+static const unsigned int dts_event_alternatives[][MAX_ALT] = {
+	{ 0x600f4, 0x1001e },
+};
+
+static int dts_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int num_alt = 0;
+
+	num_alt = isa207_get_alternatives(event, alt,
+					  ARRAY_SIZE(dts_event_alternatives), flags,
+					  dts_event_alternatives);
+
+	return num_alt;
+}
+
 static struct power_pmu dts_pmu = {
-	.name           = "cpu_dts",
-	.n_counter      = MAX_PMU_COUNTERS,
-	.attr_groups    = pmu_dts_attr_groups,
+	.name                   = "cpu_dts",
+	.n_counter              = MAX_PMU_COUNTERS,
+	.attr_groups            = pmu_dts_attr_groups,
+	.add_fields             = ISA207_ADD_FIELDS,
+	.test_adder             = ISA207_TEST_ADDER,
+	.group_constraint_mask  = CNST_CACHE_PMC4_MASK,
+	.group_constraint_val   = CNST_CACHE_PMC4_VAL,
+	.compute_mmcr           = dts_compute_mmcr,
+	// .config_bhrb         = power10_config_bhrb,
+	// .bhrb_filter_map     = power10_bhrb_filte-r_map,
+	.get_alternatives       = dts_get_alternatives,
+	.get_mem_data_src       = isa207_get_mem_data_src,
+	.get_mem_weight         = isa207_get_mem_weight,
+	.disable_pmc            = isa207_disable_pmc,
+	.flags                  = PPMU_HAS_SIER | PPMU_ARCH_207S |
+					PPMU_ARCH_31 | PPMU_HAS_ATTR_CONFIG1 |
+					PPMU_P10,
+	.attr_groups            = pmu_dts_attr_groups,
+	//.bhrb_nr              = 32,
+	.capabilities           = PERF_PMU_CAP_EXTENDED_REGS,
+	//.check_attr_config    = power10_check_attr_config,
 };
 
 /* Device Tree match */
@@ -108,6 +157,8 @@ static int pmu_dts_probe(struct platform_device *pdev)
 	u32 code64[2];
 	u32 code128[4];
 	int cells;
+	struct device_node *fmt_np, *field_np;
+	u32 bits[2], pgm[2];
 	const char *str;
 
 	pr_info("PMU DTS probe node = %s\n", np->full_name);
@@ -170,6 +221,65 @@ static int pmu_dts_probe(struct platform_device *pdev)
 	}
 
 	/* Parse events */
+	fmt_np = of_get_child_by_name(np, "evt_code_format");
+	if (!fmt_np) {
+		pr_err("pmu_dts: no evt_code_format node\n");
+		return -EINVAL;
+	}
+
+	field_count = 0;
+	for_each_child_of_node(fmt_np, field_np) {
+
+		struct dts_field_map *f = &field_maps[field_count];
+
+		printk("field_np->name is %s\n", field_np->name);
+		snprintf(f->name, sizeof(f->name), "%s", field_np->name);
+		f->is_pmc = false;
+		f->use_target_field_shift = false;
+
+		/* Identify PMC field */
+		if (!strcmp(field_np->name, "PMCx"))
+			f->is_pmc = true;
+
+		if (of_property_read_u32_array(field_np, "bits", bits, 2))
+			continue;
+
+		f->bits_start = bits[0];
+		f->bits_end   = bits[1];
+
+		if (of_property_read_u32(field_np, "mmcr", &f->mmcr))
+			continue;
+
+	/* Check target_field_shift-based mapping */
+		if (!f->is_pmc && f->mmcr != 4) {
+			if (!of_property_read_u32(field_np, "target_field_base",
+					&f->target_field_base)) {
+				of_property_read_u32(field_np, "target_field_shift",
+					&f->target_field_shift);
+				f->use_target_field_shift = true;
+
+			} else {
+				if (!of_property_read_u32_array(field_np, "target_fields", pgm, 2))
+					f->pgm_start = pgm[0];
+				else
+					f->pgm_start = 0;
+			}
+
+		} else {
+			/* MMCRA or PMC field → no target_field_shift */
+			if (!of_property_read_u32_array(field_np, "target_fields", pgm, 2))
+				f->pgm_start = pgm[0];
+			else
+				f->pgm_start = 0;
+
+			f->use_target_field_shift = false;
+		}
+
+		field_count++;
+		if (field_count >= MAX_FIELDS)
+			break;
+	}
+
 	events_np = of_get_child_by_name(np, "events");
 	if (!events_np) {
 		pr_err("pmu_dts: no events node found\n");
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index e11d1bbbc27b..f912432fd6db 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -80,6 +80,11 @@ static unsigned long sdar_mod_val(u64 event)
 	return p9_SDAR_MODE(event);
 }
 
+static u64 extract_bits(u64 val, int start, int end)
+{
+	return (val >> start) & ((1ULL << (end - start + 1)) - 1);
+}
+
 static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 {
 	/*
@@ -743,6 +748,121 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 	return 0;
 }
 
+int compute_mmcr_dts(u64 event[], int n_ev,
+			unsigned int hwc[], struct mmcr_regs *mmcr,
+			struct perf_event *pevents[], u32 flags)
+{
+	u64 mmcr_val[MAX_MMCR] = {0};
+	u32 pmc = 0, pmc_inuse = 0;
+	int i, ev;
+	u32 pmc_arr[MAX_HWEVENTS] = {0};
+
+	for (ev = 0; ev < n_ev; ev++) {
+		pmc = (event[ev] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+		pmc_arr[ev] = pmc;
+		if (pmc)
+			pmc_inuse |= 1 << pmc;
+
+		hwc[ev] = pmc - 1;
+	}
+
+	/*
+	 * Disable bhrb unless explicitly requested
+	 * by setting MMCRA (BHRBRD) bit.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_31))
+		mmcr->mmcra |= MMCRA_BHRB_DISABLE;
+
+	if (!pmc) {
+		for (pmc = 1; pmc <= 4; ++pmc) {
+			if (!(pmc_inuse & (1 << pmc)))
+				break;
+		}
+
+		pmc_inuse |= 1 << pmc;
+	}
+
+	/* Extract PMC from DTS field */
+	for (i = 0; i < field_count; i++) {
+		struct dts_field_map *f = &field_maps[i];
+
+		if (f->is_pmc) {
+			pmc = extract_bits(event[0], f->bits_start, f->bits_end);
+			break;
+		}
+	}
+	for (ev = 0; ev < n_ev; ev++) {
+		pmc = pmc_arr[ev];
+
+		for (i = 0; i < field_count; i++) {
+			struct dts_field_map *f = &field_maps[i];
+			u64 val, shift;
+
+			val = extract_bits(event[ev], f->bits_start, f->bits_end);
+			if (f->is_pmc)
+				continue;
+
+			if (pmc == 5 || pmc == 6)
+				continue;
+
+			if (f->use_target_field_shift)
+				shift = f->target_field_base - (pmc * f->target_field_shift);
+			else
+				shift = f->pgm_start;
+
+			mmcr_val[f->mmcr] |= (val << shift);
+		}
+
+		/* MMCR2 privilege filtering */
+		if (pmc <= 6 && pevents && pevents[ev]) {
+
+			if (pevents[ev]->attr.exclude_user)
+				mmcr_val[2] |= MMCR2_FCP(pmc);
+
+			if (pevents[ev]->attr.exclude_hv)
+				mmcr_val[2] |= MMCR2_FCH(pmc);
+
+			if (pevents[ev]->attr.exclude_kernel) {
+				if (cpu_has_feature(CPU_FTR_HVMODE))
+					mmcr_val[2] |= MMCR2_FCH(pmc);
+				else
+					mmcr_val[2] |= MMCR2_FCS(pmc);
+			}
+		}
+	}
+
+	mmcr->mmcr0 = 0;
+
+	/* pmc_inuse is 1-based */
+	if (pmc_inuse & 2)
+		mmcr->mmcr0 = MMCR0_PMC1CE;
+
+	if (pmc_inuse & 0x7c)
+		mmcr->mmcr0 |= MMCR0_PMCjCE;
+
+	/* If we're not using PMC 5 or 6, freeze them */
+	if (!(pmc_inuse & 0x60))
+		mmcr->mmcr0 |= MMCR0_FC56;
+
+	/*
+	 * Set mmcr0 (PMCCEXT) for p10 which
+	 * will restrict access to group B registers
+	 * when MMCR0 PMCC=0b00.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_31))
+		mmcr->mmcr0 |= MMCR0_PMCCEXT;
+
+	/*
+	 * Many places in core-book3s uses cpuhw->mmcr for enabling events
+	 * Till we move away completely to DTS, maintain values in cpu->mmcr
+	 */
+	mmcr->mmcr1 = mmcr_val[1];
+	mmcr->mmcra = mmcr_val[4];
+	mmcr->mmcr2 = mmcr_val[2];
+	mmcr->mmcr3 = mmcr_val[3];
+	return 0;
+}
+
 void isa207_disable_pmc(unsigned int pmc, struct mmcr_regs *mmcr)
 {
 	if (pmc <= 3)
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index f594fa6580d1..e9a7c5a39ec2 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -281,6 +281,8 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp,
 int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], struct mmcr_regs *mmcr,
 				struct perf_event *pevents[], u32 flags);
+int compute_mmcr_dts(u64 event[], int n_ev, unsigned int hwc[], struct mmcr_regs *mmcr,
+				struct perf_event *pevents[], u32 flags);
 void isa207_disable_pmc(unsigned int pmc, struct mmcr_regs *mmcr);
 int isa207_get_alternatives(u64 event, u64 alt[], int size, unsigned int flags,
 					const unsigned int ev_alt[][MAX_ALT]);
-- 
2.54.0


