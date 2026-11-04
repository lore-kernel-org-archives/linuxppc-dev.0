Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A46072648
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETQGuZ5m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKdTt5SgZz2yVL;
	Thu, 05 Nov 2026 08:13:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793826834;
	cv=none; b=byzCMCKCMG5qgf9dz3J13jv9X5yAyv7kwfoigRQXuBh/OMJOBzOBiAH4/pRNXLiTPjAnrbQMxmACeqeoGJ1rLFfpVynIOhbcNetC/fOhLzMJ/StfUOhoxQWSpBBHjamlrzU4i3khbMTUSn4EB1o2puU9tY05iCEOdJTSWCzt+JzHc2nqcApVyMizEtsGHO87M8bQA9nVYhxORqLZswZ+7I9yKlR6AKgKeNgn6cfi7jnrvxWQJTCnFqi5ueLJ/hG9LvqcS50IvfyiFO90UUy7AL/8o31EmVGWBMq6+1UYFEH6JGUlF6Sy7y9cwpvr3eWswrrkeOLMp4m/l1YRG+8iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793826834; c=relaxed/relaxed;
	bh=1MxYRYKjXg/+oT1B67MpjVjXxOUB68rY8isEKfXqK2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUUdxrUDEw5RcX4DXM1bV+20yPQvuITTBWpUAXl1V2XzWfqy1QJa6tKFpjW8Yr7lHZgSQmraRhnn1tt/bl3f1um16Cbb+DcMyJQ9WvdavpH/tMUzB5iUBHGokGed3EDVRakyrIpDt9ddoondGJXvjaEf/pBFcBSK17CjZME+Acxkfaizmv0obLa4z3sayvW+VSeNLdZetABstjsm3outjPcYz4B/PmwmSuDVwsBQJ1u/EjIpE/2KyGXrwKW3ghA/HFGq81fIYdikvZ//ALpb/nXRM8dTrLPgbKQOg0BPPplaEgKrnbBXrsNH6eNiKgEq1hN5dX81a/TGiFeFG7ftKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETQGuZ5m; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETQGuZ5m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKdTs6nfKz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 08:13:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE18062CCD;
	Wed,  4 Nov 2026 21:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDB1F000C1;
	Wed,  4 Nov 2026 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826831;
	bh=1MxYRYKjXg/+oT1B67MpjVjXxOUB68rY8isEKfXqK2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ETQGuZ5mWrJaw5vMCNoxKDTP6j6Ov//pzU7UV0re+JQ/fOVwqabIgrja5LMlvIx3R
	 mBlsuHBCVE8oDvKETlbRqL1mhIdq3tD2pozrg28w+TtoHjgYEwWMJ4CIpaO1h6KvxQ
	 V3ufmOQrumr5xp/6TYUAYOVWxzXCl9UAFw/i9yKn1dgBRAbUrpnmTDlh+YdGCs76Yl
	 EsaKk9QvFagOgFekDjd3Lf3WCADE6zYjwBULe2sa8XrpB7drKPKJkJrEFpU3FefsUh
	 RzD53Gz+X/bLDWxUAm40hLd+bK3dqFI/hYSlTDpB/hxhYfKzRFrbamvLaNX4sWezYW
	 AXz5pXYWXwUog==
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
Subject: [PATCH RESEND v2 10/13] SUNRPC: let procfs own the wait queue of the procfs channel files
Date: Wed,  4 Nov 2026 22:13:37 +0100
Message-ID: <20261104-work-procfs-net-v2-10-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889; i=brauner@kernel.org; h=from:subject:message-id; bh=QPerLLDMXFlA+1II+fYpDsDcCxwkLoYz0L35dMx6y10=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tPPWss1reVowb5lm3abTz0rMjlm2gkBvWsyExf/X HRC4GaxZEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEVukwMuzjjI+PiJCdw3+7 2mPbsYasgi9fNtZwRVfcuHZVTzg6v42R4eTzNOM3P9YXtbtlPnjWlcQ/W1jsYVuwd/jiwx3zgv1 CmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cache_poll() sleeps the poller on queue_wait, which went back to being
a static queue so that a poll() on a procfs channel file can't be left
on the queue of a cache_detail that its network namespace freed. procfs
owns the queue poll() uses now and it outlives the file, so the procfs
channel files leave the poll_wait() to procfs and an upcall wakes their
pollers through proc_poll_notify(). The channel entry is remembered in
the cache_detail for that and forgotten before the entries are removed.
The rpc_pipefs files keep sleeping on queue_wait, procfs has nothing to
do with them.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/sunrpc/cache.h |  2 ++
 net/sunrpc/cache.c           | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index bf4fc543e1e5..9d508205ebb2 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -129,6 +129,8 @@ struct cache_detail {
 		struct proc_dir_entry	*procfs;
 		struct dentry		*pipefs;
 	};
+	/* the channel file in @procfs, for proc_poll_notify() */
+	struct proc_dir_entry	*procfs_channel;
 	struct net		*net;
 };
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index d242b6f33cbc..f220a3036b6e 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -970,20 +970,18 @@ out:
 }
 
 /*
- * Not in struct cache_detail: poll and epoll waiters stay queued until
- * their file is closed, but a channel file in procfs can stay open after
- * the cache_detail of its dying network namespace has been freed.
+ * For the rpc_pipefs channel files. Not in struct cache_detail: poll and
+ * epoll waiters stay queued until their file is closed, which can be after
+ * the cache_detail is gone. The procfs channel files are polled on the wait
+ * queue procfs owns for them instead, see proc_poll_notify().
  */
 static DECLARE_WAIT_QUEUE_HEAD(queue_wait);
 
-static __poll_t cache_poll(struct file *filp, poll_table *wait,
-			       struct cache_detail *cd)
+static __poll_t cache_poll(struct file *filp, struct cache_detail *cd)
 {
 	__poll_t mask;
 	struct cache_reader *rp = filp->private_data;
 
-	poll_wait(filp, &queue_wait, wait);
-
 	/* alway allow write */
 	mask = EPOLLOUT | EPOLLWRNORM;
 
@@ -1248,6 +1246,7 @@ static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
 	if (ret != -EAGAIN && detail->cache_notify)
 		detail->cache_notify(detail, h);
 	wake_up(&queue_wait);
+	proc_poll_notify(detail->procfs_channel);
 	if (ret == -EAGAIN) {
 		kfree(buf);
 		kfree(crq);
@@ -1593,7 +1592,7 @@ static __poll_t cache_poll_procfs(struct file *filp, poll_table *wait)
 {
 	struct cache_detail *cd = pde_data(file_inode(filp));
 
-	return cache_poll(filp, wait, cd);
+	return cache_poll(filp, cd);
 }
 
 static int cache_open_procfs(struct inode *inode, struct file *filp)
@@ -1690,6 +1689,7 @@ static const struct proc_ops cache_flush_proc_ops = {
 static void remove_cache_proc_entries(struct cache_detail *cd)
 {
 	if (cd->procfs) {
+		cd->procfs_channel = NULL;
 		proc_remove(cd->procfs);
 		cd->procfs = NULL;
 	}
@@ -1718,6 +1718,7 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 				     &cache_channel_proc_ops, cd);
 		if (p == NULL)
 			goto out_nomem;
+		cd->procfs_channel = p;
 	}
 	if (cd->cache_show) {
 		p = proc_create_data("content", S_IFREG | 0400, cd->procfs,
@@ -1806,7 +1807,8 @@ static __poll_t cache_poll_pipefs(struct file *filp, poll_table *wait)
 {
 	struct cache_detail *cd = RPC_I(file_inode(filp))->private;
 
-	return cache_poll(filp, wait, cd);
+	poll_wait(filp, &queue_wait, wait);
+	return cache_poll(filp, cd);
 }
 
 static long cache_ioctl_pipefs(struct file *filp,

-- 
2.53.0


