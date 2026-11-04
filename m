Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DA8609B65C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxVxzqco
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKblX2vCDz3cQx;
	Thu, 05 Nov 2026 06:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822136;
	cv=none; b=fOgJinnw+eJl7ZFWyeuIZIShz9CqBGQQMcs3mR8wV8S7u4wSHy8t6l8HigK2lHmJuUZH0QXSJJ/lNp3nzS7aXgG3RAobqVxgpYBDwkInFFDKeW0FhPUmwzuE0T+pm3B8splBJFXpCZieEg6fExd55VG2x9gOTwdkXB5pU08mTHrEBeusDxvd/FEAxhDfoHQN5L/yuE4OXm/NE4gUMIQ8HQy4pnt+YhRmGN4/1vuRwufqa+iN0P6eg/qjJK7P+N1mHRlHuc9UpqCKrStdwPEIWzqWUGbYwC9ii2PsN+wjAAbOiZDZtY8Fh/ZUxij0GVeVmUr5H/EwN0CEGNDvby74Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822136; c=relaxed/relaxed;
	bh=C2fJYdTojRFSaODFdjPHql9M0bzE3FJwr1E018LBBO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtW/T3aTBS4Q/1HECUii8waZX9IqZLlQYUFwtezTtp6jjGs5oW9hDzKzIMiOG66wAtFc3mZCyajWcDlCoGQj66ZQ//8GMttpSppjMq0gbLoNM48vqLz+ug0xNxVC4x3AwmhY/aIPBaqWjhNDiQM1wQpsRvE9ZspWkbU9QU79rsRWyfjytoiy25Ot8GceNAuOJVSSgb69Ggpa51kuVVOsq7H8xf3EA2LVIWNxJM2tNm1v+EqT6zlsiHsi3Ls8FVj40PtoXXlWTJYCAtsMdBP17w7GeLlWSsbR9/nCLq8pemoSrBCHbJgqaXkdAaZdQXrHz6GDdEj8QKUmtdCQsswEgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxVxzqco; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxVxzqco;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKblW4ZNVz3cQs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:55:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A456060F37;
	Wed,  4 Nov 2026 19:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721521F000C1;
	Wed,  4 Nov 2026 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822133;
	bh=C2fJYdTojRFSaODFdjPHql9M0bzE3FJwr1E018LBBO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxVxzqcomPDLAWsqX85EWcLe7WZlzoKJpHDpOQhf+KZ1aYuixFo4RGC5WENxIeYDR
	 pLwBWxDYw0foUZ3wHytSbwfCa7iq8dLIZnc5m2y8FT0LfPDL7Q2pae5sK1fKW87eH/
	 TLoxZJitlHu5XhrmddtW5nHOKeuonavA/4uOaPJGmBoWC6YghAhb5YkhkwxhSp7tHZ
	 SnDT1yEyHPjdo3S7ahmm98p5SQhtKbsglzOsqjH27sqF26J+nVkJrN5qpLWC+cZqHa
	 3bxRMiT/Z2318AVzkaEXIjv3kDFVAW7sr0AInZ9NSC6cPhwH5gTxJMnKg8DEI8HGOJ
	 jel/AuRNeS6+A==
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
Subject: [PATCH RESEND v2 23/30] dyndbg: let procfs copy in writes to /proc/dynamic_debug/control
Date: Wed,  4 Nov 2026 20:55:19 +0100
Message-ID: <20261104-work-procfs-fs-v2-23-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288; i=brauner@kernel.org; h=from:subject:message-id; bh=Awi3L5zR/nArf9JZW1OMhl80jxJR2cXziAHCcuF5CR4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97nHPjBBTr3NykX/wLUHBgNnn4SS7+fVKVwr6yxuXL 0uRqJrSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEb0xn+Fy+YXCV0Oe/Eaz8H 4b8ha/yUgz2teDZt31XB+vfCvnbjCEaGI7bdptPVH0oejHTQsv2wPFNAJufAZvvExUsuC73W+Mv LCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the parsing into ddebug_proc_write_buf() and implement
->proc_write_buf() with it so procfs copies in what is written before
it pins the entry. The debugfs file keeps copying in itself. Writes
larger than USER_BUF_PAGE - 1 bytes to the procfs file now fail with
-EINVAL from procfs instead of -E2BIG, and without the "expected <4096
bytes into control" warning.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 lib/dynamic_debug.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 64a211290872..1d6012c9eb41 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1002,11 +1002,28 @@ __setup("dyndbg=", dyndbg_setup);
  * command text from userspace, parses and executes it.
  */
 #define USER_BUF_PAGE 4096
+
+static ssize_t ddebug_proc_write_buf(struct file *file, char *buf, size_t len,
+				     loff_t *offp)
+{
+	int ret;
+
+	if (len == 0)
+		return 0;
+	v2pr_info("read %zu bytes from userspace\n", len);
+
+	ret = ddebug_exec_queries(buf, NULL);
+	if (ret < 0)
+		return ret;
+
+	*offp += len;
+	return len;
+}
+
 static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 				  size_t len, loff_t *offp)
 {
-	char *tmpbuf;
-	int ret;
+	char *tmpbuf __free(kfree) = NULL;
 
 	if (len == 0)
 		return 0;
@@ -1017,15 +1034,7 @@ static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 	tmpbuf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
-	v2pr_info("read %zu bytes from userspace\n", len);
-
-	ret = ddebug_exec_queries(tmpbuf, NULL);
-	kfree(tmpbuf);
-	if (ret < 0)
-		return ret;
-
-	*offp += len;
-	return len;
+	return ddebug_proc_write_buf(file, tmpbuf, len, offp);
 }
 
 /*
@@ -1196,7 +1205,8 @@ static const struct file_operations ddebug_proc_fops = {
 static const struct proc_ops proc_fops = {
 	.proc_seq_ops = &ddebug_proc_seqops,
 	.proc_state_size = sizeof(struct ddebug_iter),
-	.proc_write = ddebug_proc_write
+	.proc_write_buf = ddebug_proc_write_buf,
+	.proc_write_size = USER_BUF_PAGE - 1,
 };
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt,

-- 
2.53.0


