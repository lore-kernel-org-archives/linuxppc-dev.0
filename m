Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF23606AB35
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRau239w
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbZ63GFyz3cD7;
	Thu, 05 Nov 2026 06:47:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821646;
	cv=none; b=lRtRB+1Q9o5L1anHv8oSVsrkjuKEEEtL73Rz2Y9AjnZF2h3mam6oS7Eph/dQkJZVOFqlWBCe1xbWZiWZRHB76XiDToTz9SANBJInQx+Fb/MoWZ4bcu9/99Zu4Kp2NgsqpGjrMvPPTPWjjd3BbWmabprjCa5Qw5Z0mmZ9zPLHLfL4p0gfsJzl1h2XjXJ6sd3RPN5K6CdtWptnaP6pbZCJQ8c876XUp3YfXSc3SChzby1QELd3nMRN/6ENu0s9jAVeK8JYtdDIjRWrgWj1TqLW8uHbVwjRDjac/jCN0On9aUZNefkqFO4yht9/AOaUGwEUXUhifa5EtNDtswRckvSHog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821646; c=relaxed/relaxed;
	bh=pUc3XnniVQ5ZOuyDhOysKqrOAZk7AW9/FnAFYC6PjCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=een4ZAnGcURq5pvvz/p5Fo4VrEkYv5ZPUaTv8koJD6qSH2rFQIdA8X/+BGcwdUBWoSSSQGPe6qkGRpEYBk30tjY2QNZtSXPuugU1PHhErE5M3CFJWinsbdv4CEv2Z4b2w9tLg5nH0mYr+GfYUEBERdHJsQlB6C3jit24xkOtY/VqDCOcTO+DjO+5550f0l8xn/t5lKMg7PdD5jjlX+v3wGwBN5oEWNkLR3p0/vFqdkFom66V3CYXI7/skJXuoBosxu2L90NLxCc5h7Dn0XcRfufTSbYOVuzSepLntTogjya2u98+LhwOi81l6f+s4EAN/qy+RG+bhwo85fhDu/MMjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRau239w; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRau239w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbZ54NMsz3c2H
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:47:25 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B492A60DB9;
	Wed,  4 Nov 2026 19:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6491F000C1;
	Wed,  4 Nov 2026 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821643;
	bh=pUc3XnniVQ5ZOuyDhOysKqrOAZk7AW9/FnAFYC6PjCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRau239woFQtdlJcfyIuzdt/Mz7tXpQLHgX2J3HFCxtIoQ7p0t8aEvclvbqPlKOGa
	 EedaHfHccZGMzhB5vcIwAhuyyQDAPau+H/YAUhBdRbtxFhlJqgcxmK2czVG9y5wP7T
	 vy2fA02WDdK3VJ+RlZqpZVnSB9uMz9+ib+VE15vj7NVBBxUCWLKrh6ChnabmilIhZU
	 3Y5JjgpF66wHdUqRob6tq7eO9hwAVhqpVsM3MxH/8UpRQy6y5G6Z47XYSlSWJ2d5uP
	 6lZJVoMkctk/0jcZI5OX7z1nQPxzj8u8pGN0oIBxSIKKB6fvv2I5CNKbtMZ1A+Sjdx
	 r3Q7BlsL714Bw==
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
	Chuck Lever <cel@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH RESEND v2 20/26] tty: sysrq: let procfs copy in writes to /proc/sysrq-trigger
Date: Wed,  4 Nov 2026 20:47:08 +0100
Message-ID: <20261104-work-procfs-drivers-v2-20-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=brauner@kernel.org; h=from:subject:message-id; bh=xA04tAm65fsCtMg0xl0tBqqUoHOUL5b4F/HBKwEi4qU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97up5wHzVwMj/4s+/qsc0lZwe6RUvWPryURRj4B+1W WLHtl+Y3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRvW8Z/srfZV/202bOs6pv bO3FhjJLqzofzqvaU2easvxKpvXzafoMf3jnJ8cnHTZnrf/9WuLLwePxp5qz7/ZoyYesNj+yaqb 8JzYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and handle the keys from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now. They used to trigger the
first key, or all of them in bulk mode. procfs allocates the copy, which
is as small as the write, opening the file allocated as much already.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/tty/sysrq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..99363e1b59ed 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1200,17 +1200,14 @@ EXPORT_SYMBOL(unregister_sysrq_key);
  * However, if the first character is an underscore,
  * all characters are processed.
  */
-static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
+static ssize_t write_sysrq_trigger(struct file *file, char *buf,
 				   size_t count, loff_t *ppos)
 {
 	bool bulk = false;
 	size_t i;
 
 	for (i = 0; i < count; i++) {
-		char c;
-
-		if (get_user(c, buf + i))
-			return -EFAULT;
+		char c = buf[i];
 
 		if (c == '_')
 			bulk = true;
@@ -1225,7 +1222,7 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 }
 
 static const struct proc_ops sysrq_trigger_proc_ops = {
-	.proc_write	= write_sysrq_trigger,
+	.proc_write_buf	= write_sysrq_trigger,
 	.proc_lseek	= noop_llseek,
 };
 

-- 
2.53.0


