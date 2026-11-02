Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FF607B40A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGKeYdZH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFdm513Mz3bZf;
	Tue, 03 Nov 2026 02:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632556;
	cv=none; b=R8fs+ZoUAScDJlS1IW/OWwgI7sQLY8pFkX3b+e4lBU5V6aYjZJhPvJWnITojWOT8J06YUnp4D7eGJNJBsCdr3A2ntAt2jlRti8Undw5k0835vJkzBYES0dMAmgqBCM2cW7T5nWJlnLo0F46nGwVO06AnDyY9umkZKuI5eND8Xq4XQGWTnWB1AcyTqGrSE9S+PB2M894LVb16MuNyft7+v7NXNrQF4FoAX6N1R512XsWyzyGztDKV59SbpEVRmwJreuIev4Mmxrx1IUde6lAlLu5PUsVR7cvEjzDxoyHHfs4wNt5L4QzjtkFDg8WbYmJBWHzijuRsJjW2EdTRwKmCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632556; c=relaxed/relaxed;
	bh=/po/gL747wOLzB9LODGeMVhVpt9eaPUzZYdg1qfmMOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caMR3i8QwQbR+23Z8nMU5ABF1fS9I/Ocbf4e/hC/m3ya71UIC0wnY8SdNDqqx/LJMtt6o6SEHEFCKGrUUg7vNGYKDb7XozZJEhyaxFOGjT3uxGJAHihaTCNNhUVX+UD1l8LK9duoIyB0iK4fkAmUqMshyr41hcJ4Avs8LT7183Y9NRg4CbUcYPG4bW9YGsD3ceJ6Ib9VghO54KkD5uszFgpdgDvdh/4Yd/bjjVV9IMMarO2IQ2SHyWtazATImLl2y211Fz6SN65h3Jd+Z3b12qlOTs76KYHka3Ldy33ltPjH6PzotQ9f88+6FVf2qBj3zYmaJO7SEScarAlLVjox0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGKeYdZH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGKeYdZH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFdl466Dz3bl5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:15:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7587C608FB;
	Mon,  2 Nov 2026 15:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2421F01577;
	Mon,  2 Nov 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632553;
	bh=/po/gL747wOLzB9LODGeMVhVpt9eaPUzZYdg1qfmMOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CGKeYdZH3IwAOCMuWH4rKgTK8AFjvD4vT1A8MvChb7ekc5exPD2bZli39nsFA0rll
	 Wro/pLXxHNScoGUOu2GS9dEhVACBfx94QMr+3AMAn65A2xaiLaTjC73SUe8x8Vxwck
	 TeCW4nmblkVEQmFIwgDcUhlYB0U0/KpXLfCzgE+9+Se3WYxVgLhbEreVGTJlTh7c4u
	 7jg8GYZ3EUYQeyZJ6KtO5lHZzH6stQjbxp/hT7OtsLZZLQOnXqbHn3uMLytT76+H+J
	 11fMUBwYPr5hdM+l9taHXvznWRfSrNsArNpSfoPYVGe++uXgaOyNJuTilC2BxjGnzX
	 V3ffhGBeXv1JA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:23 +0100
Subject: [PATCH RFC 16/23] fbdev: viafb: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-drivers-v1-16-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7373; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IvpcER7zxYNfDUB5gfp3pz3pT+0GSZCEEAhc7Zgpx0U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG54f1e88Ubf1/OUJVMEWfZ4yKg+n9wdmu7zh8P0w
 mbtexXfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyYx/DP839pVLn/F+/fJc4
 901N3fx3nhnHtzv3nPPxi2y8FyOeH8Dw3+1pcIH7Q+ViI6Yijo/tvDyhr4RWLF3tMmnmydKdZ9Y
 mswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for the files in /proc/viafb so procfs
copies in what is written before it pins the entry, and parse what was
written from that copy. Writes larger than PAGE_SIZE - 1 bytes fail with
-EINVAL now, the output device files refused anything over 63 bytes
already. kstrtou8_from_user() looked at the first 10 bytes of what was
written to dfph and dfpl, now the whole write is parsed.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/video/fbdev/via/viafbdev.c | 46 +++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 4b617e80a77c..94b303006915 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1121,7 +1121,7 @@ static int viafb_dvp0_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_dvp0_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	char buf[20], *value, *pbuf;
 	u8 reg_val = 0;
@@ -1129,8 +1129,7 @@ static ssize_t viafb_dvp0_proc_write(struct file *file,
 	if (count < 1)
 		return -EINVAL;
 	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
+	memcpy(&buf[0], buffer, length);
 	buf[length - 1] = '\0';	/*Ensure end string */
 	pbuf = &buf[0];
 	for (i = 0; i < 3; i++) {
@@ -1169,7 +1168,7 @@ static ssize_t viafb_dvp0_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dvp0_proc_ops = {
 	.proc_show	= viafb_dvp0_proc_show,
-	.proc_write	= viafb_dvp0_proc_write,
+	.proc_write_buf	= viafb_dvp0_proc_write,
 };
 
 static int viafb_dvp1_proc_show(struct seq_file *m, void *v)
@@ -1183,7 +1182,7 @@ static int viafb_dvp1_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_dvp1_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	char buf[20], *value, *pbuf;
 	u8 reg_val = 0;
@@ -1191,8 +1190,7 @@ static ssize_t viafb_dvp1_proc_write(struct file *file,
 	if (count < 1)
 		return -EINVAL;
 	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
+	memcpy(&buf[0], buffer, length);
 	buf[length - 1] = '\0';	/*Ensure end string */
 	pbuf = &buf[0];
 	for (i = 0; i < 3; i++) {
@@ -1225,7 +1223,7 @@ static ssize_t viafb_dvp1_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dvp1_proc_ops = {
 	.proc_show	= viafb_dvp1_proc_show,
-	.proc_write	= viafb_dvp1_proc_write,
+	.proc_write_buf	= viafb_dvp1_proc_write,
 };
 
 static int viafb_dfph_proc_show(struct seq_file *m, void *v)
@@ -1237,11 +1235,11 @@ static int viafb_dfph_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_dfph_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	int err;
 	u8 reg_val;
-	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	err = kstrtou8(buffer, 0, &reg_val);
 	if (err)
 		return err;
 
@@ -1251,7 +1249,7 @@ static ssize_t viafb_dfph_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dfph_proc_ops = {
 	.proc_show	= viafb_dfph_proc_show,
-	.proc_write	= viafb_dfph_proc_write,
+	.proc_write_buf	= viafb_dfph_proc_write,
 };
 
 static int viafb_dfpl_proc_show(struct seq_file *m, void *v)
@@ -1263,11 +1261,11 @@ static int viafb_dfpl_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_dfpl_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	int err;
 	u8 reg_val;
-	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	err = kstrtou8(buffer, 0, &reg_val);
 	if (err)
 		return err;
 
@@ -1277,7 +1275,7 @@ static ssize_t viafb_dfpl_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dfpl_proc_ops = {
 	.proc_show	= viafb_dfpl_proc_show,
-	.proc_write	= viafb_dfpl_proc_write,
+	.proc_write_buf	= viafb_dfpl_proc_write,
 };
 
 static int viafb_vt1636_proc_show(struct seq_file *m, void *v)
@@ -1313,7 +1311,7 @@ static int viafb_vt1636_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_vt1636_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	char buf[30], *value, *pbuf;
 	struct IODATA reg_val;
@@ -1321,8 +1319,7 @@ static ssize_t viafb_vt1636_proc_write(struct file *file,
 	if (count < 1)
 		return -EINVAL;
 	length = count > 30 ? 30 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
+	memcpy(&buf[0], buffer, length);
 	buf[length - 1] = '\0';	/*Ensure end string */
 	pbuf = &buf[0];
 	switch (viaparinfo->chip_info->lvds_chip_info.lvds_chip_name) {
@@ -1404,7 +1401,7 @@ static ssize_t viafb_vt1636_proc_write(struct file *file,
 
 static const struct proc_ops viafb_vt1636_proc_ops = {
 	.proc_show	= viafb_vt1636_proc_show,
-	.proc_write	= viafb_vt1636_proc_write,
+	.proc_write_buf	= viafb_vt1636_proc_write,
 };
 
 #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
@@ -1416,7 +1413,7 @@ static int __maybe_unused viafb_sup_odev_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t odev_update(const char __user *buffer, size_t count, u32 *odev)
+static ssize_t odev_update(const char *buffer, size_t count, u32 *odev)
 {
 	char buf[64], *ptr = buf;
 	u32 devices;
@@ -1424,8 +1421,7 @@ static ssize_t odev_update(const char __user *buffer, size_t count, u32 *odev)
 
 	if (count < 1 || count > 63)
 		return -EINVAL;
-	if (copy_from_user(&buf[0], buffer, count))
-		return -EFAULT;
+	memcpy(&buf[0], buffer, count);
 	buf[count] = '\0';
 	add = buf[0] == '+';
 	sub = buf[0] == '-';
@@ -1452,7 +1448,7 @@ static int viafb_iga1_odev_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_iga1_odev_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	u32 dev_on, dev_off, dev_old, dev_new;
 	ssize_t res;
@@ -1473,7 +1469,7 @@ static ssize_t viafb_iga1_odev_proc_write(struct file *file,
 
 static const struct proc_ops viafb_iga1_odev_proc_ops = {
 	.proc_show	= viafb_iga1_odev_proc_show,
-	.proc_write	= viafb_iga1_odev_proc_write,
+	.proc_write_buf	= viafb_iga1_odev_proc_write,
 };
 
 static int viafb_iga2_odev_proc_show(struct seq_file *m, void *v)
@@ -1483,7 +1479,7 @@ static int viafb_iga2_odev_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t viafb_iga2_odev_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
+	char *buffer, size_t count, loff_t *pos)
 {
 	u32 dev_on, dev_off, dev_old, dev_new;
 	ssize_t res;
@@ -1504,7 +1500,7 @@ static ssize_t viafb_iga2_odev_proc_write(struct file *file,
 
 static const struct proc_ops viafb_iga2_odev_proc_ops = {
 	.proc_show	= viafb_iga2_odev_proc_show,
-	.proc_write	= viafb_iga2_odev_proc_write,
+	.proc_write_buf	= viafb_iga2_odev_proc_write,
 };
 
 #define IS_VT1636(lvds_chip)	((lvds_chip).lvds_chip_name == VT1636_LVDS)

-- 
2.53.0


