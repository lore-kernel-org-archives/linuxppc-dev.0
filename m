Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688160DE2E5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlfLyMWw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbjG6qJSz3dTC;
	Thu, 05 Nov 2026 06:53:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822018;
	cv=none; b=WZJlkQMOB8e9BGtxwtctdKjFUUXQAKPQnI7NTnSX4q5RMuuPo7qut/vx5l25XuKtaVqBeRpcaLQPBpMQHKusbT8iHCJi82BVCKKbeA+GJlkxbbFs82fNgGGQupBaQoQMxhj48B4mzkO7Vot6uB/E4Eh7dEXiuKb2I0VJsRY2aU/pPmPQvJyJr1P5JOEW6LbAAfromY2LSe5PL8q8yLVfINos0LA2EAswbYg06+8IQxZ17YE2DsEvTEGdArwGX2q0YS6yhvKW5Zmzg5mfOo+JnfkDjuGyF4OdhAFzBvCXkQfZMjAT44PkJcweBM284hseXMxkRbw1rqx4jyzs4HBLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822018; c=relaxed/relaxed;
	bh=dsg9KbFNlQBgwAedsKmZy7BqjgWqOw9kCQlCnQdMJZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDRGKb8EtHZddvcOw2mxClMFqDCNg2eOPI56bi1K1cdb++G4gZ2VCSFeYU8jyF+9++9huJ1uLHFygQpeKS/jeXwm3pi08cB9Ghx2YHifH6+3kLJtybusw6RruJScJo7Y0YT9FtEv/xBpXqG9TVPXoa1sE+Ak59Z56hmGHvBXwilA1VrWuxdtFH+cE+j0f8DXj3sAWYh9Rg4VR4wfb4NDkYrPkQTKuYYXBCpRUTsC7Kl2fedDsvETwVnMnXg+IgsvHmNW3BY0jw0ppZc+pgE5Dq4JcNMij6asBSMvPZp2a5pFtLkK5rIyQGuLPhKsE4eoXHIcY3VsvPAk0hC2nVfpMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlfLyMWw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlfLyMWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbjG1rXDz3c53
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:53:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BCC9742B35;
	Wed,  4 Nov 2026 19:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665591F000C1;
	Wed,  4 Nov 2026 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822016;
	bh=dsg9KbFNlQBgwAedsKmZy7BqjgWqOw9kCQlCnQdMJZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlfLyMWw9PMWft6v3dWdKtEemNCAsc/h/WCr0nG5tqlw1sEQtAckqBhAP9iFKJgWf
	 27ncRmg1m8lM73l7BGvThX+mkSAof45Ljqmi9lCmiTMRbF9fM1X3/mBBhBzPydmlAO
	 DeHW3949SPOMNs+43V9Xli1roY8qLNOykPE7+vV4aJTQWW190ZkX74Zo7Zh8U+HHhP
	 d/XnnzDuQDPFQtiKceof0EppiONyIpR9s/hpjh94Xmy2AYlTdqUDnq8Cy13OVzhv5Y
	 x7sNbPQYQHvpSi8Y3OICpdiWEC+Zjh63M8mM9daa/pACN3UkdTLxiq8kpclsKBgWoi
	 4kSRU+9L7gicQ==
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
Subject: [PATCH RESEND v2 15/30] profiling: let procfs copy out reads of /proc/profile
Date: Wed,  4 Nov 2026 20:53:22 +0100
Message-ID: <20261104-work-procfs-fs-v2-15-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059; i=brauner@kernel.org; h=from:subject:message-id; bh=gnVLSy2PYfESjxmb08z8Yz7ZqLCo2VlJ7LnvjQbbWNo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97rF59HT+zup9O3ZGTf/0yHBfocWfFwsvSv5eJLh9v abrT7/nUzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmUvSD4Z/pxPOtqj0nL7pp FThnlOS/03fdYCfgm5H+M+Bo0z2DeWIM/9O8Ilp05sv4X7J9I23pz7LGW/N/3/7A04qK/L5CxZM 1uQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fill the buffer procfs hands to ->proc_read_buf() instead of reading
straight into userspace. readprofile reads the whole file in one go, so
ask for PROC_ENTRY_FULL_READS and procfs fills such a read in pieces.
The file is read through ->read_iter() now, so sendfile() and splice()
work on it like on the other converted entries.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index dc2db66a77d2..64f6a45834b1 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -142,7 +142,6 @@ void profile_tick(int type)
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/uaccess.h>
 
 /*
  * This function accesses profiling information. The returned data is
@@ -151,7 +150,7 @@ void profile_tick(int type)
  * get meaningful info out of these data.
  */
 static ssize_t
-read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+read_profile(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
 	ssize_t read;
@@ -165,13 +164,11 @@ read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	read = 0;
 
 	while (p < sizeof(unsigned int) && count > 0) {
-		if (put_user(*((char *)(&sample_step)+p), buf))
-			return -EFAULT;
+		*buf = *((char *)(&sample_step)+p);
 		buf++; p++; count--; read++;
 	}
 	pnt = (char *)prof_buffer + p - sizeof(atomic_t);
-	if (copy_to_user(buf, (void *)pnt, count))
-		return -EFAULT;
+	memcpy(buf, pnt, count);
 	read += count;
 	*ppos += read;
 	return read;
@@ -206,7 +203,8 @@ static ssize_t write_profile(struct file *file, char *buf, size_t count,
 }
 
 static const struct proc_ops profile_proc_ops = {
-	.proc_read	= read_profile,
+	.proc_flags	= PROC_ENTRY_FULL_READS,
+	.proc_read_buf	= read_profile,
 	.proc_write_buf	= write_profile,
 	.proc_lseek	= default_llseek,
 };

-- 
2.53.0


