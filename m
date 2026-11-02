Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DD6093F77
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3KPtGIP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF882DdBz30Wg;
	Tue, 03 Nov 2026 01:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631224;
	cv=none; b=Qcx+zmV1s/wbQZRFRg9GT9eNaF2OB4hE291zR+pZB8L5ZjxS4qgNNvAQFuvI19PA/sTYPplpTqkSUSmlj2OGnMwNLq5o2U1w2k0m8jsHYCZ2B6t/O7OwbY7ue84JR9GvP2ZPM6unnWERfJe3zdEq0SFi+V7Wv10tUQ/6KV7/Cb0G62OuyaYRgwL2sbAxHyLwv+PAle60sO2dZ3rWGAdmse4v/Mz1j34kSo0dA+4JUrC/XiqbhpWS67vJSwK4H9k+Cb8PGaHemsd9KQOb3MimfZYIjsBTRyfCkmpqjLJJ0YweQ+/C3H46AMBvtckYly1aObCGztcOcse26E63bqXuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631224; c=relaxed/relaxed;
	bh=1qgL1NkV0P+SHvidYZZZVaI2a05IzcudOOYTRjrcE88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obBs2qHnB+7BikSdxNzoL62GwbeTGZe3H3fgQtMWtG+9cW9lD9dcja85bPJOf3wQtWUAGjtCNydC4G0dpvURKECt9n9lZ+YKX72Uobno5ci8287z2EXVzKRaQemSrO6VYkAw3PVziGi1zAtV6RghHQuJoPZBzc8kIIxW8gYmUSXm2BRHtH9lIAI8J7w6dotMcq+ryhC2UfIDKyOerya90RCeErX2cxydrd2bdXVOFUbg+jp97fJRuOys46yxfXfO/QCZKgsozRJKJybE+4Tw2IACgbj8tkjn9AFjiMYwgA4dKNP7iZUhYSd8bOzAhYeWk9tmUBywL96+Jo/PtFi1vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3KPtGIP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3KPtGIP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF873PwBz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:53:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 927EB602A8;
	Mon,  2 Nov 2026 14:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625C81F00A16;
	Mon,  2 Nov 2026 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631221;
	bh=1qgL1NkV0P+SHvidYZZZVaI2a05IzcudOOYTRjrcE88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B3KPtGIP7tGmYNWXeX+H1i7tzVg1QuBKxBa4wYZl9yFfxSPwV/nb6la4JTArPoEWx
	 ykM6GuLSG4T3qFKBXJYZCkJGC3vo8ibb5AaiCteOj34CmMoEHIQ9jN+136jYWHeTth
	 F1T67wbusbZFJFAB68aEdSrwP7ELsjghDN+oafO9DTOUCxgQLH239365ae129l0kUM
	 nRwyjSkChWEnrjfxrrWb5DyXYYNqiMK3X+fZLo7P3uKVMTCCcTjvGOV03/bfp2Z8WD
	 FOtEMf9oTbUWnSFUeeH5hrLQ9dj/aKDWVT6F7HwyJbdDISBaRlBZGt5VGMwbWH7Jme
	 DcXRqIaFfxaXw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:52 +0100
Subject: [PATCH RFC 12/16] proc: copy in writes to the network namespace
 entries before pinning
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
Message-Id: <20261102-work-procfs-core-v1-12-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
In-Reply-To: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_simple_write() already hands ->write() a kernel copy of what was
written but makes that copy with the entry pinned. Let procfs make it
before it pins the entry instead. That covers everything created with
proc_create_net_data_write() and proc_create_net_single_write(), the
afs files and the rxrpc stats.

So a write to a proc_create_net_single() file without ->write() can
fail with -EINVAL or -EFAULT now before proc_simple_write() gets to
refuse it with -EACCES.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c  | 15 ++++-----------
 fs/proc/internal.h |  2 +-
 fs/proc/proc_net.c |  4 ++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 7dc7df101286..83d273778a60 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -904,26 +904,19 @@ void proc_remove(struct proc_dir_entry *de)
 EXPORT_SYMBOL(proc_remove);
 
 /*
- * Pull a user buffer into memory and pass it to the file's write handler if
- * one is supplied.  The ->write() method is permitted to modify the
- * kernel-side buffer.
+ * Pass what was written to the file's write handler if one is supplied. The
+ * ->write() method is permitted to modify the buffer.
  */
-ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
-			  loff_t *_pos)
+ssize_t proc_simple_write(struct file *f, char *buf, size_t size, loff_t *_pos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(f));
-	char *buf;
 	int ret;
 
 	if (!pde->write)
 		return -EACCES;
-	if (size == 0 || size > PAGE_SIZE - 1)
+	if (size == 0)
 		return -EINVAL;
-	buf = memdup_user_nul(ubuf, size);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
 	ret = pde->write(f, buf, size);
-	kfree(buf);
 	return ret == 0 ? size : ret;
 }
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 80b346a3299d..ed22c6dfb0bf 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -317,7 +317,7 @@ static inline bool is_empty_pde(const struct proc_dir_entry *pde)
 {
 	return S_ISDIR(pde->mode) && !pde->proc_iops;
 }
-extern ssize_t proc_simple_write(struct file *, const char __user *, size_t, loff_t *);
+extern ssize_t proc_simple_write(struct file *, char *, size_t, loff_t *);
 
 /*
  * inode.c
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index fa485581d05e..cdeb2e025d2e 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -77,7 +77,7 @@ static int seq_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_seq_ops = {
 	.proc_open	= seq_open_net,
-	.proc_write	= proc_simple_write,
+	.proc_write_buf	= proc_simple_write,
 	.proc_release	= seq_release_net,
 };
 
@@ -186,7 +186,7 @@ static int single_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_single_ops = {
 	.proc_open	= single_open_net,
-	.proc_write	= proc_simple_write,
+	.proc_write_buf	= proc_simple_write,
 	.proc_release	= single_release_net,
 };
 

-- 
2.53.0


