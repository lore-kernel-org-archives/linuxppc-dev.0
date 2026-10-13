Return-Path: <linuxppc-dev+bounces-29441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA12CC6B1E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:40:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48Rr5Xccz3bsm;
	Wed, 14 Oct 2026 09:40:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1348"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931224;
	cv=none; b=NtZ0ljmFTrpPY40y2SlPz2YQwBzo1Z3e3s/gbhLXPaJo9e9/IuElnh1V4P5BJ2wYJhFKVglNxJHSz9AFmJA27BnVwaziIrl/e43uD/mnE3CxqObTTBnN1YO2MFjatueyrrjbl0YInwc55t9ymqdzBQ1HqQvW3gz9F3W4ROieMLM+JUx2XYCeKLaS6TnX9PwDpHsmMgP3rK7oTgjBaNSQb4U2vVN0Hu2ZbgkJa2VcoPRFY2Bry8hiNodn8uL3QwuPCx3WpYbl9KAN6P1xIEQeWM01PPZNBnSoerJ1X//hrBLwVBJfzi1ZYhqbkzkPIaV4sBt0RH+9PFH3lPsvbUnnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931224; c=relaxed/relaxed;
	bh=qCnJ2cyf9mW8BNAz5Pcwsubr4iCDZba2S/P+mHJ/PnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRArC4OIiimKZMQUpcPJJqbh8/SS0BDYq/obhWFSHfqjSeBW+QbkuIG1NPcIPKxlORqyc1OO6uTc7rFuK4E7DyXnFERa9BI8mc3Qtsfm0QQ20Sn0Dp4r7Sx9D44SvN3dZKry/gfYe0jcnjf3ltQ5yf8a2QBf0QZPY3/n5tfHqoDFKwsxGua6fFyVTjck3+o5sc8dsYyX/fUQz4gGLBbqfm42l8swwa0HYOL/MIsn6Jlio+Bcl88dWl4aIbKqg0Qeg8CC6UI+HcjyXNv/cefF7LBnwixUdbEiXAoTUnyPFKyH54zQ5cesNylz0oVxHb4z95HaI9/FBdbH8owFV6H05w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d8hso7jV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3vbpoagckdfq4da20de2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d8hso7jV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3vbpoagckdfq4da20de2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1348.google.com (mail-dy1-x1348.google.com [IPv6:2607:f8b0:4864:20::1348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rq6ZgRz3c13
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:23 +1100 (AEDT)
Received: by mail-dy1-x1348.google.com with SMTP id 5a478bee46e88-3580c07911eso9019774eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931222; x=1792536022; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCnJ2cyf9mW8BNAz5Pcwsubr4iCDZba2S/P+mHJ/PnA=;
        b=d8hso7jV51T9ah4uCs2jsPn7mqpq79RUZCOvKN2+M/qoJAArsIlXEyJ+WI1/2zKgWf
         t2xy7Zr83U3jWA7zKVcsq4w0OnYnrlQhO6ena4tRhctXFwH6Al6Dg22PrrlKrvPeWLat
         ApluivKl6yXPef8f+MbikUqMKDLHnJ4nKRHm1mQxf6VtSl2RBSgDvaS0wl51uDS1Clt5
         0odbZ7/7a65ioEmWbBOKgAghFxHi8yuS+Dm1leEo0li66DqKtAQaQqqmTtfvH9kqf5XY
         44inaJoqqy+p6voYKXY4kPPmF4GjCMYeKTMqrX1SSNLC0pC2kNWvmV9DWHDcCwACKtEf
         h8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931222; x=1792536022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCnJ2cyf9mW8BNAz5Pcwsubr4iCDZba2S/P+mHJ/PnA=;
        b=TA1AG0ov5eR0TQSaOG5R1iC83I6oKyvyAi9g4zMCjRINzWBbr2/qldnbDuceFUqojO
         C7cPCLF3LqS8pQkkbsYbF5Wz8L3RXQitKMRNCmmgk/hOv/mpL0R/173YomOVSH/SawQ7
         KMrjUWOxgqPg9CwT7Bo1wxdL94/omkltlYdxgEwt8oH+OpzB1/Pmjm1/sMVQ25Z6hfa7
         5wus0sRAj77EJF0GAEG2fbNLNiGgGQsNooy1WsK2Hvxu3p3bApvWOmI6hhbtlc8o+/G3
         mb0AHFZc43M/rJRWZN2X9c+u0XNldDR7l7FYCi2ivc4akya3cPSdPj3tusGUB5Jxrsm5
         0raA==
X-Forwarded-Encrypted: i=1; AKwUvBy2faqIxYY2CuKCMn1Ipn5fuAppTVzdHXpJtBwAcdc4e5Z8RCnRJzhiflRsS5o5dNgAkuwZpEyOzi74cVY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIdNaacasJF0c0kBbXo7QSxbAdnMK6tGk8XUElWhJpwZDNspalX
	wgQhh/VcjcTW7wCMr7Oo1/4as8W8wUAJR6L0OrQgD2dC8v8lFhH7uRmT/HYCBZypU6fmyjo6BSQ
	/UrxNk0iSfw==
X-Received: from dybsc14.prod.google.com ([2002:a05:7301:4b0e:b0:351:7270:d79a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f60a:b0:359:2edc:e1d8
 with SMTP id 5a478bee46e88-3592edcf44bmr18703370eec.5.1791931221247; Tue, 13
 Oct 2026 15:40:21 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:39 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
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
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-5-irogers@google.com>
Subject: [PATCH 04/11] cpufreq: Initialize kobj_type release callback in
 ondemand and conservative governors
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Export cpufreq_dbs_data_release() and set .kobj_type.release in the
ondemand and conservative governors so their gov_attr_set kobjects have
a valid release callback, matching cpufreq_ governor_dbs.

This prepares for annotating struct kobj_type::release with
__require_explicit_initialization.

Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 3 ++-
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0b32ae28ec85..38c3bd5bf75a 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -316,7 +316,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 710d93ec89b5..97b64985927d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -404,7 +404,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -412,6 +412,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 73b8ed7cfaae..c03d067f42eb 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -148,6 +148,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.0.385.gd3acb90ef8-goog


