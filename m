Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C436073182
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MMZOfviV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlm94L4Gz2yrC;
	Wed, 28 Oct 2026 09:39:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::445"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140761;
	cv=none; b=NUdfFkJcCI296os+LwPtRvlwH4f6Y5MjecYs1bJ/iSAxqAxwBXN1Iey0gvk7Z2axxnR5m2ExMgnQG1/CArK3vFUmwzCRM+bP2pny+hmFhVBSjMkJzI6iGag+VD5kmNmugoNxpJ9W4wdjzTYQ2ElaKwotGo0KZpoE29Hj1wCYfFjHTTnmRnphYWOT1/dC87ZHVqrl8BAxVHkM9/bcKLGPnHMT4EUcSJ+4oAEs9cFONyQa6uZ64W5P4PJpE6UGcTXZz74zTZtymcQQAwvZbP4wr+zBgICgi7fnnLSMu+pGdZ8fZy76kK8uJ5FpKQmNBmKMpxm6UK22OrJw1pqSewBPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140761; c=relaxed/relaxed;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJqfNb+uO5V7bqtrT1rvI2zqEQKlniEpqpuQek9GwwI7l0xu5dS1eYMcmy839eAJX88ssm8Lsv3CNX35CWrllvDkiMfoHsAhWhNSnZ42sL5LMvdIxG/iZ50+TX+ETeajvNERlSi3ka3AzshFPVvc45DI3w1hU9H+UtBmEaF5JKug8Vtr02nTMP68ztJVI3VabGT1Vd548D0mXgCmxtvOt6ispnjitFncOSaA4mwHS9v7hfo1uqg0YEZUQ17VCNpBPPuuqnwNLTfsufUfpl1GZZuLuzSbqiw2tVWt8uI+pxMSxXYM2wrPODN0jkjByTBv+CykLrxkPIIxaeLmJx6UWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MMZOfviV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3fijhagckdekt2zrp23rzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MMZOfviV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3fijhagckdekt2zrp23rzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlm86yf9z2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:20 +1100 (AEDT)
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so413667b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=MMZOfviVlN9mNZ0jSb9vDKVji/u9kKJKbEbUt66ZQFxQcxeH9M4spx04iahYmOQ7Oq
         Go2p+bLRnc0v3J4g8Nj7Msd6IKIrkGt4HojctkcI+nzqi7LnQvyWFymHYh8M3UOTIUFb
         zcTMRz4vTk/+neMT6yARYQgNa3UMPNcjR6ICy4mWdmbUYsOaP+ErwWeEtQbPHzbDkvQD
         c8qsrED8h/IijlrNzNTg7WPlL+YsanCwSqWVvlAXBOH9IIf5kcwznBbNM2aU7VjDu9s0
         n7qjQ6Loci+OI7F/73mqglDCO64jzW42XvOYKQXZqwqL86a8KAErZcch8m5uvmdvvZy7
         SqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=C08j7gLjJ5THCj43JyKbvUzKsZ7SaStec8OLNV75VY0NfW5vLT2oIGNcKA/dtDVfnr
         R8ATa4XUIZnlgo8rPhHfmH9ACP/Rqto81W1uqeSpxEEg0D/N63k12pW3Z4RH6k2w0d+Q
         tRZYciZQqnD7hoM6gmR+JczlkdpeqJFTt3Cu1YfghORw5nlVZfv9p0ig+So5NnqSr6AA
         9gXQODPEKUhd9L4jY/q6sK8fQfN/FTPFpeud6PJc2L1EQZQ5m0c8WKlA7cO3FzGKtBNU
         YSxpeBUJ+yLYpnSaRpH023A1IACUXsnbr0iJYBtV950DuYJWqtQDGUDEIU5/tI/0LQ2/
         XspA==
X-Forwarded-Encrypted: i=1; AKwUvBzXAP/xls7q0q4F2YTbiSIkRcsxArseJGVaVhu7h5djI95yx9IJn64Rqu4JPPrb/4yEH9xXgRJ6EjQesHU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIzzsPfmS4OCWe5Sl3Nc4O9LDg6og1C6rxZhKoo0WHnwP86DVpy
	k6zTwGuonWin0wpN2wZW0ZL8fwd+E9liSMPrWgQi5BOvB9Aw4K/cQzX6lCRiDr6KVsLwBC9txlY
	eDbGhRkiDcQ==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
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
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.56.0.313.g2479322e68-goog


