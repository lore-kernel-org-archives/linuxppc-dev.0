Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0C607467B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIjK3Qwt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFZs3jBbz3btw;
	Tue, 03 Nov 2026 02:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632405;
	cv=none; b=Me926HRWsBAPgCXKY1TpA0deoNXmKMVRkgeV1mE6dpzGjehX7udFa4kTQW5zYlqF+FSuk6YLJFjFnnjKVmcVl6hPq2uSIo6n3vgySZ9daT9BwlHKCJOHJnTLLsPyhuah7Y4mpvfkz6DhUk1chi4jel+2xmStpiL+OX6j3e6/UiILJWHZ5UfN2JYtTfQrwVngjEQY8E9U3/lYFKr6RKd1fivgtPe3i+F+wgtDQfinyjBZy8qC/g1kcmn0XdrbsM8wKR7gmZlDWNdWUKba44s0BRWgegqccRiSjwjeZgROIVjcW91FR7Uw5FXn3u35KpEA4+hhsJDAzMkY4WToSLMt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632405; c=relaxed/relaxed;
	bh=BWMrcMxphM3j3KhJxvOCR+KbGizC6kQdxxuLzJskxVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrFjR8HbRMi4WkQs24ewQqjVVsxZqj18u60ROL+BuLyfnyf2YJp2iOaSAsiGFwg1aatapnuwFdcDWw04g3HgXXpq19lKXLRm6X8HroV14o2t06G3/UQ5SAWNDP+wQgLPnGGI8fmnN1/J867lNiuMgi+e74obpkyM9pBisYNAynKQvOyiJ2TBFdwKICi7lCQYEIUX15yLV1E+U0CAUvF7+/MZjgjwqF+2B+z0VtWYOggk//JMZMzTaAmuos+bRls3g5tAyzjJYPAaAmIkRYy+Vr7LlOL3qgq/RLdHnfdAJDLZmIs3YQjP6cs8L4+njiXlqlZWb5DMuIKn0XZpwWQPlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIjK3Qwt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIjK3Qwt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFZr4TDrz3btn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:13:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B11BF6053E;
	Mon,  2 Nov 2026 15:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643241F00A16;
	Mon,  2 Nov 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632402;
	bh=BWMrcMxphM3j3KhJxvOCR+KbGizC6kQdxxuLzJskxVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mIjK3QwtTVilSpcRMeaoz6MTKvP7Sy6dH4N9uXF4AEtvkmOD+/LZgf883MtrMNbfX
	 Fc7qy6+hRUrZLI12uqt+tFP3+FSAd9d3s0S7Oj/5J8YKb9MuvzMCclBQW5ujuLEY3R
	 0jZ40m7Qe6thFpBjmEpgSnaWIQpr2OFaA+Hu2iHvPuRwIzTy5CX2f99EzFV0hO5HRa
	 v3h43WiiAhfIdyZllqL5RbxOqUX3/Hcfx8oBtLvZRAePXNc6Si2FGn6GzYJmq+441r
	 GdWXtRs4TvUpEjCZFIA+oogkhKJvXJm8hEiDfFaliMcEnFuCVmnTvn4+eIcYomOAzM
	 v0Y6JeRoVTSgA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:16 +0100
Subject: [PATCH RFC 09/23] scsi: let procfs own the seq_file of the host
 files
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
Message-Id: <20261102-work-procfs-drivers-v1-9-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l1PqfsIz+cqTipGWNtI2ZFkSTs3hYfw6G0B1mtmwjUo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG4wo+Pp/Vmn2AIF2jK3Rnc8S5TW89ldrDXNvflSK
 a9TlSBvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2/GNk+LjMbs1f+SqdgEVP
 95yaUyouP9NB9EfZdvNTxdef/51/W53hnylf8tFqgbuGLVyB25bLi7g6NKw02Kjm+6TD3337TuM
 +XgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the show function and let procfs open and free the seq_file of
/proc/scsi/<driver>/<host>. ->proc_open() only preallocates the buffer
now. Reading the file then no longer holds up its removal when the host
goes away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/scsi_proc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 3e49c4c8704f..59229bf9938e 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -94,10 +94,10 @@ static int proc_scsi_show(struct seq_file *m, void *v)
 	return shost->hostt->show_info(m, shost);
 }
 
+/* procfs opens the seq_file */
 static int proc_scsi_host_open(struct inode *inode, struct file *file)
 {
-	return single_open_size(file, proc_scsi_show, pde_data(inode),
-				4 * PAGE_SIZE);
+	return seq_preallocate(file->private_data, 4 * PAGE_SIZE);
 }
 
 static struct scsi_proc_entry *
@@ -140,10 +140,8 @@ scsi_template_proc_dir(const struct scsi_host_template *sht)
 EXPORT_SYMBOL_GPL(scsi_template_proc_dir);
 
 static const struct proc_ops proc_scsi_ops = {
+	.proc_show	= proc_scsi_show,
 	.proc_open	= proc_scsi_host_open,
-	.proc_release	= single_release,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_write	= proc_scsi_host_write
 };
 

-- 
2.53.0


