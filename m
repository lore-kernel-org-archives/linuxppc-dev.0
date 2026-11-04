Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E66073831
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aicfXnWV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbVN1k1sz2yYd;
	Thu, 05 Nov 2026 06:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821452;
	cv=none; b=BOqpYbdxfJPJhi56YOdjC6qdmqA6N+QxT7OfnIWMfrKrpotoPawNv4d0J7Hv5nBTLX0eHowDUM8Q0fFdshRyLfw0jWSkw8rCAuzd48Yg7Um58N+id/gVLIjh1mE0OYocD3e5SeRH4H+A8VVlKYrvRDp1tqV6Y2CczwZVmC/QOUSehdhLCSpG6vVfCQ+zF6IX9Fv1EugoJBFiCfMLzjhRYHX0mS8X0I98lDbFc9xgzm1WgLU0jd/1gjk/ABhEw0jcRmwZCh3JwO/S0RFPSXEZmjYHvfYszBKBt+Vx1+iwGRZvRzBSR8i20qnfOhE5L5qQXzkxYgGJy+HLbtAsTpHCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821452; c=relaxed/relaxed;
	bh=Z72TnyR4FqZWuZXLi7RAB/58/idtKzOn4i9EyTHtGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6W+ThH7Rkd4wJFuaPQ4sBqZ7eQixzxK3QFcVIcEEWJTKE5sPly4QHLOb3JVAoJzT4FdzTXsvQME2zTMNZEmchdVmSw9xw06vFzm5IJZwNhCILDfY99o/Immz4Uh3CFcj/0ToRN3gNbXkd779U1L9KsMNa2Ya4bow1ZaSbvfZK+QT0Iq1s9ivAMNKW9StqgVMxXFKYs/B8M1xgP6AlMwE1I6aLmpJ1gT93YXoRU9B9l+uMDmO0gj4pjB+N0oBZ0BTMUiPBj/OqV/JDz+isDtuVSY+ta/uX/gl5z+2rOIcF+cM+LogHUKDuymXU5zpSs0P/LubEFpfbZ4OWmCN4NZ+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aicfXnWV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aicfXnWV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbVM3yJ1z2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:44:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1024940584;
	Wed,  4 Nov 2026 19:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0511F00919;
	Wed,  4 Nov 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821449;
	bh=Z72TnyR4FqZWuZXLi7RAB/58/idtKzOn4i9EyTHtGiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aicfXnWVc+2sorHSEArN9gD6s+r89vzM3QCItz87jq7xenbwZcKkxAyhEzMN4zilO
	 XEmAW5nDi6Qpy1HAR+3dogNdprQDzauusCx/5cNW0SrbZVyC5GFUF34a5Ax3Ufz9Ir
	 pPUXceddaTjvbGaHwgGMseQ+qlmEYJQbjS+TTvruu0qlgjbpKch86CrjWevskZ10dt
	 CPwtCbH1BlXfDfr1nCeM9GXk83OUHSgxmRLaA86TuRr7s0NevUTTC4SfMspApoUqNj
	 2Bq8k9a+tUVTivUfQqiyVO9j0Bzx/5RNz+dYk3t96b4Fnb5fexWFIEeXgiYZ4/X6vz
	 2jCoIj12+zkWQ==
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
Subject: [PATCH RESEND v2 07/26] md: let procfs own the wait queue of /proc/mdstat
Date: Wed,  4 Nov 2026 20:43:55 +0100
Message-ID: <20261104-work-procfs-drivers-v2-7-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=brauner@kernel.org; h=from:subject:message-id; bh=Nn5OVy8ZnyI1nSFUur3mK5MV0AP1ijE3ArueCKeFRT8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97qpelclm2eRivDzv95ei9M8+3HNPnr9QzG/qmrjCP rmm56dyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQCXzP8L+Ry03raKlfQfVPu 0IPvj5U0WoW+KZ9MOfz5Lev7yvuRzAx/BR75d/79PlNgAlP5pc8HHJqssrPnl5s3P0u6bivP2cv FBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mdstat_poll() sleeps the poller on md_event_waiters and md_exit() has
to wake it in a loop until nobody is left on the queue, because the
queue goes away with the module. procfs owns the queue poll() uses
now, it outlives the module, and a poll of the removed entry reports
EPOLLERR | EPOLLPRI, so md_new_event() wakes the pollers through
proc_poll_notify() and the loop and md_unloading go.

md_exit() removes /proc/mdstat last now. A sysfs store on an inactive
array doesn't hold the module, so it can still reach md_new_event()
while md_exit() runs, until destroy_workqueue() has waited for the last
array to go, and a wake-up through a removed entry is a use after free.
The static queue didn't mind that, the entry does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/md/md.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 64abf1743e41..7560dcf0f5c8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -351,12 +351,12 @@ static bool check_new_feature = true;
  *  start array, stop array, error, add device, remove device,
  *  start build, activate spare
  */
-static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
+static struct proc_dir_entry *mdstat_entry;
 static atomic_t md_event_count;
 void md_new_event(void)
 {
 	atomic_inc(&md_event_count);
-	wake_up(&md_event_waiters);
+	proc_poll_notify(mdstat_entry);
 }
 EXPORT_SYMBOL_GPL(md_new_event);
 
@@ -9176,16 +9176,11 @@ static int md_seq_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int md_unloading;
 static __poll_t mdstat_poll(struct file *filp, poll_table *wait)
 {
 	struct seq_file *seq = filp->private_data;
 	__poll_t mask;
 
-	if (md_unloading)
-		return EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
-	poll_wait(filp, &md_event_waiters, wait);
-
 	/* always allow read */
 	mask = EPOLLIN | EPOLLRDNORM;
 
@@ -10765,7 +10760,7 @@ static void md_geninit(void)
 {
 	pr_debug("md: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
 
-	proc_create("mdstat", S_IRUGO, NULL, &mdstat_proc_ops);
+	mdstat_entry = proc_create("mdstat", S_IRUGO, NULL, &mdstat_proc_ops);
 }
 
 static int __init md_init(void)
@@ -11074,25 +11069,12 @@ void md_autostart_arrays(int part)
 static __exit void md_exit(void)
 {
 	struct mddev *mddev;
-	int delay = 1;
 
 	unregister_blkdev(MD_MAJOR,"md");
 	unregister_blkdev(mdp_major, "mdp");
 	unregister_reboot_notifier(&md_notifier);
 	unregister_sysctl_table(raid_table_header);
 
-	/* We cannot unload the modules while some process is
-	 * waiting for us in select() or poll() - wake them up
-	 */
-	md_unloading = 1;
-	while (waitqueue_active(&md_event_waiters)) {
-		/* not safe to leave yet */
-		wake_up(&md_event_waiters);
-		msleep(delay);
-		delay += delay;
-	}
-	remove_proc_entry("mdstat", NULL);
-
 	spin_lock(&all_mddevs_lock);
 	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
@@ -11112,6 +11094,11 @@ static __exit void md_exit(void)
 	spin_unlock(&all_mddevs_lock);
 
 	destroy_workqueue(md_misc_wq);
+	/*
+	 * Only now can nothing reach md_new_event() anymore, which wakes the
+	 * pollers of /proc/mdstat through its entry.
+	 */
+	remove_proc_entry("mdstat", NULL);
 	md_bitmap_exit();
 }
 

-- 
2.53.0


