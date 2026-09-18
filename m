Return-Path: <linuxppc-dev+bounces-27755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACE6C982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 21:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmmPD3JTHz3bjN;
	Sat, 19 Sep 2026 07:44:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789767888;
	cv=none; b=X2LkMM++ndC+3WRA4vAs2ERk3WriYjc5TnY8wfNRPbsdFGDt52HW02XvAgm1dq7bDM8SvsW4UcPry6ttSEyHj3t6dm2Kibpu0/m2pth5GIqGufoDhFZvIm6uchaNlvnR9eyKCSSDT2+XScKBHXQ1mT2PuEaujoM4BzKXYREfj5OwiqeKLRdauQj+YCtxFvplIK6tVi/fUJsHUoulMcignrcMcZov/BiSfvg0PPLsyDDRp/AJjoFSVVdwkL5jG4IXW5vB4qLTx/BlyHqF7+KgxeKEdpvygEj4OrjA9CbrVAXqqO1q0jS9SDpRhCZynCIRAxDPFykAgUniQR3bsdYT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789767888; c=relaxed/relaxed;
	bh=55kCVMsbTazCq+1cTovBkH53ynwUrxyYXS6l9My9w+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4ErF8cKs8Egjt7BF3w8hSsQ6w+O4JblS0yWAYLnK/KYGb+E9BAGcjrGjxQ7ggPbfDOEm4RYQHl/IOCBNHhbvwvMVc+HRVerPfMmQVLFrR612Gp2W7NFyaaezJ4AsQbVjTg7N+7W9htE/iiTkHT6cplZ9MxU0dbBNT/OArEXty9OYYhWrHmdufH8Yq0+IoSGKdeJBka2vIXBiwwz3YCDbnA+L42jl4rOYXujG2ZL8UELDfliThqaI37caEE4/cdq9Qmi+Q7QW5QYUPaGJbayF7/z77edazaY7EsBQvEBI3u81MrrKifnZJMmUeNZoTt47OfuBnpICXjXv7F0qnLvSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIGpJNV/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIGpJNV/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmmPC15jSz3bjG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 07:44:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 954A441920;
	Fri, 18 Sep 2026 21:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4458E1F000FF;
	Fri, 18 Sep 2026 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767883;
	bh=55kCVMsbTazCq+1cTovBkH53ynwUrxyYXS6l9My9w+8=;
	h=From:To:Cc:Subject:Date;
	b=oIGpJNV/8v9VRDSUfiGhmPOivTFJ7a82xowvZKG7VE7y+q9wEmYhdwo+N+rsBgcWV
	 KSOlyXokLvaKPxL7ByKdzU43kqvCnpWtBGenge9b0uh9Rzw9YP09wOcoeDgHRS7xQo
	 qHNYIzLqwML0IXNXdtfjDF4KyqNV9gOX8JQ8CGfCPhQEzHiMqsotBpTt/lYQe1V8qp
	 Y5eCcacCOtgkEHzfHfp2HPIuBqfzLW00YncwfsurvwSrEz4EYmY3pKOVsqY4BoMiF1
	 1SaR+1ZesHT1WuA/PhkgB4kY7874eMkuJ5xoWSCQWw+Qg4UY3alOIyUbnctUxkrAJF
	 GTKOpSmK3zDgw==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sysfs: Use NSEC_PER_USEC for wait time conversions
Date: Fri, 18 Sep 2026 23:43:41 +0200
Message-ID: <20260918214341.271211-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2899; i=blum@kernel.org; h=from:subject; bh=CDs76baU83eu9YSB4XXMekCzKsbmc98nJgjLbBum6Ho=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlrN/QWHeTkUTYwKVg5/2u+zvzZKoUhZQavGrfOu/yH4 7HNyra3HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRnz8Y/qelxa5uK9ua0SF5 mn/WPvXWnD9rsxOWpUxYu+1e1ccfvsUM/5N3dgSeOxeVdi4/Rpol++KUFOk0/x9+GW13e598v3P /EiMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace the hard-coded conversion factor 1000 with NSEC_PER_USEC to
clarify the units. Fix the comments describing the conversion from
time-base ticks to nanoseconds. Also rename rem_us to rem_ticks since
the remainder is measured in ticks.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/kernel/sysfs.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 329c1690b5ed..2e3ef6df8837 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/sysfs.h>
+#include <linux/time64.h>
 #include <linux/export.h>
 #include <linux/nodemask.h>
 #include <linux/cpumask.h>
@@ -245,10 +246,10 @@ static unsigned int get_idle_ticks_bit(u64 ns)
 {
 	u64 cycle;
 
-	if (ns >= 10000)
-		cycle = div_u64(ns + 500, 1000) * tb_ticks_per_usec;
+	if (ns >= 10 * NSEC_PER_USEC)
+		cycle = div_u64(ns + NSEC_PER_USEC / 2, NSEC_PER_USEC) * tb_ticks_per_usec;
 	else
-		cycle = div_u64(ns * tb_ticks_per_usec, 1000);
+		cycle = div_u64(ns * tb_ticks_per_usec, NSEC_PER_USEC);
 
 	if (!cycle)
 		return 0;
@@ -324,15 +325,15 @@ static ssize_t show_pw20_wait_time(struct device *dev,
 					PWRMGTCR0_PW20_ENT_SHIFT;
 
 		tb_cycle = (tb_cycle << (MAX_BIT - value + 1));
-		/* convert ms to ns */
-		if (tb_ticks_per_usec > 1000) {
-			time = div_u64(tb_cycle, tb_ticks_per_usec / 1000);
+		/* Convert time-base ticks to ns */
+		if (tb_ticks_per_usec > NSEC_PER_USEC) {
+			time = div_u64(tb_cycle, tb_ticks_per_usec / NSEC_PER_USEC);
 		} else {
-			u32 rem_us;
+			u32 rem_ticks;
 
-			time = div_u64_rem(tb_cycle, tb_ticks_per_usec,
-						&rem_us);
-			time = time * 1000 + rem_us * 1000 / tb_ticks_per_usec;
+			time = div_u64_rem(tb_cycle, tb_ticks_per_usec, &rem_ticks);
+			time *= NSEC_PER_USEC;
+			time += rem_ticks * NSEC_PER_USEC / tb_ticks_per_usec;
 		}
 	} else {
 		time = pw20_wt;
@@ -446,15 +447,15 @@ static ssize_t show_altivec_idle_wait_time(struct device *dev,
 					PWRMGTCR0_AV_IDLE_CNT_SHIFT;
 
 		tb_cycle = (tb_cycle << (MAX_BIT - value + 1));
-		/* convert ms to ns */
-		if (tb_ticks_per_usec > 1000) {
-			time = div_u64(tb_cycle, tb_ticks_per_usec / 1000);
+		/* Convert time-base ticks to ns */
+		if (tb_ticks_per_usec > NSEC_PER_USEC) {
+			time = div_u64(tb_cycle, tb_ticks_per_usec / NSEC_PER_USEC);
 		} else {
-			u32 rem_us;
+			u32 rem_ticks;
 
-			time = div_u64_rem(tb_cycle, tb_ticks_per_usec,
-						&rem_us);
-			time = time * 1000 + rem_us * 1000 / tb_ticks_per_usec;
+			time = div_u64_rem(tb_cycle, tb_ticks_per_usec, &rem_ticks);
+			time *= NSEC_PER_USEC;
+			time += rem_ticks * NSEC_PER_USEC / tb_ticks_per_usec;
 		}
 	} else {
 		time = altivec_idle_wt;

