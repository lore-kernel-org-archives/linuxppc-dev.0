Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052226070267
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIejajPL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFHc4tYMz2y2T;
	Tue, 03 Nov 2026 02:00:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631612;
	cv=none; b=ZrClLZI+UvebJ8HEdIsxTGo/GSvV/U9JvrwWQ6xFbUHmf8DO7LnHTzB7HcdEQEzWX4N5Az4PiWFeJNadqU35n0j8b1tCKF9K8NpPqmyamkKPtQz2raYh+RWb8nkJ8fY0QIid/KO8tOJJ8bWjc0knfd6vMiFYGR8rzZbAmDuArKxmWE1JesoXNJlSfmaYhCXG1JN8SJ6yQTECOTasxe3qwVcBoXDEB64nCMdwfAkgmwlAunITL76ftDhP+vQ0hklza8VPk2zYD+wyzWuIBeoIEyTjpB9yYqJtQuYZ+MDprstyLOFkwFhRUBckANOAPw04HGRsQKmoBphDEPOBBJoyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631612; c=relaxed/relaxed;
	bh=DA4U0m1CHtqk19BjQpd8o6fqolui3N68b+LzMS0kHTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDqkCXPTXFJpI//T27ytPPkfbNGoLTEgJeigYV7IJrCf1XwYEWkeJ20bJ7at0d43ZF3NIuHVQbhMAC5FmpRp2sgFHTPIvuZx3Ix5HV2wKlIfgpbinHsDcQQOJ1EnBN/dBSa0jdGg57n6PrD7mT83v89uUG0M7p40LS6CcbC4F0LW3J6FD8Sq6iD0UcL3boacwSQNPkFHLXClrZlpBqwAE2KXYt9Cl2DsRMks2caIItRQl+Q9JdAEVaw8CrVc9XDJVv+BND7uoz8mBLIVSlu3brxzrR3hiJlcce/CRRVIRHjJvdZ0ZozT/u7P7aWT9Ga6xmEVT8Prol/c9wub4K8D0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIejajPL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIejajPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFHb1k7sz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:00:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E70C841966;
	Mon,  2 Nov 2026 15:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C201F00A16;
	Mon,  2 Nov 2026 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631608;
	bh=DA4U0m1CHtqk19BjQpd8o6fqolui3N68b+LzMS0kHTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kIejajPLDhBhNAF+5qAkd+IjamKUOnO1hhgOl6ob3NywfSYo1UCCZClj+UVXxg6hN
	 8GZuczs7QvhEz8GqB31Q0v4Sfe6zaLku1E8g4bV1Nm7S11GUdX9udG3+A+XpQmpG4w
	 SKp3yZE5RKwGE6D9RxNOhr665KUXvrAf7U9EgM6t8GMzBMTN1Hyi8S9DzqCn2e/KFT
	 qYkBu+IipshrjT/yGx4WL5OycQQAysKT17bx+VTU/wQ//N1IctW6952TFgl4pmjQUh
	 Zgj0NC/jh4zpBceIV8H3jC5zH7xmHBcraK25zYbCARrQ8e4MvgCvvVFdA3MjVOm0bI
	 x3pJnolxi8+9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:54 +0100
Subject: [PATCH RFC 14/16] fs/proc/vmcore: let procfs copy out reads
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
Message-Id: <20261102-work-procfs-core-v1-14-75df35e4f8b8@kernel.org>
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

Implement ->proc_read_buf() so procfs copies what is read to userspace
after it unpinned the entry. __read_vmcore() fills procfs' buffer
through a kvec iov_iter. So a read goes through that buffer now instead
of straight from the old memory into the reader's, which is what
splice() did already. mmap() isn't affected. On ppc64 a machine check
while reading the old memory used to be recovered through the exception
table of copy_to_user(), by accident. copy_oldmem_page() copies with
_copy_mc_to_iter() now, so a read through procfs' buffer recovers from
it as well.

The buffer is 128k, which keeps the entry pinned for one such piece at
a time, and /proc/vmcore asks for PROC_ENTRY_FULL_READS so that a
larger read is filled in pieces. kexec-tools treats a short read of it
as fatal. A read that faults on its buffer in a later piece returns the
pieces before it now instead of failing with -EFAULT. fadump removes
/proc/vmcore when its memory is released and that no longer waits for a
reader that faults on its buffer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/vmcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index ccb795b85509..1c1e71231f4e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/sizes.h>
 #include <linux/uio.h>
 #include <linux/cc_platform.h>
 #include <asm/io.h>
@@ -427,9 +428,14 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 	return acc;
 }
 
-static ssize_t read_vmcore(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t read_vmcore(struct file *file, char *buf, size_t count,
+			   loff_t *ppos)
 {
-	return __read_vmcore(iter, &iocb->ki_pos);
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
+	return __read_vmcore(&iter, ppos);
 }
 
 /**
@@ -709,9 +715,11 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 #endif
 
 static const struct proc_ops vmcore_proc_ops = {
+	.proc_flags	= PROC_ENTRY_FULL_READS,
 	.proc_open	= open_vmcore,
 	.proc_release	= release_vmcore,
-	.proc_read_iter	= read_vmcore,
+	.proc_read_buf	= read_vmcore,
+	.proc_read_size	= SZ_128K,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
 };

-- 
2.53.0


