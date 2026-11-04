Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DA606E4C8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQh9dOUg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbFw4ccfz30DK;
	Thu, 05 Nov 2026 06:33:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820804;
	cv=none; b=jJ4Qyq2TICGIiZd0aqHXQdHdfbIhQKXFYztKXztaBcZW14Lc1tRc4VGz1oE1HElmLTWFCwX484Q60Cy8IkSCK9cR3wOIOFYALtWLG86q9dWhw4lFgnb/m6ehg6PYmMdkNHxBIj8+Qpr+O/HPizRveLiF8fqVWqb5yvCmN9DjLCBzSua2JuWH9VjMIUe+IjAc4oF99p4g4KkcwZ24PiS/8nULP3gRSm9ki/B/tK4LQ0XfNxbWDzQThBAk+kWqGT5X1towGuIlpWNY4afb3Di14eJJSt+gV2tGpOmOqdr0lLZDqJliUit81aikMSm0VaoUAlE9qit7zZigjBh7yCFdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820804; c=relaxed/relaxed;
	bh=m5fnOjZPCdCthpmqWOs3L34lGoL1k3Cz80cer2f5luU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMfQY778gJxhjF7B8QAEe5T3uyMciTH+gCJXlYFDxyhEutJKPl/Uh9dDQ2fHnIT5Ag6/BweTJhku2wtjnF0fdXSF31uJ0bdVj/6gYA71JQ2h//oj5LwRYDlP+CptUnlFg8QEnuX+CTFAh9NbMmXhzXfoUdi1ytBIs9mCT4ipXlPh5OK273idjN1nTcoBIZ7THfgWMQB+Q4Hp3nx/8WegM0pM0V//Fot6FfrZNRC3cXy+AOdbLLyhVrUvuzKQkb/sxwPDOaT5SDSltrQvi9Ji8xzrFSUzIHHwZAgYS0+qvXjnSYRx1ZG/y0ODX2Z78YDhirkxdRiYrBcopGlWEroRCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQh9dOUg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQh9dOUg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbFv5Yqtz303B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:33:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CEE5442DEB;
	Wed,  4 Nov 2026 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9FA1F00A15;
	Wed,  4 Nov 2026 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820801;
	bh=m5fnOjZPCdCthpmqWOs3L34lGoL1k3Cz80cer2f5luU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQh9dOUguZczFeerwVOxndMwGa9cSfoH+fhP8/3Rxa3DPH1G+HM/+za7WadZQAZ/D
	 fq4TopM7uKGJZXNziRVvG3QJUkhqI5gLMgvkcBqdsoumv4l8nfzfDshfSBVOxZxBHm
	 d3c7LWZdB2HKGoSI+d7ZlkEpANj3csWagleMS01d/UP0PQ1iNhncl7yqrSrJLx+/3X
	 K5bN2l+amW6lxaeZ7FtF3rJYpe6HpiLOriOGELF4SvKo0lvOUsGtT4wc+u8RElFRu9
	 B5D2UX6yl1GFTMAVHUTcM0UCtPI2Y3OIiqUgVz2B95tPby/8tvIjbVoFCZGBoCwbdo
	 cioCcciQ8nukA==
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
Subject: [PATCH RESEND v2 16/23] proc: let procfs copy out reads that don't go through seq_file
Date: Wed,  4 Nov 2026 20:33:07 +0100
Message-ID: <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836; i=brauner@kernel.org; h=from:subject:message-id; bh=mbWG9ixnvuYkETLZWF9m7UYU/9GwiQQdqKoWR6bF7rs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bm+ZfOxA288E569R1y9t+CIcLDHr2pknf3oS29uN4 nNU1oV1dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEhJ+R4dbcljMZoU9+7toU vvWYhMZ39lupMcF71bRLvu9YvfX2eQuG/0WCu2Y9ft04V/et0hmXjW48qu/X3j1hMT8kT+xU7OR oLi4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_reg_read() and proc_reg_read_iter() pin the entry and call
->proc_read() or ->proc_read_iter() which copy to userspace
themselves. Like for seq_file reads and for writes, a reader can make
a page fault in that copy take as long as it wants and
remove_proc_entry() waits for it.

So do what kernfs does for these reads as well. An entry that implements
->proc_read_buf() fills a kernel buffer of at most ->proc_read_size
bytes, a page if the entry doesn't care, and procfs copies it to
userspace after unpinning the entry. The entry moves the position like
it did for ->proc_read() but that only sticks if the copy to userspace
worked, like in kernfs_file_read_iter(). If the copy fails halfway the
read fails with -EFAULT and the position stays, where
simple_read_from_buffer() returned what it had copied until then.
procfs remembers ->proc_read_size in the entry like ->proc_write_size.

Larger reads come up short, like with kernfs. An entry whose readers
want all of a large file in one read asks for PROC_ENTRY_FULL_READS and
procfs fills the read in pieces of ->proc_read_size, unpinning the entry
in between. A piece whose copy fails ends the read with what the pieces
before it returned. kexec-tools treats any short read of /proc/vmcore
as fatal for example (cf. [1]).

These entries are read through ->read_iter() so readv(), splice(), aio,
the RWF flags, kernel_read() and io_uring work for them like for the
->proc_read_iter() ones. io_uring's nonblocking attempt gets -EAGAIN
though, like loop_rw_iter() gave it for ->proc_read() entries. Neither
the allocation nor the entry can honor IOCB_NOWAIT, and io_uring would
take a short read of a record file for an unfinished one and glue the
next record to it. So it retries from a worker like before.

An entry that implements ->proc_read_buf() and also declares a seq_file
or one of the other read methods fails to register.

No users yet.

[1]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c       |  9 ++++++++
 fs/proc/inode.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/proc/internal.h      | 11 +++++++++
 include/linux/proc_fs.h | 16 +++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5e2ed5a04ec9..2d503250de75 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -474,6 +474,15 @@ static int pde_set_flags(struct proc_dir_entry *pde)
 		if (proc_ops->proc_flags & PROC_ENTRY_SHORT_WRITES)
 			pde->flags |= PROC_ENTRY_SHORT_WRITES;
 	}
+	if (proc_ops->proc_read_buf) {
+		if (WARN_ON_ONCE(pde_is_seq_file(pde) || proc_ops->proc_read ||
+				 proc_ops->proc_read_iter))
+			return -EINVAL;
+		pde->flags |= PROC_ENTRY_proc_read_buf;
+		pde->read_size = proc_ops->proc_read_size ?: PAGE_SIZE;
+		if (proc_ops->proc_flags & PROC_ENTRY_FULL_READS)
+			pde->flags |= PROC_ENTRY_FULL_READS;
+	}
 	return 0;
 }
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index df1caa0f238d..caa47933c233 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -23,6 +23,8 @@
 #include <linux/sysctl.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/sched/signal.h>
+#include <linux/uio.h>
 #include <linux/mount.h>
 #include <linux/bug.h>
 #include <linux/wait_bit.h>
@@ -377,11 +379,67 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 	return rv;
 }
 
+/*
+ * The entry fills a kernel buffer and procfs copies that to userspace after
+ * unpinning the entry. A reader that faults on its buffer then doesn't hold
+ * up remove_proc_entry().
+ */
+static ssize_t pde_read_buf(struct proc_dir_entry *pde, struct kiocb *iocb,
+			    struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	char *buf __free(kvfree) = NULL;
+	ssize_t rv, done = 0;
+	size_t len, count;
+	loff_t pos;
+
+	if (!iov_iter_count(iter))
+		return 0;
+	/* neither the allocation nor the entry can honor IOCB_NOWAIT */
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+	len = min_t(size_t, iov_iter_count(iter), pde->read_size);
+	buf = kvmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* PROC_ENTRY_FULL_READS fills the read in pieces */
+	do {
+		count = min_t(size_t, iov_iter_count(iter), len);
+		pos = iocb->ki_pos;
+		if (!pde_pin(pde)) {
+			rv = -EIO;
+			break;
+		}
+		rv = pde->proc_ops->proc_read_buf(file, buf, count, &pos);
+		pde_unpin(pde);
+		if (rv <= 0)
+			break;
+		if (WARN_ON_ONCE(rv > count)) {
+			rv = -EIO;
+			break;
+		}
+		if (copy_to_iter(buf, rv, iter) != rv) {
+			rv = -EFAULT;
+			break;
+		}
+		iocb->ki_pos = pos;
+		done += rv;
+		if (!pde_has_full_reads(pde) || rv < count)
+			break;
+		cond_resched();
+	} while (iov_iter_count(iter) && !fatal_signal_pending(current));
+
+	return done ?: rv;
+}
+
 static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(iocb->ki_filp));
 	ssize_t ret;
 
+	if (pde_has_proc_read_buf(pde))
+		return pde_read_buf(pde, iocb, iter);
 	if (!pde_pin(pde))
 		return -EIO;
 	ret = pde->proc_ops->proc_read_iter(iocb, iter);
@@ -793,7 +851,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		inode->i_op = de->proc_iops;
 		if (pde_is_seq_file(de))
 			inode->i_fop = &proc_seq_file_ops;
-		else if (pde_has_proc_read_iter(de))
+		else if (pde_has_proc_read_iter(de) || pde_has_proc_read_buf(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1d36fe4b1af5..b5c78f4f392c 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -52,6 +52,7 @@ struct proc_dir_entry {
 	void *data;
 	unsigned int state_size;
 	unsigned int write_size;
+	unsigned int read_size;
 	unsigned int low_ino;
 	nlink_t nlink;
 	kuid_t uid;
@@ -120,6 +121,16 @@ static inline bool pde_has_short_writes(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_SHORT_WRITES;
 }
 
+static inline bool pde_has_proc_read_buf(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_buf;
+}
+
+static inline bool pde_has_full_reads(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_FULL_READS;
+}
+
 /* procfs owns the seq_file, see pde_seq_start() */
 static inline bool pde_is_seq_file(const struct proc_dir_entry *pde)
 {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index c81c93325044..0f0997898ba3 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -38,6 +38,13 @@ enum {
 	 * failing with -EINVAL.
 	 */
 	PROC_ENTRY_SHORT_WRITES		= 1U << 9,
+	PROC_ENTRY_proc_read_buf	= 1U << 10,
+
+	/*
+	 * Reads larger than ->proc_read_size are filled in pieces instead of
+	 * coming up short.
+	 */
+	PROC_ENTRY_FULL_READS		= 1U << 11,
 };
 
 struct proc_ops {
@@ -84,6 +91,15 @@ struct proc_ops {
 	 */
 	ssize_t	(*proc_write_buf)(struct file *, char *, size_t, loff_t *);
 	unsigned int proc_write_size;
+	/*
+	 * procfs calls ->proc_read_buf() to fill a kernel buffer of at most
+	 * ->proc_read_size bytes, PAGE_SIZE if that's 0, and copies it to
+	 * userspace afterwards. Larger reads come up short unless the entry
+	 * asks for PROC_ENTRY_FULL_READS. The position the entry moves to only
+	 * sticks if the copy works.
+	 */
+	ssize_t	(*proc_read_buf)(struct file *, char *, size_t, loff_t *);
+	unsigned int proc_read_size;
 } __randomize_layout;
 
 /* definitions for hide_pid field */

-- 
2.53.0


