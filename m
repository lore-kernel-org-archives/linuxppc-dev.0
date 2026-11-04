Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A8608B1D3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQZZk22I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbWX4m7Vz308j;
	Thu, 05 Nov 2026 06:45:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821512;
	cv=none; b=QQ3IFL8NTzS6k2IN9W1mb/zd/OjwuE9u97cHszJWEBhMdD5pEmfTXjpymOpSvDaD3NJzYUNPaXFU99zPWxo8M3e60kcz264nNiwH0uu/rr5GZzW/gMsMIrklrqX5WEhNGFCsYhclzW737qv4sw6z0jqNtOrLEoYorQqJO5eqlQbjzDpLH6Oy4JVKHfn8ngGtllt+rHD7NAiYoPpKQ5CO7ZE/Qnh7JnVMYZCbjtq3w0cT1rXBCxLNwknZG2RbbH+BmuKmrqGUSexyVUSJZTTvofUXw2723F6LzwRiuNRd+PfWt+7A9NxUrGSOiW3OWhrZfzbFHOLveWguL61ODsXp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821512; c=relaxed/relaxed;
	bh=Rp3cBypvlPCLWQcsEgZutivLH7EPpJBFO75qhCW/oJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJyD6/gYTNFdR89IpjLOWQMeIE9ex0t+A2OsnZdRpDbxJrlELsZAoFBt6A30doPErYm0tUg43AYWRrZXYwmr87tNmw3m0DyDX3++34GrZ8v58qXgDTcLN5LZfs3YK+KE0b7y12dj96b3bbMdMmOmLGPruKlNywX1/weHbR4z/Uc+YEVFbfC9uqHguTIxrFMqBM3gnXPyCSH1l9x9q6P5fLRJj0y7HOXj7Zx+kdl0eF+7dKltQb+2bV98u7RD1ixwj4lGMlaYy7BLpJcPZ82H759cJS4RzYNeDhYofgaaMXqK9TWtivkDhgJ+5cs9rwOoMtHAtN9c8GJ7VKsAyIqePA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQZZk22I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQZZk22I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbWW2hhfz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:45:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7818060A9F;
	Wed,  4 Nov 2026 19:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F041F000C1;
	Wed,  4 Nov 2026 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821509;
	bh=Rp3cBypvlPCLWQcsEgZutivLH7EPpJBFO75qhCW/oJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQZZk22IBDSdlRg9+GChLXhspu7iunkZLLfTPZExTpVWSZ10XMRGmnTYlf4TG3XAH
	 1cwjSXYkmlC+l/hnbMTY6YP/Kzl3udvQ65e0OecgcsLuWkW0rAc2mS+7lsMTsFJwex
	 5Mm7xmU/jLtpvu5WcV/D7gF7UYlkqWEYw175OcfKq5UOR7IVWPNSq4SA6IFaxtf5na
	 9paORCG9sxlWn9HEykiPNg6mhlzTVo5kiuDStPCb0diMzwScMmB/UEKOmuTvYKKKer
	 rmzoLKe6KegT6EasDc6fEzLXRRh89qOwFDegOrU9dPoQb3yaDpwnk6UqQg5okye4vV
	 YLTrXAZzXjLgw==
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
Subject: [PATCH RESEND v2 11/26] scsi: core: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:44:54 +0100
Message-ID: <20261104-work-procfs-drivers-v2-11-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090; i=brauner@kernel.org; h=from:subject:message-id; bh=vGFrM/mDJbel5Ek/YnwRAY7y8jtd20EKftAALqu9TzI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mpQbTp/83Hlrc1+rz/OurT8HMOG96arD+w4Gdd2K pr9ek/Lho5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJBMUz/E+Jqow63i4ukh/z NaPAjPXzm42+O7RrV1sb6zj3n/W84cXwV7CJ58e5Hsv5XGU5lw4fTp7zeKbnjYq6WmGe/zMumlX 84gQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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


