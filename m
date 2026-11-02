Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45446606BA5A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEGAtuEw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFTX06TKz3blB;
	Tue, 03 Nov 2026 02:08:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632127;
	cv=none; b=eowX6VqOqG3j/E+D+NvC5lVb2HEoOjsIRNTzsPbuzi7wzVtAPUo2YuzhDVUNb4Yq3cOMMWIra9umUywGYTSy1PX+aMFaKI1fYhxuqVOWZ9HukOj3jSvE15s3PbqJkPKve1XOD9vWT83dmpnnrQhFrbTGpn2FS6pbld/rgsie+sDnSVRyzqOdwjKCIfBXoHs7aQYQ4Z3lbSq3rsGpG7WCo+qUJKwu9IKuMqOmA3oGLofAYiDBbJltT5aBhiRokUmDyVbM+NKYxu4nS7n74C/t/6T6RL/+eNi3DqcuStjpUJhO4CtawkLWPYKLdNrHY938pZcqFSnGmNNIkwACpZjtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632127; c=relaxed/relaxed;
	bh=zr7obOUiLNzJ4M2rJicyi/Ze6HCzMDPfBdGpZnrgFfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKW5Nq2fKWupfXM8d9otOSPhdzw5YTSkC4hP4J+wiQGUkN+IjuKACmxH3uPAxkVV0PioBVoUqNaOnuQ2Kw3vk2BFLlP1iFQtF135/M4nPGMQTZF59YOo7A0eKxlxLGLfuECifC2gtt18QnDpFKQ5LXxFnAw3LcwAKm9f67ApE7aeP6ebHG3hUY7wZr41BAazEBkbqqB8no81t2ZhEs6kkkZLdurbg2g8xy0uwe4Pe/+PKNa1F8oXRqV3PZnsZlT6SJ8qHsE9lvEVUUEtHSRqX4fAPrzt4+ipYbEIGmt1vPo4dyb2jD29ikP9LzKYrNkyPbsgBor0J69a9ZdKxLyo6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEGAtuEw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEGAtuEw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFTW0myZz3bX3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:08:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28A32600DB;
	Mon,  2 Nov 2026 15:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133F1F00A1A;
	Mon,  2 Nov 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632124;
	bh=zr7obOUiLNzJ4M2rJicyi/Ze6HCzMDPfBdGpZnrgFfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kEGAtuEwvTMgDuPbyzJeFLVaUSWvZkCX/wUBabr5CM+BjM76qvrrMDRwKN+aUpp0M
	 LwULw5zP7H3bcIRxCu2+BVsEU4zGp6OX1M94GYtTzJYZ1Sv0pAvkktXo+Zb0As3XcC
	 7Tm5eTy1em1aicRexVm3TwZLua7XOaqJGZGjekvzyZG3iJISitPVfI4Rb1C6HoqO15
	 zds1p1eADnGHiS7upjctx8NMqWH7A7NsO/n5J+MjqWiNif9k5AGi+lAXG6mfYJREeh
	 /tq8fM2qbOInntFHxnk7n1aXVsuVbuc+aacS++TfSOw8xPUMY5Re+hh0DhYh68pv/r
	 SxGHP8KpJ8aAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:48 +0100
Subject: [PATCH RFC 21/22] PNP: pnpbios: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-arch-v1-21-c9492ab08480@kernel.org>
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

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/bus/pnp/<node> before it pins the entry, and take the node data
from that copy. A node with more than PAGE_SIZE - 1 bytes of data can't
be written anymore. I don't think there are any.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/pnpbios/proc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
index 14632a8d0da0..00163aedd738 100644
--- a/drivers/pnp/pnpbios/proc.c
+++ b/drivers/pnp/pnpbios/proc.c
@@ -171,7 +171,7 @@ static int pnpbios_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t pnpbios_proc_write(struct file *file, const char __user *buf,
+static ssize_t pnpbios_proc_write(struct file *file, char *buf,
 				  size_t count, loff_t *pos)
 {
 	void *data = pde_data(file_inode(file));
@@ -191,10 +191,7 @@ static ssize_t pnpbios_proc_write(struct file *file, const char __user *buf,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (copy_from_user(node->data, buf, count)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	memcpy(node->data, buf, count);
 	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0) {
 		ret = -EINVAL;
 		goto out;
@@ -207,7 +204,7 @@ out:
 
 static const struct proc_ops pnpbios_proc_ops = {
 	.proc_show	= pnpbios_proc_show,
-	.proc_write	= pnpbios_proc_write,
+	.proc_write_buf	= pnpbios_proc_write,
 };
 
 int pnpbios_interface_attach_device(struct pnp_bios_node *node)

-- 
2.53.0


