Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AADEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 06:32:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D354F20818
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chwskYTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D354F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vWp00WqszDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 17:32:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=rashmica.g@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="chwskYTV"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vWm91xY2zDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 17:30:49 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so2485835pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Feb 2019 22:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FgmIibRIauQpilafnQmrFzF5n4x71dTaARn70yO8/Ew=;
 b=chwskYTVK7MqlDmj6pV3EabvchkvDLyobBprL+sv1/artUuDi/L1dosMxi2IGYau0/
 E8Q6phj0jcmYF/xbqzPRive9szD/biQLM0FREQS9JvaXUXjNpxs4gRGwDVgs48zGCc6A
 NFOuRPuUGCHr9x/kSnIgLW00UtFXGJduTbqKVVbA9Zwq4+0QSXf7e0aBV7Ouzys+oCBp
 njYUGZU9ET7epxya9H8/cDoSUXz04911poBAN7hr1vCuYeEflLu2f5HkdODxJToSiPzt
 eS35UoHujXNG/heGYKS/5gspXD/l2QQK8iiuzbC6/SrC7Osfb3EjubrI8GBDN4M04cDt
 oOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FgmIibRIauQpilafnQmrFzF5n4x71dTaARn70yO8/Ew=;
 b=mi2e8647xqkj/AfI/IPI7kdJAetGxtvnetznNvMFLGKqBy+pVkCWMzkrfPYBs4fjjw
 jRs8cpK9HQxtL9gMtwcv+ra2HpodO3xBPd9x3AzsFySoym1CsRKCemiLUDC7GMjMMyFH
 uQAQ8kkW9HRgPc8iZZvRguJLmYHk4HNUiW8pxX5T+OE+7Ix/PGhi7awE15G773gc2Z57
 wOq2y1Q5u1mJZ3ouLWBJ+S9OIV6VW+Jl346IWpbGyCvQsFNq5tottxoE0wLODVaiiS29
 R8fGlWS5a7f+cpdVBpU0KZIju7k+WwVW8zDMTkQMF1bODZGxZKuTou5fMzGnKelO0fwx
 Ir8Q==
X-Gm-Message-State: AHQUAuYKcF/AlqhWSy+QcxD1icHSQtlV77QDx3zlrHlwk+K3Dp5VLcc5
 xmht5B4BfBmQR7DH5OrMz9f57C89
X-Google-Smtp-Source: AHgI3IZoqClpf0d3zi4ZO/BXZ/APOUjMKuDDY+tLzpu6qrdBn8+tKVE9F6re2QQJms9Tq5pYz8vW9g==
X-Received: by 2002:a62:5b44:: with SMTP id p65mr8856076pfb.47.1549434646875; 
 Tue, 05 Feb 2019 22:30:46 -0800 (PST)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id n74sm18525988pfi.163.2019.02.05.22.30.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 22:30:46 -0800 (PST)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/perf: Use PVR rather than oprofile field to
 determine CPU version
Date: Wed,  6 Feb 2019 17:30:24 +1100
Message-Id: <20190206063024.8489-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.17.2
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rashmica Gupta <rashmica.g@gmail.com>, maddy@linux.vnet.ibm.com,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the perf CPU backend drivers detect what CPU they're on using
cur_cpu_spec->oprofile_cpu_type.

Although that works, it's a bit crufty to be using oprofile related fields,
especially seeing as oprofile is more or less unused these days.

It also means perf is reliant on the fragile logic in setup_cpu_spec()
which detects when we're using a logical PVR and copies back the PMU
related fields from the raw CPU entry. So lets check the PVR directly.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
v2: fixed misspelling of PVR_VER_E500V2

 arch/powerpc/perf/e500-pmu.c    | 10 ++++++----
 arch/powerpc/perf/e6500-pmu.c   |  5 +++--
 arch/powerpc/perf/hv-24x7.c     |  6 +++---
 arch/powerpc/perf/mpc7450-pmu.c |  5 +++--
 arch/powerpc/perf/power5+-pmu.c |  6 +++---
 arch/powerpc/perf/power5-pmu.c  |  5 +++--
 arch/powerpc/perf/power6-pmu.c  |  5 +++--
 arch/powerpc/perf/power7-pmu.c  |  7 ++++---
 arch/powerpc/perf/power8-pmu.c  |  5 +++--
 arch/powerpc/perf/power9-pmu.c  |  4 +---
 arch/powerpc/perf/ppc970-pmu.c  |  8 +++++---
 11 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/perf/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
index fb664929f5da..e1a185a30928 100644
--- a/arch/powerpc/perf/e500-pmu.c
+++ b/arch/powerpc/perf/e500-pmu.c
@@ -122,12 +122,14 @@ static struct fsl_emb_pmu e500_pmu = {
 
 static int init_e500_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
+	unsigned int pvr = mfspr(SPRN_PVR);
 
-	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500mc"))
+	/* ec500mc */
+	if ((PVR_VER(pvr) == PVR_VER_E500MC) || (PVR_VER(pvr) == PVR_VER_E5500))
 		num_events = 256;
-	else if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500"))
+	/* e500 */
+	else if ((PVR_VER(pvr) != PVR_VER_E500V1) &&
+			(PVR_VER(pvr) != PVR_VER_E500V2))
 		return -ENODEV;
 
 	return register_fsl_emb_pmu(&e500_pmu);
diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
index 3d877aa777b5..47c93d13da1a 100644
--- a/arch/powerpc/perf/e6500-pmu.c
+++ b/arch/powerpc/perf/e6500-pmu.c
@@ -111,8 +111,9 @@ static struct fsl_emb_pmu e6500_pmu = {
 
 static int init_e6500_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-		strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e6500"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_VER_E6500)
 		return -ENODEV;
 
 	return register_fsl_emb_pmu(&e6500_pmu);
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238eedc360..30dd379ddcd3 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1583,16 +1583,16 @@ static int hv_24x7_init(void)
 {
 	int r;
 	unsigned long hret;
+	unsigned int pvr = mfspr(SPRN_PVR);
 	struct hv_perf_caps caps;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		pr_debug("not a virtualized system, not enabling\n");
 		return -ENODEV;
-	} else if (!cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
+	}
 
 	/* POWER8 only supports v1, while POWER9 only supports v2. */
-	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
+	if (PVR_VER(pvr) == PVR_POWER8)
 		interface_version = 1;
 	else {
 		interface_version = 2;
diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index d115c5635bf3..17e69cabbcac 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -413,8 +413,9 @@ struct power_pmu mpc7450_pmu = {
 
 static int __init init_mpc7450_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_7450)
 		return -ENODEV;
 
 	return register_power_pmu(&mpc7450_pmu);
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index 0526dac66007..17a32e7ef234 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -679,9 +679,9 @@ static struct power_pmu power5p_pmu = {
 
 static int __init init_power5p_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER5p)
 		return -ENODEV;
 
 	return register_power_pmu(&power5p_pmu);
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index 4dc99f9f7962..844782e6d367 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -620,8 +620,9 @@ static struct power_pmu power5_pmu = {
 
 static int __init init_power5_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER5)
 		return -ENODEV;
 
 	return register_power_pmu(&power5_pmu);
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index 9c9d646b68a1..9659b781f588 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -542,8 +542,9 @@ static struct power_pmu power6_pmu = {
 
 static int __init init_power6_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PVR_POWER6)
 		return -ENODEV;
 
 	return register_power_pmu(&power6_pmu);
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 6dbae9884ec4..79f05a7f28c6 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -447,11 +447,12 @@ static struct power_pmu power7_pmu = {
 
 static int __init init_power7_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if ((PVR_VER(pvr) != PVR_POWER7) && (PVR_VER(pvr) != PVR_POWER7p))
 		return -ENODEV;
 
-	if (pvr_version_is(PVR_POWER7p))
+	if (PVR_VER(pvr) == PVR_POWER7p)
 		power7_pmu.flags |= PPMU_SIAR_VALID;
 
 	return register_power_pmu(&power7_pmu);
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index d12a2db26353..81a5142efab0 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -382,9 +382,10 @@ static struct power_pmu power8_pmu = {
 static int __init init_power8_pmu(void)
 {
 	int rc;
+	unsigned int pvr = mfspr(SPRN_PVR);
 
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
+	if ((PVR_VER(pvr) != PVR_POWER8E) && (PVR_VER(pvr) != PVR_POWER8NVL)
+			&& PVR_VER(pvr) != PVR_POWER8)
 		return -ENODEV;
 
 	rc = register_power_pmu(&power8_pmu);
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 0ff9c43733e9..6b414b8bedfd 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -438,9 +438,7 @@ static int __init init_power9_pmu(void)
 	int rc = 0;
 	unsigned int pvr = mfspr(SPRN_PVR);
 
-	/* Comes from cpu_specs[] */
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
+	if (PVR_VER(pvr) != PVR_POWER9)
 		return -ENODEV;
 
 	/* Blacklist events */
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index 8b6a8a36fa38..5832de10e073 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -492,9 +492,11 @@ static struct power_pmu ppc970_pmu = {
 
 static int __init init_ppc970_pmu(void)
 {
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
+	unsigned int pvr = mfspr(SPRN_PVR);
+
+	if ((PVR_VER(pvr) != PVR_970) && (PVR_VER(pvr) != PVR_970MP)
+			&& (PVR_VER(pvr) != PVR_970FX)
+			&& (PVR_VER(pvr) != PVR_970GX))
 		return -ENODEV;
 
 	return register_power_pmu(&ppc970_pmu);
-- 
2.17.2

