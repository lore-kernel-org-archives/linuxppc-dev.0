Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA493607076C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwuYQ/g0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb6b4VDnz2yd7;
	Thu, 05 Nov 2026 06:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820423;
	cv=none; b=mu7f9X4/r6xRXfIDKNWfkphuRd+ez8xHB2uPm2wBgGmQjTj/buJ30RYlZAhggJosBFj43XpuYosfhrweB7VFko+JgPPbMGF/44dUbNd+oBi+i7Q0NA2/Ds5YWyrnbjhYninBlCWhO2gy7+hlwoYn5sp09Jq17A4madUPB3EifyAspNZ9nZHBghYAj6AGv+BZv0nXSRPOeNXOqP/SzlfmU5RGCWDcrQhuLteh6wfncHBFVFO4sJKbA2wfBdr+axPcI3TMDXubhTNXVKA6MRaFgK1ChysdyCr8b4EgOG/4CY8FB4NOmNH8K6s//TiueMLvDrpB7B4twi8bLmBULpMYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820423; c=relaxed/relaxed;
	bh=7+iLqul4i6MH7HabpPra1XD+cE9kLUhjlQUujW+Foac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLW6fEBoctI+91eH5d/ms5I9r8KrfuACs9uhpvAF3MeS/IlqRvbxglYCLom38yoqhjtzTvHf8f87SzjSJUiR249HjDwqgh3TdECMtTIzlzZuXDULbYFSKpEg1gfGyC9avynyWrgz48gDn6FcIRXiSxiOywDcLlzTfd9jCliRUQ0aXu0VmKvMfi8N9tFCpVZp7J0rB5wvarcrUO/53l/o8qw0zRj5PblJLfSo3LyaxvtBWdOFh2TT7V9RkntZx2lpkV/vWVLnU+idLOsqSoFdgoiZ/5+WNH4OLR5E1Fz7lLfV/ZT9V9dyusox0PgDW4aQv8VjPka2Gt/E9aOsIjQdug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwuYQ/g0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwuYQ/g0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb6Z34Qzz2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:27:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7399343501;
	Wed,  4 Nov 2026 19:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7056C1F000C1;
	Wed,  4 Nov 2026 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820420;
	bh=7+iLqul4i6MH7HabpPra1XD+cE9kLUhjlQUujW+Foac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwuYQ/g05s3gCBWqi01st+AhG7zHew/xp8Uznvwn+sDxcWbOQHDx0K6MiMNaJlMnn
	 FmRdPCKm7fkDETjs85IQuGrygG0+Kztae+2biv7affNlVGZa+740Q3EgS6bHLXzDAV
	 aZg/kj7ORMq3jG1VJUSRX7BspNpMXg05Y19bYI5nFwDkTbUCy7DkbcjACUCYm39cJL
	 1hjnL/Y8r5QEdR/ZG6gyEzvVACpd4uA3340dvWdaCzuD2XUKV78V0T86RZ4/PTZxmN
	 6DWlsLGZikNjgCiYO3E2b9BOArDy2vTby4LS8qdcZoBLlt+6sqSyJxYEok/M8LmEf+
	 KqqS4SWhqzhlw==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the last name it returned
Date: Wed,  4 Nov 2026 20:26:46 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6631; i=brauner@kernel.org; h=from:subject:message-id; bh=KA4vlzE2TMzRxzNzG7ghDFHvczKD3qjxMkOpFlB4RO0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bmKaP+1dqtKk7Ry8h36o7w8+8ED+es07ge0M3E7bf EVjbtyc0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRo+YM/xQP2S46ukZlhay/ dM9N5vuX+JaYFXVstFEvOrL+mO15sy0M//3tvzCq2Bx6uWV+/uS+iG11xZcyBKb+navC/L3kW8y Go9wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_sys_readdir() counts the entries of a directory and resumes a
listing at the number getdents64() stopped at. The entries are sorted
by name, so one that is registered or unregistered in between shifts
everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
buffer that holds ".", ".." and "all" and registering a device whose
name sorts before "all" makes the next call return "all" a second time.
Unregistering one that sorted before the position makes it skip an
entry instead. So a listing that takes more than one call shows a name
twice, or not at all. Even the 64k buffer of ls needs a second call to
find the end of the directory, so a device that comes up right then
repeats the last entry.

So remember the name of the last entry a call emitted in the file and
resume at the first usable entry after it, like kernfs resumes after
the node it stopped at. The entry itself can't be pinned across calls,
unregistering waits for that. If the position was moved by a seek in
between the listing counts from the start like before, seeking to an
arbitrary position has never been better than that.

That also takes one walk down the tree to resume instead of a walk over
every entry in front of the position with a round trip through
sysctl_lock for each of them.

Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/proc_sysctl.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b4a309d49698..ba52f13eb8f3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -417,6 +417,54 @@ static void next_entry(struct ctl_table_header **phead, const struct ctl_table *
 	*pentry = entry;
 }
 
+/*
+ * The first usable entry of @dir after @name, or the first one at all for a
+ * NULL @name. The entries are sorted by name, so that is where a listing
+ * resumes when entries in front of it came or went in between. -ENOENT if
+ * the directory is being unregistered.
+ */
+static int entry_after(struct ctl_dir *dir, const char *name, int namelen,
+		       struct ctl_table_header **phead,
+		       const struct ctl_table **pentry)
+{
+	struct ctl_table_header *head = NULL;
+	const struct ctl_table *entry = NULL;
+	struct rb_node *node, *after = NULL;
+	struct ctl_node *ctl_node;
+
+	spin_lock(&sysctl_lock);
+	if (unlikely(dir->header.unregistering)) {
+		spin_unlock(&sysctl_lock);
+		return -ENOENT;
+	}
+	if (!name) {
+		after = rb_first(&dir->root);
+	} else for (node = dir->root.rb_node; node;) {
+		const struct ctl_table *table;
+		struct ctl_table_header *h;
+
+		ctl_node = rb_entry(node, struct ctl_node, node);
+		h = ctl_node->header;
+		table = &h->ctl_table[ctl_node - h->node];
+		if (namecmp(table->procname, strlen(table->procname),
+			    name, namelen) > 0) {
+			after = node;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+	ctl_node = first_usable_entry(after);
+	spin_unlock(&sysctl_lock);
+	if (ctl_node) {
+		head = ctl_node->header;
+		entry = &head->ctl_table[ctl_node - head->node];
+	}
+	*phead = head;
+	*pentry = entry;
+	return 0;
+}
+
 /*
  * sysctl_perm does NOT grant the superuser all rights automatically, because
  * some sysctl variables are readonly even to root.
@@ -675,6 +723,36 @@ out:
 	return ret;
 }
 
+/*
+ * Where the next readdir resumes. The entries are counted, so one that is
+ * registered or unregistered in front of the position would shift what
+ * the next call returns. The name of the last entry emitted doesn't move.
+ */
+struct sysctl_cursor {
+	loff_t pos;			/* the position behind the entry */
+	int len;
+	char name[NAME_MAX + 1];
+};
+
+/* If this can't remember the entry the next call counts from the start. */
+static void sysctl_cursor_set(struct file *file, const char *name, int len,
+			      loff_t pos)
+{
+	struct sysctl_cursor *cursor = file->private_data;
+
+	if (len > NAME_MAX)
+		return;
+	if (!cursor) {
+		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL);
+		if (!cursor)
+			return;
+		file->private_data = cursor;
+	}
+	cursor->pos = pos;
+	cursor->len = len;
+	memcpy(cursor->name, name, len);
+}
+
 static bool proc_sys_fill_cache(struct file *file,
 				struct dir_context *ctx,
 				struct ctl_table_header *head,
@@ -756,8 +834,11 @@ static int scan(struct ctl_table_header *head, const struct ctl_table *table,
 	else
 		res = proc_sys_fill_cache(file, ctx, head, table);
 
-	if (res)
+	if (res) {
 		ctx->pos = *pos;
+		sysctl_cursor_set(file, table->procname, strlen(table->procname),
+				  ctx->pos);
+	}
 
 	return res;
 }
@@ -765,6 +846,7 @@ static int scan(struct ctl_table_header *head, const struct ctl_table *table,
 static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct ctl_table_header *head = grab_header(file_inode(file));
+	struct sysctl_cursor *cursor = file->private_data;
 	struct ctl_table_header *h = NULL;
 	const struct ctl_table *entry;
 	struct ctl_dir *ctl_dir;
@@ -778,9 +860,20 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		goto out;
 
-	pos = 2;
+	/*
+	 * Resume after the last entry the previous call emitted. Only a seek
+	 * that moved the position away from it counts from the start, like
+	 * seeking to an arbitrary position always did.
+	 */
+	if (cursor && cursor->pos == ctx->pos) {
+		entry_after(ctl_dir, cursor->name, cursor->len, &h, &entry);
+		pos = ctx->pos;
+	} else {
+		first_entry(ctl_dir, &h, &entry);
+		pos = 2;
+	}
 
-	for (first_entry(ctl_dir, &h, &entry); h; next_entry(&h, &entry)) {
+	for (; h; next_entry(&h, &entry)) {
 		if (!scan(h, entry, &pos, file, ctx)) {
 			sysctl_head_finish(h);
 			break;
@@ -791,6 +884,12 @@ out:
 	return 0;
 }
 
+static int proc_sys_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
 static int proc_sys_permission(const struct mnt_idmap *idmap,
 			       struct inode *inode, int mask)
 {
@@ -870,6 +969,7 @@ static const struct file_operations proc_sys_dir_file_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_sys_readdir,
 	.llseek		= generic_file_llseek,
+	.release	= proc_sys_dir_release,
 };
 
 static const struct inode_operations proc_sys_inode_operations = {

-- 
2.53.0


