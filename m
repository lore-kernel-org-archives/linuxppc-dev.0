Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCA606EE9D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a3NBbPo4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7C74Gt6z2yGT;
	Mon, 09 Nov 2026 09:39:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177587;
	cv=none; b=buNIIhkJPCUw6Tu2Cll7BQ28w3coXqxi2HkY0tGv6Sm4QxrHxNz27wiHA6hqX0ElxRuq0c121d8TMdSjJiuAaJP3yOBDmOE/hnnmJKye8xdvd2idO5TJ5h1Rn3VYfMqsgaqSqfUFRDAfIoL0AcCxpJfcgezhpEejMhEPG2C6Dif2EP5qS5mFyZh3Kc11X53dZQCCzeMaYdsMEMSJ1zBZ/BvQ9pAqpyukxpldX73HsHhu7wNxxnxIc1+KSPaGlPv6O5njtnboBUpfxVWqR3NxFz3pArv6cve6d0i7nNwBrXCsGgOtLJItTYAhTt0i/d6p1CkCoaeM6bKdFsZ5JcbZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177587; c=relaxed/relaxed;
	bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QhY3xaqM++REEmYgBk57oM3BIYysgYODYXU58x9LqHKSeuaTLHR8aS/CQ0Nlakbs7TxSyhPqr0gHBWFLVSE8WDLl+b/t/nuqOSbAvZ3Zq32VB00GHJYDC5Xcvqc7AkgpRdP/q/yCKgNok18m1iQnbYcuSLXlZWXXPDPRl2a0hc9WEW2opaMij+7qQM24nI/6tEb+QJFl23kBzpUICpl17n2b+dfKCjaRa/JXUImd3qOhgXtUJF2bacbazcCTCzlYDR+XXQJspTkuyjfTVWcO9MtPsNvGUEfGF0gcPYZOIqdC9sSsF2ZmCw5g0v1miecxQoHCLE6TAz6PpUy8VJivOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a3NBbPo4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3l_rwagckdeyqzwomz0owwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a3NBbPo4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3l_rwagckdeyqzwomz0owwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1347.google.com (mail-dy1-x1347.google.com [IPv6:2607:f8b0:4864:20::1347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7C661Mfz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:46 +1100 (AEDT)
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-36d1353fdcdso767931eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177584; x=1794782384; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=a3NBbPo4FQ8jG/IxPddJ3kiaMSGqhBdHB8uQBEfNsErgSzY1xCKJiNsxacy/VV5bay
         vlgNgJr6e8oeCV5TlluORLTSEP2kyfYLlkDmFvuGLiCeRGibZwwHMwDpwDau1AkHbeQW
         sGa3/72ia8VCSNcWX5dVpq6QScjNY1DVptd5FAoJiTvDGMlkX0LBmLiUiq+k3dywgQc+
         oRx7+YKavGTMqGyz6F0THik8ThdlJv74BpKLfY45AIUogqAyFt6h9eWQxLAv9zD6AO/e
         gQUZu/AhJIG0PiiZBJMXMWLTSQ2X1/53fiSIIwwlyWAYaKdX3tjSWtxwSWhyP4ImRLCo
         SX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177584; x=1794782384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=KTZpJH9DHAx70fyVS+1c7UDwkfnSfOrPNyfk6GqrM1ZmL/V8t1EiDRBWe8ejSFZIIg
         SBSqdAKN9q9LvxHVbvkRNhE/bA3hIooe7ldvwogl6M33axqKIgJPkroN85zo29d9wWqu
         htWNXC+HQs0qS9B4z6fG8GgUUBFlGcuWlLBYPnw8KqLUEmwIzKXE/Lese3M5JZJ048BW
         5BKKq7CxHG2J2v/MwW8iuXd74EjvUrKM32JOBufDqCB7okJqm4/fGDSoPEg/SB8/siFK
         H21Bb2sa9zQdkddMv4nJJkzYDx3Q53JCIslrjaygmfZyoRKkLX135EPY5mqNq5rE+q0g
         tB5Q==
X-Forwarded-Encrypted: i=1; AL+hErFIzdw3l8ZGHXQKLIcenM8Fefav9e9PcWdvFUM83ZtTzYrg7pLa18unB7y6xl+yDKmvGdqizRUsG+ey3pA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8CGYr4MlHHSkw75mrWIVGsa9Jza4cP9MHJg5Y2AtfrJpPPB+MY
	nMwYK/5+fkI2vE1RQAXJE9f6DXwv+iwjY4c0ym8mOv6kcWClsG6WzMJ6FpWcqJX9A9qPfPOWwQ7
	b8TyJpRJDdQ==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
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
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog


