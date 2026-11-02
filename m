Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70F60810E7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMV7oMe2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFkh1q03z3cgy;
	Tue, 03 Nov 2026 02:20:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632812;
	cv=none; b=FOS4b7KrJnnsV5NsszxhooND+pj/D10EcKG1yzSQYeOZQK31YaiKu/m3ikDZ6rA+arUdFAMrrw4VsKXc/GYrU8kQ/KQ/gvXY5mn3ZNspuVC1vvMPuYJ5VtHCv1CmMONmVNaS4t46r1TmKJQx22PIlGkxAvnF2tlPWX5Cc2HGfWxo1Z4TeMBYM4ow1+2gbs5bDxzB/hEyzNVkWGOnwWFqtGyvvOD6yTKFKL1m/7E20uqdy4r7v3yhLA7ueeEuFxRfnYPyq26A1CIfCntBVsxjNT1deFtPyYJ/wPVRl4+HPW3ne/9TBdGQ1Cnma7YYhrfU5BXJjefsuNOTs+YaikCnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632812; c=relaxed/relaxed;
	bh=gDybWaXH0yVqSHGh6cSao1kY+huQ+XTPXQ1Vld4D+UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Brez3pID2JUnZY48ky9fs6C27dxnQ53FB97ZllYC9heHpyEbt8TBjjpDDnMEt6BUwwUB7Upvae2u31BB8BNFTjGnI0Az8HpaRvOEaT4ReSiQlQ0ghXzZwwwp58PKHS1HlSYlLdgXOwwKD2yrVDvxxg61LG6GFSx1PKUiCJEJA9S/k7gLrNEB4mltqexS4Plc1xxmpi+kZafI/BBKvHVKNZ3GV4AOuQGXYpKA9G2n8XawZSBiYA7foyYQVg7JpaDpIXpd3zg1d+wDIXiJ2U8o+JX9vPofMvdI3EO4/HB5tVJmb4lkFRbtHIwWro2tNQUfdgaijaBj+FG475Cora4yTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMV7oMe2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMV7oMe2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFkg2s56z3cgx
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:20:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81FDB6061F;
	Mon,  2 Nov 2026 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976621F00A1D;
	Mon,  2 Nov 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632809;
	bh=gDybWaXH0yVqSHGh6cSao1kY+huQ+XTPXQ1Vld4D+UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gMV7oMe2qdf0+aS9olfnOBAqn/OBe6DasxdwT9LImBIs7Pj7CDa/oA2a6B/8kY9pd
	 QfSD+01vRhmQIdCiXlwTDyOpKHr/+vYVKI1GFm8wQR5ZwmzCN80Jrz/IWpqVDIWfYl
	 3Bzlzk4aLDYzHqqx14bF+dEvwX8XoOta/BsfktGPBtManOh4//zemOTXkilWggqbhn
	 W/RtVoTwiEMKAtL6JeSwBY8eTWp9GpOtjwbXtxAZExlQVzQlk62v23yj30uR9SnWUe
	 jbKIL4QwYWDm+Xox3mBmfSoPFHGyBgWuJOAs5l7OErmCDLr8xRUVWg57VzoW07Bk1H
	 D+JLNSysS0GGw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:12 +0100
Subject: [PATCH RFC 02/27] jfs: let procfs copy in writes to the loglevel
 file
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
Message-Id: <20261102-work-procfs-fs-v1-2-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=brauner@kernel.org;
 h=from:subject:message-id; bh=izEZyN2ciF2azWBwOiarD7rxdH5SrLb74RUgxhmuQ3M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7IJf+71NVUmNfmjuySXN5GYdHLr8WmWM125JvlY
 84Qs/VxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES0PBgZHvWw/qhbNX2Pi9i5
 F4F+xcfDMxt+ZB+X21+0fPH/f32bHBkZLj5bwyh982HI2kgp1W2/Husu5Fmlc+PU8aMTrX5F3I/
 u5gEA
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
it pins the entry, and take the level from that copy. Writes larger than
PAGE_SIZE - 1 bytes fail with -EINVAL now and so do empty writes, which
looked at a byte that wasn't written before.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/jfs/jfs_debug.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/jfs/jfs_debug.c b/fs/jfs/jfs_debug.c
index 5eb35b0d420f..e1c0211a6a32 100644
--- a/fs/jfs/jfs_debug.c
+++ b/fs/jfs/jfs_debug.c
@@ -23,13 +23,10 @@ static int jfs_loglevel_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t jfs_loglevel_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t jfs_loglevel_proc_write(struct file *file, char *buffer,
+		size_t count, loff_t *ppos)
 {
-	char c;
-
-	if (get_user(c, buffer))
-		return -EFAULT;
+	char c = buffer[0];
 
 	/* yes, I know this is an ASCIIism.  --hch */
 	if (c < '0' || c > '9')
@@ -40,7 +37,7 @@ static ssize_t jfs_loglevel_proc_write(struct file *file,
 
 static const struct proc_ops jfs_loglevel_proc_ops = {
 	.proc_show	= jfs_loglevel_proc_show,
-	.proc_write	= jfs_loglevel_proc_write,
+	.proc_write_buf	= jfs_loglevel_proc_write,
 };
 #endif
 

-- 
2.53.0


