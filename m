Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAD60A2601
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEX8xSE2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlmH1ZLKz30Pp;
	Wed, 28 Oct 2026 09:39:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1246"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140767;
	cv=none; b=VO9erXG70QpNvKjnhBoZ8uyi6yzMEi4UnfIC7tBTX4wZkishLfSMKsH6OacvXXK9mvZ6eLfZVL40NpRTPT0GY+nJOmCmVx3kmbBMKyU+YySF8LW/wmhJZiGXsuPkF+XKzeO8IyHJmXvo0OZstT1CMCfqRFvZuKDYpvVhkFOqnkv1QZB3ES3r9oDTqlTfF3VN0I4pY7MAS6Ziu88Y5cIk7TJzQHpAirWNEyBZab9xJZP5fRMnLWeD7ssZ0612VyIXmOqc/cXtv6Z+zeMnMvi8Ed5G10v8gf7XNhBGmuSJ2XwoGwub9V9cr2gjt2SLfq3uFug3OrPz9NIPgRQj34oRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140767; c=relaxed/relaxed;
	bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avZ+3d7JsaEY810VfLWFUBi3JjxU0nVbkO4uxs1LIKq9i/cVBG2KRPsjqp6DSc5qSLzgT7IpymzwnCxoPiNywa1baesFzS9B7YdYr8YkEs4ZhHNQxUJfsJAm1iZTrbGhbh261bGU0B7SImEWgw+mCNsQQoT1HraN/8oE6KzV8bYwTAeRd+1F2tEZG45chCNtk4bVorLUWwE4u41e2f3jhBD2WMuoEgGdrksC8brmAkHfAdO9mvnNWEVUFsiANa10/y3YENjid7sAaFOdZsRwlykPJGVq7og2OMfNOdjhQpusAXGWQkbx1Fy+JvZfKL9DFMWnHRDllF/wuaIGy9nbRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEX8xSE2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1246; helo=mail-dl1-x1246.google.com; envelope-from=3gyjhagckde4y74wu78w44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEX8xSE2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1246; helo=mail-dl1-x1246.google.com; envelope-from=3gyjhagckde4y74wu78w44w1u.s421y3ad55s-tub1y898.4f1qr8.47w@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1246.google.com (mail-dl1-x1246.google.com [IPv6:2607:f8b0:4864:20::1246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlmG3KT8z2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:26 +1100 (AEDT)
Received: by mail-dl1-x1246.google.com with SMTP id a92af1059eb24-147be78cd56so953025c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140764; x=1793745564; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
        b=ZEX8xSE2Hvb8QTDGQR8zRnm8GAjUEWq6eIooUvJpPmhYFP+YH/snsxzJS5cVTqKouB
         TWeT01mSB9B5sFu/D+5w60+eg19BTSc5hnVrU5k2ULmjq3QY4vypoYuPhb8uczItJIJL
         zHW25AN+hyuAJt5uPcfXQfAc3QGDrlUl/y4LdKuLiog7Nb/UVQjYL/HfFPjbkMX4UlI7
         GzNVINHevLfzLIMdbqT7gqQQQksKJJQvuR9Fw4ScVQdxBDxEK6xgivENN9qZ12P39NrX
         Ck7crLHdr5qYOQCymD0BeZo3xc+b0+j49MN6FBbXLJ+jIgyongURDM7rBu4uVvwqbVXA
         XV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140764; x=1793745564;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2p5eYZPmxsY9xh985bGLWJJ6j3FfFGXO/U6MsVvS8Z8=;
        b=EovnuDy5UlRIZS4+eai724FwGY6glKppcRruLguxJHuX5l4i8tJusX/lMbpSW+RmAg
         uepfSJZESgJjY2WpEd0LQDd76zh0iXjPGPUjjpWX5OszQED1zYFEx392DLLq4moAcEfB
         VoOQ6cYR9hfL0lmVNxhc5DU1CiVh+7deZKroOFmyHGcNiffJtYUqLzB9Zr5nvKbIoc4K
         +ZMK7tHxY42sUabZxEQs7ov8lv3LsvGE9ZHbdWKkuVOhcIpw1lJZS7Fnto7zjyNBCvEu
         VfP0qcQY9ed0eyQUaJBG3ClwEB+QLOyeGtnfCCgvuMWqU0fS6s35CSbVcSmegElfEoSs
         L8CA==
X-Forwarded-Encrypted: i=1; AKwUvByoTtmhxSz5G8YVPoWcyZS7oYLzjOVPoIXbjcXEsFb/XrYIlVrfN8uBZuPk3Gy0/jUF6UfYk9W3OC4etkk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIx483jeNPNzFkwpWXJkZJFZ6UMVKcDBtiWQp5OpguW33v6x+Cu
	vNNP0gtdp9dOvfCKtOklSUz3PnzWvfFu4N15n9m/PFPtmvV4zfpGGNHJW8b/l432St5KOJDIvT3
	Vf+CMLh5n2Q==
X-Received: from dlbsv1.prod.google.com ([2002:a05:7022:3a01:b0:1a1:3ce6:560b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd04:b0:1a3:bfb6:44ad
 with SMTP id a92af1059eb24-1a6ce2ff120mr1130455c88.32.1793140763880; Tue, 27
 Oct 2026 15:39:23 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:40 -0700
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
Message-ID: <20261027223847.652884-6-irogers@google.com>
Subject: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
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
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
delayed kobject release runs causes a use-after-free, and unloading the
module while the delayed release is pending results in an instruction
page fault.

Add a completion ls_kobj_done and dlm_ls_release() to complete it when
the last kobject reference is dropped, waiting for it in free_lockspace()
before kfree(ls) and in the new_lockspace() error path before module_put().
Also delete the kobject via kobject_del() before stopping dlm_recoverd
to close the window where concurrent sysfs writes could wake the stopped
recovery task.

Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/dlm_internal.h |  1 +
 fs/dlm/lockspace.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 74c2e77d1b55..95b3bff0cb57 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -576,6 +576,7 @@ struct dlm_ls {
 	int			ls_create_count; /* create/release refcount */
 	unsigned long		ls_flags;	/* LSFL_ */
 	struct kobject		ls_kobj;
+	struct completion	ls_kobj_done;
 
 	struct xarray		ls_lkbxa;
 	rwlock_t		ls_lkbxa_lock;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..2dccd080a10f 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	complete(&ls->ls_kobj_done);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,6 +363,8 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
+	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
 }
 
@@ -435,7 +445,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_lvblen = lvblen;
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
+	init_completion(&ls->ls_kobj_done);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +580,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -582,7 +593,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = do_uevent(ls, 1, 0);
 	if (error < 0)
-		goto out_recoverd;
+		goto out_kobj;
 
 	/* wait until recovery is successful or failed */
 	wait_for_completion(&ls->ls_recovery_done);
@@ -600,6 +611,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	do_uevent(ls, 0, 0);
 	dlm_clear_members(ls);
 	kfree(ls->ls_node_array);
+ out_kobj:
+	kobject_del(&ls->ls_kobj);
  out_recoverd:
 	dlm_recoverd_stop(ls);
  out_callback:
@@ -615,6 +628,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
+	wait_for_completion(&ls->ls_kobj_done);
 	kfree(ls);
  out:
 	module_put(THIS_MODULE);
@@ -740,6 +754,8 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 	    dlm_user_daemon_available())
 		do_uevent(ls, 0, (release_option == DLM_RELEASE_RECOVER));
 
+	kobject_del(&ls->ls_kobj);
+
 	dlm_recoverd_stop(ls);
 
 	/* clear the LSFL_RUNNING flag to fast up
@@ -759,8 +775,6 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
-
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
-- 
2.56.0.313.g2479322e68-goog


