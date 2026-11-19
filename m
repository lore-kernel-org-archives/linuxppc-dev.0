Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AF606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DRqDDD7A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpNT61TFz2y2f;
	Fri, 20 Nov 2026 06:26:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116361;
	cv=none; b=PLwIdPXKuHWDd8UEWgShx1qSTZOZycnw02MXc7OdgmmG1GFyW1N2OJ7nZrA0Hv2pIcBDQRmYu/Jx7JxJpGY8w0b2JL4eEVGzX9LxaN+oY/cDNLGwOmF1nSzD56fb+F0vwR6mPh1KrC9fKcXKUFRUVUAJfAvx5ZtvXFnOaNP9aT8Eso2HPBGHjkegidW6YEIncrlJMZCxdECb2dPcimw7uZ2l0AFNPg2C7WOxwV/GJbqx47a5nhb8euHonTc6DtOtXGMiH2cUShj555HntATOsOMGrayqMa0IvqFEA7+wEXoBXj8FQdkiTZpdOdDXXk6+agSCu11Hl+hN6CDK4YCOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116361; c=relaxed/relaxed;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kR8bKvKyvodHZaBvjydptItXV7zYc9qDdwQuD9IY6Lh+Sh7wWiF9KtN16bMHLx5t51fD8uA/EpBiro0/KBRjOIBSWo1Ga8we7NreGOe5hb8VJIa99KEYSd3yKfCcHJZF0asi+jjyk779C+itTr2e6I+JSyl7DcJ3Z3P/3jZnGiRYg+euF1HLNU+RVDUsykujyKVU5eOgaKF54vF1iW/WNXodxX25IXQxrRGvWb97N2P35xvEuPvKyfEijYxVG135B9Q7SWlkXW3Pyir1U/+ayxMHoWESWaz+KHE5weoqO+xk7E7gGxk2vh1DimGzEDyU3UFjeqZDbLji284d0ilG6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DRqDDD7A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3rk3_agckdd0hqnfdqrfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DRqDDD7A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3rk3_agckdd0hqnfdqrfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpNT0g9Dz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:26:01 +1100 (AEDT)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso56984a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=DRqDDD7A0PKn0/FPE37N2+QAQN1nQGkf+W+jxgMB5NxPAS048BH9t1ntM4oRf08u93
         9q+smraK7f8hiGv3yEKGaTsKP4uDzguENfIe8ebU7vEwc0PuE3k9mlyBEqmVqfnRC1L5
         rnE0XYcnJys2jlIAP/5HQIi7iUL9QtrJjgBb4g/CY7v+oO0e+4+qdBTfsqPNYBRWKQWT
         NOmlAKm4aFSOgssloX2He3fP96kB82wyBD9N2CDPpuvVbPNSsk6P+cwMdKBF+BMtU2iB
         wubOAfcD5mkmnprbhusXJqyf7ba3WyfOCxjpGY2BHCDd49tOB2z42p6AFSvAn/gXF1pW
         LVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=a1SFZSrusHxXMm0VDXRSnu1y/H2pd4GbBajm56/2qsHSrHag7GLjzLwWm9ACcabkgy
         uzW7oemzWuoEBJcmR0O+o3VmFb3ifJ2sPV3+q3O2wHq+sM5WAW0G8+ymglR6ve9LUdIM
         U+TVQdMZLA/oMM6/S8JC51qDebZSnXu5GHEp1l5ZvTvbmDnUMrp+MUFLpSjW5QszDjx6
         MBEIsTR61hQlfff/HprqiLb3Eo9LV6maJ9XRYIqc0AQXLuSZAQcomUphfsjnIo9zomzY
         +jmGt052k0v5MCNeHdFbfDEDDegPSHK3B7b/Gtxx+oyYKohwY0HsLMRBKBLfWMxi/XjN
         mBOg==
X-Forwarded-Encrypted: i=1; AL+hErGmu94BHzezc+3Zt5dgCCC0c/mBlOloE7XtCdi1rpkBlGqhIC+cJ7nZ26lPtYpixULOz+NpU6xtpHj4tnc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z80za4Y4fDkIXV1WjwQRRzRW848ym+R3qZ4f1IOiTnmszV8VS90
	tX4Sq+WEewhIDpHDFOe6j6D5FSj27dwQESrCH1iAttViPFfTfDGYhu8nKmasOfAsk9aUMnZ4ID5
	06EqJY3+cbw==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
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
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog


