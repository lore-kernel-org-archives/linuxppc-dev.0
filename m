Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C1606A90A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWjkcOBN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFMV3chgz30Wg;
	Tue, 03 Nov 2026 02:03:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631814;
	cv=none; b=aNcDOHl5B7SaBXN1sCP+QsdAxYIOO2KFeW84qlT1LCYiTAMjWGMgn5CZC3Q7j/gYg4CLfl0bgVlnbb/WUoD5WoNOuJBfcL1CIMWp+4tVez6+OucTvIhYZ2jhYOjkaHxvsmomrJa3Gv0erJBSfmy2w5uxuF3mPtjZNf/DLocj0u3RYH0cZ6db3d4ecsBY8rHnstNwQ/iJKWbJATI661injkibxuTpujI04B8oCseYZtwZHeysIP5GGIWbxXGIdrpDI8omVuGQkeGZM2ySbkHYshdDaRFWzlbHeZl2RPHIJ9RuKD1eiJSwKMjBlyh1lSIfCqepXbcXm4eeY/3LDJfMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631814; c=relaxed/relaxed;
	bh=oVeQwusVcdWt+t2MXjuQ/DhAoQowLCWkhlldD+EM/ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cV7aROv56a6h2ROyQ2gPpLejaimLOnBiUAC4Ns/Sli6JHIO2pvxg/nd/7I50Kf2HIM+QhnmPRKZonbv4LurHR7CXe7hpKx18HMaW2f4PRbsbLlsbiHvFgzWhJK1ErnQky7hYXtWecZqqUIIgYhxyfQSGbYr6kYv4enwqiF0e1GFs91NWG3usfO3o69Z00XLCdNpLUQezcd9vk9t59dUFwfEUE4vUFWX7DnI2qYfL7rglmWkBwLrlgUPoqDc+4vINIno9xRkHgFwXkac2HliCJNia9a4lzxgjlSl/V2Ip2dkfvRJNnQIyoJIWan4MN8EjSJrrhjKG0M2GKRr0dUP/4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWjkcOBN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWjkcOBN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFMT5DX5z2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:03:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 322F243228;
	Mon,  2 Nov 2026 15:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822311F00A1A;
	Mon,  2 Nov 2026 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631812;
	bh=oVeQwusVcdWt+t2MXjuQ/DhAoQowLCWkhlldD+EM/ro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OWjkcOBNjrMUeTufmvVyzLqLuyvTySsw+dhv5IHxs/hieYtMOgOEszSyAJzpSCxpE
	 ivhlaW3vverSeo9xxXMpCNv4uvFlwTOs2Rxv79ipdQZsAXLlNfjnYXqlikAzK9Rhwj
	 fbSTM45jfTBK7jdKNJHzSS+yPm+jYE9xinTq6+vQkPrWwGMPkbWnlrXkqvWf+SEGzv
	 NUr+FGlXFmobxkkYkI8iFyJMqEYyanfGZehuXpsHLl/Q30PMDmV9NESufDJsqM/FXP
	 RzCWFajSSJkhhGsUeItsbwH1Bh143kv0KKo/cAPN6grVu2VmnCed1H7khCoprygo9o
	 BRZHUp6nTcKrA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:33 +0100
Subject: [PATCH RFC 06/22] powerpc/rtas: let procfs copy out reads
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
Message-Id: <20261102-work-procfs-arch-v1-6-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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

Implement ->proc_read_buf() for the error log and the flash files so
procfs copies what is read to userspace after it unpinned the entry.

The error log hands out a record the way it did before, the record is
consumed before it reaches userspace. A reader that passes a NULL buffer
now loses a record like one that passed a bad buffer always did, instead
of getting -EINVAL. The files can be spliced now, like every entry that
is read through ->read_iter(). Note that a sendfile() from the error log
into a target that fails or takes less than was read drops the records
in between, splice_direct_to_actor() rewinds any seekable file like
that and the error log doesn't hand a record out twice.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/rtas_flash.c | 24 ++++++++++++------------
 arch/powerpc/kernel/rtasd.c      | 19 +++++--------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 77a4627f2507..5ebaee7683ef 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -269,7 +269,7 @@ static size_t get_flash_status_msg(int status, char *buf)
 }
 
 /* Reading the proc file will show status (not the firmware contents) */
-static ssize_t rtas_flash_read_msg(struct file *file, char __user *buf,
+static ssize_t rtas_flash_read_msg(struct file *file, char *buf,
 				   size_t count, loff_t *ppos)
 {
 	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
@@ -283,10 +283,10 @@ static ssize_t rtas_flash_read_msg(struct file *file, char __user *buf,
 
 	/* Read as text message */
 	len = get_flash_status_msg(status, msg);
-	return simple_read_from_buffer(buf, count, ppos, msg, len);
+	return memory_read_from_buffer(buf, count, ppos, msg, len);
 }
 
-static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
+static ssize_t rtas_flash_read_num(struct file *file, char *buf,
 				   size_t count, loff_t *ppos)
 {
 	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
@@ -299,7 +299,7 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
 
 	/* Read as number */
 	sprintf(msg, "%d\n", status);
-	return simple_read_from_buffer(buf, count, ppos, msg, strlen(msg));
+	return memory_read_from_buffer(buf, count, ppos, msg, strlen(msg));
 }
 
 /* We could be much more efficient here.  But to keep this function
@@ -370,7 +370,7 @@ static void manage_flash(struct rtas_manage_flash_t *args_buf, unsigned int op)
 	args_buf->status = rc;
 }
 
-static ssize_t manage_flash_read(struct file *file, char __user *buf,
+static ssize_t manage_flash_read(struct file *file, char *buf,
 			       size_t count, loff_t *ppos)
 {
 	struct rtas_manage_flash_t *const args_buf = &rtas_manage_flash_data;
@@ -382,7 +382,7 @@ static ssize_t manage_flash_read(struct file *file, char __user *buf,
 	mutex_unlock(&rtas_manage_flash_mutex);
 
 	msglen = sprintf(msg, "%d\n", status);
-	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
+	return memory_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
 static ssize_t manage_flash_write(struct file *file, char *buf,
@@ -450,7 +450,7 @@ static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf,
 	return n;
 }
 
-static ssize_t validate_flash_read(struct file *file, char __user *buf,
+static ssize_t validate_flash_read(struct file *file, char *buf,
 			       size_t count, loff_t *ppos)
 {
 	struct rtas_validate_flash_t *const args_buf =
@@ -462,7 +462,7 @@ static ssize_t validate_flash_read(struct file *file, char __user *buf,
 	msglen = get_validate_flash_msg(args_buf, msg, VALIDATE_MSG_LEN);
 	mutex_unlock(&rtas_validate_flash_mutex);
 
-	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
+	return memory_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
 static ssize_t validate_flash_write(struct file *file, char *buf,
@@ -623,7 +623,7 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.handle		= RTAS_FN_IBM_UPDATE_FLASH_64_AND_REBOOT,
 		.status		= &rtas_update_flash_data.status,
 		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
-		.ops.proc_read	= rtas_flash_read_msg,
+		.ops.proc_read_buf = rtas_flash_read_msg,
 		.ops.proc_write_buf = rtas_flash_write,
 		.ops.proc_write_size = RTAS_BLK_SIZE,
 		.ops.proc_release = rtas_flash_release,
@@ -634,7 +634,7 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.handle		= RTAS_FN_IBM_UPDATE_FLASH_64_AND_REBOOT,
 		.status		= &rtas_update_flash_data.status,
 		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
-		.ops.proc_read	= rtas_flash_read_num,
+		.ops.proc_read_buf = rtas_flash_read_num,
 		.ops.proc_write_buf = rtas_flash_write,
 		.ops.proc_write_size = RTAS_BLK_SIZE,
 		.ops.proc_release = rtas_flash_release,
@@ -645,7 +645,7 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.handle		= RTAS_FN_IBM_VALIDATE_FLASH_IMAGE,
 		.status		= &rtas_validate_flash_data.status,
 		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
-		.ops.proc_read	= validate_flash_read,
+		.ops.proc_read_buf = validate_flash_read,
 		.ops.proc_write_buf = validate_flash_write,
 		.ops.proc_write_size = VALIDATE_BUF_SIZE,
 		.ops.proc_release = validate_flash_release,
@@ -655,7 +655,7 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.filename	= "powerpc/rtas/" MANAGE_FLASH_NAME,
 		.handle		= RTAS_FN_IBM_MANAGE_FLASH_IMAGE,
 		.status		= &rtas_manage_flash_data.status,
-		.ops.proc_read	= manage_flash_read,
+		.ops.proc_read_buf = manage_flash_read,
 		.ops.proc_write_buf = manage_flash_write,
 		.ops.proc_lseek	= default_llseek,
 	}
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index dd0df5e164a3..360ed2e30fd5 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -291,26 +291,18 @@ static int rtas_log_release(struct inode * inode, struct file * file)
  * know that we can safely clear the events in NVRAM.
  * Next we'll sit and wait for something else to log.
  */
-static ssize_t rtas_log_read(struct file * file, char __user * buf,
+static ssize_t rtas_log_read(struct file * file, char * buf,
 			 size_t count, loff_t *ppos)
 {
 	int error;
-	char *tmp;
 	unsigned long s;
 	unsigned long offset;
 
-	if (!buf || count < rtas_error_log_buffer_max)
+	if (count < rtas_error_log_buffer_max)
 		return -EINVAL;
 
 	count = rtas_error_log_buffer_max;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
-
-	tmp = kmalloc(count, GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&rtasd_log_lock, s);
 
 	/* if it's 0, then we know we got the last one (the one in NVRAM) */
@@ -338,15 +330,14 @@ static ssize_t rtas_log_read(struct file * file, char __user * buf,
 	}
 
 	offset = rtas_error_log_buffer_max * (rtas_log_start & LOG_NUMBER_MASK);
-	memcpy(tmp, &rtas_log_buf[offset], count);
+	memcpy(buf, &rtas_log_buf[offset], count);
 
 	rtas_log_start += 1;
 	rtas_log_size -= 1;
 	spin_unlock_irqrestore(&rtasd_log_lock, s);
 
-	error = copy_to_user(buf, tmp, count) ? -EFAULT : count;
+	error = count;
 out:
-	kfree(tmp);
 	return error;
 }
 
@@ -359,7 +350,7 @@ static __poll_t rtas_log_poll(struct file *file, poll_table * wait)
 }
 
 static const struct proc_ops rtas_log_proc_ops = {
-	.proc_read	= rtas_log_read,
+	.proc_read_buf	= rtas_log_read,
 	.proc_poll	= rtas_log_poll,
 	.proc_open	= rtas_log_open,
 	.proc_release	= rtas_log_release,

-- 
2.53.0


