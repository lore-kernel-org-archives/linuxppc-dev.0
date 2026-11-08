Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632F606A322
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kGd7fiWd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7C929Syz2ygW;
	Mon, 09 Nov 2026 09:39:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177589;
	cv=none; b=WXp/Y6CdiO/0wJlgZXdV1fYv+z8UQvpUIf0ZZziHgaB+Bxc1Vr0XfF3qXgkc4/7/uDjOT1GG/o6yk5NnKrnTkRxpaMkSy8kUs89i0AxUVaWUpnaUaAY1L6OdMJIhPQFSFR0202IK04k5T6CqYjNf3TrjThLRB5TyeY/tW4wrCH9XJCic0ZtdnETBRmE4v7rgM/m5rSLI9INLQHBFOKMNcDConTXZH+AbKAD6/PuIjKTQhE8Cacl/+PWAxYqogU5khJmgUyVY997SPVss0PCirTZpwzmbcNTFIJ7xXcQoOqtGB0QoG2ys47bueGq6+UpokY0mCGmjJEdJ1Zg3OmleJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177589; c=relaxed/relaxed;
	bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FvS4TjsNmPLki4aVft2KjzqUgfVHr+DUxnw6J6Et0iWL7Y8p4empEvhsLDU3KgILGp8rJxPee/xznut0uVgpXpFOL286h5ly44gmL0zyeqfe1rrUbz4eZrRN7mRzWqsymLIUt9+rhMq4KkNm9at8CdyHMdy6t6Cgfd+uA8ZQHE+uyxq++FW4ASYMonTMbIuT0zGx2b0E7+yjUQEbrsCTbOLBd4YdyogdehZnsc09t6W3YtXPHFEJM78JKdiiT1EYQFzzqIF4m1DPWpVrQAjHOtAcGo/ax4+dMMgK/597+DrHM33TKIgAr8+ZwskJb3PkNMP3gqtuFIKRgXtkYwCGCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kGd7fiWd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3mfrwagckdegs1yqo12qyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kGd7fiWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3mfrwagckdegs1yqo12qyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7C83ZcMz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:48 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-3724667bc16so320744eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177586; x=1794782386; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=kGd7fiWdla26Fi3TBiqGgjfE43slh3YVv3OHAmcQ2c8sLZyCA9Ee6IfMi4KrUC4Ow+
         on6YrVaH6Pa+RyfCBkMRQnqbQaIHawFKojxda8JSXpEw9X0h5sNkmRN9gqdLSfKhmn0x
         hhFyw22TU5enPEcoLOJYaV/edZMmoIRT/3vW/xRDtGaTnBl3duo7Kqmo9ZHRJsBLHhUm
         srbkpPnJxg8/UadSzZeRuk/c5epeC96apvVCwudbBgjEweQm8KUonf62mt922VbviXZy
         PIH+0uxSm3tNF/62x6yDkzX+IXGH2SHUUqY47xq51r6u54eN09lcmBjdBdyvV/HVIbr/
         hs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177586; x=1794782386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=OksY5qabVZgn37EAS4dT5assXLlXjIPT9kEeYUQlUxc/T2gCz6cxixbk26bu6bNSFm
         Er+GhlDZ3FG8dx2QPnuT3oEdb0CdF6y5iqbYcLUwBnFVnLHFMhK1P0EO97zKrOKnDFtZ
         0ZrJw2HzeTlLh7dReSmDOQQr2id7pdj+gPA/3IZJ2Pt7pR3zM683DsLtLW4WmBHZHqY+
         XiNGfnIHhXnxc5KZyqUJD4jSOR1DuY2C7WUKfH6yjJDLcpm604c5RgI3C5nxe4PxYuUO
         +NTozDG31C164rRsPK3ccKVwqAEFtOB2CDX1Agc41wSb9PHvfrZ5WA1b2yIIEeGo+Xk0
         zJ7A==
X-Forwarded-Encrypted: i=1; AL+hErHZVoZfMB1ErWka5FikVeM3PWD5Rx3SsGNrYAbdCAj+I1Tu8/4bCmhqxiBBLjd9U39VemQ/CZEe/T6H2Jk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9+7Pwk69ra1/cLGaobBTeYIOPbiY051p9wUo8fA94uOToHs1gX
	C5+U1XPsbiot65tbHq3DxGXBhJL55tqoRiaOeVJNOxHNVywtqJ56F0vz37RrrzF3zvDharDz1DO
	kR3CFsIfDTA==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
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
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog


