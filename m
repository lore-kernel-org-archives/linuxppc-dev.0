Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA96091CAD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inKajwEE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFbC43MSz3bjN;
	Tue, 03 Nov 2026 02:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632423;
	cv=none; b=QAkMTQzElWEMExEm1AC1a9fxg5l/v1ydy0AQ5RatxFedwyqi1F6NrcDJHNRhcUy7/yUJHjQTnHSbivzjXhXi32kqEbhQQ5x94dcMQsc7cZ+6H00EUCp1B1j802T7TNlD10OaBLLfqN4LxFLMqzyXHSzQcVsIdqCzacvfTblXU40QwzoU4eWyqygza1WC56iuSbSLBZv0X1buHmOKIWmMSE+bCbrZH6FYjtBy6MPCah18KqMgknSeRft+8cVhH0IOG9qsQr0cvwoQZqYvtq+xQhbZg/eZNcJTkLJlQgwBA/2Alb2skmpNt9fGUerp4Xkvrpt5qnPNm+bB6gSX3ofkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632423; c=relaxed/relaxed;
	bh=Rp3cBypvlPCLWQcsEgZutivLH7EPpJBFO75qhCW/oJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOGyorHiflUFCsi5CLdcPAnXNn2sSfm4akZUEAbN+FsVDUJuuWLOBXnuiW2VxKSpnPWtxlfZ0VBs4TeruHTBSa6NF9wnvMJ57Dsj34pDv/55GHYxVtRW3+5KEo+rNXj8td5B/Ou8i+Cv4c5+0Rw5FLwYEGcWZ0kvX9pFcDysBc39KMuwdcQVXHNpQI9zhAZQAdJMGYf9TNRkcEQyuib/syT3yVFm6CanZTZSWOnHsmmJkpQEKPY+W6oc/U4HSfzCN+9POgMjL/V3sdNhFon8aJL+T+cQ4flRD2TuL8+MacB7L0fkG5e/q4FD6ZgZO5Ds5g2SEhvgxYwiJOo+JBwBxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inKajwEE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inKajwEE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFbB6209z3bx1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:13:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54B7E41860;
	Mon,  2 Nov 2026 15:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49A41F00A16;
	Mon,  2 Nov 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632421;
	bh=Rp3cBypvlPCLWQcsEgZutivLH7EPpJBFO75qhCW/oJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=inKajwEEAwMoHnDPteIsszpp+0/UJE+sH1dcRO3L/FVi7pG6bML9PLf7beknb8BdL
	 5MQTx4jDbN6vOHeJxw6i3QBTD/vaTRhHRSBDcIcLXd+3e9HF074pZjh8KpAt9SGtmt
	 JOiGL6Tx8k0xhC/Euwa1o1K150jjjSE7j8GK34RKndNsCPhq4JCoa1y8V/FJaak7tQ
	 sIo7pPqK3wIVaSyqVLUcMOS2/mUFkthHgMUSqu1fTag9cUMixxI0kmyYvEBaUL/61N
	 /p62SUvaIR4X5tJTeFjC9esd/XuiBrsEJMh9ZeLl3eTyrN3FqEcwOKweqLGafV76hM
	 GBi4RyeNSgR4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:17 +0100
Subject: [PATCH RFC 10/23] scsi: core: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-drivers-v1-10-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vGFrM/mDJbel5Ek/YnwRAY7y8jtd20EKftAALqu9TzI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6wbs9mk5mrv0xU3X+16EaLjJbetu1Tahw0NK74G
 XJYrLy2oqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi9+8z/NP5dyTkr+Pqgvks
 tmYr2GzsdlxjWTkn2a8rR7w2gk/iwnaGf6oJ7vtUPv35vWtB+q7r99Z2c2x9l6Jyo+P0aQ5b7gu
 905kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for /proc/scsi/scsi, /proc/scsi/device_info
and the host files so procfs copies in what is written before it pins
the entry, and parse what was written from that copy. /proc/scsi/scsi
and device_info take up to PAGE_SIZE bytes like before. The host files
pass the copy to ->write_info(), writes to them that are larger than
PAGE_SIZE - 1 bytes fail with -EINVAL from procfs instead of -EOVERFLOW.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/scsi_devinfo.c | 29 +++++-----------------------
 drivers/scsi/scsi_proc.c    | 47 +++++++++++----------------------------------
 2 files changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 0b8f5ff40543..d9093851b23e 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -678,39 +678,20 @@ static const struct seq_operations scsi_devinfo_seq_ops = {
  * To use, echo "vendor:model:flag" > /proc/scsi/device_info
  */
 static ssize_t proc_scsi_devinfo_write(struct file *file,
-				       const char __user *buf,
+				       char *buffer,
 				       size_t length, loff_t *ppos)
 {
-	char *buffer;
-	ssize_t err = length;
-
-	if (!buf || length>PAGE_SIZE)
+	if (length == PAGE_SIZE && buffer[PAGE_SIZE-1])
 		return -EINVAL;
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-	if (copy_from_user(buffer, buf, length)) {
-		err =-EFAULT;
-		goto out;
-	}
-
-	if (length < PAGE_SIZE)
-		buffer[length] = '\0';
-	else if (buffer[PAGE_SIZE-1]) {
-		err = -EINVAL;
-		goto out;
-	}
 
 	scsi_dev_info_list_add_str(buffer);
-
-out:
-	kfree(buffer);
-	return err;
+	return length;
 }
 
 static const struct proc_ops scsi_devinfo_proc_ops = {
 	.proc_seq_ops	= &scsi_devinfo_seq_ops,
-	.proc_write	= proc_scsi_devinfo_write,
+	.proc_write_buf	= proc_scsi_devinfo_write,
+	.proc_write_size = PAGE_SIZE,
 };
 #endif /* CONFIG_SCSI_PROC_FS */
 
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 59229bf9938e..5962e671cc83 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -62,30 +62,18 @@ struct scsi_proc_entry {
 	unsigned int		present;
 };
 
-static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
+static ssize_t proc_scsi_host_write(struct file *file, char *buf,
                            size_t count, loff_t *ppos)
 {
 	struct Scsi_Host *shost = pde_data(file_inode(file));
-	ssize_t ret = -ENOMEM;
-	char *page;
-    
+
 	if (count > PROC_BLOCK_SIZE)
 		return -EOVERFLOW;
 
 	if (!shost->hostt->write_info)
 		return -EINVAL;
 
-	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (page) {
-		ret = -EFAULT;
-		if (copy_from_user(page, buf, count))
-			goto out;
-		page[count] = '\0';
-		ret = shost->hostt->write_info(shost, page, count);
-	}
-out:
-	kfree(page);
-	return ret;
+	return shost->hostt->write_info(shost, buf, count);
 }
 
 static int proc_scsi_show(struct seq_file *m, void *v)
@@ -142,7 +130,7 @@ EXPORT_SYMBOL_GPL(scsi_template_proc_dir);
 static const struct proc_ops proc_scsi_ops = {
 	.proc_show	= proc_scsi_show,
 	.proc_open	= proc_scsi_host_open,
-	.proc_write	= proc_scsi_host_write
+	.proc_write_buf	= proc_scsi_host_write
 };
 
 /**
@@ -386,8 +374,8 @@ static int scsi_remove_single_device(uint host, uint channel, uint id, uint lun)
 /**
  * proc_scsi_write - handle writes to /proc/scsi/scsi
  * @file: not used
- * @buf: buffer to write
- * @length: length of buf, at most PAGE_SIZE
+ * @buffer: buffer to write
+ * @length: length of buffer, at most PAGE_SIZE
  * @ppos: not used
  *
  * Description: this provides a legacy mechanism to add or remove devices by
@@ -402,32 +390,20 @@ static int scsi_remove_single_device(uint host, uint channel, uint id, uint lun)
  */
 
 
-static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
+static ssize_t proc_scsi_write(struct file *file, char *buffer,
 			       size_t length, loff_t *ppos)
 {
 	int host, channel, id, lun;
-	char *buffer, *end, *p;
+	char *end, *p;
 	int err;
 
-	if (!buf || length > PAGE_SIZE)
-		return -EINVAL;
-
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	err = -EFAULT;
-	if (copy_from_user(buffer, buf, length))
-		goto out;
-
 	err = -EINVAL;
 	if (length < PAGE_SIZE) {
 		end = buffer + length;
-		*end = '\0';
 	} else {
 		end = buffer + PAGE_SIZE - 1;
 		if (*end)
-			goto out;
+			return err;
 	}
 
 	/*
@@ -466,8 +442,6 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!err)
 		err = length;
 
- out:
-	kfree(buffer);
 	return err;
 }
 
@@ -521,7 +495,8 @@ static const struct seq_operations scsi_seq_ops = {
 
 static const struct proc_ops scsi_scsi_proc_ops = {
 	.proc_seq_ops	= &scsi_seq_ops,
-	.proc_write	= proc_scsi_write,
+	.proc_write_buf	= proc_scsi_write,
+	.proc_write_size = PAGE_SIZE,
 };
 
 /**

-- 
2.53.0


