Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF5606B38E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njOAnem7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbbX3x8Qz3dJw;
	Thu, 05 Nov 2026 06:48:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821720;
	cv=none; b=luPwn5NZj2NxS0GntPF79IYf2Wzef0jDC2g4CKHF9IpOli4udzAChE2iku9d/8UD9i2jfsqoM7ERG+dc3ykhPrbZKS/USNgZwYYY++vlve86ExKMyloum+l27HQoiVsQPB/gWM6x3HDIQYo504LCEHrVH3YKBxOGnN0Mcq/RP63TwkO0rCBcTlxmpKhPyxrwPfON07VdJV3dTQPd+DlnbQQcxA4evKzBCG7t84bZF+styfeLEpaWN7lGrpFCKoLzOD0P4kqv+oJCGYv19uFvnrkPtAXo5yomKixtWz5OeJNhXxuX6uf5/vUz5aUY2EkwMhWE8DJfDWGF9XLJkWVaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821720; c=relaxed/relaxed;
	bh=ngy72uTMwq8MvwxWP/NtrsM5SokWnoNP+4Ao9ix0Oqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7+nnsJB7BpIIR4EFw9eCDF51FgckgYydkscLBSMfqNvENURexZEOntF8QQbnMXyAvpCyu5EGHdbWY3qLC2DM7il6554ZtakVBEivgIhWX/TQG56wTIh3T0ZqDcQq7CgtD+w1KJ9cijB4KSu9ti+r2Rdc5FcYltqivauaz2c8CeDYWBYKjSkzCYy+NYMAtkLrXnmIG9vuiv6lj2xHsNKUDAPdbLL6sYIhbwIFNdskF0PhMzvpah+NJpbJGr2gCqND5LSG8ZN/OZc6HoJ/BeXI1jEsCV2gYBiGu3QiF2na+3WxL4/vvS7pFYypuoQ6j+wX3VqZNh5/LLWX009+RIc9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njOAnem7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njOAnem7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbbW5YJHz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:48:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C429F60DB3;
	Wed,  4 Nov 2026 19:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0BB1F00919;
	Wed,  4 Nov 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821717;
	bh=ngy72uTMwq8MvwxWP/NtrsM5SokWnoNP+4Ao9ix0Oqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=njOAnem7hZCWCyoet0RXEP40JyR4Yvp8pSYpBwltayKMJQbQC02d6SDgwP3xfs2tW
	 xugmM2WcWgYjdXPF6Mpd2U1pnELiviUGXPgsNw3v3y4DzBw8QX4m5zjJ4eAZUEMths
	 UuP11YcxHe2FKmrAnf0bFq7VlBn/6YRgVmBP1T8N1Pr+4kbSLl5O+osL1UE7K2ty1P
	 oEnDJhUirOpG54zRCn9fBxOKPvej4c0rIHuyjklb9YxqCXBsCkIQ2RjAx+czJOY+yG
	 SGBgiczQci/1p6CrIWfHpSe7cjL18eekUFtsRfK2WYjztl+jvPA9MqISF9cLRounAB
	 d6ISRqW2l121Q==
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
Subject: [PATCH RESEND v2 25/26] ALSA: info: drop the ioctl hook of data entries
Date: Wed,  4 Nov 2026 20:48:23 +0100
Message-ID: <20261104-work-procfs-drivers-v2-25-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=brauner@kernel.org; h=from:subject:message-id; bh=ytKHjP0KrW2lhifPjaN3U+UGytfp8SXew1PrSRALrDc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97prYf73Zf87rJ/bzhO9o2U2cd3uTmky32JvXZSUnv D87rpJj7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIqQcjw3w7mYjfZf/2BjgU yhprzp8/L8lsS7vIuu9/1C6a3Z2zPZnhr0jr77LtKiqlbqL+yafW33ec+O1HujL70h7GlBuzOj/ lsAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No driver implements ->ioctl() of struct snd_info_entry_ops.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/sound/info.h |  2 --
 sound/core/info.c    | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 67378da4d36c..d6cb0346f77d 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -50,8 +50,6 @@ struct snd_info_entry_ops {
 	__poll_t (*poll)(struct snd_info_entry *entry,
 			     void *file_private_data, struct file *file,
 			     poll_table *wait);
-	int (*ioctl)(struct snd_info_entry *entry, void *file_private_data,
-		     struct file *file, unsigned int cmd, unsigned long arg);
 	int (*mmap)(struct snd_info_entry *entry, void *file_private_data,
 		    struct inode *inode, struct file *file,
 		    struct vm_area_struct *vma);
diff --git a/sound/core/info.c b/sound/core/info.c
index 663ecb96f828..f837cfbe7313 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -201,18 +201,6 @@ static __poll_t snd_info_entry_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static long snd_info_entry_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	struct snd_info_private_data *data = file->private_data;
-	struct snd_info_entry *entry = data->entry;
-
-	if (!entry->c.ops->ioctl)
-		return -ENOTTY;
-	return entry->c.ops->ioctl(entry, data->file_private_data,
-				   file, cmd, arg);
-}
-
 static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
@@ -283,7 +271,6 @@ static const struct proc_ops snd_info_entry_operations =
 	.proc_write_buf	= snd_info_entry_write,
 	.proc_write_size = PAGE_SIZE,
 	.proc_poll	= snd_info_entry_poll,
-	.proc_ioctl	= snd_info_entry_ioctl,
 	.proc_mmap	= snd_info_entry_mmap,
 	.proc_open	= snd_info_entry_open,
 	.proc_release	= snd_info_entry_release,

-- 
2.53.0


