Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJkGk1BG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7CK2fhNz30TQ;
	Mon, 09 Nov 2026 09:39:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177597;
	cv=none; b=ayA0uXiFT+LH78gpXCSngVCw7UzJjSkddfG/lGoCWOQwU8c1qs1uwscnE7v+bIbdDJeL99rStegDrgVxuABdakU78LHayZ0wYKzNs42IhO0XJ/P6Nr+DiVn0PJ8j2A4kS/xNjLhX/9yIZgAbpAAMAT5RZSqlb68Zg0Jmy6PxdywVXJXLDYRIiZGD682j40z4Dl/2YmDauIrPdLnzI/pEWM2WRJ/auagEjTSHJ42gx1oZqzczXpQgT5wYoiCp+UJTV2rfk0pwv+OoVRwAqTOrJ7h9EwHYMhKVHUbN9a24siimCSkERDECp+7ZUGdCscS+q3+FG+QSda5kuescxOgdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177597; c=relaxed/relaxed;
	bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fjQGQiEs35+7ogd5NV6PJdWt+l1KM2Wre+++OqRDuNlXJ+4zt0mffZvwyjR2XBIiCzHcYT1gvFhbmKzpujxZIAMbU69nIpGRAsVJRAcY4YDYlBGnJMGpGgqoJIIG6+sO+x0rTozZyub5ckfCGpJbJLyIVYShyaH2RBgNGDlKHmBKy/1lD3SbtXVXYfcBfqmNLLcSV5P7H7kf8x8Q8r+ngWHeLDE0apHYxOr7jRNv0LlgcWGa/xBdyaGJAlTHRC8JZAUMSEFeiaA9aNwmjqFecw7ylaxtOE4nBTnbkFbUoLcNZmfE41PsJWohgVL7uINf/C+5jXrqMYCCdg10lNTm4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJkGk1BG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3ovrwagckdfe1a7zxabz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJkGk1BG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3ovrwagckdfe1a7zxabz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com [IPv6:2607:f8b0:4864:20::1345])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7CJ4zqNz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:56 +1100 (AEDT)
Received: by mail-dy1-x1345.google.com with SMTP id 5a478bee46e88-36ecd5db581so237300eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177595; x=1794782395; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=kJkGk1BGA1QYuFHgd2pk3RZ9fV6VZsS+cq4cfyQ77g0opkoslumwhLtK9QKDmdSaVv
         kwYCVDLw1YeeY2T57xMGC3udzvAFFUTotFDPHayigVeN7MCG1AKBkpSsJY88qH+TqflW
         yUYGYkFw0+Q/PEAOlORlD1Ilo2TEcHgqYau0dsAqGucr2OK7H2Clwv/1tZolNd1e+nHW
         8mhje5FSwv7h/DoZUu0TnT9BURlJG5WvzDUksZ2TqVlKZRHNOYL7Br9bbtj1Xhr92El7
         G/TTGsfkeZp72smHMu3tuepyvcTn4C1+0l3gHTT7kVWlt9byVM14bXv/wrYTdrmYzvA7
         ju1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177595; x=1794782395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=gBXoQR6UhDvTjklLgfBXT8wh4N7XihDj+C1EyI1gE36z17RyR/f6B0jSDka1rqbmWA
         JAdZ4TB1LiHsqkKCi8r8iCxLqUOkVh70i1zmYW73U0JwC6gHn0PRD5u5YF7c+pUaAre7
         77UQZ6ALetI+iweNWpCwoF6+GxPSQHjc8+Ieb4erQzS2KyYp/a4cUglKfGPpoS03EddI
         F7p/z/vl3b/J1PSlG4MgIgMlbmizvTdpllycGIZbGHJm3bxu4yYpJeHpwpgzqNXd2x74
         jxX3UqsxIb+14lat1El0JaA4CMjihk1T58y9p76diIbXPjwZwTfKjP2yxCILbULS+cGI
         tgwQ==
X-Forwarded-Encrypted: i=1; AL+hErHsHDUJ7sQvKfyJmx1n/XXvGDfH4+SiTj7hlDs2F0cxbeArRhZ9CEVrGUl8/WvLLWh/tJE0jP5RDRUHGqE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+lUsr4zULM29bZUcWj4TRur2Jchn31yfYRtYABI8KTDTaM9guP
	877xyciSD/CVEwqTMUCgHxQr+St4Cjx0nRxm4gKig5JgU+3dXflrG+SDSU5bMX9lvpXoaC2pn+6
	Lxe0i0H2unw==
X-Received: from dyblf39.prod.google.com ([2002:a05:7301:a27:b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d584:b0:36c:9f1a:30b8
 with SMTP id 5a478bee46e88-3725661520amr5331882eec.31.1794177594363; Sun, 08
 Nov 2026 14:39:54 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:11 -0800
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
Message-ID: <20261108223913.3624571-8-irogers@google.com>
Subject: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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
2.56.0.455.g6c5a503b38-goog


