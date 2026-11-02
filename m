Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20960A6C0E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv854kNM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG633Snbz3cKm;
	Tue, 03 Nov 2026 02:36:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633819;
	cv=none; b=SGTX0G0XHErNEZh/j1sKijAREsq0md1USsmWpjZlp3whkcDSWB/xp0rsKOj5DNLPUDbF2NjfWI6JXXaciR7S5ufgCXDVniM59wbqF/I8f2MkSaIYfLsm4hGFq3UPYJBGI30fz88Qeds3hNlAPYXHtcF+cK+UCdv0jyWizWSo7ZsoQ73HTGkpco3ajmwQO8gp52yZzYiog0wGXgKJAmaIfEm6ATmvIqtx5pRrUAuOdzzKDyrbCebA+KotDww4k1Ep0zOJv/2xPSpeqLqvrzkHoocXEBQFEHYht6bo19CncYSQCFRCugTXDQBvV56e4AdCntaeo5jNzgVJEejB19QN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633819; c=relaxed/relaxed;
	bh=S9tzR156ub0Ko3Mv53tQ+R8L9hVWUPj+OCS3UYlYhFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=krsr5Y43H9iEuPzMB7q4SLFLfE9GC/ymnxCO+Gxa0Ufsv+AvANT2i4oNFP4FDYAhfIUU3BODmTqA4vrvz2C4pxYcj5Xa7D/1TddnfyvAmzhgL+xNTLZjYI3bXhG0O2Vs46oYAQKFxx5Ot0f0ScGW+4fyzZeh93bN8D90/bl4kDpQo9Yf4y77DK8cyIgsAciAO/V9p/q25xPnhCkHeHPjLj7bVQjONbw/VkvvwaMZTH+J8hzIe9nDBwykd/SKuYGkMwBJ/EICpmlbILdtKmV30+mv8lJTEQLiOqve72Db0UUK/fpaZ9TmuoLRt8b5B+UTJ/rPF4f9kKFGVNXLV/0qiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv854kNM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv854kNM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG624qHZz3cKj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:36:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BE75C605D0;
	Mon,  2 Nov 2026 15:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531081F00A18;
	Mon,  2 Nov 2026 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633816;
	bh=S9tzR156ub0Ko3Mv53tQ+R8L9hVWUPj+OCS3UYlYhFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xv854kNMsGwo7y+d1KGrPoCvj8xhJsXdx+NPbr36bs+rW5xwmzoPtt2iRcwjhbEKU
	 XfGn3WHT/EUTweyMuOntYcuRNkJ8rTxnpo6+2PE2yMcenfdCzl5eIgjm5/Mh5ebn7G
	 fkhyKa0rXacAXgJ+DCsssER449+cBLCHyxVdSSLX+Dc8MDSqMopDEivA7yuiSDKGIt
	 S+zxOV5qOgzsYi0jxj417k6xxIdELaXugUKSSeWJd0Mj/Dej88U0tMQwopSyTcFdVs
	 +LuR+neBjXGs3pWPltnJUq6afbVpYXhNMgZlQFhveRD+FSFnPEgw7sZPZlNM5HmN/s
	 Kl3S3hqMGw5FQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:15:56 +0100
Subject: [PATCH RFC 3/5] proc: only let permanent entries read straight
 into userspace
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-cleanup-v1-3-c40014bc12f5@kernel.org>
References: <20261102-work-procfs-cleanup-v1-0-c40014bc12f5@kernel.org>
In-Reply-To: <20261102-work-procfs-cleanup-v1-0-c40014bc12f5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3948; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HAEx+xWoU7bRVFGL7mPvEVPlpuc3m3z2NxJgiNg4Kyk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WJlZf/pOH6N9WMJzv9uNpixmJcz8Ug/Ejvz11/239
 6GG0aykjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncamf4X3St2856z96lFedd
 LXNe81VttXmn+CW5oKrcbePRNO7QUwz/LLla1BTNtBU3uscdWNC45ueiHItPagqx/Q8zd6094Fv
 ADgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every entry that can be removed implements ->proc_read_buf() now and
procfs copies what is read to userspace after unpinning the entry.
->proc_read() and ->proc_read_iter() are left for the entries that are
never removed, kcore, kmsg, kpagecount, kpageflags, kpagecgroup and
profile. procfs never pins those, so nothing can wait for them.

Say so in struct proc_ops and refuse to register an entry that can be
removed and has one of them. The read paths then don't need to pin the
entry anymore.

PROC_ENTRY_PERMANENT is 0 in modules, so a module can't register an
entry with one of them anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c       |  4 ++++
 fs/proc/inode.c         | 27 ++++++++-------------------
 include/linux/proc_fs.h |  6 ++++++
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 413382efefc7..7c8def4ed9fc 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -443,6 +443,10 @@ static int pde_set_flags(struct proc_dir_entry *pde)
 
 	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	/* These copy to userspace and only an entry that can't go away may. */
+	if (WARN_ON_ONCE((proc_ops->proc_read || proc_ops->proc_read_iter) &&
+			 !pde_is_permanent(pde)))
+		return -EINVAL;
 	if (proc_ops->proc_seq_ops) {
 		pde->seq_ops = proc_ops->proc_seq_ops;
 		pde->state_size = proc_ops->proc_state_size;
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 971f2aecc006..a7f8818b0b74 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -460,35 +460,24 @@ static ssize_t pde_read_buf(struct proc_dir_entry *pde, struct kiocb *iocb,
 static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(iocb->ki_filp));
-	ssize_t ret;
 
 	if (pde_has_proc_read_buf(pde))
 		return pde_read_buf(pde, iocb, iter);
-	if (!pde_pin(pde))
-		return -EIO;
-	ret = pde->proc_ops->proc_read_iter(iocb, iter);
-	pde_unpin(pde);
-	return ret;
-}
-
-static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
-{
-	const auto read = pde->proc_ops->proc_read;
-	if (read)
-		return read(file, buf, count, ppos);
-	return -EIO;
+	/* only permanent entries have one, see pde_set_flags() */
+	return pde->proc_ops->proc_read_iter(iocb, iter);
 }
 
 static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
-	ssize_t rv;
 
-	if (!pde_pin(pde))
+	/*
+	 * Only permanent entries have one, see pde_set_flags(). Anything else
+	 * might be gone along with its ->proc_ops.
+	 */
+	if (!pde_is_permanent(pde) || !pde->proc_ops->proc_read)
 		return -EIO;
-	rv = pde_read(pde, file, buf, count, ppos);
-	pde_unpin(pde);
-	return rv;
+	return pde->proc_ops->proc_read(file, buf, count, ppos);
 }
 
 /*
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 64242a9aa117..17516b064922 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -17,6 +17,8 @@ struct seq_operations;
 enum {
 	/*
 	 * All /proc entries using this ->proc_ops instance are never removed.
+	 * procfs calls into them without pinning them, so they may copy to
+	 * userspace themselves through ->proc_read() or ->proc_read_iter().
 	 *
 	 * If in doubt, ignore this flag.
 	 */
@@ -72,6 +74,10 @@ struct proc_ioctl_arg {
 struct proc_ops {
 	unsigned int proc_flags;
 	int	(*proc_open)(struct inode *, struct file *);
+	/*
+	 * These two are only for PROC_ENTRY_PERMANENT entries. Everything else
+	 * uses ->proc_read_buf().
+	 */
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*proc_read_iter)(struct kiocb *, struct iov_iter *);
 	/*

-- 
2.53.0


