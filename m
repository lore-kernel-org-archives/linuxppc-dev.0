Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8916606A325
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=buyxMJ38
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlmN3hlnz2ySl;
	Wed, 28 Oct 2026 09:39:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1245"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140772;
	cv=none; b=Y7nduC+puu88lS+Fp+WmrBPAoirpd6DZD2doNVjnwHnAvFLT4mO5MPETLi7nJ2i9uLuNuevK+J5UpSIMA8ICNnKBOzcKndmsLEK2x1ysy8TeKo/n9siYLRpQhBblZnDc4tLTocm1qB2RnyC9ku1xzcKlOiWfq+S0z1XJ5zUyY400tYs1fDrUQZjza4LPQmBi4dr+WBWoOfkRGPkZSeSx5nliRQVa2cjDD7vtwAof/m2ckvGC1kSCVBxLXojElSH7BS/L/e5miL7mz97z9l/mRbn30/TglRB2UvcM3d4p6jvA/qqbnVuiw20wet80IYEwt60do67Z6faEPkbPgMaLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140772; c=relaxed/relaxed;
	bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIHChre+Y06RJ6Q/ZsdnF6eZKnxxJcPevFr/yeOCP/42PLBgBEzOHVUy3H0o9hB8UMlogZqjzoS8t/AvxAKn5GqpzEPvGq+T91LmX604rWOPwNwTmtnl2O5SqwGtdApT7KJVG+HqAhbunCMwgYBQt1sr5vW1gIY74ed2I8aWNs4thKNLNc9iR5Xdl4IIVMSFES1v6b+36K67ApaedK/q1eZBZn8m0Zh/crcrdCsLQS07/K3t941b6VWLfVAAr6YHGdBJo9GcebeSloazbpCq697SuMu7cuad4virf3/vG6eUlv/xm8SY1VtrO3xBOz1LBGsKKDvpC4x/yX0nFN5Www==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=buyxMJ38; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3isjhagckdfq4da20de2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=buyxMJ38;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3isjhagckdfq4da20de2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1245.google.com (mail-dl1-x1245.google.com [IPv6:2607:f8b0:4864:20::1245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlmM64yJz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:31 +1100 (AEDT)
Received: by mail-dl1-x1245.google.com with SMTP id a92af1059eb24-1a71dd190b0so299091c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140770; x=1793745570; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=buyxMJ381aJznQKuhmxlDBZfa5/iKg2/Fs8w22TT4SxH1dhAfaPfDvtYSxm2r51t2O
         THgT7bPcm3T9IfVi7MO72fYtDkQIugFqQ6mnIVSf5rmzwiRIE/MzHlxivEmnRoa1AzCC
         PtdtXFj7n8sahqJBtCTQrup5tjR75s0zMkgYDWtrXE5bW9dcKu8IGQM1bZV/dbm6cpJ6
         V+y07xuTzA0Wjng3Ayx0HPccLCqgl9cTUG5fxEJk07wQKI9Sb4TMb+vjN6mdLY98A0RG
         v7sUnvdbY3Tj9E9qfkMKoikqgHNeGwybPA/LsZbkdoHmRhY7PUVez0Bi4/icq3u12+Vo
         Kj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140770; x=1793745570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aItLXVgOXAbsJZn2OZIWl+3TQwb1N1Woum6UsPYCRPI=;
        b=p6m2cdekL5V/ogLnHSmF82F1jvrRY+fyW84kKo3vqVxw2e34s1z0z7yAVUPjqJE21/
         +o6kBfU6yNKUIiPLY7owSY0PAAWJuPIdIWthQA8QKoy1Vk5nPzzCz3IKpbnQV2TLAF2R
         QelZFo5EYB6gKs4vLUI1Fu1bq0f4XL27xcGX6IBCi2cT4qj5wMlHq+xd6TLhlWvVgA3M
         ggMYHpQj/d0jgI/OlkSLpmPknshELI+ou1rHjVDW2JTBDfEHzI1L0DFwOAFhwCsZO5wg
         H/hysfT7gPHxJlCPvUtXKHENnw8tnTpmcz6ofsFPOdCp0cH6uVJIJNvt3kGMaKEmBwas
         nhrw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ2jzsP5lxRXKE9P9oGZt3sqXowEUVWHi37s/pqE7NmhWRown5896CuiKAQw7416nwTGW6vfBAoYCFPDE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJxqDRV7TqjuYkp+VEgnxiwJDZmIRmRwMJ5zdHLsKwIIxuDgqEg
	WpEHqZNE3tMMTblTPjnfFatT2hUC8XfrEdh0vHwgyWKi7L+WcHhF9HMHrXedSBNNJfgnv/hVZCb
	6xAwT+QlTrw==
X-Received: from dld12.prod.google.com ([2002:a05:7022:30c:b0:191:45cb:f8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:607:b0:166:af48:a2ba
 with SMTP id a92af1059eb24-1a6c2c71125mr1317138c88.0.1793140769446; Tue, 27
 Oct 2026 15:39:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:42 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
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
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-8-irogers@google.com>
Subject: [PATCH v2 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Richard Weinberger <richard@nod.at>, Liu Shixin <liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/ubifs/sysfs.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index dbf967dcf26e..e20931e3a62f 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
 	.release	= ubifs_sb_release,
 };
 
-static const struct kobj_type ubifs_ktype = {
-	.sysfs_ops	= &ubifs_attr_ops,
-};
-
-static struct kset ubifs_kset = {
-	.kobj	= {.ktype = &ubifs_ktype},
-};
+static struct kset *ubifs_kset;
 
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
@@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 		goto out_free;
 	}
 
-	c->kobj.kset = &ubifs_kset;
+	c->kobj.kset = ubifs_kset;
 	init_completion(&c->kobj_unregister);
 
 	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
@@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
 
 int __init ubifs_sysfs_init(void)
 {
-	int ret;
+	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
+	if (!ubifs_kset)
+		return -ENOMEM;
 
-	kobject_set_name(&ubifs_kset.kobj, "ubifs");
-	ubifs_kset.kobj.parent = fs_kobj;
-	ret = kset_register(&ubifs_kset);
-	if (ret)
-		kset_put(&ubifs_kset);
-
-	return ret;
+	return 0;
 }
 
 void ubifs_sysfs_exit(void)
 {
-	kset_unregister(&ubifs_kset);
+	kset_unregister(ubifs_kset);
 }
-- 
2.56.0.313.g2479322e68-goog


