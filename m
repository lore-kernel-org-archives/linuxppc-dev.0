Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B260A2614
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jpKno1NT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpNF57BWz2xLq;
	Fri, 20 Nov 2026 06:25:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116349;
	cv=none; b=jy7ioX5RXLPyV+R4VBwzxLrJ8/FTwxgCGc1gcT/JIL5Ypu3N8glSABYT+7We+DYdj27ljdpDwIMkh7t153/WIL0bzHFDa0FRh7cmfbSXpccJfryR5QQgmzgPRlTiSnXxjX/EO1fxCnYV3NCX67i3exogX3T1ZZvnvtmuhEn8ez0cjBVOQj9X4zkwi5VDyHfh4hJL+lL2Gsc4HwkfHf/l9ih5RkE+oxVkPbOPpX/rdjCrWNB4xQJckDr3akx3/UWcERSLpAVDxV2y4viSm9JMcQd16MnNzNnldWSYAFDkQF0bDB8xqTwB69RchrQ9Lo0ufaIZZasIbfLLV+37FNPgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116349; c=relaxed/relaxed;
	bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2AH845EeJTysFf7QhQqKObGodye1TxUbx1SKMLE2F6wHirir89qOhTr8/khLg9CVECbAn4hsrchs16D1eNlh608BTTY19l8OlLrMLGFXob+cV+yGpfqHqWE1a3l0sIJ/vsDQ3zCqF/ICNQxgmu7ZWOtpok/qCofUgKihg/MIIswoDOb6RZPBRMhtXEdqUE0j7RyByZuJxYIOAfADaRyTQk/pPki2aB9E3ljrQ7+bcynoqA4AmHR9sodTFyh4pbWX4h51+0t6yyaSoHE+SlJPJtpwBYmkXZ15T48q0JmVILtQ8CGA5Hv8C+H8yq/GEwOp3/u85qRJbE1ngcvY5/w6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jpKno1NT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3ok3_agckddevebtreftbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jpKno1NT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3ok3_agckddevebtreftbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpNF07jxz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:25:49 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-383435e46f9so47439eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116347; x=1795721147; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
        b=jpKno1NTLwywRqVMZj30cvv33X5nDhkGjQH1mZwglkoJxajPSf1AZdu6qAe+qDYUm3
         l+bTAH/sIYe5VjiMjnKVWWOIQb3xlBmZdxAsx/GVz6Q6lvsrDenOaPmlkIN8MYPZvhg/
         vrwTokWzyLbWYkoS1mZMKn2/zIAn/ZyyvmT73uEcEbJl7Q5MUr5FbwwQQ+itsEHE92Yd
         kGSJ0Bkmv6DLBvhs/E6DsUjMKBx+Qnj6XcVqoSNzEE0m/u6cHc5AI4IBgDQpTED2Nq8D
         QWrj7R08R5Conffhi6chLI2YeFmOKvPE0VhZ8f5W2aSQSscLBlC86N8aVYZgiaHo6UKw
         /0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116347; x=1795721147;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkWfFph3Jhdo1iVdBmUApUet/72n0u945LBk/dYhnBA=;
        b=x9QE757vGF6Fl5Pr5YcNOcYDWSkzSgU5wiEoDmCCv/3iymCxfOpm652mlvC/aiBuNG
         0VF5b9FkhxdoyClvGzSEPpChn44ezRgfYie76+5tFw5Ndyvq7YClvko4lqX1IKQeRenp
         SsbD3zgMocPJk03r+62kYIz3QrBe4np4ygnHKu+3WHtnlZIlFw7AZltWmmroOFYAMryg
         mzRPQmdZHg8Hoo5HxZgpTEFGGtb++aVX9qf39kOAWO5UEpmGYWgzNfBvtQDPPYyvrjbd
         1MYD9mEtS5TYl7bo5Je4s8rUvUmc1ro9nrwzhvdUF3dqB+BXdRvbdde5BfCuExIAmHWG
         pf7w==
X-Forwarded-Encrypted: i=1; AL+hErE+OowMwnxtN9DLmHIL68FfMjv6Wr/CRM41ZrmofJrjJFiF2TS+1e+Bqlu3aiiHnWRedzSIVG02eOqsPyo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9gwAyl5eJu8ahzvvrUIz5oBk/fGxeF1nx4E/SYaYPum9cF5ZnK
	xenOeh60pZtHohGu8gTEfDLGoOuuFuK/q1R2rskkYQeOe+KnfJ9QVA23QH2X9mhfYQhqNkEcqJL
	d897WvVNVCw==
X-Received: from dyvo18-n1.prod.google.com ([2002:a05:693c:41d2:10b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:820d:b0:36d:394d:e690
 with SMTP id 5a478bee46e88-38570b34f2fmr260461eec.40.1795116346621; Thu, 19
 Nov 2026 11:25:46 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:15 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-5-irogers@google.com>
Subject: [PATCH v4 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export cpufreq_dbs_data_release() and initialize .kobj_type.release
statically in the ondemand and conservative governors instead of
assigning it at runtime in cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
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
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
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
2.56.1.708.g77570a6a1d-goog


