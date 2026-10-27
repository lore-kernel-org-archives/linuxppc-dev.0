Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F080606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpDUd4jc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlmR12q3z2yWy;
	Wed, 28 Oct 2026 09:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140775;
	cv=none; b=jHhVxtLKWyQ5rmWGzfju/wyo+kMg6CzWjgrpOFc3WRUYe2V4E3IGLZgFKLwD+suyau5EKejhPJGihCpNG8zMlVtlpTjwdwov0yjTRJlzLCmfT3pmrvo/eVLQzXiWEiUlAsryamMyibqjYJ/TSETw8I7vK3VcrJT2UPfL+gL+rwcHyH+pirorMAqM69/8iToSXBnL6bgTV8GH5V1hrXjjemTa0uAgBl5oARV6SJfA1DapkmdZuBh9BEPPdKekA9sxK1x3So0ASnNTMuRb/Yi2fMjbK13Uo90NY44gtIufy8VB71/hYiuO48A/UaTSdoX7+wLsRdiLNR6ZJl9S5yh7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140775; c=relaxed/relaxed;
	bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXYcf9QngBTQ50Wipxv/NeaR4s+MKbghn15W4D3hn5tZ84r2yE2/lK7UW5o+KhNUPEeICRx387vL1Pkg7SQ6GTucOH+BuKAEewAkxwQXwVGsWIJCBWyjVrVLFLMFOr5m/vML0Fx2QqDpaoXZpdtaF0xoQfMKIZHaw70ZN3JQyXt2091ThcrXYGUcKmJJiiE+6Y+eJovr4quj8uUCjNPzqj3ZD6Jj48Xi9Eu5fNzSCHx/+hAtT96bvD+u9xnlkjo+BaLB4Gjqurq9b0jov6azpm+5EmSU2gXrnw1JpT3ES3w6/0vFPh+Ek8joRBIDzyfTC6SYXyWX9QtSuy0qzQad/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpDUd4jc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3jcjhagckdfc7gd53gh5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpDUd4jc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3jcjhagckdfc7gd53gh5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1347.google.com (mail-dy1-x1347.google.com [IPv6:2607:f8b0:4864:20::1347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlmQ2wRbz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:34 +1100 (AEDT)
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-359b81ad4e8so403040eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140772; x=1793745572; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
        b=fpDUd4jcX+jwOB64iZ4fLqAW3l0hMutPg14dMf2sUC+Y/9AP8ujLOkFWyo40mZbwhL
         SHRuU0hPZ0VALFYhFI1iDzINEbAQ415/EFh+PuBoqZftgTFsheV1F4n89jHS+O+d7d7n
         mLewMsbiEqr/UyZxhDQFv7JH6099Dd1dOmyRvAlU7CJkeRb4px8q/3htj6nS0GhPevYL
         jZN2h1I16hNF1UJhhvre6jDWjJwj3tiiR4UqFB/y9U0SsnbsDN15srUelbrgtUCDGp5F
         NhqnnJpXqKmTufjqUqmdr6fsZ1a2Q9Tlvc0PjYU3i2JLLAWTh2xEstdUPHJ1KX8wkXG/
         Mk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140772; x=1793745572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
        b=X98e4IvSBSp8NUKUAXMg07XT9/RVMqjn0I/FsAuBqCew5HqqDOwryelVoZebqB/aBG
         KRKCdIFCTNg0Aovs0AmO0vCph1ab5F5pbYB3BkIGBZMj4x5PELe9uFcDxEnZJF0to9fu
         8lNf9tKDC2PrWCyvkUvBNwZerQHGxG79Sb1Rw5ntXKlE/accH08EtPqPz/qgU7pPyeow
         5LybU+Ym5zCl6jfVJouNtBtvhqQmSstiwVbre2EXRNqsOUxOCAC97lnWnSVegOAuO1Zg
         KNnriZVt/6qhMDQTJafr6jMaD4Xl3XnU+3vmW+6FBpsHw22b1J+fIHmYvgL2PV0AskvO
         b4LQ==
X-Forwarded-Encrypted: i=1; AKwUvByf+8bLN0eaO8DUoL54sIwzXkotMK4kM6ph9n1E4TC2Zc963LgjPjZqmw29UtgdhjoUqxlQWPWsJOFREcM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJyrKVY8B6rZtKegeCe/LL1iGT8OgLxUle428VEsalVfC9+0LRb
	s3Ms6eSSzU+m/K8CMXZXaGH2y3uBEJFS74xAPJnuqqIB4oBXk+dLFPJg9wx6+IxHbN3GBo968w3
	EKMWGO9Fokw==
X-Received: from dlea12-n1.prod.google.com ([2002:a05:701b:420c:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2813:b0:143:6525:f9f6
 with SMTP id a92af1059eb24-1a6cd3a1575mr630918c88.13.1793140772067; Tue, 27
 Oct 2026 15:39:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:43 -0700
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
Message-ID: <20261027223847.652884-9-irogers@google.com>
Subject: [PATCH v2 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..8e6136d52a50 100644
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
index ae3e7c54014a..4666110aebe0 100644
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
2.56.0.313.g2479322e68-goog


