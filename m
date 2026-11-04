Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBF606EEB0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWOls/Qa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb3m3Py8z2yYd;
	Thu, 05 Nov 2026 06:24:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820276;
	cv=none; b=Eip5KT1+7tOjNCbDAXnqA1dSIGmaog4ScdyqZKz4efApMRDyLXoKUksyVaGxGHxesfDXV7YNIzr89nM9CawFV7L7r3H9DbbJJIwPmnMfMEF3NBB3sGp9Frqz6DF/ZM4K5z8lJE/hQiDr/el9rnRRUYi6CaLJa9QoaQilmIi25+pQ25Xb8CB/72skFCTurE/aV0sQP0Vs6oN032lgKg9wjhvVcBwPJI/o2XIU8+sAxu8R21KCNSfM8oxWcjVQ7FDBN7jJ3QZp9UEvTI2JlUThJUhT5jFq+FJ9mcnHONT7YwzYwj6iLIuBrQJpJf47ezQyEMSy37flgqQEgN4OKrNlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820276; c=relaxed/relaxed;
	bh=iZnPQiZm1xh8fsSdf/bokwm1XgR51VX0qi8vvYA3hwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlTBNV2WH1qSQAb1T0GuPdrhvhvZ52p94jVQJ0LPD+aV/s9h/zRXMVAaYd7ZkICR6XwIhreHGvHYRszazHwf7docS1SyOoThbq9OHHqsvcSajC9/kzmdMpTQF0VdB/AGt76EZiYQKlCiQjuNkl8pAcBGLBYCV8htUM6G906RfR3epks1aCcdRT5AUm4U5Mz/z4Q3t0CLPdQeVaN5l8yt7HrhxJ2trdGb0PL2nBnNjbG/51zsvPk44rbOyfosxKXck2uWJpWgmHGc+LymvIfQX3YJ+w0n1nT7Sb+bpOeaBJxzKcM1aOrzfz832fVjXjRBWNS3/KrinF17dWRggd5LBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWOls/Qa; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWOls/Qa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb3l4sM5z2y89
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:24:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8933B60D7D;
	Wed,  4 Nov 2026 19:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D91F00919;
	Wed,  4 Nov 2026 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820273;
	bh=iZnPQiZm1xh8fsSdf/bokwm1XgR51VX0qi8vvYA3hwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWOls/Qat2i8BrXb5K71S2uLB9tj4kjTJEbo9UFvy20m8JsJIw6rlM5z7ZgXmAhhg
	 DX3SJAZObSbZ0q10m0cO34TgAflLOcPAP+hEY5fVaKi7i6rKXFInKLNWloaYRSC+Ks
	 ljGOlefMkwlxlumGHgHWbLc97n+0vZptHyvo04WmKfXqk+oQZSwiVP5UbhoSw45CC9
	 o7GTWTT7YXcs5JwSCwntnLmjdKmMt8KgGm4sAZYEtS+zlJv61izpcMBFUi+CEbW/Cc
	 xRBz49tKkDksLfYIDDAGshWSF63L9oy+SRRSZVZWhxGUtwnTpG3FVQOlOfqrJXfy1c
	 nLtmp96X09lUw==
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
Subject: [PATCH RESEND v2 34/51] proc: let proc_remove() remove the entry it was given
Date: Wed,  4 Nov 2026 20:24:18 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-34-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4142; i=brauner@kernel.org; h=from:subject:message-id; bh=TWEC0A9DF1l/jNuw2UHiBUJ2nMkOgHxIGSf9WilEatA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bvyaox39LcDtqOvRJ4ZbOT4aq194fNEiYOO6+EM7j 5os/VhY1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARG32GP1wXpkhH8H/asV76 WPuPyH/OaVaTHH7dNBF8c4GtfEmftRfD//g/MT/EQt8lq2eISbw5HcGTbfBAPPZ1g/kbd1/h09/ keAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_remove() looks the entry up by its name in its parent and removes
whatever it finds there:

  remove_proc_subtree(de->name, de->parent);

If the entry was removed already, say along with its parent, that is
either nothing or a different entry that got the same name in the
meantime, and de->parent may well be gone. Two removals of the same
entry are a bug in the caller, but going by the name turns it into
removing an entry that belongs to somebody else.

Since commit 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()")
an entry that was unlinked has an empty rb node. So check for that
under proc_subdir_lock and otherwise remove the entry itself, with the
loop of remove_proc_subtree() moved into a helper both of them use.
Nothing can help a caller that passes an entry that has been freed
already.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: a8ca16ea7b0a ("proc: Supply a function to remove a proc entry by PDE")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c | 78 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 588999058e66..9a0a2fcac7c7 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -818,33 +818,14 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 }
 EXPORT_SYMBOL(remove_proc_entry);
 
-int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
+/*
+ * Remove @root, already erased from its parent, and everything below it.
+ * Called with proc_subdir_lock held for writing, returns with it dropped.
+ */
+static int __remove_proc_subtree(struct proc_dir_entry *root)
 {
-	struct proc_dir_entry *root = NULL, *de, *next;
-	const char *fn = name;
-	unsigned int len;
-
-	write_lock(&proc_subdir_lock);
-	if (__xlate_proc_name(name, &parent, &fn) != 0) {
-		write_unlock(&proc_subdir_lock);
-		return -ENOENT;
-	}
-	len = strlen(fn);
+	struct proc_dir_entry *de = root, *next;
 
-	root = pde_subdir_find(parent, fn, len);
-	if (!root) {
-		write_unlock(&proc_subdir_lock);
-		return -ENOENT;
-	}
-	if (unlikely(pde_is_permanent(root))) {
-		write_unlock(&proc_subdir_lock);
-		WARN(1, "removing permanent /proc entry '%s/%s'",
-			root->parent->name, root->name);
-		return -EINVAL;
-	}
-	pde_erase(root, parent);
-
-	de = root;
 	while (1) {
 		next = pde_subdir_first(de);
 		if (next) {
@@ -872,6 +853,34 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 	pde_put(root);
 	return 0;
 }
+
+int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *root = NULL;
+	const char *fn = name;
+	unsigned int len;
+
+	write_lock(&proc_subdir_lock);
+	if (__xlate_proc_name(name, &parent, &fn) != 0) {
+		write_unlock(&proc_subdir_lock);
+		return -ENOENT;
+	}
+	len = strlen(fn);
+
+	root = pde_subdir_find(parent, fn, len);
+	if (!root) {
+		write_unlock(&proc_subdir_lock);
+		return -ENOENT;
+	}
+	if (unlikely(pde_is_permanent(root))) {
+		write_unlock(&proc_subdir_lock);
+		WARN(1, "removing permanent /proc entry '%s/%s'",
+			root->parent->name, root->name);
+		return -EINVAL;
+	}
+	pde_erase(root, parent);
+	return __remove_proc_subtree(root);
+}
 EXPORT_SYMBOL(remove_proc_subtree);
 
 void *proc_get_parent_data(const struct inode *inode)
@@ -883,8 +892,23 @@ EXPORT_SYMBOL_GPL(proc_get_parent_data);
 
 void proc_remove(struct proc_dir_entry *de)
 {
-	if (de)
-		remove_proc_subtree(de->name, de->parent);
+	if (!de)
+		return;
+
+	write_lock(&proc_subdir_lock);
+	/* Removed already, maybe along with its parent. */
+	if (RB_EMPTY_NODE(&de->subdir_node)) {
+		write_unlock(&proc_subdir_lock);
+		return;
+	}
+	if (unlikely(pde_is_permanent(de))) {
+		write_unlock(&proc_subdir_lock);
+		WARN(1, "removing permanent /proc entry '%s/%s'",
+		     de->parent->name, de->name);
+		return;
+	}
+	pde_erase(de, de->parent);
+	__remove_proc_subtree(de);
 }
 EXPORT_SYMBOL(proc_remove);
 

-- 
2.53.0


