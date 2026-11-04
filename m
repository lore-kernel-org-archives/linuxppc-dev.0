Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52A607B566
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdIhkmR8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbHt3YsSz3c3g;
	Thu, 05 Nov 2026 06:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820906;
	cv=none; b=V7rd9GJu+yFcyn/UbxQqQFoNz+Nq+hqJ/LzZwQbe2STgWqaXwnB6ALayBZdyZGuLV6DnuhwTKHA02KcVe3oS7HUaxRPlcGpDaA1DG51zROnvgDhqKmoZoEa6Q0tSYucfztH+4s9y21LvhikQEEH/0z33yYdjgFPaOlEL0P6W9RKNKFQjp3IopKl0piMurt7RwDV0NvMoQlhPpHxrFDNAvhT/85mCwrna3O6BE/wEQE2KOldUvdSnYV3R0ZZJmZkxYtsoGbWbxHEl2UirueP46O8YgubnW60uh8u3roagpaAdreEsuRPZCQQGi2WemykLG5PXLtranis/i5gOxrAcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820906; c=relaxed/relaxed;
	bh=oemelKiySoMOiwqgnAV36fuORtRsmkNeJKV1jFDEe84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMUrNC+I3JmH7Rr4H7KtyZbl4qqUZdAV+TrCp8D/aets6Bv2/irO71UkfC9yKgJstNKSgCCBC9RMqVpfIhEx+4Cgu5+R9qBamQVTK2pr0RuVULqgZW7ytlLbRb+Qelu1qLk3Gn4Jfh8STUl41xeTFD+SOpaVErhpTphTlxqiJXzwL8KN7pvvrDKSs8io8adhIkK1u8rXDV1uQEsxitdS5qBeHAnMc3IFAMSC2Ia9J44odu8HEzUCgWSsP+WJLEB500X8BCBQBer2/VCBbNwVsCnjjMZWMVY9jIVbvH5Fe027sBTk9O8+bpeqil/+ILbZr129n93P1GNh9gLVh38tEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdIhkmR8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdIhkmR8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbHs3nnNz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:35:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 672E160F14;
	Wed,  4 Nov 2026 19:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED851F00A02;
	Wed,  4 Nov 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820903;
	bh=oemelKiySoMOiwqgnAV36fuORtRsmkNeJKV1jFDEe84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NdIhkmR863LfWCMprOyQyV25PD9rqXv4D86G8KwpEpwgu1ew2ly1VSDsSi+vvNYEk
	 pdiZGLaYCfcSpolU08dh2Ox1XpOziHjEMF9eLPIDzoTncs0uTQyA6t8IDEFXhb5uJs
	 MRInNSukyF1lX2N30J/c9l2JglsG5ux7QFyq1uyq7vfLaPRQQlR15nRd48a3wYrcj6
	 lZnjRRg76YYo/mMbP1lvf4rqBK45QGvet6xWqoa/QxNtd7fbtopkQWoQ70/UsVkZ5X
	 A0w5KwPb7M+lvH7D74CrzGbvuZKc4J2ZdYCBgX0hv6j2ovnkrXSc22NLiSnmZ4i+5N
	 tZ+4a/qMfQlag==
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
Subject: [PATCH RESEND v2 23/23] Documentation: seq_file: describe how a /proc file uses seq_file
Date: Wed,  4 Nov 2026 20:34:48 +0100
Message-ID: <20261104-work-procfs-core-v2-23-76ace653a773@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403; i=brauner@kernel.org; h=from:subject:message-id; bh=6aFABatdXquU8hYCBft2XO0RwrbgVBBoDcjFdlGJCdI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bu999ubNM3NDJXcTDjvH6RMe/w9V29r24X7WXYarX YufWirLd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk2jSGf9YGYrvfJiTw13KH 3J79bJLsjXdRNnOFKw4/9t52hvePsgMjw7XgK04OnTPMIvIuqxf1X2w3cXUIes79qe2gRORUuY8 PuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The example in seq_file.rst hands proc_create() file operations built
from an open method that calls seq_open() and from seq_read(),
seq_lseek() and seq_release(). procfs doesn't work that way anymore. It
opens and releases the seq_file itself when the entry declares its
seq_operations or its show function in struct proc_ops. Say so, and
point the extra-simple version at ->proc_show() for /proc files.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/seq_file.rst | 42 ++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/seq_file.rst b/Documentation/filesystems/seq_file.rst
index d753d8177bcb..3e6ff1c1226d 100644
--- a/Documentation/filesystems/seq_file.rst
+++ b/Documentation/filesystems/seq_file.rst
@@ -68,7 +68,7 @@ kernel 3.10. Current versions require the following update::
     -	entry = create_proc_entry("sequence", 0, NULL);
     -	if (entry)
     -		entry->proc_fops = &ct_file_ops;
-    +	entry = proc_create("sequence", 0, NULL, &ct_file_ops);
+    +	entry = proc_create("sequence", 0, NULL, &ct_proc_ops);
 
 The iterator interface
 ======================
@@ -277,9 +277,10 @@ seq_file system, but we have not yet turned them into a file that a user
 can see. Creating a file within the kernel requires, of course, the
 creation of a set of file_operations which implement the operations on that
 file. The seq_file interface provides a set of canned operations which do
-most of the work. The virtual file author still must implement the open()
-method, however, to hook everything up. The open function is often a single
-line, as in the example module::
+most of the work. A file in /proc is special, procfs hooks the seq_file up
+itself, see below. Everywhere else the virtual file author still must
+implement the open() method to do that. The open function is often a
+single line::
 
 	static int ct_open(struct inode *inode, struct file *file)
 	{
@@ -343,19 +344,38 @@ file_operations structure will look like::
 There is also a seq_release_private() which passes the contents of the
 seq_file private field to kfree() before releasing the structure.
 
-The final step is the creation of the /proc file itself. In the example
-code, that is done in the initialization code in the usual way::
+The final step is the creation of the file itself. A file in /proc is
+special here: procfs opens and releases the seq_file itself, so there is
+no open method and no file_operations for it. The entry declares its
+seq_operations in struct proc_ops instead, and the size of a private
+block in proc_state_size if it wants procfs to allocate one like
+seq_open_private() would::
+
+	static const struct proc_ops ct_proc_ops = {
+	        .proc_seq_ops = &ct_seq_ops,
+	};
 
 	static int ct_init(void)
 	{
-	        struct proc_dir_entry *entry;
-
-	        proc_create("sequence", 0, NULL, &ct_file_ops);
+	        proc_create("sequence", 0, NULL, &ct_proc_ops);
 	        return 0;
 	}
 
 	module_init(ct_init);
 
+A ->proc_open() method of such an entry finds the seq_file in
+file->private_data and may set up more state; ->proc_release() releases
+only that. It runs when the entry is removed, which can be while a reader
+is still copying out of the seq_file, so it must leave the seq_file
+alone. procfs only calls into the entry with the entry pinned, between
+start() and stop() like in its other methods, so nothing that runs there
+may wait for something a reader can hold while it copies to userspace,
+like the seq_file's lock.
+An entry that wants to start out with a larger buffer, like
+single_open_size() gives, calls seq_preallocate() from ->proc_open().
+The file_operations above are what a file elsewhere, in debugfs for
+example, uses.
+
 And that is pretty much it.
 
 
@@ -394,3 +414,7 @@ value given to single_open() can be found in the private field of the
 seq_file structure. When using single_open(), the programmer should use
 single_release() instead of seq_release() in the file_operations structure
 to avoid a memory leak.
+
+A file in /proc puts the show() function into the proc_show field of its
+struct proc_ops instead and procfs does the rest, with the entry's data in
+the private field of the seq_file structure.

-- 
2.53.0


