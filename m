Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F687606A338
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KA3M3dU3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlmK2MWxz2y7r;
	Wed, 28 Oct 2026 09:39:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1245"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140769;
	cv=none; b=TYzU0P+qaxnHdTOSvJoO/ZKBmzIK1fRYABYAwr5J3eYAJmuY317ZSLrfhMZWCV7hyNQ1o17DfJ9IH3kQASS06CPcTweB15RQRZEvycyaiBRY3K59NXA9P/yN5p3pVLBV3rY8lKfPSSyeYLzoKHENa+JjolZ1CNpBdQBOPWtk91xwAzI0VhvxALjq/w/m3KyxP39yJB0CWT/VlQ/6sY8OCJfrw2Zu24NMcTybXnaJN84QFwptuX86iWp4Yphg+a4OaM7i6AX4bqtlZ0LLXA7v62aYiUPvUIxGAaNUkV0zZp4S0nhAelZeT9SjDRe1KlOZaJFeQWXNtKuSGhK+EEe1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140769; c=relaxed/relaxed;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goSWQF9fV6PXq7s5REnNA8aRB+gUi7ZiTW2BiAfhlCeo65ik/4cw6oHTYbuRxIcD+TwCVfdKRqht2RRis9Sllw+0hXWYX1O3rK+w/ytqoBfqfA//wzVRb62gFNm+PrPkIe4hMsGMvsq06zwE5DJEuLNkN0ODUQyqQ3uPCuorC6ixZEbyvGZVO52Qos2RvBIvLH3gMk/AIBNZz31dRt0KXoxwwdEaZOfpMYOEQX0PJ4tNmsvHKXmXLQv4p4s0WI74iHGF7l5Y2oDwDTGXupMuo5IunGhTD/UI8AMq0qawdAMmz/bjpPA11eRSLndEAVan+nchy/ewmuvZYAB1TQV93w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KA3M3dU3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3hijhagckdfe1a7zxabz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KA3M3dU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1245; helo=mail-dl1-x1245.google.com; envelope-from=3hijhagckdfe1a7zxabz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1245.google.com (mail-dl1-x1245.google.com [IPv6:2607:f8b0:4864:20::1245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlmJ4Q8zz2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:28 +1100 (AEDT)
Received: by mail-dl1-x1245.google.com with SMTP id a92af1059eb24-147be78cd56so953099c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=KA3M3dU3fW9MDfN9bbOIauywrgBOR05k1IGvTomX0x+5rJwgCeoP0II0/fsPdL7gFm
         b76ZuBT6MIt9MBMnqNmaAhY+5ZtKvMMWByr+a66lZ3wTAYG2J7aADATyAk7h0v0wzpQf
         x/rIivQmFg25efiRSTlgLm8ibbfmaY7cxIDvKXlE/ZHm13jGJgH0IGWkLKRBRWEqVwMd
         1OLTNlobj6v3zmW7TizQeHvsXqA+ecLdl+BnPfQCozLekiZf14evfgls6z99VeGN+y/p
         XtnAxXrr2RxTtoyKkErEioSpY9llpH84/cRToaC+BJr6nyP4iY2nosd6ctbTHbcP6/a5
         f3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=INURacuDnMf+u7pRBuMn40gdy0S7uu9eTsofyE8yl89IsQPCaFqVE/V7eqBXIBVdKR
         JxM0vlehxDzhxc3goZpHRcX2ZZ9bqpQhWaRt9vr7OIsdBOwYB3bmFWPtIr/aDhpapkw5
         Z+EVN/6LjFbWWoQNaJDWEXaMWWvHj4oA34dbMbfqDgjnq3Km/6IzmMv8AoewkAgbuIgW
         0G7Xzuoy4qAycSOdrwuD61yVRPdYA81TUFAm1hKEJvxeUXRjPeYY4Q3F0DSxMJGCBLgp
         GUfC4eZTQgmFV+Vf/x9Y/SMIa4IX84DZ6xjSmRZ/eswv2Ei50WXrXQEUjQhxIGwrVqLI
         05pQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVI76nzUQsI2qk5VclECk4lcbNZFpSq0TlmstMd5QLsSXWnp1qVqNiFlZQuObNCsjppo1u5cRBUUz1F9o=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLilTCbAmecMf7T59X05G6F8Z+7fJIV2XaSNAe5L9gsdxOvW9cb
	1XRrO5AV0IWDGw2SJItU+QDMZAYugUvLZm8hVcsNhuzEbGCNoqkd1k66cgJtQ7Hxc9my09cy5dq
	nsvTj0SAQ/w==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
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
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
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
2.56.0.313.g2479322e68-goog


