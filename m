Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6616079915
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2L6lcib
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF7j4YN6z2y8r;
	Tue, 03 Nov 2026 01:53:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631201;
	cv=none; b=TcT3NRBEQHSaqGjSRjvfIDwtC71Vp6NPJi7ffiyBjretMSihPbVxlK4BhztUk2gZJWn3A1vl3yf2U6xjecLbAWAGi6vCGGua5jjmQJGgwCFpNJELnDAH4sBmGt/0/PiOwDCzcg/cMzT7EM52M3XKCPrJqdzgzRGPjxm2ONyI6EmopqSD2tybPjOAdpAy4Ivx3hgRKrTc1c4H0KBrbjY4gLRe3Fl4fcLUHgvFjGZVH+/lN9e0uhGlFztknI778+8dVyF5WfXcVgFy2QPJJnKf53md7Bwa8sGrDGp6J1usJJFKpyUldis4lskm2RBLTHpXRuxoeUt924F7iu5WHJkYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631201; c=relaxed/relaxed;
	bh=SuIwn2r98IWfqwTZEZpGxulO+eCOsS/OzPuASS7qjfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMPdaRhjEu308aHec1S+P0eKVsCdMTls7koM+hIa59jCUIicR2zrYAfba46Pzb4OnTR5cR8895bxGnRNnrGV6ENYxAkmElyidgR3ZKQWFHCABxTe3Arsw0Me+eVjKw9CUZQr116F6UYgBqnxaEf/NO3snmEZEsGUpHKefbXQeRXi7kJysH7x/WLtqUWfi51Q/z4XrX+numls/DlizJ61tE1w+u+TS2FVQvsfOmRZCq38kZsnrELrFIDu0EIBb3D+P2weGVz2evH7p7Xi78JTrKmIn5HwU13fCPf655lz2Bkh+O2DwJaUpFzaSdEVJ0XXIfZJJ8RK6ca6yiCcz1F/Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2L6lcib; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2L6lcib;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF7h5v7Jz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:53:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3B78601E4;
	Mon,  2 Nov 2026 14:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3261F00A16;
	Mon,  2 Nov 2026 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631198;
	bh=SuIwn2r98IWfqwTZEZpGxulO+eCOsS/OzPuASS7qjfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k2L6lcibhhKdv5bNLuwXbZmsfwzqvWwfwfZBS/eCf10awP60Wjanun9ZPK7oQruFW
	 KAcLZA6ECIFhwbDmPQYeBgLo1RfEogbBQHv4UEPmeTClP1/TCKc2QeEax047wQdumO
	 W0YE3jPgoRd/LmLaUtzca4qSMLcaei0NK+lXWxavlWmeeyNH5nmuwBkbR0kVT1sHQn
	 ZsMYcO881dzVUBN/9pT74wlmk+ab9wqr2yJQ2aCxtEgQ3a76we2PDn3LnSGHPCJ71W
	 l/Ayog1x0iLUa25PHtbJu1dJlwcPaGZm3EPOMbWysr+KgooO5mZVhjlchoAznOAeVa
	 tYwRxP451ni0A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:51 +0100
Subject: [PATCH RFC 11/16] proc: let procfs copy in writes before pinning
 the entry
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
Message-Id: <20261102-work-procfs-core-v1-11-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
In-Reply-To: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
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

proc_reg_write() pins the entry and calls ->proc_write() which copies
from userspace itself. A page fault in that copy can take as long as
the writer wants, just like the copy to userspace of a read, and
remove_proc_entry() waits for it.

So do what kernfs does for writes as well. An entry that implements
->proc_write_buf() gets a NUL-terminated kernel copy of what was
written. procfs makes that copy before it pins the entry. The copy is
capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
proc_simple_write() if the entry doesn't care. Larger writes fail with
-EINVAL. The proc_ops go away with the entry, so procfs remembers the
limit in the entry when it is registered, like the size of the seq_file
state, instead of pinning the entry just to look up a number.

Entries that take binary data in pieces, like the PCI config space,
ALSA's data entries or a firmware image, can ask for
PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
->proc_write_size bytes and the write comes up short.

->proc_write_buf() gets the position like ->proc_write() so entries
that write at an offset keep working.

Note that procfs copies in the whole write before the entry looks at any
of it. So a write that is too large or whose buffer can't be read fails
before the entry's own checks run, permission checks included, even
where the entry only ever looked at the first few bytes.

An entry that implements ->proc_write_buf() and still has a
->proc_write() fails to register.

No users yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c       |  8 ++++++++
 fs/proc/inode.c         | 33 +++++++++++++++++++++++++++++++++
 fs/proc/internal.h      | 11 +++++++++++
 include/linux/proc_fs.h | 17 +++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 6ed8bc313db0..7dc7df101286 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -468,6 +468,14 @@ static int pde_set_flags(struct proc_dir_entry *pde)
 		if (proc_ops->proc_lseek)
 			pde->flags |= PROC_ENTRY_proc_lseek;
 	}
+	if (proc_ops->proc_write_buf) {
+		if (WARN_ON_ONCE(proc_ops->proc_write))
+			return -EINVAL;
+		pde->flags |= PROC_ENTRY_proc_write_buf;
+		pde->write_size = proc_ops->proc_write_size ?: PAGE_SIZE - 1;
+		if (proc_ops->proc_flags & PROC_ENTRY_SHORT_WRITES)
+			pde->flags |= PROC_ENTRY_SHORT_WRITES;
+	}
 	return 0;
 }
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8425465aae5d..c0bb40e7ff96 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -440,11 +440,44 @@ static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const ch
 	return -EIO;
 }
 
+/*
+ * procfs copies in what is written before it pins the entry. A writer that
+ * faults on its buffer then doesn't hold up remove_proc_entry().
+ */
+static ssize_t pde_write_buf(struct proc_dir_entry *pde, struct file *file,
+			     const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf __free(kvfree) = NULL;
+	size_t size;
+	ssize_t rv;
+
+	size = pde->write_size;
+	if (count > size) {
+		if (!pde_has_short_writes(pde))
+			return -EINVAL;
+		count = size;
+	}
+	buf = kvmalloc(count + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	if (!pde_pin(pde))
+		return -EIO;
+	rv = pde->proc_ops->proc_write_buf(file, buf, count, ppos);
+	pde_unpin(pde);
+	return rv;
+}
+
 static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv;
 
+	if (pde_has_proc_write_buf(pde))
+		return pde_write_buf(pde, file, buf, count, ppos);
 	if (!pde_pin(pde))
 		return -EIO;
 	rv = pde_write(pde, file, buf, count, ppos);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index d8093451524a..80b346a3299d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -51,6 +51,7 @@ struct proc_dir_entry {
 	proc_write_t write;
 	void *data;
 	unsigned int state_size;
+	unsigned int write_size;
 	unsigned int low_ino;
 	nlink_t nlink;
 	kuid_t uid;
@@ -107,6 +108,16 @@ static inline bool pde_has_proc_show(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_proc_show;
 }
 
+static inline bool pde_has_proc_write_buf(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_write_buf;
+}
+
+static inline bool pde_has_short_writes(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_SHORT_WRITES;
+}
+
 /* procfs owns the seq_file, see pde_seq_ops */
 static inline bool pde_is_seq_file(const struct proc_dir_entry *pde)
 {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea55ed85a2d6..c81c93325044 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -31,6 +31,13 @@ enum {
 	PROC_ENTRY_proc_show		= 1U << 5,
 
 	PROC_ENTRY_FORCE_LOOKUP		= 1U << 7,
+	PROC_ENTRY_proc_write_buf	= 1U << 8,
+
+	/*
+	 * Writes larger than ->proc_write_size come up short instead of
+	 * failing with -EINVAL.
+	 */
+	PROC_ENTRY_SHORT_WRITES		= 1U << 9,
 };
 
 struct proc_ops {
@@ -67,6 +74,16 @@ struct proc_ops {
 	const struct seq_operations *proc_seq_ops;
 	int	(*proc_show)(struct seq_file *, void *);
 	unsigned int proc_state_size;
+	/*
+	 * procfs copies what is written into a kernel buffer and calls
+	 * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
+	 * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
+	 * writes fail with -EINVAL unless the entry asks for
+	 * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
+	 * for ->write().
+	 */
+	ssize_t	(*proc_write_buf)(struct file *, char *, size_t, loff_t *);
+	unsigned int proc_write_size;
 } __randomize_layout;
 
 /* definitions for hide_pid field */

-- 
2.53.0


