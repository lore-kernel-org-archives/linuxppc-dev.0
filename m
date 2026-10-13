Return-Path: <linuxppc-dev+bounces-29443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D1CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48Rx5HZhz3c4D;
	Wed, 14 Oct 2026 09:40:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1348"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931229;
	cv=none; b=BGhgiEPQD+JUMrUeGiSdfZ0Le2XwuOg8kv6Glo6LqWSFQxHsh3wC3EDhlUTcS82NUmFldgJx7G+LNYPddZOWTQ85MeKOpFZk3KdNfTr3UUHbSVQ9zs9Mnfyy3wzV1TEL3zjNMhb/5ttQuzR46fuIvTSkXmqZvgsswBus4qDxtBU7s9PFwR8cy6aXRTN1SF3CkCjnIXV3yikP2Wsgn9b+++S1EGu1W0SHrpmDF+qRFLBvtjl2dHPdIuGmQWJ0UOSlzOoJQILOjbacIKDpetbQc3PJEVgb1GnK19KAL0R/AyG+8VvtUl9p8jn7PB1kuhLB6WVaLAbN5yb+i4nDl3qvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931229; c=relaxed/relaxed;
	bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgFrYznnDJs4di7u6KaWI6EXqoBzK2MmduUvzS/T5Q9lRIZweJpXIQBMXCegf8uRtfAm2EoI2eXVVbupFe+Hdc4vHQZxUy4yW0GQ8Ct1WBnIUvHqKB6KuxP1OYhHzosMqtbTehcfF4hCMmZqis6PlwOACcQBT2OO0CHXUG7I4C+Efd7dEMmkMd4C5R7eDQuDOcr6NSHHYbWPNhHYiwP5z0V9HNtBzM2lWl+1jX6svbgLaoonCc9OwQktYS8gFWvWEI9cWoQ2SQmYx9ekTefMETluK7iZjAde0vK4AIAa4IlE8AF1JNxiwi7a5c7mwjPVyVhiqMnBKnEvjyafe9wV1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jYV3BgKP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3wrpoagckdfk9if75ij7ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jYV3BgKP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3wrpoagckdfk9if75ij7ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1348.google.com (mail-dy1-x1348.google.com [IPv6:2607:f8b0:4864:20::1348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rx03P6z3c13
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:29 +1100 (AEDT)
Received: by mail-dy1-x1348.google.com with SMTP id 5a478bee46e88-30c0d568830so7230442eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931227; x=1792536027; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
        b=jYV3BgKP9h8hCsJ41o9rvgduELkjIv50OjK/WK+BPlHZKuU9TmaneaJMqbIYU1p0RJ
         Rw3aDxq4Je4ShEv/lgP/h1+Ie46hqfwxO9292yzQAg3kdIyd2w1/Xdo1oB09AwSKkRJ7
         UhdpeHu4WECEEKeF+0nYs5uG4NkTILxMifsnbD+vqlWVv2EDmLH8NkHpmfn/vrZeLHxE
         R7RQIvJVmOyZzBJX0Zxv/I0LyJfTHGLKtHLZ4s94Pvz1zZMQlyGqtm26Jy4x5MhZXn2b
         avMUKYBgA8A68lnhr8ac1rFScBFn/DpJi01wO0fhYC1jcO72bwGLs2Bm5PnBNXaKe5Dd
         yswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931227; x=1792536027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
        b=x3eMwuVeSE1P+RCozA258kiOT9m1f2Qkk8gA+I0XJwFMJnEnJnf5j9iue8jvjwbCiF
         1RTCiD99sEjVrP8G2xjJY1LDpkvRHZCFRQkvyoCP27CuOucVvPLZYGTeJC2wlImPxGr6
         noMNQkS2ePjXsRBv3zcsGAhAmTzOSIGhBP3roCtZO72oeHuF3q3u2Zx13FhcMbhqYmJp
         5rcgXkPuwMMSdX6LeeS4y5fdTgt7Mw/J7nwLHGyD0j8f+fkDnyHpawCXi3tw7q9Smzo2
         8kCQMNNdRfo2PX6Ac4ZPOUDj9SFVF5XzsTzk3vQbyDKRwOu8shA8vfhsN4ydv2k5mljn
         vniw==
X-Forwarded-Encrypted: i=1; AKwUvByvBtg2ConCQbqZc3Fci8wB1MZ1fWSblSkpPndj8RQDxIGvIKkPucDmpJKUy8Z2W6PRjCH7+zy66ZLLHNw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI1fotOX65fjVKI7WegpM/9GgYX+LLS2MNQP4zZrkkmOK+rs2an
	c0jr/Y5AxGSVEcMNFkGBRaQmRPa3a2i30LyfCIWldgk6NK2Tzhr/M6n4lJ3Cuik5YqsWuSw6uB3
	XgUppMXyeig==
X-Received: from dldyq19-n1.prod.google.com ([2002:a05:701b:4553:10b0:164:47f8:a96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4286:10b0:144:c128:4c4b
 with SMTP id a92af1059eb24-16a5e49c474mr18578865c88.36.1791931226644; Tue, 13
 Oct 2026 15:40:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:41 -0700
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
Message-ID: <20261013223946.1836757-7-irogers@google.com>
Subject: [PATCH 06/11] dlm: Free dlm_ls in kobject release callback
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

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
kobject release runs causes a use-after-free.

Add dlm_ls_release() to free struct dlm_ls when the last reference to
ls_kobj is dropped, use kobject_del() in release_lockspace(), and drop
the final kobject reference in free_lockspace().

Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/lockspace.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..1d226b27d8e6 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	kfree(ls);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,7 +363,7 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
-	kfree(ls);
+	kobject_put(&ls->ls_kobj);
 }
 
 static int new_lockspace(const char *name, const char *cluster,
@@ -436,6 +444,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +577,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -615,7 +623,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
-	kfree(ls);
  out:
 	module_put(THIS_MODULE);
 	return error;
@@ -759,7 +766,7 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
+	kobject_del(&ls->ls_kobj);
 
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
-- 
2.56.0.385.gd3acb90ef8-goog


