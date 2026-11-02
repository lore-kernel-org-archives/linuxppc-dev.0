Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B6608B7F9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpmBPtZO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFTr2mW5z3cFG;
	Tue, 03 Nov 2026 02:09:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632144;
	cv=none; b=UxakCOJrj2htVHFZYt1m59JQ6WVFEAjw3ioWmevlfZ901aaVULK1DLIIEjIpI1QTyuzk5PN4zeOTQxnAMYe4kooPYI51f5/3NttjM/Xu23Gn51x5QME2L+m7RWrURK1f5ZfA2toydvNpbes8rhMnTJmFTEOlYi8LZCF1gj2IrYZ3zPxfb72hN8AIV4edoRQqundCfxSYFOH4Knku4BHcA+QFOFPBlssOurC2RSNMaPV4WysI5Fo+MiPAbsmku1338kaVa6FBbYsusiGgQY5KAM8wADnyUn24vkNPMLMu86dfVcF5qvBj5XTQ4HoK8B8BV7Kc/UiFJfhuBv15QaPibw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632144; c=relaxed/relaxed;
	bh=YGofg29spfHBU5j0sEupYlWEu86pUC9IfXeVVL8qINU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkNC1CYYG6idLrhb8BDi7YeEWtFFX1il3vRMfaSZuQfuYXeM4/sGFV32DHY7WGQV2UZ3qvw8Ai97z3ZyRNNa+++fUjXhZgppo9N6iorLYYzsdKCs0EVegmjw8cBWyTHIa68xrQqQM6s/xbeObKxfj8wHftzS2KZCnGWnVWli5U2e/QBQoIdgcNtb/ztBfsnOwzzn9gymxqLAe6UiJ6y1d+oAEw4brGhNWXWMJpoS7qV1d8dU/RvVG+yv+j5AeL7hosc7ASz5IvDP41RQXDG5+m7zLxV0UnS1Pv0wF9u/jK16KM/USdpXzji1FXEP0brTCMyEp7P+6e9WotV7gKw3pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpmBPtZO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpmBPtZO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFTq4Ykcz3bYG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:09:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 056B14197D;
	Mon,  2 Nov 2026 15:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB991F00A18;
	Mon,  2 Nov 2026 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632141;
	bh=YGofg29spfHBU5j0sEupYlWEu86pUC9IfXeVVL8qINU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JpmBPtZO6G/UqVUziPY4iWq6sxFWqxjtkt4mByDfSmQn4JPupogU0bEEb3whcdZpv
	 bxJjhl9riucbcDZJP757/It4YGJC5UnRtX978pao8OmQBnQl2aSFvJGabRNROHyvpQ
	 bZzdyysVF3U57cA3Ja1OK9TBd8Tsli7X4hjtxAFP6BIZk3DMCdCyX58cnbypS2jX2/
	 rkwz1SxlnDr9giKtJvEtvZB1xm8ozK/+QHDHx5w/XweZen0aQhQjbqjSvObAObvY2I
	 HxCcEBImWMheaGFA39+r4mxQ3C4umA03aHVfQBgmMCsinQB7bWR44TPgh7+0yTz50I
	 jxnkq4gmT3FLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:49 +0100
Subject: [PATCH RFC 22/22] PNP: isapnp: let procfs copy out reads
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
Message-Id: <20261102-work-procfs-arch-v1-22-c9492ab08480@kernel.org>
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

Implement ->proc_read_buf() so procfs copies what is read from
/proc/bus/isapnp/<card>/<dev> to userspace after it unpinned the entry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pnp/isapnp/proc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 8197c7f29743..152fd5bfbc06 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -19,37 +19,31 @@ static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
 	return fixed_size_llseek(file, off, whence, 256);
 }
 
-static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
+static ssize_t isapnp_proc_bus_read(struct file *file, char *buf,
 				    size_t nbytes, loff_t * ppos)
 {
 	struct pnp_dev *dev = pde_data(file_inode(file));
 	loff_t pos = *ppos;
-	int cnt, size = 256;
+	int size = 256;
+	size_t cnt;
 
 	if (pos >= size)
 		return 0;
 	if (nbytes > size - pos)
 		nbytes = size - pos;
-	cnt = nbytes;
-
-	if (!access_ok(buf, cnt))
-		return -EINVAL;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
-	for (; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
-		unsigned char val;
-		val = isapnp_read_byte(pos);
-		put_user(val, buf);
-	}
+	for (cnt = 0; cnt < nbytes; cnt++)
+		buf[cnt] = isapnp_read_byte(pos + cnt);
 	isapnp_cfg_end();
 
-	*ppos = pos;
+	*ppos = pos + nbytes;
 	return nbytes;
 }
 
 static const struct proc_ops isapnp_proc_bus_proc_ops = {
 	.proc_lseek	= isapnp_proc_bus_lseek,
-	.proc_read	= isapnp_proc_bus_read,
+	.proc_read_buf	= isapnp_proc_bus_read,
 };
 
 static int isapnp_proc_attach_device(struct pnp_dev *dev)

-- 
2.53.0


