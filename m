Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC755606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fe/KRYPO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7CM27PZz30Vn;
	Mon, 09 Nov 2026 09:39:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177599;
	cv=none; b=RNcS6Htj6V1ZzU0aKkNHhqBBwYcYaTqy16EyFK841zLefkeBnaKLPqc++x/PQ3MqZB28+WONt5lDC8l5F7Dw9wvb5Dmw5L2l1QhsbeJdmGEDuQzMqcI/oQuVBy6FTGJNc/zRdUPeyXAafpt0bZzaBvMPqvIv4qfxAzan6tqDBb/dQWBxN2PWIMEJMpiDJUdcTWBROmZvQ0J1WKuplA5cNkBg1KP9ZkOU6CHkUuKi3TKNOW3zCf346TlDd0s0/0DkBFiZdC4dW9d/OxIQQMUUGkYqDmoS67KYQGqoTVIC54dI0STQJuNHLCERPmLyWpSGTr4RGSknxpPRdLyUH9qFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177599; c=relaxed/relaxed;
	bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3M519cI/EwzZYuqI8gA7V2oBZ0Heur0OAYIdn9Pne7XrVvQvVrcnWV3IlHVxr2HpVoy35Yy2CSLAm2wGb7coGqWi155/9ViGycBetDv5P6FXlPK2Y5Yg1iyH3W3QKd/buGwcRw+AxYaMEgaE164ZU7ZO8tRPhBMRA8twFeiERvxkUF0/ALpneOuYMPyQkAjvzq/lHD+wei3wYiqqjRq19WXaK6og2pr7frCqZj4RaRSCJMnirZ9WOAy7MQo0XIoX7LE+7+2M23W6nPh0Di3QjknI45Q8LSmD1i5WGml4Od0847HYYYeEsN5hDXtVOeQegqc80qP3fYw6xnoW1dGmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fe/KRYPO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3pprwagckdfm3c91zcd19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fe/KRYPO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3pprwagckdfm3c91zcd19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7CL4Rymz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:58 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-36cec75d8caso401724eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177597; x=1794782397; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=Fe/KRYPOas1udFCBJZKwBpdSUrRla7uq7DOXYmNIkWYP+Iz0gMqgKLp1yJSX2VvCYm
         2hh3S/C2PA3O3oIIoj8mhMPXng8CGC2n/A0qbqRGKCMa+EiyyTlAY767u/SDL/bm3++5
         psiMdyspH+p7xwB241S15RvNWdFm2RfSDHI3fJIbLjwen80HoYljA0yHq3hKMuqz7cyL
         ED2ByYLrbIOcnh7Y28mjUUvN9W9gOpuwDpai1IObb8je/PZfQ/cMGMHLhpYtgYSXqWnr
         vmNTBCgDmT4LXOjfR7FYL/OC3SGOb8ypOcZjuhH1oVOXCW/iUXzn5Q+oMnJ+IpgqBSQr
         5tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177597; x=1794782397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=x6NT2jZW2irzRbX5ifqVCRwt5F8ZjKcyPlIwF9ElIesHg7LUpetF8Anx3QuGp6Nlit
         u2h10LT9IAWAknBjkW+merwG/K8MZg2KKsRoxZlSZ7h4HtNyc8rTdvhzrHMpIhw02OAy
         kyWX4ID4cDq++p6SB3ClTsFjYXhCEH/Wj9AA3gGSbckqeNFMpbjpy+sj5BvE/TvpsfeC
         qndOcjloh4Go4uGqGBubZ/GChDXFpT9gt2RE8j06qqJaxXBoVFjisrCVKCYteg+SLmUe
         q7x1dcRHtyBPS4V1S6CbU1HLxtyGS201K7T9Hwa/mtHSbaajNfj4mUt11bwxyZBHvdj5
         wutQ==
X-Forwarded-Encrypted: i=1; AL+hErEpt9m7FJEcEREwhEa+/Z928TdsUhwW741mkWoHEOOdSJo9TsrM1SljLrA3C1TajfURfHZd70iEGee6/jY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9jbvh0ooJ0vAOFaAK7yb7z3SgRs7aOyhMKkwwqu8E1dYgJXWk5
	U0Celimn28ibCaCmhKW6kvwCK2vnf1/lM8ioWoxMU19pHB67kDDh3eotdLxm+9riEmfxaD2Ich4
	LPCEj3UlQfw==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9a90:b0:36d:38e0:79f3
 with SMTP id 5a478bee46e88-370f8170ddamr8689075eec.25.1794177596308; Sun, 08
 Nov 2026 14:39:56 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:12 -0800
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
Message-ID: <20261108223913.3624571-9-irogers@google.com>
Subject: [PATCH v3 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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
index 6010a5d7a7eb..f7413d651620 100644
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
2.56.0.455.g6c5a503b38-goog


