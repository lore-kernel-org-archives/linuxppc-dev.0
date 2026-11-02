Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB56082BD2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwNawf2u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFMC0pkpz2yh4;
	Tue, 03 Nov 2026 02:03:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631799;
	cv=none; b=KKe7pOu1XO2/0y5yq6tCM7QAsxbmJj4/dzm8tzejT3NE4mVXTqlDmbkb2WhI3XEdK6uUg4kX5HBM3qw9bC9bFKRouz9UnjSb/vVdU9mxyt0Px9QwrKpCjGnwjFfr+AWjlMovRF/07LOEp/cChbod8ZXXSRYW3YU1eDDbL7SOcoqeRIV4uerqwxTeQiv25tNkvsR41M01g1vqaRGP/aLV3biHKIJMQ4hkTUzUfGXLlpPdDzsEKL57p0heUX1JOAjDr+FSr5Lolf8NYQtu+rai/AKAq2fN09yBSPBt453BWz6N23erPSFzUIiYS5296Z0zSp0YCtXrzSlmhLGQrFDmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631799; c=relaxed/relaxed;
	bh=SeSqWCgckwihcSErYyiMc6rZ3Zm4y3kjZ5EEGxJWIgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWyYFLNYD+Y79ZjFwsPlQdZaXS63ozW9hh+rxJxD0QG8X0dyJUX7ZxGd7k8QLYJ0AUGRkzraY4KpifI3LaSbpzukF1boe0ohVvqnigRRcc6g/ULfeF+qXlEJ4PiaW4THgi39f+QD78i9yR2wdj4WtjiF4qHbTHZDPVHMM/Iw6QcmYx/Q7me4ZxIOmPFhJ82hyciQypJ3YuzrEV+N/bb1CqVrCvrr6nKS1aYNZv+JC6Hk+/6QtVgpxCvHZ9u9/Lfl2Q9gS2xJ9uRxKHCRXXGhkRgeHZkwSVZgVpthJZxcq5YOE9vm6+k8jKkc0OXS8QFWSjhP7HFo7ydewHtcagp73A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwNawf2u; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwNawf2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFMB1LwYz2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:03:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EE6260613;
	Mon,  2 Nov 2026 15:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF31F00A18;
	Mon,  2 Nov 2026 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631795;
	bh=SeSqWCgckwihcSErYyiMc6rZ3Zm4y3kjZ5EEGxJWIgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CwNawf2uPczi8WJdPDNkHtSgDWIXAV10IshSH1eNh6O8W9BXkP2tEug+AdMt8nQZt
	 380ZRltiSIxBcIZcWlnOLRJnpli4yznDcDX6tik4WmffnOqr144BmVKoQ7jmh10aLj
	 xAc2Dh2kX4fj22+WC0AtCadmf5R8CNYLd8M/NFA0Xp8X5pkJQ1Mlk2iZ2DYC/2jliR
	 ZPNHRMopA8L7QRp/6ITH6UKGjj9v8wUwbbdXfJb7+fQn27NXB1Qu0m5O94rsMJNxrl
	 EJ7Px46au8wXJiUx591MNpF14s7TpJCkk+efIh02U2sqPl6KlYAL+Hv4MojyEgnZce
	 +OkwRpXnT/WGA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:32 +0100
Subject: [PATCH RFC 05/22] powerpc/rtas: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-arch-v1-5-c9492ab08480@kernel.org>
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

Implement ->proc_write_buf() for the files in /proc/powerpc/rtas and
/proc/ppc64/rtas so procfs copies in what is written before it pins the
entry, and parse what was written from that copy.

firmware_flash, firmware_update and validate_flash take an image in 4k
pieces and relied on writes coming up short. They keep doing that with
PROC_ENTRY_SHORT_WRITES. Writes to the other files that are larger than
PAGE_SIZE - 1 bytes fail with -EINVAL now.

validate_flash only keeps the first 4k of the image and used to swallow
whatever was written beyond that in one go. It takes at most 4k per
write now, like for the part it keeps, so a writer has to loop there
like it has to for the image itself.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/rtas-proc.c  | 40 ++++++++++++++++++----------------------
 arch/powerpc/kernel/rtas_flash.c | 38 +++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index ebf416840b3c..9598866f11cb 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -138,45 +138,45 @@ static unsigned long rtas_tone_volume = 0;
 static int ppc_rtas_sensors_show(struct seq_file *m, void *v);
 static int ppc_rtas_clock_show(struct seq_file *m, void *v);
 static ssize_t ppc_rtas_clock_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos);
+		char *buf, size_t count, loff_t *ppos);
 static int ppc_rtas_progress_show(struct seq_file *m, void *v);
 static ssize_t ppc_rtas_progress_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos);
+		char *buf, size_t count, loff_t *ppos);
 static int ppc_rtas_poweron_show(struct seq_file *m, void *v);
 static ssize_t ppc_rtas_poweron_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos);
+		char *buf, size_t count, loff_t *ppos);
 
 static ssize_t ppc_rtas_tone_freq_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos);
+		char *buf, size_t count, loff_t *ppos);
 static int ppc_rtas_tone_freq_show(struct seq_file *m, void *v);
 static ssize_t ppc_rtas_tone_volume_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos);
+		char *buf, size_t count, loff_t *ppos);
 static int ppc_rtas_tone_volume_show(struct seq_file *m, void *v);
 static int ppc_rtas_rmo_buf_show(struct seq_file *m, void *v);
 
 static const struct proc_ops ppc_rtas_poweron_proc_ops = {
 	.proc_show	= ppc_rtas_poweron_show,
-	.proc_write	= ppc_rtas_poweron_write,
+	.proc_write_buf	= ppc_rtas_poweron_write,
 };
 
 static const struct proc_ops ppc_rtas_progress_proc_ops = {
 	.proc_show	= ppc_rtas_progress_show,
-	.proc_write	= ppc_rtas_progress_write,
+	.proc_write_buf	= ppc_rtas_progress_write,
 };
 
 static const struct proc_ops ppc_rtas_clock_proc_ops = {
 	.proc_show	= ppc_rtas_clock_show,
-	.proc_write	= ppc_rtas_clock_write,
+	.proc_write_buf	= ppc_rtas_clock_write,
 };
 
 static const struct proc_ops ppc_rtas_tone_freq_proc_ops = {
 	.proc_show	= ppc_rtas_tone_freq_show,
-	.proc_write	= ppc_rtas_tone_freq_write,
+	.proc_write_buf	= ppc_rtas_tone_freq_write,
 };
 
 static const struct proc_ops ppc_rtas_tone_volume_proc_ops = {
 	.proc_show	= ppc_rtas_tone_volume_show,
-	.proc_write	= ppc_rtas_tone_volume_write,
+	.proc_write_buf	= ppc_rtas_tone_volume_write,
 };
 
 static int ppc_rtas_find_all_sensors(void);
@@ -216,16 +216,14 @@ static int __init proc_rtas_init(void)
 
 __initcall(proc_rtas_init);
 
-static int parse_number(const char __user *p, size_t count, u64 *val)
+static int parse_number(const char *p, size_t count, u64 *val)
 {
 	char buf[40];
 
 	if (count > 39)
 		return -EINVAL;
 
-	if (copy_from_user(buf, p, count))
-		return -EFAULT;
-
+	memcpy(buf, p, count);
 	buf[count] = 0;
 
 	return kstrtoull(buf, 10, val);
@@ -235,7 +233,7 @@ static int parse_number(const char __user *p, size_t count, u64 *val)
 /* POWER-ON-TIME                                                      */
 /* ****************************************************************** */
 static ssize_t ppc_rtas_poweron_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+		char *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
 	time64_t nowtime;
@@ -269,15 +267,13 @@ static int ppc_rtas_poweron_show(struct seq_file *m, void *v)
 /* PROGRESS                                                           */
 /* ****************************************************************** */
 static ssize_t ppc_rtas_progress_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+		char *buf, size_t count, loff_t *ppos)
 {
 	unsigned long hex;
 
 	if (count >= MAX_LINELENGTH)
 		count = MAX_LINELENGTH -1;
-	if (copy_from_user(progress_led, buf, count)) { /* save the string */
-		return -EFAULT;
-	}
+	memcpy(progress_led, buf, count); /* save the string */
 	progress_led[count] = 0;
 
 	/* Lets see if the user passed hexdigits */
@@ -301,7 +297,7 @@ static int ppc_rtas_progress_show(struct seq_file *m, void *v)
 /* CLOCK                                                              */
 /* ****************************************************************** */
 static ssize_t ppc_rtas_clock_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+		char *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
 	time64_t nowtime;
@@ -660,7 +656,7 @@ static void get_location_code(struct seq_file *m, struct individual_sensor *s,
 /* INDICATORS - Tone Frequency                                        */
 /* ****************************************************************** */
 static ssize_t ppc_rtas_tone_freq_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+		char *buf, size_t count, loff_t *ppos)
 {
 	u64 freq;
 	int error = parse_number(buf, count, &freq);
@@ -685,7 +681,7 @@ static int ppc_rtas_tone_freq_show(struct seq_file *m, void *v)
 /* INDICATORS - Tone Volume                                           */
 /* ****************************************************************** */
 static ssize_t ppc_rtas_tone_volume_write(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+		char *buf, size_t count, loff_t *ppos)
 {
 	u64 volume;
 	int error = parse_number(buf, count, &volume);
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index f1cd105f7426..77a4627f2507 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -307,7 +307,7 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
  * count is.  If the system is low on memory it will be just as well
  * that we fail....
  */
-static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
+static ssize_t rtas_flash_write(struct file *file, char *buffer,
 				size_t count, loff_t *off)
 {
 	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
@@ -343,16 +343,11 @@ static ssize_t rtas_flash_write(struct file *file, const char __user *buffer,
 		next_free = 0;
 	}
 
-	if (count > RTAS_BLK_SIZE)
-		count = RTAS_BLK_SIZE;
 	p = kmem_cache_zalloc(flash_block_cache, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	
-	if(copy_from_user(p, buffer, count)) {
-		kmem_cache_free(flash_block_cache, p);
-		return -EFAULT;
-	}
+	memcpy(p, buffer, count);
 	fl->blocks[next_free].data = p;
 	fl->blocks[next_free].length = count;
 	fl->num_blocks++;
@@ -390,7 +385,7 @@ static ssize_t manage_flash_read(struct file *file, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
-static ssize_t manage_flash_write(struct file *file, const char __user *buf,
+static ssize_t manage_flash_write(struct file *file, char *buf,
 				size_t count, loff_t *off)
 {
 	struct rtas_manage_flash_t *const args_buf = &rtas_manage_flash_data;
@@ -401,9 +396,8 @@ static ssize_t manage_flash_write(struct file *file, const char __user *buf,
 
 	if ((args_buf->status == MANAGE_AUTH) || (count == 0))
 		return count;
-		
-	if (get_user(cmd, buf))
-		return -EFAULT;
+
+	cmd = buf[0];
 
 	if (cmd == '0')
 		op = RTAS_REJECT_TMP_IMG;
@@ -471,7 +465,7 @@ static ssize_t validate_flash_read(struct file *file, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
-static ssize_t validate_flash_write(struct file *file, const char __user *buf,
+static ssize_t validate_flash_write(struct file *file, char *buf,
 				    size_t count, loff_t *off)
 {
 	struct rtas_validate_flash_t *const args_buf =
@@ -494,11 +488,7 @@ static ssize_t validate_flash_write(struct file *file, const char __user *buf,
 		args_buf->status = VALIDATE_INCOMPLETE;
 	}
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
-
-	if (copy_from_user(args_buf->buf + *off, buf, count))
-		return -EFAULT;
+	memcpy(args_buf->buf + *off, buf, count);
 
 	*off += count;
 	return count;
@@ -632,8 +622,10 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.filename	= "powerpc/rtas/" FIRMWARE_FLASH_NAME,
 		.handle		= RTAS_FN_IBM_UPDATE_FLASH_64_AND_REBOOT,
 		.status		= &rtas_update_flash_data.status,
+		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 		.ops.proc_read	= rtas_flash_read_msg,
-		.ops.proc_write	= rtas_flash_write,
+		.ops.proc_write_buf = rtas_flash_write,
+		.ops.proc_write_size = RTAS_BLK_SIZE,
 		.ops.proc_release = rtas_flash_release,
 		.ops.proc_lseek	= default_llseek,
 	},
@@ -641,8 +633,10 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.filename	= "powerpc/rtas/" FIRMWARE_UPDATE_NAME,
 		.handle		= RTAS_FN_IBM_UPDATE_FLASH_64_AND_REBOOT,
 		.status		= &rtas_update_flash_data.status,
+		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 		.ops.proc_read	= rtas_flash_read_num,
-		.ops.proc_write	= rtas_flash_write,
+		.ops.proc_write_buf = rtas_flash_write,
+		.ops.proc_write_size = RTAS_BLK_SIZE,
 		.ops.proc_release = rtas_flash_release,
 		.ops.proc_lseek	= default_llseek,
 	},
@@ -650,8 +644,10 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.filename	= "powerpc/rtas/" VALIDATE_FLASH_NAME,
 		.handle		= RTAS_FN_IBM_VALIDATE_FLASH_IMAGE,
 		.status		= &rtas_validate_flash_data.status,
+		.ops.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 		.ops.proc_read	= validate_flash_read,
-		.ops.proc_write	= validate_flash_write,
+		.ops.proc_write_buf = validate_flash_write,
+		.ops.proc_write_size = VALIDATE_BUF_SIZE,
 		.ops.proc_release = validate_flash_release,
 		.ops.proc_lseek	= default_llseek,
 	},
@@ -660,7 +656,7 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 		.handle		= RTAS_FN_IBM_MANAGE_FLASH_IMAGE,
 		.status		= &rtas_manage_flash_data.status,
 		.ops.proc_read	= manage_flash_read,
-		.ops.proc_write	= manage_flash_write,
+		.ops.proc_write_buf = manage_flash_write,
 		.ops.proc_lseek	= default_llseek,
 	}
 };

-- 
2.53.0


