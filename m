Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8C60A0CA6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9QGwQro
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG3P4692z3fV5;
	Tue, 03 Nov 2026 02:34:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633681;
	cv=none; b=nr9xjFwRyJrbdvCom8nOOqeNSEEeuiOwRAKbxkrtJuCP43iOzlMRFbqkLi6O8WkpsVUbgJm8Z8LexWEnzK25U7ea8rB7AMmuCS0Xf7pVJ9P3V8ThanJ+NQMnFh62LDqpyW8/GBp6adPK11gOEcqj5q0Ly8hDy/i/1KBng1wjdBmzZraXjpnqrRPckEPwHcxkspxqotbU9iehL6iVZoABfumutPYw7bzHp09/wa45ITgzIA0QJG/++FmaUCS+7CNabJCxdNt9dCLV8/SEraCqy9Ei800w3J8//TBJ8J9zDbzQcb3Bch0JBeoOOZVG5ULifPceFaMtm4dD/jzhLVpPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633681; c=relaxed/relaxed;
	bh=pmnFGMOE2v1+F0PJGOHw4Gdli7q7gPuktrXwX9LNfoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQJC5yxjxBgzIM8DIu2Do2BvHtTtuN57zgjgChDF7yYvqLKeNFI/lcrOGp70UgQG/fv0Oj7DZf3OWK4A/giH+r3RW7MkcT8t5/mS+7FTFBLsnQIkkyWE7Y3g9GKQ0hpSBgtubh0fgu9Og9lD8g5fLj3u2Uj9RfJvamZgM5qooMPhdhNw6WA/NWYi+j4O6IQcGP3aQuTWlHjBSz1qFGFxebNbquOpb89np8qTxpVfgfYFnivceAqLgQOaefVczEy+RmBk2EQRWRyVy5tq3ffJSXk22ZiT3S/nLlA3Ntm77CKE3dA3bHpV+zXgQHBxsctO3twv5/FBvKXGxhruvAOeeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9QGwQro; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9QGwQro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG3N5WMvz3f7V
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:34:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB41B609D2;
	Mon,  2 Nov 2026 15:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFFB1F00A17;
	Mon,  2 Nov 2026 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633678;
	bh=pmnFGMOE2v1+F0PJGOHw4Gdli7q7gPuktrXwX9LNfoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d9QGwQrotLscF4xo8DU9S109UjfAgcN4a46hjwVSf3SjqQgEaO4Rv1AEyP5dT4O5y
	 xhGnDHnb/jFSk8D7qKuO+39L5VOpMdQp+GEPoALOWTv2sAj3bbh7bn9Ca6T4Zctpcj
	 fNImnpjl37D5rGo6ytZAGYcvcU7Hs6e2nTEg5V2aQ/mC4G0yjxmcpG1Hu5e0aBYP77
	 YqqQjJjSh1N4cnNNEz/pCqHHyFFMtbDFf9uvFYMyEZgjLi1JBmongPZBS4PXj3B4fR
	 cGUqecnhkpX6QHjYWkx5oNKUT3XrFn+eoX8EGZYKiM0ZGpeR++e3aBl28Ylp4YaymR
	 Z4/Or8kbU/uIg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:24 +0100
Subject: [PATCH RFC 10/11] samples/kfifo: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-net-v1-10-982104a4f592@kernel.org>
References: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
In-Reply-To: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wqPh89nrehb8eXTwTved41pSSj+cx0NGgazKeJSdQJg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG5SKeDGcNhJw++9Z7LY3JTfuwQ+VK2efenXodN77
 51lStK62FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRuBCG/z6xtYb3b823yGzs
 EFIryW+ZU83Lc9Vb497sqedPcyic+MvwP/CknED65Xe3rd5zTJCoDZgg+Puey5sJtRciovqzWZV
 mcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and put that copy into the fifo with kfifo_in()
instead of kfifo_from_user(). Writes larger than PAGE_SIZE - 1 bytes
fail with -EINVAL now. kfifo_from_user() cut a record to 255 bytes,
what the one byte that holds its length can say, so the record sample
keeps doing that with PROC_ENTRY_SHORT_WRITES.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 samples/kfifo/bytestream-example.c |  9 +++------
 samples/kfifo/inttype-example.c    | 10 ++++------
 samples/kfifo/record-example.c     | 12 ++++++------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/samples/kfifo/bytestream-example.c b/samples/kfifo/bytestream-example.c
index 4ae29a12cc8a..8c58fb46a2bf 100644
--- a/samples/kfifo/bytestream-example.c
+++ b/samples/kfifo/bytestream-example.c
@@ -110,20 +110,17 @@ static int __init testfunc(void)
 	return 0;
 }
 
-static ssize_t fifo_write(struct file *file, const char __user *buf,
+static ssize_t fifo_write(struct file *file, char *buf,
 						size_t count, loff_t *ppos)
 {
-	int ret;
 	unsigned int copied;
 
 	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
-	ret = kfifo_from_user(&test, buf, count, &copied);
+	copied = kfifo_in(&test, buf, count);
 
 	mutex_unlock(&write_access);
-	if (ret)
-		return ret;
 
 	return copied;
 }
@@ -148,7 +145,7 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 
 static const struct proc_ops fifo_proc_ops = {
 	.proc_read	= fifo_read,
-	.proc_write	= fifo_write,
+	.proc_write_buf	= fifo_write,
 	.proc_lseek	= noop_llseek,
 };
 
diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-example.c
index e4f93317c5d0..c5d16b815e73 100644
--- a/samples/kfifo/inttype-example.c
+++ b/samples/kfifo/inttype-example.c
@@ -103,20 +103,18 @@ static int __init testfunc(void)
 	return 0;
 }
 
-static ssize_t fifo_write(struct file *file, const char __user *buf,
+static ssize_t fifo_write(struct file *file, char *buf,
 						size_t count, loff_t *ppos)
 {
-	int ret;
 	unsigned int copied;
 
 	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
-	ret = kfifo_from_user(&test, buf, count, &copied);
+	copied = kfifo_in(&test, (const int *)buf, count / sizeof(int)) *
+		 sizeof(int);
 
 	mutex_unlock(&write_access);
-	if (ret)
-		return ret;
 
 	return copied;
 }
@@ -141,7 +139,7 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 
 static const struct proc_ops fifo_proc_ops = {
 	.proc_read	= fifo_read,
-	.proc_write	= fifo_write,
+	.proc_write_buf	= fifo_write,
 	.proc_lseek	= noop_llseek,
 };
 
diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-example.c
index e4d1a2d7983c..dcc749247c64 100644
--- a/samples/kfifo/record-example.c
+++ b/samples/kfifo/record-example.c
@@ -117,20 +117,17 @@ static int __init testfunc(void)
 	return 0;
 }
 
-static ssize_t fifo_write(struct file *file, const char __user *buf,
+static ssize_t fifo_write(struct file *file, char *buf,
 						size_t count, loff_t *ppos)
 {
-	int ret;
 	unsigned int copied;
 
 	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
-	ret = kfifo_from_user(&test, buf, count, &copied);
+	copied = kfifo_in(&test, buf, count);
 
 	mutex_unlock(&write_access);
-	if (ret)
-		return ret;
 
 	return copied;
 }
@@ -155,8 +152,11 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 
 static const struct proc_ops fifo_proc_ops = {
 	.proc_read	= fifo_read,
-	.proc_write	= fifo_write,
+	.proc_write_buf	= fifo_write,
 	.proc_lseek	= noop_llseek,
+	/* kfifo_from_user() cut a record to what its length byte holds */
+	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
+	.proc_write_size = U8_MAX,
 };
 
 static int __init example_init(void)

-- 
2.53.0


