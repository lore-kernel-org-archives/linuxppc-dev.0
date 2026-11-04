Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111B606EE8F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkp6RIn6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbZy6gp9z3dJ5;
	Thu, 05 Nov 2026 06:48:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821690;
	cv=none; b=GKzo5czmG1Rw4Nb0qb8W+uqlgzLTN588V+6WHHEWm0AYbq2bmXs6fUiajK/1aJPS8YB52uWxO1akJ3UqKS7ot8DAp5gJV6OcgwrieOZcRKOoXzA1S0gyKXGYi4ue+6G/e2lDqZvwTeyWSM9MG+35KzjWjv1dY713yX2Q+e9xAdRXvWZ/FIPi1RrsjUSpBRJNy98cYHdQUAFuSOGxEsDSlOAt4VNgXWB53etIO0lLKb7be5tDRCyAZXyEoH9P+FQtdpfHRim3I97CkDSQFkpOPZbMyOqGJipFnXrZ4s32THaD1CLuGBco8CWQXYMVfUqtKjJeoFDgk3H/gnxC7U2Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821690; c=relaxed/relaxed;
	bh=ONplUVUaTXxK76De6Vn1Er9qs4C1NOSJXP/cPYa1zD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyQyq2op+DKG8DPrt5fVwh/l/3FDGPv8M+Sho/4UVOwyUcGQGmWdT+AHbbsdMy5I/6Z4OZwf7jFS9WKUGuKbT4gqiVh48fBv4gsP8NNXMRyQ2aNQ8YsTXOel4jKhhrQ+BJgut5Wh9leXd9w0RhJymnbRyTdbDAF+3Br2EUTp5MsZiVJR23IzGXEU3Q2xJH3NHjz0FpHxhH4OXpLngrSHdhqcnPgctSjGMkJff8RjiQtOZGuibx17YAvkbk5gzZJP3NvZdDn03V8crSFaWk94ZJS/VW40Ig0EdTTeVE0fdCajAKgc1a6wsAAoqqmBjpxGDKuDUJaFdESFYy/Lumts1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkp6RIn6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkp6RIn6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbZy0dJcz30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:48:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 31D6D60F05;
	Wed,  4 Nov 2026 19:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FC71F000C1;
	Wed,  4 Nov 2026 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821687;
	bh=ONplUVUaTXxK76De6Vn1Er9qs4C1NOSJXP/cPYa1zD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkp6RIn69wa7QrxD965N76gTH76+Ad2SR2O4p5PIPFHK1xPstYpO5rXkJqMhkQ1Lt
	 f15stAccZE+S2yUy9VGYtTIgb/gLZoRkrtlXoSacpGUOek+JW4mciApeqg2m5gx7x7
	 jGcS2vzRcQT4C4Y2PMcgBIOORBdEDw5OW53AWsnhXJof8U2cIcsSBGzLLOhYFg8OY7
	 xr0CoygIBWv0A8Or/m5mqhRp+z3mn0v/XHAYgjIlNWHV+2hv84NzEvNyWKQmtZ3LQt
	 Nr81LfNZpAVIjzqW/eNpYRsboymU0WuZFRUFGyiYnkNPIl/SIoK0dzBDYI5+8c0PL1
	 46Zaq8Svqs2Yw==
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
Subject: [PATCH RESEND v2 23/26] ALSA: info: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:47:53 +0100
Message-ID: <20261104-work-procfs-drivers-v2-23-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4905; i=brauner@kernel.org; h=from:subject:message-id; bh=9ArjgwxZmmzVVHcaJKjV9iOUwuFu8vZkTaYAiSu/pJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97urfa8O39IWQ3sMqj7K8++pB6682y+x4pbRQuVd71 /ZZwXuOdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkaD8jw6qXkrMe32mW0Fr4 KjZPsovjwSUF/kq/82FOm+4YrNPjX8Pwz37zUZPZUqvCmfvMVYrnaPSeXD/5c/zt75vbeeakVdv 5MAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for data and text entries so procfs copies
in what is written before it pins the entry.

Data entries take writes a page at a time with PROC_ENTRY_SHORT_WRITES.
They used to get the whole write at once. ->write() of struct
snd_info_entry_ops gets the kernel copy and opl4, its only user, writes
it to the sample memory without bouncing it through a vmalloc() buffer
of its own.

Text entries take up to SND_INFO_TEXT_WRITE_MAX bytes at once like
before. A single write that is larger fails with -EINVAL from procfs
instead of -EIO now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/sound/info.h           |  2 +-
 sound/core/info.c              | 21 ++++++++++++---------
 sound/drivers/opl4/opl4_proc.c | 11 +----------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index f216291e5c41..a9344c44e352 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -42,7 +42,7 @@ struct snd_info_entry_ops {
 			struct file *file, char __user *buf,
 			size_t count, loff_t pos);
 	ssize_t (*write)(struct snd_info_entry *entry, void *file_private_data,
-			 struct file *file, const char __user *buf,
+			 struct file *file, const char *buf,
 			 size_t count, loff_t pos);
 	loff_t (*llseek)(struct snd_info_entry *entry,
 			 void *file_private_data, struct file *file,
diff --git a/sound/core/info.c b/sound/core/info.c
index 42a4f8fb3198..3bfeab1a5a1f 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -160,7 +160,7 @@ static ssize_t snd_info_entry_read(struct file *file, char __user *buffer,
 	return size;
 }
 
-static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer,
+static ssize_t snd_info_entry_write(struct file *file, char *buffer,
 				    size_t count, loff_t * offset)
 {
 	struct snd_info_private_data *data = file->private_data;
@@ -277,9 +277,11 @@ static int snd_info_entry_release(struct inode *inode, struct file *file)
 
 static const struct proc_ops snd_info_entry_operations =
 {
+	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 	.proc_lseek	= snd_info_entry_llseek,
 	.proc_read	= snd_info_entry_read,
-	.proc_write	= snd_info_entry_write,
+	.proc_write_buf	= snd_info_entry_write,
+	.proc_write_size = PAGE_SIZE,
 	.proc_poll	= snd_info_entry_poll,
 	.proc_ioctl	= snd_info_entry_ioctl,
 	.proc_mmap	= snd_info_entry_mmap,
@@ -287,11 +289,13 @@ static const struct proc_ops snd_info_entry_operations =
 	.proc_release	= snd_info_entry_release,
 };
 
+/* don't handle too large text inputs */
+#define SND_INFO_TEXT_WRITE_MAX	(16 * 1024)
+
 /*
  * file ops for text proc files
  */
-static ssize_t snd_info_text_entry_write(struct file *file,
-					 const char __user *buffer,
+static ssize_t snd_info_text_entry_write(struct file *file, char *buffer,
 					 size_t count, loff_t *offset)
 {
 	struct seq_file *m = file->private_data;
@@ -307,8 +311,7 @@ static ssize_t snd_info_text_entry_write(struct file *file,
 	if (!valid_pos(pos, count))
 		return -EIO;
 	next = pos + count;
-	/* don't handle too large text inputs */
-	if (next > 16 * 1024)
+	if (next > SND_INFO_TEXT_WRITE_MAX)
 		return -EIO;
 	guard(mutex)(&entry->access);
 	buf = data->wbuffer;
@@ -325,8 +328,7 @@ static ssize_t snd_info_text_entry_write(struct file *file,
 		buf->buffer = nbuf;
 		buf->len = PAGE_ALIGN(next);
 	}
-	if (copy_from_user(buf->buffer + pos, buffer, count))
-		return -EFAULT;
+	memcpy(buf->buffer + pos, buffer, count);
 	buf->size = next;
 	*offset = next;
 	return count;
@@ -404,7 +406,8 @@ static const struct proc_ops snd_info_text_entry_ops =
 	.proc_show	= snd_info_seq_show,
 	.proc_open	= snd_info_text_entry_open,
 	.proc_release	= snd_info_text_entry_release,
-	.proc_write	= snd_info_text_entry_write,
+	.proc_write_buf	= snd_info_text_entry_write,
+	.proc_write_size = SND_INFO_TEXT_WRITE_MAX,
 };
 
 static struct snd_info_entry *create_subdir(struct module *mod,
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index fd0ba4704d9f..bdcae02a4dc2 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -54,21 +54,12 @@ static ssize_t snd_opl4_mem_proc_read(struct snd_info_entry *entry,
 static ssize_t snd_opl4_mem_proc_write(struct snd_info_entry *entry,
 				       void *file_private_data,
 				       struct file *file,
-				       const char __user *_buf,
+				       const char *buf,
 				       size_t count, loff_t pos)
 {
 	struct snd_opl4 *opl4 = entry->private_data;
-	char *buf;
 
-	buf = vmalloc(count);
-	if (!buf)
-		return -ENOMEM;
-	if (copy_from_user(buf, _buf, count)) {
-		vfree(buf);
-		return -EFAULT;
-	}
 	snd_opl4_write_memory(opl4, buf, pos, count);
-	vfree(buf);
 	return count;
 }
 

-- 
2.53.0


