Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB822606A325
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ETPNxB64
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpNk1QDzz2xB1;
	Fri, 20 Nov 2026 06:26:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116374;
	cv=none; b=hw+DE3bDrlNDiHS9/vfiCJV88RXvGs3FFLsshWB9cpPd8Fi/VyZ8Ue4l/m7zdMT4gpNM55r8Jay/RFw07ctkV+K4eAMUbOTJlts9GZiHLml+k1dtTdtrDRbqtw/KbJ6bOLF8KHgmAeqzvfIq4sp7Tb2EuLC+jVJ+elwcdRjnn/llozxUUdHJyTIsO5cMozzlhRJMgYP6DOyYh/RMSpyug+t+bPiTXFdVOG2DNyW6JVrefWVuao8fDjZn2CVhta3Z7syi1Bu30AxYHgRwuZEmglpNd2NUGgIlztbsX8t1RaXGEnWk4oo2pPQ0Fl8D9YwhPyXkXUwC0qxvXX+UmTiZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116374; c=relaxed/relaxed;
	bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mp8zqHFaMKAcqFpxs1AfD4Vf4UkX3GRiOsYhHDHNSF15d21hcV5MAP8GC+sVXMzPyeltV2eEi4TlGlK2JgJB2UigTRjFx7PYltoK4xkBzb60jgzC13c9CD4XmwD9Kxi2OAexxgurVsVgQ768xAASrcS5SQTBf097kHrOr+nicEjgGF4+b0n5fE3Ci3Hl9J03MEchLSEPaNYCyG1ndCTlpmpvM0c1SnXqj8hUX1gfVPwNDCED6c6ZxjgJTcSDZ/9PLxnQOXWbQhnM44h+XuhFj/UXPvYUnAl+/eZ2u1iaPUCgUskIgGpDqivQyjvdg2weRSEbUNmPC5sWBD6I+kqRvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ETPNxB64; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3uk3_agckdekt2zrp23rzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ETPNxB64;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3uk3_agckdekt2zrp23rzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1347.google.com (mail-dy1-x1347.google.com [IPv6:2607:f8b0:4864:20::1347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpNj4YHBz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:26:13 +1100 (AEDT)
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-383f2d05c73so196805eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116371; x=1795721171; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=ETPNxB64BIZNr9saFD3P9ZdU5r2e2qkQIrJKDL4YGMUTAiRN+MwXBU4rzFHFzAlP4I
         0aG03q+cRaGwHHeXO5xrwnYGZrhmil79Vs+d/J5lh0lfTITpRRKkiTSWrhAvPZ4BQ9PO
         ZyVMyHv8n6hnNTZX3tAWmsPk3+HCzlUAAY/1CQXccQy+34+zxkM1CM6LchLiRKbeMDUO
         pSZFM0kfBNizCNBTMCuGMkaY5mcbmYwwG98zXpdx5Ntz1JsKEvx/StiXflkzhk/5Ini7
         owQu1yoqX0wlhHQ3mtCmjjJlravPBOcgapTqgwI7Xg+YtqRHxjfJ8RNG4c/vZUux4/iw
         v1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116371; x=1795721171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=y23aA+Afs5W/nCfYW0TdK71EhofC1k+x0NY3d2erKfUGE2185zmhybCsxneCKDjgha
         AJRzJ6VmMr6H7ayDkB9RzVRo/Ywomzxqv/tc/ViexnPyfWypE5So+kJ+CSbMStPoQkIB
         g9+oNV4Ypu1SucKtrItrr0gHApBMGs9ILWQfNUSPYFLyCVufOmGbKCjqpNnQ+AhE5Pjw
         u5YvBN+6N2Zf7OnqfmNBxsCcdUxxgGtsenQ6g3cQKdcP6+fXPWq9kGe5dDoP3MEX8phr
         CpQ29OTlRznQwbXt2y6bQWsqLSOSTD25TVk6TWGBouDcYKp+m2gYW2ICYyhKFZRYkohR
         xUpg==
X-Forwarded-Encrypted: i=1; AL+hErHlc4d/R5zrQGZDgoaQrsvbXnVyKhSp9HXSHasBYtIteDAe29eHHsXLUtyNXJAK/stH02RxGeNhXd5gT5M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9TrXzbKJoPVlpmzX00pb8+Y31yWp+Ewc6TU+OJor+12l8KPkne
	4XRJSV974syF2M5pWJ2mMALY2soJp0JZPDAwJBLMy6OquCG3L8X8Ax/ggGhI8vno/lGxZW7zFPF
	LxDn0fKzjtg==
X-Received: from dyhd22.prod.google.com ([2002:a05:7300:8296:b0:381:d3ca:9f05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6018:b0:381:9593:9984
 with SMTP id 5a478bee46e88-3857151d6abmr284926eec.37.1795116370935; Thu, 19
 Nov 2026 11:26:10 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:19 -0800
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
Message-ID: <20261119192520.1983406-9-irogers@google.com>
Subject: [PATCH v4 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6663718fb83c..b349e0d8d47b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
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
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index cd41b10e0873..636cc894223d 100644
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
2.56.1.708.g77570a6a1d-goog


