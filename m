Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AD606D815
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxCVzhBy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFXN5TDbz3cMc;
	Tue, 03 Nov 2026 02:11:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632276;
	cv=none; b=gyfq2tlOQamYs0gdHCJnO6pqo0EWuIKhpr/BzX1ycVw0wegmEc7pE9MhR1bTO3epzrxMF5M2l/vgjI+vyaXOty6CoJYSKCPHd2JvgPq/hRI0tuenW+mYtzuoXh4rD/xiLdVVGTGQOx1pO8Q5fE6ucuVKjUYSVGpYYrtpVX0JQvK68VO/AUbYhJOSiRymD/c9rLYfF/XwN9tMV1ie98MkOpmNdkxO4ZJO+cxjCucbBnOB3DTmnKUHrCYxBYCmTQN4M41B+YUHQIUN90qaAhzNN1IOBqC2dzehhTPe5+klmgsImwjmkGnT3bZZlGUUaFtihhNjNcNMDj4QMaltoUgI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632276; c=relaxed/relaxed;
	bh=vqkxnch8qakIwUVP+9QJA5QeGLg7HpbhcDTmIF75pEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyaFHEx8sEi3dk6f7qvZQRBm0bA9TdEwyqroFd4Bv6/pj3vpLN5JyMdi+CL/RTwfniVrr+spbPLmeOnT/tg9BLiWNvpnNbI+6vhzzfnVbBzfWifYhRtDz91klvTUQb2gMv0Kypc3bqLQWb3x0/zPXPuVPVd1Y7VNRk6zSG4b7FEpV8jHb0ORfEfccjfAwUZvXxpCwgL+iwghCtXMsopmjBIuoPVvZbXCFBCMX/xFu5Jpe27uT/rr4XcAM2WY2t/eJJnlnP63uxqaxQFsGD4RDWbjQ0CxOLJLj+QWrlEcrztEWzEbaQqiyWA5+pQ2gyvfhXJbdEVFwa/DoyJFlnXI5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxCVzhBy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxCVzhBy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFXM6xnkz3cMQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:11:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 182B8609CE;
	Mon,  2 Nov 2026 15:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C151F00A16;
	Mon,  2 Nov 2026 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632273;
	bh=vqkxnch8qakIwUVP+9QJA5QeGLg7HpbhcDTmIF75pEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cxCVzhByWu3o4NPMXdI664xNWkShTHR36O9m/09VZ9+jFA9OG6kKc4h3juX9pF4hG
	 KES/99TyZfxZMZsILDCBbUPiL2m0c7yvku8def0K3xyx1BZSfmHoibrjV4xOJY9TRv
	 aRQUlDzCSvfjdbS81rVindZYNfHG/n3/STb1D5KKMtjDWOzG48TPwOOda5MyUodL1/
	 sl6+1c+KcBwatTkHqiITxDL+ifFRuErDfWC3t7wYwV8vzWLwDTzNDzYcITGLDruDX/
	 CBg0J86Rpsxds6f1vNXAUOdjLXrIDS/33ZjvCLz1gmlcS3YhkDRMkNQrIFMIeovXK6
	 qXYbgPdy439+w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:10 +0100
Subject: [PATCH RFC 03/23] PCI/proc: let procfs copy in config space writes
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
Message-Id: <20261102-work-procfs-drivers-v1-3-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3416; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FHhIortRJiKYhZazrarBsz8LKuG1O3uAWYPgQRTjmaQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG4Q5v+r4smER+KNHzUv/1vj6ThP4Dffzpik1rx7S
 Ye2i2bmdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk62VGhs6XkTMTRfwbPBQL
 /x4Lzpj+wfz/1vf3Y5U2mfjmTS4+wc7wz+JImkaMBv+rn36HnuYuOOJ748u9kLuro6932ZoynGx
 15wQA
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
it pins the entry, and write the config space from that copy with
get_unaligned_le16() and get_unaligned_le32() instead of get_user().

The copy holds at most PCI_CFG_SPACE_EXP_SIZE bytes. Larger writes come
up short with PROC_ENTRY_SHORT_WRITES, like they did before because
they were cut at the end of the config space.

A buffer that can't be read used to write zeroes to the config space and
report success. It fails with -EFAULT now and nothing is written.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pci/proc.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index e0dc70123f82..d420353ee2b3 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/panic.h>
 #include <linux/sched.h>
+#include <linux/unaligned.h>
 #include <asm/byteorder.h>
 #include "pci.h"
 
@@ -114,8 +115,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	return nbytes;
 }
 
-static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
-				  size_t nbytes, loff_t *ppos)
+static ssize_t proc_bus_pci_write(struct file *file, char *buf, size_t nbytes,
+				  loff_t *ppos)
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
@@ -145,51 +146,38 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 		nbytes = size - pos;
 	cnt = nbytes;
 
-	if (!access_ok(buf, cnt))
-		return -EINVAL;
-
 	pci_config_pm_runtime_get(dev);
 
 	if ((pos & 1) && cnt) {
-		unsigned char val;
-		get_user(val, buf);
-		pci_user_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, *buf);
 		buf++;
 		pos++;
 		cnt--;
 	}
 
 	if ((pos & 3) && cnt > 2) {
-		__le16 val;
-		get_user(val, (__le16 __user *) buf);
-		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, get_unaligned_le16(buf));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
 	}
 
 	while (cnt >= 4) {
-		__le32 val;
-		get_user(val, (__le32 __user *) buf);
-		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
+		pci_user_write_config_dword(dev, pos, get_unaligned_le32(buf));
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
 	}
 
 	if (cnt >= 2) {
-		__le16 val;
-		get_user(val, (__le16 __user *) buf);
-		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, get_unaligned_le16(buf));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
 	}
 
 	if (cnt) {
-		unsigned char val;
-		get_user(val, buf);
-		pci_user_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, *buf);
 		pos++;
 	}
 
@@ -337,9 +325,11 @@ static int proc_bus_pci_release(struct inode *inode, struct file *file)
 #endif /* HAVE_PCI_MMAP */
 
 static const struct proc_ops proc_bus_pci_ops = {
+	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 	.proc_lseek	= proc_bus_pci_lseek,
 	.proc_read	= proc_bus_pci_read,
-	.proc_write	= proc_bus_pci_write,
+	.proc_write_buf	= proc_bus_pci_write,
+	.proc_write_size = PCI_CFG_SPACE_EXP_SIZE,
 	.proc_ioctl	= proc_bus_pci_ioctl,
 #ifdef CONFIG_COMPAT
 	.proc_compat_ioctl = proc_bus_pci_ioctl,

-- 
2.53.0


