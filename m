Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FF6070D9C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k68ttWG6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF0H57QLz2xXB;
	Tue, 03 Nov 2026 01:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793630815;
	cv=none; b=AA2Dfz5W9tafy4Da2/FmJJBH0Fh9P07PakNIMs9dO3ejI/9wrODLN6mbPPv3bqPcYb+fpNnzuuYKBLzsFMNoS0sACYQd9ckCoYGdsPTjWQHC3ldXHya2eSEAx8iJRXsQxc0zGzFVB8UTuGy4TIzyePCVXchhTwyDIniRoYivejdxJGK9726bRa/Es0GmUCaLivlWTaNtnYBqOMEVX4jKG0NtitQDuQWs88sAQLiH0NsoUpmcQdkfrveX8+G6ClUsVxNVyLx2NW+0kaTuqJmMpoM01wTnK5bqKi9ko164IVuoVDVg3JvFA6njF8muWyPMbtjekTBsKPFc/ge7cnq60A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793630815; c=relaxed/relaxed;
	bh=gGh9qQAToZE5wrWgcgjg72Buy8fnK2LgswQGjbfg87A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7s8CwTFF4+tk3Jib516MUEcvPREFnVOlisv6YcNAwycMAciS5EIQfPYSMkM5b5wniEYcZ7WrQDVEI2OYHcN0TAJ4PslhYbxNCGkoijJTDE63fTXsv+4Y+MxukssikFFzk40jBhwOg7gmt8CFSsAqCRjxzM9iGybZOTFXfV5XJEMHuFZGrwxVEwmQdt+uF98tQA9jKuEUwo+kHgynZpJgYQh2ncMcZrkDNAimuopuGbAlghApSAaMMrB0ZOOTifBj911tFtfbQs1Tz+APk1Zq+IqMWOGkKJhQpflQavnsYtdZ/wAchW894SklJ7a/ynvppUtHhAO8wxavaxFKuVIhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k68ttWG6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k68ttWG6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF0G5s2zz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:46:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3FC46020C;
	Mon,  2 Nov 2026 14:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FD21F00A1B;
	Mon,  2 Nov 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630812;
	bh=gGh9qQAToZE5wrWgcgjg72Buy8fnK2LgswQGjbfg87A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k68ttWG6wR2uYUNWQI+ECVf+fO/XJ0eqvyJRIGqlTdn3SeSK5FwYTdTBaVjsoBsYJ
	 kJXwecLDVVqkc0QtPna5nnmOaGhEH6lV2p3+n4SMeLLTjqLfMHRMfS6+IdU5FeP6Ex
	 EEbVMiiZNLXMTNclGmw6p8mC8yLNPYuUSTnCtn6ZR27qjgY9RaX2RJuHLWLPx9jmMt
	 9JJmAL/6SUvZypF7nop8NC5qp7LgJYP8eJFNNtNBvtdk7y2N5+2qF+LGhO9FlXYxla
	 LSU+v/oAHtst3btNP9gxZgyUrKBFNLcCwNm+jD4+mesxl+NmeCWqzBEWi80sNRNQ/1
	 Y+2ZOSQK06ITw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:43:28 +0100
Subject: [PATCH RFC 37/38] proc: don't pin a symlink's entry while
 readlink() copies it out
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
Message-Id: <20261102-work-procfs-bugfixes-v1-37-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_get_link() pins the entry with use_pde() and the delayed call
unpins it. vfs_readlink() copies the link to userspace in between. So a
page fault in that copy holds up remove_proc_entry() just like the
copies of reads and writes do, and the callers hold locks while they
wait. /proc/asound/<id> is removed with snd_card_mutex and info_mutex
held when a card changes its id.

The pin doesn't keep anything alive. proc_symlink() copies the target
and pde_free() frees it with the entry, and the inode holds a reference
to the entry. What the pin does is keep a removed symlink from being
followed. So check ->in_use instead and drop the delayed call. That
also takes an atomic pair off every traversal of /proc/net and
/proc/mounts.

Fixes: 7e0e953bb0cf ("procfs: fix race between symlink removals and traversals")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 9933f03ab9fb..2d65f3c8ec03 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -629,19 +629,19 @@ static const struct file_operations proc_iter_file_ops_compat = {
 };
 #endif
 
-static void proc_put_link(void *p)
-{
-	unuse_pde(p);
-}
-
 static const char *proc_get_link(struct dentry *dentry,
 				 struct inode *inode,
 				 struct delayed_call *done)
 {
 	struct proc_dir_entry *pde = PDE(inode);
-	if (!use_pde(pde))
+
+	/*
+	 * No pin. The link lives with the entry, which the inode holds, and a
+	 * reader could fault while vfs_readlink() copies it out. Just don't
+	 * follow a removed one.
+	 */
+	if (unlikely(atomic_read(&pde->in_use) < 0))
 		return ERR_PTR(-EINVAL);
-	set_delayed_call(done, proc_put_link, pde);
 	return pde->data;
 }
 

-- 
2.53.0


