Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53256607A8A2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJGwG/6h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFd00VJhz3cDf;
	Tue, 03 Nov 2026 02:15:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632516;
	cv=none; b=Eaz743GnIqsnUxAif4qmCo5ucqM9oanyG4cmAkGo/cj4N8b5OWU68Yl1NyxeyuSs9pDaeTOP62YPHpC+wDLok6GYIojyw/SWigBOYlGNJxajCUUHfHkNzYIz4gX94kuw6QlV8NPMb4wiapcYvbIEnxnaJHMuyGm2PSH/I2P36I2RKur3KWynaQUpcUkTE0zGbGRLQxCVQdkN4mu5uf7aVVzOkkOeBaByf5j4VbZanNSDhPNJPr2psLuIPz1v+xxbH1bLs1mzeSvILbA1yCfah8VQMMRxbqOmiue/lyfCRqvgSTczgzI1v2rGXzpO2CTMD4hpE3zSA5HIU3/dHER25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632516; c=relaxed/relaxed;
	bh=bLxRwCxtJ/P3YNIr6jvbkvrLQvoA3ATHIuHzWzBn2J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHRfRMfvcMNeB+tFOlXWosDPs5YSk/b7BxD+/8WG20+T5Wr5pGn6FoB6KJcZMDnjDyvAX2MqGWH5oQZnIyFluK9edvTWYPsK1LqGFCQqDwOTwUti79Y1TJ6FKp6iQjnvDRvLn3eZ3Xv7M6sn2W0umJTOuoU3DUBfmeJKUZPthHT+9PFM45DwG3Nn1Z4gKP0bNdbfBlt5nEzEI+3+XJ3R2WYO0tvjIEz48CDmLdTZ5jhbY0U6qQAxL/dpXzaBMlwkaewwrfUNpQPlCCiMl6ddQugTW1VqgmdEB7lrLVT3WS7yETOX+npj/7kzNVGqScwG8RmvXKaQx6KMyopW8fmeAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJGwG/6h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJGwG/6h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFcz25lVz3cDY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:15:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6D8E40DE8;
	Mon,  2 Nov 2026 15:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC531F00A1E;
	Mon,  2 Nov 2026 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632513;
	bh=bLxRwCxtJ/P3YNIr6jvbkvrLQvoA3ATHIuHzWzBn2J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aJGwG/6hEIXyLfWmKFvXVRjD3pi6UQH/DTvV3cC7DcTh4N/HcF4nnCkxWMSznc6hy
	 c7hGsGqmLuhGImmqBA8HQwtIMWkwLQW5HRs4iHh81hTAWhkgs2OvSuIp/lEwm85W9d
	 uvjIgGTnlZelSY+8QFDOq9mKlCgW8ew05dUZ423oPWs2PbAaXvTVTer1uR+Q19WcSd
	 saiX/ZfSnReCygXk6xbkfe3Cv4xjGMpF4N4R3qn7AIIGAKhndeoYMRbVau3i5aPogd
	 WGrsPu5F3Co+ya30mCf7vuh+bnrNlc3JlBctP1nTSWEk8d19qbLvSzIhcB3xtAk5Zz
	 cTo6R42Iaq1qg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:22 +0100
Subject: [PATCH RFC 15/23] hwmon: (dell-smm) let procfs copy the i8k ioctl
 arguments
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
Message-Id: <20261102-work-procfs-drivers-v1-15-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4573; i=brauner@kernel.org;
 h=from:subject:message-id; bh=negOiIwbpBXFbC2+4UQ2qelUCL0pz2XjdZael8czB8w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7wfOvG13Ue+TY6YgY/P8p121v+35fv6PEqSTJv0
 6vT9vcUO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbScZnhv8ujWTvu1BYxV1XK
 sD6t0T6SdbHl9c1T0T8mMq25dlN2gTIjw/ZM+U1cLyxPWnrVKXeXnrv56tyX2eemZWmU1m/Wczw
 5jwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_ioctl_buf() so procfs copies the arguments in before
it pins the entry and back out after unpinning it. The command numbers
in <uapi/linux/i8k.h> encode the wrong sizes, so the table lists what
is really copied: an int or the 16 bytes of the machine id out, and one
or two ints in.

A NULL argument fails with -EFAULT now instead of -EINVAL, and so does
a bad pointer to SET_FAN from an unprivileged task, which got -EPERM
before, since procfs copies the argument in before the entry's own
checks run. 32-bit tasks can use the commands whose numbers don't
depend on the size of size_t.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 492b2b6c6d7e..67b8c6e5752f 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -549,16 +549,13 @@ static int i8k_get_power_status(const struct dell_smm_data *data)
  * Procfs interface
  */
 
-static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+static long i8k_ioctl(struct file *fp, unsigned int cmd, void *arg)
 {
 	struct dell_smm_data *data = pde_data(file_inode(fp));
-	int __user *argp = (int __user *)arg;
+	int *argp = arg;
 	int speed, err;
 	int val = 0;
 
-	if (!argp)
-		return -EINVAL;
-
 	switch (cmd) {
 	case I8K_BIOS_VERSION:
 		if (!isdigit(data->bios_version[0]) || !isdigit(data->bios_version[1]) ||
@@ -568,17 +565,13 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		val = (data->bios_version[0] << 16) |
 				(data->bios_version[1] << 8) | data->bios_version[2];
 
-		if (copy_to_user(argp, &val, sizeof(val)))
-			return -EFAULT;
-
+		*argp = val;
 		return 0;
 	case I8K_MACHINE_ID:
 		if (restricted && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		if (copy_to_user(argp, data->bios_machineid, sizeof(data->bios_machineid)))
-			return -EFAULT;
-
+		memcpy(argp, data->bios_machineid, sizeof(data->bios_machineid));
 		return 0;
 	case I8K_FN_STATUS:
 		val = i8k_get_fn_status(data);
@@ -593,8 +586,7 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		break;
 
 	case I8K_GET_SPEED:
-		if (copy_from_user(&val, argp, sizeof(int)))
-			return -EFAULT;
+		val = *argp;
 
 		if (val > U8_MAX || val < 0)
 			return -EINVAL;
@@ -603,8 +595,7 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		break;
 
 	case I8K_GET_FAN:
-		if (copy_from_user(&val, argp, sizeof(int)))
-			return -EFAULT;
+		val = *argp;
 
 		if (val > U8_MAX || val < 0)
 			return -EINVAL;
@@ -616,14 +607,11 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		if (restricted && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&val, argp, sizeof(int)))
-			return -EFAULT;
-
+		val = argp[0];
 		if (val > U8_MAX || val < 0)
 			return -EINVAL;
 
-		if (copy_from_user(&speed, argp + 1, sizeof(int)))
-			return -EFAULT;
+		speed = argp[1];
 
 		speed = clamp_val(speed, 0, data->i8k_fan_max);
 
@@ -643,12 +631,22 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 	if (val < 0)
 		return val;
 
-	if (copy_to_user(argp, &val, sizeof(int)))
-		return -EFAULT;
-
+	*argp = val;
 	return 0;
 }
 
+/* The command numbers don't encode what is copied, see <uapi/linux/i8k.h>. */
+static const struct proc_ioctl_arg i8k_ioctl_args[] = {
+	PROC_IOCTL_ARG(I8K_BIOS_VERSION, 0, sizeof(int)),
+	PROC_IOCTL_ARG(I8K_MACHINE_ID, 0, sizeof_field(struct dell_smm_data, bios_machineid)),
+	PROC_IOCTL_ARG(I8K_FN_STATUS, 0, sizeof(int)),
+	PROC_IOCTL_ARG(I8K_POWER_STATUS, 0, sizeof(int)),
+	PROC_IOCTL_ARG(I8K_GET_TEMP, 0, sizeof(int)),
+	PROC_IOCTL_ARG(I8K_GET_SPEED, sizeof(int), sizeof(int)),
+	PROC_IOCTL_ARG(I8K_GET_FAN, sizeof(int), sizeof(int)),
+	PROC_IOCTL_ARG(I8K_SET_FAN, 2 * sizeof(int), sizeof(int)),
+};
+
 /*
  * Print the information for /proc/i8k.
  */
@@ -696,7 +694,9 @@ static int i8k_proc_show(struct seq_file *seq, void *offset)
 
 static const struct proc_ops i8k_proc_ops = {
 	.proc_show	= i8k_proc_show,
-	.proc_ioctl	= i8k_ioctl,
+	.proc_ioctl_buf	= i8k_ioctl,
+	.proc_ioctl_args = i8k_ioctl_args,
+	.proc_nr_ioctl_args = ARRAY_SIZE(i8k_ioctl_args),
 };
 
 static void i8k_exit_procfs(void *param)

-- 
2.53.0


