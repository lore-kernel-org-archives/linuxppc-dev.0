Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4C606ABBA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esP1NXiJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFQG6tHcz3bb2;
	Tue, 03 Nov 2026 02:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631958;
	cv=none; b=K3x2toa1rQH8MfnfFB94nESyklsweiyw02OdpO3IgmcEamsMxZsbat+JEZBUUkD8ySTXFyXup0vCzitwPwvyTs8Xde5+VmepYu72DRR/MTJJQBLVQ/FGVQZUu4Vi6Gt7GFh2+k7b16JfX+sEEz1pRJu3l2fFY9BKDgLgwtFxOU67Ra0AnpGIa/LHjtHl6j+xRwwzi5pYOGvJwgCXrgHGiq1ma0tLeBK+Lx+E2orOijtE3afP98xujaH6ZJpvvd2e2/mDoL5e1ScICuknLcQQgR010+Idnp2VBXeC4HkdKDyejqZsaTsJh3CgEXxCEvc2CgmVM6OA46n+of+/dETWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631958; c=relaxed/relaxed;
	bh=08oqN1TE6XF/zda2aaIy/jJ7rzXSJoF5jY3Jq8EQn3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJQD/InnybESdvGHGvmkQz/2gkVjfF1ovYypKiRgKjRTTR0HOB8G7r0y0FLJF7YhZXa1EGIK9i0nynMpSNmMOjz9dl2z89okdO1TEPucO85oJ+GvoKxszDyXZMouBtst08VvDCgxPKnj38Dzvqi50+l+OJq1ZtsIiyl6mBV1YVjqbLh/x+xBWU0QEQw9Zgz/Nf/tFubZTT9PBL9oQau6kXEmp5TDja28OO2HukmcMW9uR3Ks926NFtDoGbtbm64eEJ7lTgdy4AbToh4VGqnde2aacH+gY6+vspV/PJVCPmb9+7XRieM4otRQShQGtEdfvWw30XVOfwQv9784dHAg5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esP1NXiJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esP1NXiJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFQG1XNwz30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:05:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DEA543A26;
	Mon,  2 Nov 2026 15:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD921F00A1C;
	Mon,  2 Nov 2026 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631956;
	bh=08oqN1TE6XF/zda2aaIy/jJ7rzXSJoF5jY3Jq8EQn3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=esP1NXiJtkWIwe0zxy+yALxJft8aenVVlvrmNyeWEmPwwMUFoGj4vVXV8t6fYRCCr
	 PUrWrFhkorqvWNCdJaSQMLf/MWYFqMu/fjhYRkfg/ntu2jTry0OdIErXKyYUuaX9b2
	 s/YJB0wieY9b+/J0uqo3gTDUZNa/iAbOQ22VE6vCDejVVu2QvhNeen/wYMi1uUBddD
	 otQ6tttXu5fna5CmPdbWZ3/5LvyLR1HZD3qs4y3l163vI5ZM0FWutUhg0hU7z8iAs6
	 9fnCJsDMduAv+8gXV1qLG+g/a4WXlmT3vfPCv0fZZv3ZT7nfZmWkFHzOiAfiEsinuc
	 E814TEauo1aaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:40 +0100
Subject: [PATCH RFC 13/22] x86/mtrr: let procfs copy in writes to
 /proc/mtrr
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
Message-Id: <20261102-work-procfs-arch-v1-13-c9492ab08480@kernel.org>
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and parse the command from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 9510e01d5103..038e2dc38797 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -91,7 +91,7 @@ mtrr_file_del(unsigned long base, unsigned long size,
  *    "base=%Lx size=%Lx type=%s" or "disable=%d"
  */
 static ssize_t
-mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
+mtrr_write(struct file *file, char *buf, size_t len, loff_t * ppos)
 {
 	int i, err;
 	unsigned long reg;
@@ -103,9 +103,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	memset(line, 0, LINE_SIZE);
 
 	len = min_t(size_t, len, LINE_SIZE - 1);
-	length = strncpy_from_user(line, buf, len);
-	if (length < 0)
-		return length;
+	length = strnlen(buf, len);
+	memcpy(line, buf, length);
 
 	ptr = line + length - 1;
 	if (length && *ptr == '\n')
@@ -397,7 +396,7 @@ static int mtrr_open(struct inode *inode, struct file *file)
 static const struct proc_ops mtrr_proc_ops = {
 	.proc_show		= mtrr_seq_show,
 	.proc_open		= mtrr_open,
-	.proc_write		= mtrr_write,
+	.proc_write_buf		= mtrr_write,
 	.proc_ioctl		= mtrr_ioctl,
 #ifdef CONFIG_COMPAT
 	.proc_compat_ioctl	= mtrr_ioctl,

-- 
2.53.0


