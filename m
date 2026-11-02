Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52773608362F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYBs0GAF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFtS0WX9z3bcj;
	Tue, 03 Nov 2026 02:26:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633216;
	cv=none; b=BKSc5UDC8M6oUvQivOH8Z56/OpGVka3ifFrkhn/+XTBpyUYA1HzkcvwKbc9pNNvRL4HgoPk49XYCTszoWhJeSzw0y7tgbgWBge6ACj6siyM3OnYX6nTFJWulkSgHNvwS4vd/kIaXJ2M7d9wq8dQZcap5tuPIkiRou7x3grataJwpH5f2LZn+wBnksN9cQFkT9hTLHG38juLqPYk7plYGXEvUlaG5OGaP3wG/1zc/2T45J8bvrek/m1nhmOVt5O5iL3N96dRu1nv3jc+CKFo/9vD8kB4x/Bhf4aQc9wenLJt4gNkV3M9zyitQkc7aO+bbDAGgx2qoExvF3myETH0TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633216; c=relaxed/relaxed;
	bh=5GRAUZH2kX1HsIdPeFBozE83iEr60/LUxZUEqoYcqBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFX911waTMm1Z1AuDzAnFZppwoCt5r8Xm2SOU1dwzvBcqMyHMprwRQojHSdde7hMWgFNzmPUg9RXeTw16DO/dAdn0+XqBdJYQVuEw8Q1TNpMHYuU04S0KuZkJXq9mjKnpDo6OSVZSw4laEdNNj88UZ8IkbnCkU6LmE2pZUNq2t4bNaeHUkqh33vQdgkNrHbHF/mc+t+LupK4nr1Ek+eT//r/V/KeVsvUlYcbP1TAFrg0cG1r1CM8Fyc+6Fp0EJjBZdUydE0JVPuspHH1J8O2sP8f4Q8BuYh4SrUd3MYDisFz/zMtStUHBkpED3JPg5Awz27E+0WNyXyDSvXNbmiFXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYBs0GAF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYBs0GAF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFtR27Fmz3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:26:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C642B404E4;
	Mon,  2 Nov 2026 15:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FDA1F00A16;
	Mon,  2 Nov 2026 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633213;
	bh=5GRAUZH2kX1HsIdPeFBozE83iEr60/LUxZUEqoYcqBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nYBs0GAF8b3S0eatIZoAhddTaBQQ/i0CrcM92EglgsZZbWpy731ExatrOh40qewLF
	 Lp8S7Rrut+eO6q6LdIfOUD8IT/maYnyF1DBExnOFJG7mwcNuHGN5jv9pNZ9AuWREId
	 lnOMTthrQoRObRBolVjhYcHCSAlAi4r+kE39L/TCDTKs5S84hkUHNI6KoriDtYwBpI
	 U0fE3C6vht9Hwk8FIpEHBtzNae5orDp4ap1DfxmedQEVe2FH237hpiNUepRwcWVPa9
	 eKW1KUqWkYD6wrjns7QIlZcwyB9vCaN2c35pIVU6Iu87SgiaL5+rLK2WDEDvulHZL8
	 tBantGPOqqkGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:30 +0100
Subject: [PATCH RFC 20/27] module: procfs: let procfs own the seq_file of
 /proc/modules
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
Message-Id: <20261102-work-procfs-fs-v1-20-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=brauner@kernel.org;
 h=from:subject:message-id; bh=flwsY9W3AwD1el1fvMS4MRjAzw7empBDyCTwiYsv/MA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG50+lPbWr8TO3/XJX642z+55KDeRh0pIW9bi1VZ/
 MvKft0s7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIpwUjwwyex5oMWjNmXVW1
 TDi5fH3+9vUsj5XnVPa/nJM/5XDQTDNGhsPvYp7dK/9aPKFSfO5H07Jd/XPz+O2FRZWOr7PQyLs
 rzAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() only decides whether to hide the addresses now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/module/procfs.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 90712aa9dd13..a759bd916df7 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -117,31 +117,24 @@ static const struct seq_operations modules_op = {
 };
 
 /*
- * This also sets the "private" pointer to non-NULL if the
- * kernel pointers should be hidden (so you can just test
+ * procfs opens the seq_file. This sets the "private" pointer to non-NULL
+ * if the kernel pointers should be hidden (so you can just test
  * "m->private" to see if you should keep the values private).
  *
  * We use the same logic as for /proc/kallsyms.
  */
 static int modules_open(struct inode *inode, struct file *file)
 {
-	int err = seq_open(file, &modules_op);
+	struct seq_file *m = file->private_data;
 
-	if (!err) {
-		struct seq_file *m = file->private_data;
-
-		m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
-	}
-
-	return err;
+	m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
+	return 0;
 }
 
 static const struct proc_ops modules_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_seq_ops	= &modules_op,
 	.proc_open	= modules_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
 };
 
 static int __init proc_modules_init(void)

-- 
2.53.0


