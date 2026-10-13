Return-Path: <linuxppc-dev+bounces-29447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEECCC6B0F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48S83RXLz3c8Y;
	Wed, 14 Oct 2026 09:40:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931240;
	cv=none; b=nNu1J8u2mZJ620SLVqmaFKjS3fho1e9cjRmelQf+TkXOM2xkbASdpdG7lyPZheO4I0tH1wjvYJEp7hmR2PmvAxaIIEmni77MdemFMzR1ToicGdYL5RrHTQgskQTyCZjo9XaPrYx9RddjKfjjx99a74s2CFINXy23Qzd1EMdTqcFnYGwkLbUsAGNjTDR8i+T8GFVzWF1XVXoUg5WJVGtee9WawQPhd4nIduALjwknl8jHtSvgHfa1PaEhpEEunaSaRz7kWWQi9jbb286soKHRuyyMnc66oU6l16VYJhaueORzF2PU5zAlqzM17XLmU0VEX248BrdlIHHDWriUGAnOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931240; c=relaxed/relaxed;
	bh=5eLIAAx2L+9DvCRKYW0jDBbtdiyv3jUNIhafttj/B0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUE20jdzXx3Abq1cD1IzG83gZtNmmPAp9njMEhcvk0kmeuCOvaEB2RZncEIrSdmprZNM9s5zLfIQ5KP5phMsPQABhy8JvymWUXjtno/Je0XrZtTqkZ/cMCFRTibKYQnCyQ+f7/wQCJnjdTBQS6yPyQObsJtXJRqHe8Z8qTA0Y5CjgZH6/IdVSonbs5BvGDjGHCQSsXa1+9I2ORCCtmE801Cs/54sL/ZhTvq4zD8oegXupdtk/dqML1/w0JeAlkzShcET0irV9EeN2JbEePfBPVwHos28szUCS4JWDpG0I94ueyBZvPUtCXpRAuDekiCJJQDFjuX+eME1FzaXOKEcUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mvCMDNBC; dkim-atps=neutral; spf=pass (client-ip=74.125.82.71; helo=mail-dl1-f71.google.com; envelope-from=3y7poagckdgiirogersgoogle.comlinuxppc-devlists.ozlabs.org@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mvCMDNBC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=74.125.82.71; helo=mail-dl1-f71.google.com; envelope-from=3y7poagckdgiirogersgoogle.comlinuxppc-devlists.ozlabs.org@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48S76GY3z3c6Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:39 +1100 (AEDT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1663fb7e005so4564897c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931236; x=1792536036; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5eLIAAx2L+9DvCRKYW0jDBbtdiyv3jUNIhafttj/B0g=;
        b=mvCMDNBClPhgRYyCHd4w4CIDuIsqcfuu1hRQ6zSve73Be/mSxun/fOh+4MdQ3JC/uf
         Uxae0Wrk1ZKGmh585Uua0AfXDY0SqtU7sz7mQp8+ldHfPGkw5MFZ9YcxWNsmGuv2woQF
         e2tIwtg4VL01Xykv3XQ7wJtCTZmBbzrCb5Xxd7JxKMsWcwCQFoP5FVGrcwjVFx2cwoim
         MIftH6/U1eWKjw/dFLMNyvlsGpuYExHif/NfsQTgDonJldwYTEWHNjADj4kUdYPZJW2a
         lmWTgXYz1RDernqqGqtxQwW5/69fspHWOxUGSPuRqaSb6xpyERN3pCq8OQ1TVl1r27GU
         GiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931236; x=1792536036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eLIAAx2L+9DvCRKYW0jDBbtdiyv3jUNIhafttj/B0g=;
        b=vHgfP18+JcW2VqiWv7gK3N1vPsvC1WRofe2dDri6evnzPcuM8x5cPEmyY2Utr6D3Eu
         jHb/6nlRPgPpzDP8LC3rYwh0YG5A6defr2OQHPL8bLM9vdXNI5IouCT83c5pnA3oYnhY
         eAIOaawGGtgpMTZaB8g2uVIRwnayqNuFOVOPlKfzwKlCc3ytx/HDiOnNIJ92XohFx3iT
         Mu6YJvTXPVVWlg2x9M1t/zoC7wZiFX3sPiYOcvYdVAxVtLQ8o5r3JOObTOn6vnRGebTP
         qAYLUb4khHYq6iljcfpjqeLCPdgPeNPLfM3Vb1DcUqAJcRyd1FHkw+myOmGbVC0SGI0p
         doKw==
X-Forwarded-Encrypted: i=1; AKwUvBx+mj8U9JWTiTrSeSEsEdbPWVeUEjVphU9RHrYZgVk+JRD20X2HsSyZvcNXBxUxgKvW6ZVplMMmq7qCSV4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL6uzHknvzp5hTTRpFbKvnwIEmQMmXcScgjdu/FWT/LpO3bAJka
	xhTY4TT+mOd1FUOm9dIOwcLjbUHK8M1jXrnMVjNwPSMyuItSC2rVdrKPLnQ7HxgmHKT7WTnqet4
	s+cThWhiq2w==
X-Received: from dlbuu9.prod.google.com ([2002:a05:7022:7e89:b0:16c:bd18:1ee2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:231b:b0:165:55e2:2d69
 with SMTP id a92af1059eb24-16a640fcc35mr21018967c88.46.1791931235508; Tue, 13
 Oct 2026 15:40:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:45 -0700
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
Message-ID: <20261013223946.1836757-11-irogers@google.com>
Subject: [PATCH 10/11] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put().

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da95..6099cb893573 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -510,7 +510,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -550,7 +558,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -699,7 +706,6 @@ void kfd_procfs_del_queue(struct queue *q)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 15eeaaebbbcd..8d1afc5b47e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.0.385.gd3acb90ef8-goog


