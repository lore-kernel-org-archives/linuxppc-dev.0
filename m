Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BF60A262B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCNdUxr+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpN81c8Cz30Ng;
	Fri, 20 Nov 2026 06:25:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116344;
	cv=none; b=bF+4fNXOYQQVBdenYWtDj8EJEIBV/XOvtu75h7QER9UKUT32x5Z8+rLsXUcKf7JUcWw5quvWRgin5dxgpWYKulzN3gG+hwaMbV0cNIRdMprjXRptsAM2eZf2H4eeEDtVCHd8z1b5vNildskBCjD7qX4g6+kffumhifgeby3Qz4Umix7yZvEZbLpK4Js+TMP/q/MiGQkOrNb1R22uvktot778VZ+ZeUxmjnZl3b8gQDyA+SsaxPMA3knbf0yAnS6Wc5BQHcZyKylBJCz9PfJV4jxTNiP0mAnP9AucLFqDJ7ybpw/e9t/HfbORGzjRbljRu/s8AgRD3MvUpgiSOrj0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116344; c=relaxed/relaxed;
	bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jgApiSB4pRsBWxSljtkfjS3khEDEoqVPJrfmSQ5zKuk8GTwX32kEV8U1DfIOBxzPwmqbymiOkEVU+/zTi+kdzaPcPC1bI3j5L+l5qkxoKJX8nzFi4Jadeibj+b/gYEykc8eMoGR3MZjvUdtyrrNMAguglZ+sjyP3tY/5Z3mI/4DxVRpxxm2CKtiUNFBm+SpD8324yE5Stn2V10GJaTzEGJDR0wKaPTtClzMeGVVc6UE6URoqcRTzfb+iOLf1tt+42UWJJYYzItsdRGJxpaqb0Aau0jUPvcQUhFFzj8c2sW2tvouwroHxse67oiBzq3oo5zQ7z4EKK3gsTLxGysJcXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCNdUxr+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3nu3_agckdcwqzwomzaowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCNdUxr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3nu3_agckdcwqzwomzaowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpN74W86z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:25:43 +1100 (AEDT)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2f0381f07a0so434505ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116341; x=1795721141; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=cCNdUxr+I4P22KkQ4Ss4ZiGrSLlyviqDRdyxcu7EJD6wPjOhVSaYUu4WCs0S0LSW7p
         Wzs5HqUncaf2rTH77K+SQTX2BcXiPmHDEG8wZZEbgOk5A6gLdWxIjY85BpvrjoWUAldo
         M/g2QNcB9KpjujkYeVmjjPAJhHOji4XwX9jC51rPPAx4e2DNYjqxxPcR55rYV5FrMD2w
         ST7ceMbH3VdSh88DqPOnRaeOZRSE8mcY/yIqtnz+bM0edsomV/+JA58FqAfMha41Ydt6
         XBVIVOAnTb5Maf3YGyMCPPzwHBkVlpY2WLsluF9u/fWzuVadsDEwQQxLIX1Ft33QJT69
         YYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116341; x=1795721141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
        b=GUOWWrnZNc0U1m+2ArJrTs4cr4G5gUY/EQ7X47MvF0oOV4nYGczRNhy9OPn1tL3wke
         PdgNFDq/uuMv4FUo+XF37wNBRMcxzlPfBqc7+tX3clud+SNNyhMHCdPJ8IB7yEHktEcb
         Axr3eC5ZqI/jIOqIypF0y5QcOkUooPbBhQRn5128xxdoWMmAU3qZfsukSIUKmRUSvKl+
         kKm0CbknblVJzmk4WSn7Y0B+S6hPbFCQ8r8uLam+AatuI2T7y4oR31PByu8s2ROgan0T
         4QRJ20lxQmLIxkbJ4UGfoLnaU+9Vpq9YMl9lbGPLgDqrDT7ZiCMnL30CjW/f1rxpCiEB
         Yv7A==
X-Forwarded-Encrypted: i=1; AL+hErG4qDOhk4GaKc3EtUI1yh/PWoP9W6p3oguJgRpZ7XaJGAFj2unydfDOn8aQDLtj3fUJhSo97kc1TZMr7a8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/paJN0fapNAqWRJ0jvUCXUOSa519cdloDvBK/t2Hr9aHOsimti
	ukk/MCeKyIUuLWAfcijcIJ+zesTp/KwiwL3OUXhVEdrVUitKf2fvMzNDzTMnNA2Xu/dDNjw7wCz
	yPDZ/b5CWBg==
X-Received: from pleu15.prod.google.com ([2002:a17:903:41cf:b0:2ef:d860:1c85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fda5:b0:2ed:fb0:bfd6
 with SMTP id d9443c01a7336-2f031e08699mr15736045ad.11.1795116341051; Thu, 19
 Nov 2026 11:25:41 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:14 -0800
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
Message-ID: <20261119192520.1983406-4-irogers@google.com>
Subject: [PATCH v4 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
2.56.1.708.g77570a6a1d-goog


