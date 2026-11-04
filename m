Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A660E1D84
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJyOhlQt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbkg57Qkz2yql;
	Thu, 05 Nov 2026 06:54:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822091;
	cv=none; b=JkCxB8eOm4icXc01WVKP9aZomV/bZVhICRgdUIT6y9IxZ+feF7JjgjMDHkH0H377OeAE0SPWxDkNigxehc3WQnWSwsH7jYUBqJN4UD94C/hoB3L0IYHCWhU7yP0acK+Ny9TrsmvdK2hYtp59yS0jLaz3t+xFduE4XHhFxS6zi4GfwYRazEQN5c5zhKjp4iWtw5zCpaXVED85RO+Wd4TYtwpMOkeJ/3OtF+Uvcl3wTZc4eegNkRPzwREb7RsGWqiDpze7YfR+n+VqvVEedCFSKJLRismZxwWbAqwYb5I6kUferjPB7Rn2MSn28oUL+EmjonprbfDceK7rHW1t4ZHgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822091; c=relaxed/relaxed;
	bh=LwOyQmkvG4TrYSsjhoNvmU1CfgZA+V6RV4LLe+r+cHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z08ASn2KbOCSmQgkyMxVQvU4JVa0QtKrIcdG0KbaEcdBtPXRMXOY3oYpwBun8ZsiDE+49BLAV45Se3zNM++o3FomnFuX8Rq29gdv6LfRj8KJHClJ3sdSGw/sA1GvffjStcUiMX11M2/1p7HaJIoxCie8wzpqdUTwTh77BpWPKLPaX2ElpUbDKcR1DMcLgA971XCIKLswOi813DwnqYAFIUNKEUHJe/fgt8WsO1fuYRyM825F1NvFwEAj6P8pfU9fqClMkxlcFj1DJNuK2ZAJ70OZIH3WVOjC6Ns5/x8qmicSqooWwq4RUghMwbxwyEXqB6lP6s7zDbEnC5KYsXTGFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJyOhlQt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJyOhlQt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbkg0Gkjz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:54:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8517C447A9;
	Wed,  4 Nov 2026 19:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2B01F0093A;
	Wed,  4 Nov 2026 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822089;
	bh=LwOyQmkvG4TrYSsjhoNvmU1CfgZA+V6RV4LLe+r+cHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJyOhlQt7v/yUeJe2KxDzjfIgCPFjEFsKvYVx2A3N/ozpWFiPJU0KUhNdF3Wnx++v
	 sI9BCBWIdMMiP0QcpAXFpZsOn0jW7NrHt4r2cB6NkOMsL6mxo8rFKgvE84hLglCx66
	 OqQujMha7035TQ4ZwwiVUfu7SbYHZU96GqKi/rxAVkSUfLy231e9TMVVFOEYebJCby
	 NOwJ0wLy1EviZyidaxTUbqL58HBSyhB/XKNBxXObC0roAJt5FLGPIUnCJuWzz6FbgG
	 K3Yv0a5upmIEZWtQAvIYMc9ZxBopPWyj6ON1cpCflNYuRijpKAoniKAIZEUIsRrLGe
	 wTSzOu7fuS0uw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 20/30] sched/psi: let procfs own the wait queue of the pressure files
Date: Wed,  4 Nov 2026 20:54:35 +0100
Message-ID: <20261104-work-procfs-fs-v2-20-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6098; i=brauner@kernel.org; h=from:subject:message-id; bh=CeHhvuLOJ2DxGx1mSjted70KaKApRIjx6GoOIAUH5Kc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97nEOnuN4eKv7y+UynWu9t7p/P/D2dPOuOt7MtW4RY cbN7Z4KHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZtpnhnzqLca7vmStVc8on LzvQtZvr1cV7Wl6vAr9Pan8zzeRX1XOG/zVVv26edFdZ+WTuhnfLRZpsnu+SuzP1+Nxz33L9reT Tf/MDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A trigger on one of the /proc/pressure files has a wait queue of its
own for its poller, the cgroup pressure files use the queue of their
kernfs node through kernfs_generic_poll() and kernfs_notify(). procfs
owns the queue of its pressure files now, so use it the same way: the
poll_wait() is procfs', and a trigger that fires wakes the pollers of
its file with proc_poll_notify(). Like for the cgroup files every
poller of the file is woken when any trigger on it fires, and each
reports the state of its own trigger. psi_trigger_poll() doesn't need
the file anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/psi.h       |  3 +--
 include/linux/psi_types.h |  8 +++++---
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/sched/psi.c        | 30 +++++++++++++++++-------------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7966e3ac03b9..c6f536631411 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -30,8 +30,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 int psi_trigger_create_rtpoll_worker(struct psi_group *group);
 void psi_trigger_destroy(struct psi_trigger *t);
 
-__poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
-			poll_table *wait);
+__poll_t psi_trigger_poll(void **trigger_ptr, poll_table *wait);
 
 #ifdef CONFIG_CGROUPS
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index dd10c22299ab..ce772575c5da 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -8,6 +8,8 @@
 #include <linux/kref.h>
 #include <linux/wait.h>
 
+struct proc_dir_entry;
+
 #ifdef CONFIG_PSI
 
 /* Tracked task states */
@@ -132,12 +134,12 @@ struct psi_trigger {
 	/* Backpointer needed during trigger destruction */
 	struct psi_group *group;
 
-	/* Wait queue for polling */
-	wait_queue_head_t event_wait;
-
 	/* Kernfs file for cgroup triggers */
 	struct kernfs_open_file *of;
 
+	/* /proc/pressure file for system triggers, see proc_poll_notify() */
+	struct proc_dir_entry *pde;
+
 	/* Pending event flag */
 	int event;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a284225f8dc9..c5da33495ae3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4232,7 +4232,7 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 
-	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
+	return psi_trigger_poll(&ctx->psi.trigger, pt);
 }
 
 static void cgroup_pressure_release(struct kernfs_open_file *of)
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cdb7a832333a..97b5e2488106 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -514,7 +514,7 @@ static void update_triggers(struct psi_group *group, u64 now,
 			if (t->of)
 				kernfs_notify(t->of->kn);
 			else
-				wake_up_interruptible(&t->event_wait);
+				proc_poll_notify(t->pde);
 		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
@@ -1327,6 +1327,9 @@ int psi_trigger_create_rtpoll_worker(struct psi_group *group)
 	return 0;
 }
 
+/* the /proc/pressure files, see psi_proc_init() */
+static struct proc_dir_entry *psi_proc_entry[NR_PSI_RESOURCES];
+
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 				       enum psi_res res, struct file *file,
 				       struct kernfs_open_file *of,
@@ -1392,8 +1395,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	t->event = 0;
 	t->last_event_time = 0;
 	t->of = of;
-	if (!of)
-		init_waitqueue_head(&t->event_wait);
+	t->pde = of ? NULL : psi_proc_entry[res];
 	t->pending_event = false;
 	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
@@ -1441,7 +1443,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	if (t->of)
 		kernfs_notify(t->of->kn);
 	else
-		wake_up_interruptible(&t->event_wait);
+		proc_poll_notify(t->pde);
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1495,8 +1497,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	kfree(t);
 }
 
-__poll_t psi_trigger_poll(void **trigger_ptr,
-				struct file *file, poll_table *wait)
+__poll_t psi_trigger_poll(void **trigger_ptr, poll_table *wait)
 {
 	__poll_t ret = DEFAULT_POLLMASK;
 	struct psi_trigger *t;
@@ -1508,10 +1509,9 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
+	/* a /proc/pressure file is polled on the queue procfs owns for it */
 	if (t->of)
 		kernfs_generic_poll(t->of, wait);
-	else
-		poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
@@ -1610,7 +1610,7 @@ static __poll_t psi_fop_poll(struct file *file, poll_table *wait)
 {
 	struct seq_file *seq = file->private_data;
 
-	return psi_trigger_poll(&seq->private, file, wait);
+	return psi_trigger_poll(&seq->private, wait);
 }
 
 static int psi_fop_release(struct inode *inode, struct file *file)
@@ -1670,11 +1670,15 @@ static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
 		proc_mkdir("pressure", NULL);
-		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
-		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
-		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
+		psi_proc_entry[PSI_IO] = proc_create("pressure/io", 0666, NULL,
+						     &psi_io_proc_ops);
+		psi_proc_entry[PSI_MEM] = proc_create("pressure/memory", 0666,
+						      NULL, &psi_memory_proc_ops);
+		psi_proc_entry[PSI_CPU] = proc_create("pressure/cpu", 0666, NULL,
+						      &psi_cpu_proc_ops);
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-		proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops);
+		psi_proc_entry[PSI_IRQ] = proc_create("pressure/irq", 0666, NULL,
+						      &psi_irq_proc_ops);
 #endif
 	}
 	return 0;

-- 
2.53.0


