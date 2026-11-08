Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B64606A321
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXDOrIHa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7CC1pt9z2ypY;
	Mon, 09 Nov 2026 09:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1245"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177591;
	cv=none; b=Bd2GLDY6C9RuiQqxb0tDR82XaaAeZnT/0awxzBxCEwjBA9zRchLhLGgv03FNTlWXXmF9Aal3mhbRGrxqIalzmMNt8YZIDKjdH6T/JKE6+B2MZuaDc10YEqJTCp4mI478xP8doH1fldMtRrSX0iveNs3vPryjenFckjw2UtpiUTCWapKsWSd6bk/KV+Rc30SPTJxwNjz9Aa18VIzBBZc5soEaqjxb+V/jmd4oIb53JhL/yRlykBHRBV1NE4AdimVvAVALMSo/FulPGjbyjkn6zoATY022KsuyZwj8Stx4HrNbUg4a10wyYdGdfFIj3MVBPFD4EMT3F2eF5moWGBTwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177591; c=relaxed/relaxed;
	bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iLepaMT3YHkL0x3Nn3jp9xs5i4UPcibdljC3bcGimSE4pm+XtQCbXs8td9PRvRL5iA8rRwswxHy26FWPPxOWvo2YuKHW4y/93+hmOf++dBVR2/QVV3wRZ8sbiNA7SqTVS8Dnv8y6BTr7nNkfAFGv8FDlxSdokJhWRgPZCI34fZLjmEwdJZMXlH5XVNusn9JzLKzV8pXHXZFYPwdKaPIBwkzx+gXNX69vMmvt0qT1baETPbXIYs8nL9ovU6atdkw3aNChivmT2gpvbIv2PnoLLQiPdRHby9ZImrs2WzlKMI/dmL9YG4MVoFHwMnN2eGGNAC6w4qUQPOJUABDxwaLtBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXDOrIHa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3nprwagckdesv41tr45t11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXDOrIHa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3nprwagckdesv41tr45t11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1245.google.com (mail-dl1-x1245.google.com [IPv6:2607:f8b0:4864:20::1245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7CB4lK1z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:50 +1100 (AEDT)
Received: by mail-dl1-x1245.google.com with SMTP id a92af1059eb24-1383723dfddso396987c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177589; x=1794782389; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=UXDOrIHaDFuGNiT0ZH5ot5BE7wHsPZZ+QwwrmWQ5X4z4pZ+iwMXwQ27QMXCzBHfOAK
         +sH1j/ybPEwh8btNr2cjpgUJ9/GBqXXm2tvtneIKHt2nwzf0GZSBh8VRiBD71Niwy/Er
         LYZpylbm4FBYXNHRnJvHVdyrIX/6zOOLwNToVn2vwpPICB8S6DjKnKSeDr+MfsNn6GB7
         HJDNYi/vGdroEf73fCz+ZpNfyhQuYujZwWd+fJ75t93/a+4AUz8au/9bKKutF/jHCuRH
         jv/q9anxtJ3ueotszWiiBWwMMHIoOr/XpMgggwyq7/8BzI6pm+JVRyu/tviI32d+LI5N
         hV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177589; x=1794782389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=MQT6S0ZBk+4JRyZ6tCLovIClyhE9hmoQ1FzwTzrkclIOvIyaifY1bX2pNA+A7cq9uE
         ts5X4G8qgGrorJCwtW4c99rR8PTPoF9L8jx2LoWWB7HSFBss/xke3HKAu/IxkDvZCzMT
         Z6Ln50kL83I3dSIlf4Zx6SAbonlIMUvRsKz0SHwA6RcGtWhtE0DIfH6A/rO2bwh/D49x
         1gqZ7ByFZSRu7/Dwln95lUhFylbdiKYzUEPelKnqIXwEwytmuHWIrRJErbM7bhNRhRbZ
         ZEq+nBJbfG2Qdr8nUl579YvGJwBWVTDI9L7BJ7hGVmSXqrlvLlgFovz/Knjou0dAFjj/
         5ZKg==
X-Forwarded-Encrypted: i=1; AL+hErHdPe2GM/0aENA61t7rOd/GRA9e+gHXUow4/L9BnHcTfKqFx+BwFGMlg+z9dmfvYMJgEgK4lEaR6e51Saw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+CzsC6LtblwO0VxLrag84QS/BnppU20+Ju2FiBK8+FqHBNRKGz
	TZTKAmq3AxZemmj86MHiDyrHnLbm/SBefdB6j2yEc5LbPMKoeFuU9Az/ZMeZTxbG/DBnEdmKnrd
	yagzH05IXOw==
X-Received: from dlec20-n1.prod.google.com ([2002:a05:701b:4294:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef16:b0:1b3:a26b:8b97
 with SMTP id a92af1059eb24-1b3a26b8c4bmr3821391c88.41.1794177588129; Sun, 08
 Nov 2026 14:39:48 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:08 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
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
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-5-irogers@google.com>
Subject: [PATCH v3 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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
2.56.0.455.g6c5a503b38-goog


