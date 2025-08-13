Return-Path: <linuxppc-dev+bounces-10946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D005CA0EE0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Aug 2025 17:03:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2F6d2JDrz3bmC;
	Thu, 14 Aug 2025 03:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755104553;
	cv=none; b=mN9MlCFvAyCw0CaJ8PirJGNUVsqBRcv+rL+4N77UvVWQInGutFqVAkj50Pw2ckc03NS5OfKC4kVOfLA3J5kOTODvTEn7YN6UD5kwxw52Jw8BvWBWvqAjks2BTs2dK7toBPaSxkCOyz7DhkVzrbGStw/BjzGx4lREkLt3bnz9meP93/lRVvNhIkDOdWbn7wMIAwzDfQgyZfnWXw33q1vYf7tK6ePdWhYknTIVxxz0OoFbc9m9bYnFHQG28cxUnyOvNn8o2wYJ+Yj1K/kcb4mMxBpx5M1qgkr8QMuCmQ+kFHfXzY0pug9p5GzybxL+iN9NzkFLGt6bT/b1iIptpv/UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755104553; c=relaxed/relaxed;
	bh=EBGDke6NrPEwwsNMNZKq4BKfcoViEJgulzCycTPRffE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOsiU9O+osNFkQYpHJ6C3m68tCsk4pV0QHfexdcrf1W8946JvG6+81xjoIpdaPsAamjl51INWlO4yVuUmpy6XQGCrsX7Lql9fN5ZfzmiL+68i30TbjV5pMznGh/mlsRz7FB2JkGoWHtoFf94mwmY+Ia5ItSMEBbnx5tWhcyCrbfChYOmK29+HxQQWJwRJDJA8lU/aEEGxdFhH+AfcBLbT5tyV0sweRSWFfoNXxLZbCINwe688dmgfdQ+wUVQVkIcAoYM3g6icEz0+g7b3J6spueJkK769e+noOp6SEiSgTk68YEDsjNjaViKbWwHMwP4z8OzA3KpLGSeQ2fxXf7ilA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2F6c5875z3bqP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2025 03:02:32 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A361CDD;
	Wed, 13 Aug 2025 10:01:53 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 181F03F738;
	Wed, 13 Aug 2025 10:01:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	coresight@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 08/19] perf/arm_smmu_v3: Improve group validation
Date: Wed, 13 Aug 2025 18:01:00 +0100
Message-Id: <c0e5e426b571a438a88adc8a9e16d2f066171cc2.1755096883.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1755096883.git.robin.murphy@arm.com>
References: <cover.1755096883.git.robin.murphy@arm.com>
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

The group validation here is OK, except for the benign issue that it
will double-count an event that is its own group leader. Even though
it's highly unlikely we'd ever have PMCG hardware with only one counter,
let's sort that out, cleaning up some reudundant checks in the process.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 621f02a7f43b..7cac380a3528 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -377,9 +377,6 @@ static int smmu_pmu_get_event_idx(struct smmu_pmu *smmu_pmu,
 static bool smmu_pmu_events_compatible(struct perf_event *curr,
 				       struct perf_event *new)
 {
-	if (new->pmu != curr->pmu)
-		return false;
-
 	if (to_smmu_pmu(new->pmu)->global_filter &&
 	    !smmu_pmu_check_global_filter(curr, new))
 		return false;
@@ -422,15 +419,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* Don't allow groups with mixed PMUs, except for s/w events */
-	if (!is_software_event(event->group_leader)) {
-		if (!smmu_pmu_events_compatible(event->group_leader, event))
-			return -EINVAL;
-
-		if (++group_num_events > smmu_pmu->num_counters)
-			return -EINVAL;
-	}
-
 	/*
 	 * Ensure all events are on the same cpu so all events are in the
 	 * same cpu context, to avoid races on pmu_enable etc.
@@ -442,8 +430,16 @@ static int smmu_pmu_event_init(struct perf_event *event)
 	if (event->group_leader == event)
 		return 0;
 
+	if (event->group_leader->pmu == event->pmu) {
+		if (!smmu_pmu_events_compatible(event->group_leader, event))
+			return -EINVAL;
+
+		if (++group_num_events > smmu_pmu->num_counters)
+			return -EINVAL;
+	}
+
 	for_each_sibling_event(sibling, event->group_leader) {
-		if (is_software_event(sibling))
+		if (sibling->pmu != event->pmu)
 			continue;
 
 		if (!smmu_pmu_events_compatible(sibling, event))
-- 
2.39.2.101.g768bb238c484.dirty


