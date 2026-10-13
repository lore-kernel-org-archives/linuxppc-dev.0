Return-Path: <linuxppc-dev+bounces-29446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A507CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48S62MmBz3c7R;
	Wed, 14 Oct 2026 09:40:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931238;
	cv=none; b=A2WKGkm/HFUlBKfc+y4IAGiwTGeLt42pFboCIll3gLUoqOxss9gVNC16JdbOOTzafoc54VTS5JERby/D7fS88lGhi9nblFkddNmnQGp7wyBwbeGlsHml1ei1B+0xV9m1bQ4SRxTg2kfPAIH4yXP2kbDehzwGYdZ/VGfvDO5F3t/b0WjUuR1YY6cHdqiIUS/bOyQ9sCetUwSPOkx0ShjMkTti0AEWBjyB+SGOH72CHGxJv+WkExh2EkKfe/XeYl6LWOP+Qphyr4PnX/bb05mOQx9Cdd2LKzEzbPllTtRPnnFQK4CkZ9P6cCqVlArqRPdImM9Lvp0VniKq/h8mpxqINA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931238; c=relaxed/relaxed;
	bh=gurzTkqqRagMZrBgJFBCVz7i93uSa3r8+lp0iuHqO9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mntQFvvN8AyTBTxNq2wj4idgFQoa2NlgayNVorZpwnEqHes2UiUsvo+6ESdTlpMab2fyQs9VpiXfSEDt2CCz/8Op3BlcceMM2/qB2QB2ptirBdlGkGaDRiUotqMXikObACztzJpdGoQEy84Hm3Ml+JFIOLrt4Ee10UCy2kVNSHf202fFDfd7fmDUR0Mxme/6jPVvyL9xHrNjK0FYOaYMVYgL24i37mrOwaySJsSVcfcXkGD/facyDktBMwqcgUlnj8RrdIwfKTuMZQm9F1eJAcgAKtSLzF0AFeLjYSxPD2WE4YnXwJQLGGO0J2w+yVkcEi6h0yr+msCwncweztN7sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RlHNMQVl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3ylpoagckdf8foldbopdlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RlHNMQVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3ylpoagckdf8foldbopdlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1347.google.com (mail-dy1-x1347.google.com [IPv6:2607:f8b0:4864:20::1347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48S55BpRz3c6Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:37 +1100 (AEDT)
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-33713e5e6daso5245755eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931236; x=1792536036; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gurzTkqqRagMZrBgJFBCVz7i93uSa3r8+lp0iuHqO9A=;
        b=RlHNMQVls6QTztc4+mj0T8ZUkH49odcdrfF8j8LsyUxs5fXbVa8rnVeqWuR0mzNhSF
         pZyuCEcKttlIyPVG+pupm6iZLV83CNgAspJ/iQ/0+LjCjBZL2cXO/bX3lSH++ziUrU4N
         zTUb8MKM8JMU4ggh/jyichm/wIrwy6SuRcG9e4aCo2C3uuEm/r207mynEgXZGRfKgOeH
         9jmQOX6axq7D5k+SJbamGhOF9vcyPqvD5DVFIHlbSbh/dx1tcc1Rx54gcO9AbCtxMo4L
         vd3yhzUeKu3Tdc5E7yt7jlE6RXaPwgx7gurQKzxGwJPOAusGP22qaZ3x46d9v1Nmf1ze
         hmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931236; x=1792536036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gurzTkqqRagMZrBgJFBCVz7i93uSa3r8+lp0iuHqO9A=;
        b=skWiB97huOSKkMjyCGuKnWaUk78h4x0ou9YBy5SBWxikd088wOp4kPFZZDav/NzcKP
         BuSkuRuPN2kIWu1JMh2/xeIHc/8K274K6I11WnAT5t/9hfV7+qv56+DBHnJ55CgRK08Y
         hMxksTk8NPcXgs4dReKSpZ0Cj29FPn+1kRqKcdmtwupUzayrr4VBAEsrg2rKyilGHAMB
         LLXlOVNvv5R/FAyXmIzYDCbMPxQ/wKnP90T4gpUBN3CulsWVg2SYqeTKcpqIjMGixi+K
         hjOk0CqMglfeHHcD2RCTTISzMtYYocgKuvSlyXteRx54r9XMbgqGhZ1szSFA7Sb/jS37
         LNZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCS11xA4muLAgskOdSeVnC0c7xDCOoWJa7rSBhs75HkvA08nerP1SIW9A6hFdzohzaKYXWqXMU9FllaUY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLAfONFvfHLMF7w1O5pC1/xpApScwMC9JdxLPMEFcyPTbLJlroz
	cAP9bsq50jLZeg3IU0+5h18uH2US5gG1nLzPLhpD0j4GTqxFaXEocpP8VPAT/kSn8KGQByi6lIt
	Egx9hjNX67g==
X-Received: from dleg6-n1.prod.google.com ([2002:a05:701b:4306:10b0:160:bb23:390d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4586:20b0:169:b1b1:1445
 with SMTP id a92af1059eb24-16a5dbfe73dmr17947821c88.31.1791931232672; Tue, 13
 Oct 2026 15:40:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:44 -0700
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
Message-ID: <20261013223946.1836757-10-irogers@google.com>
Subject: [PATCH 09/11] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Assisted-by: Antigravity:gemini-3.1-pro
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
2.56.0.385.gd3acb90ef8-goog


