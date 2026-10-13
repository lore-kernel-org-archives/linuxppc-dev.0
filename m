Return-Path: <linuxppc-dev+bounces-29445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E294CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48S20tTjz30Vs;
	Wed, 14 Oct 2026 09:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1348"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931234;
	cv=none; b=Z65tj9C/Tyi2Ul6eSL136iCZ/Q/i2H+oMUrr3Befe1Ldgvmx7kbvcfSlrV6QM07QT2zI6b0xnVZdK71jVGPbTZZWtRs2kA+Idvplj+YmUP3oBqhBvCLYAzg5rOdAkTvMR1GyiKkc/CSfRNohNSVuPDPUE+HllwgL76w8Y2GrroFwW7APUI0JPTgbAlGwgn0dFaKkRyCXWiefLj0rd9PTVkYd/LQYhh4EItDs1htYWJYb3mHuX7PtK6QoSc7GTYNR8ieODhnio7K2PaDIGruBmm+HC4LiPlqRfkQD889hLHR0wlJ1YYKhpqpdXW6h4qxLU/ed8vb3eEkKZTpJgSrmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931234; c=relaxed/relaxed;
	bh=E3db36lwsPWQArDIHzP6eqDHTacNJpd6D0FMiQjZlVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gs6KTUwJQDgtpBpUxxho6BHHfGmRueF88uyOcTyptQ0CPL4CNPtamc6kxnxYUtc4IHQdm0CdvKCtdNfRgTbvvVwbS8eUJsLWtIcePWwPTPgkGJ76FHGgtWht0dbixylS/wxT1MAZJB7R1gBp0RhODaRy6ihtVE4O6V2TaYzyW4w2HzLxoUGCPNEBfLGDfRkfMyDX9BAUz1AZqbeNfILxQH29kBkP+ggFhLvc+eySXm4AF2ZSld544AxfWTFf/Ik36nYu8lf0KIedEMOwYENVGlqqW5jISsxGi6gnhRprlNa1jBMBXtmH/lv2txGFdHcOjpHoZqkbCK9e2w5PkLlWIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oyubUZdB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3xrpoagckdf0dmjb9mnbjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oyubUZdB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3xrpoagckdf0dmjb9mnbjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1348.google.com (mail-dy1-x1348.google.com [IPv6:2607:f8b0:4864:20::1348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48S12NJ2z3c6Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:33 +1100 (AEDT)
Received: by mail-dy1-x1348.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6716350eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931231; x=1792536031; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3db36lwsPWQArDIHzP6eqDHTacNJpd6D0FMiQjZlVc=;
        b=oyubUZdBxUdTy4ob1yZn7yDDYu1DRYYjwQIVjODdZIzviqF7K+gfenBNcl5+ChWWeB
         ePyNj9cVlIyRsg7ftuE0mePd3mQMSE7C3OFR4l828zy98VwXN+Gw1DxakbDPukgcHaDK
         GIy3AuaR/Hx1RSo24lnjFQtLTxDiaQO8WYG0Z5dAUEOdWAUPpCuOX4drbnh6ksdQZDiy
         WfQVxLJpnMjiAg/BJRSrZrneiAn5dq9gF8/PJqwEDzRncZGZv/JDbUS6+MivmUTLX5TY
         IAKad+VTndj5Un1CEVwvwKixbsW+1T/Y9B20fBssCzfrnm1/8vmjoXljTqULddQEmpuY
         2gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931231; x=1792536031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3db36lwsPWQArDIHzP6eqDHTacNJpd6D0FMiQjZlVc=;
        b=SvQwujfujyw9pw//UaY3B/oOEwC/XlG5jdeQ/UyZGpeDBXyB/8mSsPL2BJ5GVbMFS4
         cr+Tj5OC2pDiWf+S+yHC5tG9Uwz8UAQfHg/6jOxGboThW3Rshgs9wBCJZycdYziPAx+I
         cqZmStbhbuc+dRTdwuPNZ5xdpACOPnVEWIwR1+h1p+Rh9d2FlJJYRjWC30cm7WKMkcO8
         Wb1XFQIFnz8xo0jHZ1+ehE0/oXh4gMuRsA6Xw2AjyRxjhvqhiAYPopta2PFcLVKSvYLV
         sD3wfjx7iXMrRIJQzIEndKs2307QGWBjdE4ztOi4sGQBdYm+yELzJky9bSH+XVUw0XUA
         Sh9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwaIEN793O6VThIxlvKO94FjSDDsZdK5EZjD2PVshyDrnbWG+bfCXVHsEzDvrW0V1RycsN3n0BQmoTbhYM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJe1fR9MFzekCUrHtFoVsewGT67YRfv9u2H6V5TUQCV7Kfa9vuh
	zZ0N7pmwad+qSv4upKLMwoJ5rU+ZY+CxZw9wHgEVmaiJ1/F2P1jfCeiStxoNli6K1e9wIsbinDM
	KFVHP1CJrzg==
X-Received: from dybmd37.prod.google.com ([2002:a05:7301:1825:b0:351:1da6:c2e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:78cb:b0:351:515b:4e85
 with SMTP id 5a478bee46e88-3537e088bd7mr19706222eec.16.1791931230851; Tue, 13
 Oct 2026 15:40:30 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:43 -0700
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
Message-ID: <20261013223946.1836757-9-irogers@google.com>
Subject: [PATCH 08/11] s390/sclp_mem: Allocate struct sclp_mem dynamically and
 add kobject release
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

sclp_init_mem() allocated a single array of struct sclp_mem with
kzalloc_objs() and registered each embedded kobject using a kobj_type
without a .release callback. Allocate each struct sclp_mem individually
with kzalloc_obj() instead and add sclp_mem_release() to free it.

Fixes: ff18dcb19aab ("s390/sclp: Add support for dynamic (de)configuration of memory")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/s390/char/sclp_mem.c | 73 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..f7c161e0d836 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -49,11 +49,6 @@ struct sclp_mem {
 #endif
 };
 
-struct sclp_mem_arg {
-	struct sclp_mem *sclp_mems;
-	struct kset *kset;
-};
-
 struct assign_storage_sccb {
 	struct sccb_header header;
 	u16 rn;
@@ -304,7 +299,15 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 	return rc ? rc : count;
 }
 
+static void sclp_mem_release(struct kobject *kobj)
+{
+	struct sclp_mem *sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+
+	kfree(sclp_mem);
+}
+
 static const struct kobj_type ktype = {
+	.release = sclp_mem_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
@@ -321,36 +324,40 @@ static struct attribute_group sclp_mem_attr_group = {
 	.attrs = sclp_mem_attrs,
 };
 
-static int sclp_create_mem(struct sclp_mem *sclp_mem, struct kset *kset,
-			   unsigned int id, bool config, bool memmap_on_memory)
+static int sclp_create_mem(struct kset *kset, unsigned int id, bool config,
+			   bool memmap_on_memory)
 {
+	struct sclp_mem *sclp_mem;
 	int rc;
 
+	sclp_mem = kzalloc_obj(*sclp_mem);
+	if (!sclp_mem)
+		return -ENOMEM;
 	sclp_mem->memmap_on_memory = memmap_on_memory;
 	sclp_mem->config = config;
 #ifdef CONFIG_KASAN
 	sclp_mem->early_shadow_mapped = config;
 #endif
 	sclp_mem->id = id;
-	kobject_init(&sclp_mem->kobj, &ktype);
-	rc = kobject_add(&sclp_mem->kobj, &kset->kobj, "memory%d", id);
-	if (rc)
+	rc = kobject_init_and_add(&sclp_mem->kobj, &ktype, &kset->kobj,
+				  "memory%d", id);
+	if (rc) {
+		kobject_put(&sclp_mem->kobj);
 		return rc;
-	return sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);
+	}
+	rc = sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);
+	if (rc) {
+		kobject_put(&sclp_mem->kobj);
+		return rc;
+	}
+	return 0;
 }
 
 static int sclp_create_configured_mem(struct memory_block *mem, void *argument)
 {
-	struct sclp_mem *sclp_mems;
-	struct sclp_mem_arg *arg;
-	struct kset *kset;
-	unsigned int id;
+	struct kset *kset = argument;
 
-	id = mem->dev.id;
-	arg = (struct sclp_mem_arg *)argument;
-	sclp_mems = arg->sclp_mems;
-	kset = arg->kset;
-	return sclp_create_mem(&sclp_mems[id], kset, id, true, false);
+	return sclp_create_mem(kset, mem->dev.id, true, false);
 }
 
 static void __init align_to_block_size(unsigned long *start,
@@ -368,8 +375,7 @@ static void __init align_to_block_size(unsigned long *start,
 	*size = size_align;
 }
 
-static int __init sclp_create_standby_mems_merged(struct sclp_mem *sclp_mems,
-						  struct kset *kset, u16 rn)
+static int __init sclp_create_standby_mems_merged(struct kset *kset, u16 rn)
 {
 	unsigned long start, size, addr, block_size;
 	static u16 first_rn, num;
@@ -394,7 +400,7 @@ static int __init sclp_create_standby_mems_merged(struct sclp_mem *sclp_mems,
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size) {
 		id = addr / block_size;
-		rc = sclp_create_mem(&sclp_mems[id], kset, id, false,
+		rc = sclp_create_mem(kset, id, false,
 				     mhp_supports_memmap_on_memory());
 		if (rc)
 			break;
@@ -405,45 +411,34 @@ static int __init sclp_create_standby_mems_merged(struct sclp_mem *sclp_mems,
 	return rc;
 }
 
-static int __init sclp_create_standby_mems(struct sclp_mem *sclp_mems, struct kset *kset)
+static int __init sclp_create_standby_mems(struct kset *kset)
 {
 	struct memory_increment *incr;
 	int rc = 0;
 
 	list_for_each_entry(incr, &sclp_mem_list, list) {
 		if (incr->standby)
-			rc = sclp_create_standby_mems_merged(sclp_mems, kset, incr->rn);
+			rc = sclp_create_standby_mems_merged(kset, incr->rn);
 		if (rc)
 			return rc;
 	}
-	return sclp_create_standby_mems_merged(sclp_mems, kset, 0);
+	return sclp_create_standby_mems_merged(kset, 0);
 }
 
 static int __init sclp_init_mem(void)
 {
-	const unsigned long block_size = memory_block_size_bytes();
-	unsigned int max_sclp_mems;
-	struct sclp_mem *sclp_mems;
-	struct sclp_mem_arg arg;
 	struct kset *kset;
 	int rc;
 
-	max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
-	/* Allocate memory for all blocks ahead of time. */
-	sclp_mems = kzalloc_objs(struct sclp_mem, max_sclp_mems);
-	if (!sclp_mems)
-		return -ENOMEM;
 	kset = kset_create_and_add("memory", NULL, firmware_kobj);
 	if (!kset)
 		return -ENOMEM;
 	/* Initial memory is in the "configured" state already. */
-	arg.sclp_mems = sclp_mems;
-	arg.kset = kset;
-	rc = for_each_memory_block(&arg, sclp_create_configured_mem);
+	rc = for_each_memory_block(kset, sclp_create_configured_mem);
 	if (rc)
 		return rc;
 	/* Standby memory is "deconfigured". */
-	return sclp_create_standby_mems(sclp_mems, kset);
+	return sclp_create_standby_mems(kset);
 }
 
 static void __init insert_increment(u16 rn, int standby, int assigned)
-- 
2.56.0.385.gd3acb90ef8-goog


