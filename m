Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8660A2617
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5GdRlPB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpN470Lrz30C0;
	Fri, 20 Nov 2026 06:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::246"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116340;
	cv=none; b=mzR1CCLIy3Z999mXW2E9tuR/9MGRqtJHf0bamEfk4TRynejXuS9BzQzzqGKalqXElHw7MFBw0PEzvzxs0qoI1YPv/TujOAZ8NyVLbjyE+GKDR25lOvPKS0pa3/p5MMhT+RyemOtQl1TB11rH2xw7qy/HBnDD9XkBAXVNKjSK4zlYNoQU2rL6Zcq9gViCMgP5sWn8BeeVIs3DEzPUy4x3YkVjwCrDo4T5KTHwCo7H5irIC9+xzyHewxLNjPShK03eicgnf9ZGfYZl/tY4ni21a/aKxVTb0a7qfoDlh1x9PXZJhlo6oBd/nGuwjwOJgGwtADV2ISVMwrleoy/52GqL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116340; c=relaxed/relaxed;
	bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NojRKqXoafRmQZzm4EKNiwsY9IyO5xPjtnJMh/2rNyHrUdmN3ucyNjQubX7GELdBr5T8Su24DNuRI0nwXL5E1xNKFh3jayZVLvLpORnI9zzBngYu67EJTJ2/74uPiq49E/iFJSOLK03I2QfmIfJ5ZUh0QqggnC5QbaQq1vzsYXeeKJNoXihaxmy6CvT6Ih/lkY30eAB5B8lX4M/N4aPuRoGl0AWBf9+Euq091L7PvOqoTDPT/FZ0Bg3TgfOThfNBF6xbBfQLo1T+ITKU0t7R1fjn++c0mGkUR/xe8rs/5xCDyZcquF09z+hhLEEnQPL0bDgpWLDwz+r+8clp1lecxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5GdRlPB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::246; helo=mail-oi1-x246.google.com; envelope-from=3mu3_agckdcgmvskivwksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5GdRlPB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::246; helo=mail-oi1-x246.google.com; envelope-from=3mu3_agckdcgmvskivwksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x246.google.com (mail-oi1-x246.google.com [IPv6:2607:f8b0:4864:20::246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpN41sd7z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:25:40 +1100 (AEDT)
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4b597558c4cso223155b6e.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116338; x=1795721138; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=p5GdRlPBF/PoLLBricfu1WCgo7s1kubeMLNYAKFZI+ZP13VUnOmrCF4CUIQnGnfE4V
         2oj0XZlRxShAT86zfi7s+4sWTi/iE6TU/AJrW5CmbImKkwD3QMKEGFUXpWp+bU7HqL9W
         3PDQ0pntcFPa/7e71vzuwtMAlGRl1OG6A8O+JK1ZxT/RT3RZlEX59+cvGGTeDhN3el2U
         yV1+UTiciLd1WjtSa2AavtRfci5VK7FbjrkK6ksclXgjThjhzc9DiJ39c+1k9JiapLkd
         jSsg4FSVSx39bJZZT6Ih3aVVKSakfiwMsJc1qS9mUP+pZU95M/oGqsrx7nk2t6uqQy0D
         LG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116338; x=1795721138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=SOfFTBB+xcFPXBtXlS2rGvRNCTcnn76nhjvmDmtkUl8+sLEUCFEb6kU8buaraLf8c2
         BHbEfOVHE3VTkHuiZydEw1EestyhTbKMaujMP2/ik5OQJjyiHf1wdM1s7xBsXfzWJIsk
         Q1Zg93wXtVn6ZfbxrDD4OqWAh04EyfoNeGafzCGHidA2+s1hzJf6hmqEQozbMCIsjYXA
         3axkftIKQUrG2yTwImkuUspk3y8BEF9ocnr4OfLR+btx8KDapHdkG4kbTcPmYvrpFcRW
         zPfjr+lIJNETe7XQO5x9A7dgOcyqAFar4OGtUJJY1/BQX5DkuIUHgy4+AK8itwob3lF9
         HhLQ==
X-Forwarded-Encrypted: i=1; AL+hErHq2AstUzMQCqzYfHgWNcBrF8UUA+AbymstkDuUBkI/4jZkhVuDRmKVQfvWhwYSVdzYEpH0+VrNYw/4DbQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8DGBfiGlkyg6FsPINaCbupttjNajcW+96QsfGgX3JY9dQOw/PE
	mzMntdvzCDqldo05Bcg+iFC4XArrmaL61K4Qf/STF8AfHBM9MKMyeRqwtCSJjZcl5qpG8F0mmkE
	jJi/EXw3kkg==
X-Received: from ilmp8.prod.google.com ([2002:a92:c608:0:b0:51e:1b8:eceb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c110:b0:576:4595:9836
 with SMTP id 5614622812f47-57a0ba52419mr994155b6e.40.1795116337420; Thu, 19
 Nov 2026 11:25:37 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:13 -0800
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
Message-ID: <20261119192520.1983406-3-irogers@google.com>
Subject: [PATCH v4 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
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
2.56.1.708.g77570a6a1d-goog


