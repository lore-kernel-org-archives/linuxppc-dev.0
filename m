Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132A606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBx7Stfh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpNN6tsdz2xLr;
	Fri, 20 Nov 2026 06:25:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::247"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116356;
	cv=none; b=WU7bUxfwJxVkqMy5ECKpHTrAp9Q908uSVtlYP7SebbZeAYZGkH0y/uRXTbrT6uDYyLnNpw7gl7ScPVRyNCRPWOtJkCagzRJ3oogaMG8VjoecV8Xn4skVfEJeyE4UWGFFIjA31SVRPPIomxqt/adVvQu32F476gI6UX7RDusEnjc57YzbkGUHV5gDGbgtNqbTBeQokHCo5moG54E/jeiQJOVwE7awru2oIqM7/wB/tq4bhPvACGyo0O7t9KDS5+dmohDeiIv/+c4LTvG4mFVar0E+VSB9gd4Nz3aGDBo/IXs+YymIsyLz7N+675qcFjIR9YLQdigJcyVmCUx4v9YFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116356; c=relaxed/relaxed;
	bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISVVSsNFq/JckSNzSF1kTQxkGyphwJ6DPBj/77AV07MWdRYHZArvvbhQHE/KtFmVjAcR5BfZo44OU+Tkg67mGCdyncm5tQzhUy3in9/JGYUmYxb5P37ym1PLvXKGybVZuwloa6nJy/suz6N+gJrEY/pXhA/qTAUtXPyk6JX/JGfEaUL5XlZpNMYyTUVg1C8Bv9plaJjnEBsXCRcdZG4wqpLmFq6/PMaR6NYHxPR5p37taqtGl7fNGgl1iugbZuTAauapcKv+4jcd4eNW3B3Sv6rUfBN09D4d5llGM73PTt/L+YpeLYfRp3D/h5WPowUQhOTY8A6eWvhBa8YJf9H3Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBx7Stfh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::247; helo=mail-oi1-x247.google.com; envelope-from=3qu3_agckddgcliaylmaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBx7Stfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::247; helo=mail-oi1-x247.google.com; envelope-from=3qu3_agckddgcliaylmaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x247.google.com (mail-oi1-x247.google.com [IPv6:2607:f8b0:4864:20::247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpNN1dVDz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:25:56 +1100 (AEDT)
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-5713cd0fb42so1691298b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116354; x=1795721154; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
        b=NBx7StfhRoK8PGGY+4Trhe8cde9aVy8y0Gsxc6XDpncyxD4e1eDOZAf6BH7g9bhTQG
         XiHavrrx+nKOG2G7mbFpAoz2jAor/iG5He6z+nYmFtuI+Dr0Aj6iX4wdzdn/dbiBsA66
         yhnH0D5POSo+0g08xLf6LRdBsLhRerw22EEP+f7GyH+18okicyotsKszDa+pZZvLflMC
         DGAEZlUWEWD27DGOSA5/74TOhJt1debP+ySSnMYC0ScZY20theG/1eDLW75LzdZC8zcD
         Lllc1Uh28Gf1ECEAP+K9T/QBtXJ0WZ1UQ9wDoWLlnsNVfNtrs3Oa4Ze91pKWAW6C8jo3
         Zp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116354; x=1795721154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohgce9vn+z31zJY1A4d/uIcUdw7UhPIFGYmbETxOr2U=;
        b=q3sztWh2siOStb1DavKOwc7/74iLzYG25AKcbgIMhe9tVP6drdOxZlftnOrQY4eEO9
         5wjFOsc46njCHm0YIQ0KACn1/YnCTbCONvWPTw+lNIPBgiZHogV4wL9RlzTOX7zNK6Az
         pzmN84wvNnOrkr5spiqDmZXGfZ+k2CDO+gWKez0iQiANgB6KQUWEHVj8jXID1xxN3dNV
         jUA9u6unxcDrlp6JDEquZ1tsfP1mnqg8SmqrS2QJLKF7EoTQjGfm6KxyWomH6/BGqdxq
         6mc1FTtSusgU1g80dV+ISMTz4RB+7r7z/JCfszC46tBBAMVJH0pMQy9flHoGKjhpJiX8
         vUEw==
X-Forwarded-Encrypted: i=1; AL+hErGEdBIATWc4x+HcreSfyEHeFSXH1OY1uKFH9an1enUS02fHX46RcayfTYhf/6hJ14H1o3tBTr64pen3M8I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9W4jaf9wc7jR0cL4heDTWBxJnOfPcyUhqU1/1po/rHmHyo3O0X
	NaSSaIc9EzurlYE353yD4aHwNjyxA2+cQ4ybIvgjdP/D4+MkIC2l2kNNEzPuyrhtqoImyrfXss3
	Z3+7E6HMFIw==
X-Received: from ilbdx27-n1.prod.google.com ([2002:a05:6e02:421b:10b0:547:8b66:16bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2383:b0:572:f8ec:5340
 with SMTP id 5614622812f47-5797dd97e12mr1569173b6e.40.1795116353256; Thu, 19
 Nov 2026 11:25:53 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:16 -0800
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
Message-ID: <20261119192520.1983406-6-irogers@google.com>
Subject: [PATCH v4 5/9] dlm: Wait for kobject release before freeing dlm_ls
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

Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
Acked-by: Alexander Aring <aahringo@redhat.com>
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
2.56.1.708.g77570a6a1d-goog


