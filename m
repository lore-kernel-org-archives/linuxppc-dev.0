Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C16096924
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRuzWbzB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbhj35nbz3dSM;
	Thu, 05 Nov 2026 06:53:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821989;
	cv=none; b=oTczgP+U/dp7TGFZeGZM6pku3M7b9NCuJzkwP0MuzV9/YmjhX4X3tUTgL5pNpEY0+rvv0TAAimQrAj2HnW/ZtvfVrhXtLS4Fw19KT/6CcZuR4jiMgPLFswPDlKGj+4RYd7HcSU5GSFeEP4pDZUptQjsvTr0V4z+CJZ+4LjjTkJl3twDVcPqGIJIDsGIj57jF/zWvpS5lSMyYeEuy6Fi8BibeLIaQjEe3hKRPM045Mz+5d1EXhG2/cpxpd08riwtxKNVwTahig2vIKrCO3HAu6H/454Hj4aVMwuDSTJGr31sECjEaOYhOzNf+ZJFB3RhIEpRaeqiakWcixFg3VdQiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821989; c=relaxed/relaxed;
	bh=0DA6RuBvRtTkFqswtNQb2uYlEiZpU59l9tIHU1Ga2j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY+Q6nhJLcr2kONKafjcbTapC5wQJq81iHGFNzXQCf2JYaQ8yrWd/6rH2/h8XExQsUFo/GdbIbGb/XCQGypc8pz57K/w6FcnZ1fDlZFpztDZoq4J0wr0MWCPfCaxctA3t+5YZ5WYWQt25aCsgEsdBnb7NFc63WbWJ959e8L0BQ/uNOCuBm5vw3faXU2BqMmp6rTpeVa2dAhAHyTiANNK8ewa4AIn4PuYFmxVV0Et18VeY4cxzjLp0oOFquXxhdV2Zv5FSw4XQYzddMhACTeybUAIAxl9MtaVy4jtU9d88pXnCjsOh7YEZpDpT7RKOtE4Vq5PROmnKMn7dWytSPjiKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRuzWbzB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRuzWbzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbhh4KBjz3dSK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:53:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3A9060F18;
	Wed,  4 Nov 2026 19:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630E91F000C1;
	Wed,  4 Nov 2026 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821986;
	bh=0DA6RuBvRtTkFqswtNQb2uYlEiZpU59l9tIHU1Ga2j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRuzWbzBA/Ayk18PSyfBxT/OLXbTcYla80E66c/JAUTNKWwvu8J+iV96HiiS6uEcH
	 QHS7YxPFtx6Ioglu8rsGqiQzEoeQ8bEbGSKEx4XN8omB6KX5mlTYTqW0Wk6eUgmEQB
	 B+z770ZN0h6sM7vDGdXR9zfXGIS1XJndXGgje4DTMOIYeLURXu2T1GmuCPMzPMxK7S
	 nurIEXlnG0ZIr4a8/L+heetwhEB8F1E5hs5NCWlfyBW+GWY4C/S4AmxGoDaGeMs9Vs
	 f5F7cAhX60Ts55MnyTtdNSbrqHrZaPAO/QFQ6TbKEkPr3xHro9JRcDthamnh6QpgBO
	 gt08JD3Kfhntg==
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
Subject: [PATCH RESEND v2 13/30] locking/lockdep: let procfs copy in writes to /proc/lock_stat
Date: Wed,  4 Nov 2026 20:52:51 +0100
Message-ID: <20261104-work-procfs-fs-v2-13-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=brauner@kernel.org; h=from:subject:message-id; bh=8vcSfGoyDeqLJaquRqiN2D+SQsNeRK8HAS3H3FbecE8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97rEyKlv/n0U+Ncf4zZ0z/k8rXxQFN5xqvbLjdI24b /iyrX7bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSJsLIsDDpMX+EXH+FfOlz /4uiJpUibR6mKrvnlKufSe+7ojVxOyPDsftVl+Qu1LCnTp70o3zhxgUrJCWyJ/n6XbbhU5x210y eCQA=
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
it pins the entry, and look at the first character of that copy. Writes
larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/locking/lockdep_proc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9b034b5b94bd..2a66ea09c2aa 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -669,18 +669,14 @@ static int lock_stat_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t lock_stat_write(struct file *file, const char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t lock_stat_write(struct file *file, char *buf, size_t count,
+			       loff_t *ppos)
 {
 	struct lock_class *class;
 	unsigned long idx;
-	char c;
 
 	if (count) {
-		if (get_user(c, buf))
-			return -EFAULT;
-
-		if (c != '0')
+		if (buf[0] != '0')
 			return count;
 
 		iterate_lock_classes(idx, class) {
@@ -703,7 +699,7 @@ static int lock_stat_release(struct inode *inode, struct file *file)
 static const struct proc_ops lock_stat_proc_ops = {
 	.proc_seq_ops	= &lockstat_ops,
 	.proc_open	= lock_stat_open,
-	.proc_write	= lock_stat_write,
+	.proc_write_buf	= lock_stat_write,
 	.proc_release	= lock_stat_release,
 };
 #endif /* CONFIG_LOCK_STAT */

-- 
2.53.0


