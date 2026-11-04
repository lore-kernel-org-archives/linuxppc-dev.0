Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857716090499
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYsPe7EK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbdF2373z3c58;
	Thu, 05 Nov 2026 06:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821809;
	cv=none; b=kN8ecKFl9Qfj7ourrBn3pXLQknWZQdGwvibIGXLni1GJX96APQYyfIdf6d6uAJD0KXqr0K9BOI2BhoaAqj+VB4keTFna8RlaAf8qpdwzLENwIBz+SA5DoYId52K8K7VQHVUgMjlAwW8s9Fe9s/72mxciXULN4naaso7WTa4L29+FGcBENqcOZqtQc5SEUSa/SWtYzwMoIhp0q1PWiz7oaptWHYhuzPxIPXbJuWL8/AFvuyU5koZ3v+skdrSH+wZvmKVwvpkDwZlUJ/pzISLO0OyiHqFRisxAUUv+vcqBDqAcR68eKSOEA4F7T989+hQVbYXOo/T2WWuh+QBTdYaBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821809; c=relaxed/relaxed;
	bh=o8L0vvGY5Km24xgHgPbylEP8c5DuS625RCEauDmBOHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSfl3tNWUX/VXjKG0AB4S+msbjGt4Pe0QRcdcHGD1lsLwiFByyR/TripaeiB0optsMMAEMdd4Ts0flc5OLoWShCDo5DqADytNR9L+6mh703rTkTd0g5RfapglJ40bGci760H+5FpjexKMwk/ejxS8w54gyi78JhrVyM03iAajOAIMpOTOc9jYgDreghKNTHUDaO3J/8FOOBv3ghUUXbLFJ3YLKYoGfkO7T1Jm7eS9f812TsgeEGlgy6XVwD0HLN7gkFDfZJZMWF1ueIB/nAKErfeBTrL8pA81ROBCJM77RfcfcLaUDCUgLx0swyRu7+dEX4RZgqw/RQFUGVx6KouOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYsPe7EK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYsPe7EK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbdD2bvqz3c4t
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:50:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 66EFF43A0C;
	Wed,  4 Nov 2026 19:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D31F000C1;
	Wed,  4 Nov 2026 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821806;
	bh=o8L0vvGY5Km24xgHgPbylEP8c5DuS625RCEauDmBOHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYsPe7EK9xlznqxSarRjMWb/keF20UxFAAIxFblrc1DyDdCICYC0tZhLXHGBEjv2m
	 wlolIDJ7YESPSIUpyajqx3Pi5Z9zhYfRI4siggX085u5ZCM59zXJsjvpX8buE3Tg23
	 SlNWXDQdYn3g1vBGkIMitmFjx3pOOiiqYXRBb4AvwUHkH0/o2nSoE/7xM2+bGZtgQ5
	 OviczvtzIq+aURT2ywz7ETtS4VmDmtvxHciSqzRG/NUK0pmlve0K75uh+30R9f7Khm
	 DjfChaLv0h87xnlfhv41ydwZ032RXJPkYnLbVO+AjaHCHz+rJCzl03k7b2tSTGaF4A
	 finR4PnDyeWlA==
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
Subject: [PATCH RESEND v2 01/30] jbd2: let procfs own the seq_file of the info file
Date: Wed,  4 Nov 2026 20:49:51 +0100
Message-ID: <20261104-work-procfs-fs-v2-1-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=brauner@kernel.org; h=from:subject:message-id; bh=4wXeP/X63evRQ0XlRmaO+RfgvVw7qBYaC3PXgCgMk/I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tFWfOxU95GH3XdJTEYBl8knnmuK/UXrVrUrzorQz FINDXTtKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEieL8P/uohlXprsW1qaIpK+ b1x9yGKVsvXjy55Vj5KKjk2tPrHQnZFh1Trl08dUnn26v0t1fseh4COavFYvfAQPnCsMWqPzN0G SEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and the size of the session state and let
procfs open and free the seq_file of /proc/fs/jbd2/<dev>/info.
->proc_open() only takes the snapshot of the statistics now and
->proc_release() frees it. Reading the file then no longer holds up its
removal when the journal goes away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/jbd2/journal.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 3a4f3f613ead..1e4f4e95a00e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1173,51 +1173,36 @@ static const struct seq_operations jbd2_seq_info_ops = {
 	.show   = jbd2_seq_info_show,
 };
 
+/* procfs opened the seq_file and allocated @s */
 static int jbd2_seq_info_open(struct inode *inode, struct file *file)
 {
 	journal_t *journal = pde_data(inode);
-	struct jbd2_stats_proc_session *s;
-	int rc, size;
+	struct jbd2_stats_proc_session *s = ((struct seq_file *)file->private_data)->private;
+	int size = sizeof(struct transaction_stats_s);
 
-	s = kmalloc_obj(*s);
-	if (s == NULL)
-		return -ENOMEM;
-	size = sizeof(struct transaction_stats_s);
 	s->stats = kmalloc(size, GFP_KERNEL);
-	if (s->stats == NULL) {
-		kfree(s);
+	if (s->stats == NULL)
 		return -ENOMEM;
-	}
 	spin_lock(&journal->j_history_lock);
 	memcpy(s->stats, &journal->j_stats, size);
 	s->journal = journal;
 	spin_unlock(&journal->j_history_lock);
-
-	rc = seq_open(file, &jbd2_seq_info_ops);
-	if (rc == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = s;
-	} else {
-		kfree(s->stats);
-		kfree(s);
-	}
-	return rc;
-
+	return 0;
 }
 
 static int jbd2_seq_info_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
 	struct jbd2_stats_proc_session *s = seq->private;
+
 	kfree(s->stats);
-	kfree(s);
-	return seq_release(inode, file);
+	return 0;
 }
 
 static const struct proc_ops jbd2_info_proc_ops = {
+	.proc_seq_ops	= &jbd2_seq_info_ops,
+	.proc_state_size = sizeof(struct jbd2_stats_proc_session),
 	.proc_open	= jbd2_seq_info_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_release	= jbd2_seq_info_release,
 };
 

-- 
2.53.0


