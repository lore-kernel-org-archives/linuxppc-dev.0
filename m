Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63568609A684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrdQsd6G
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbkz0tNwz3c5W;
	Thu, 05 Nov 2026 06:55:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822107;
	cv=none; b=lNhahTc4eID4T1fFsqWgJ2yT8iREnPFYDmt5OTu5YRsCc5gDD1lPFeTwl4yzGg/hlSjjijB3qpAMMY2ozUFnmY8sq86vh8AlSgK3SU0WE8Baw9j7Dr6M5F07FL+MizkFaicPpVbpk+ALLOS5e/hBg2OHrwinmGlK7YxLrqWE5UFMo+HuXHywrFRYwyRqsOHu9MENx7hiKm07z/DaD1tI+xdzwAtFBE65AJkqwzzoNkhYzWzYceejFd6/GrXJ558UxOYlcMgwuHUBT8ozkmEAXMtdWcUiHkwi9rTRVM+3vlrosJr+p/6LONCNv59Y4N+iB7MjKH4gUk6cdbOGPTvmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822107; c=relaxed/relaxed;
	bh=R1VqjUGL5+J0t5hj5seZeRe1Maiv3S9hp7Jj5OG0/0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmzxKjI5K6O3G6y/uubNr4ivVrbv/xIbm+L6mNpzLhrjq04pYt6XQlRfGcl/70/5BcQmnFKKwdTVGu5KBndMt11S5h9ey55aiFQu6wC3NoP9uKZasTEMgDDhxeoVbiRl5tFzuCjrUP03vZ6taP3On82HkSYHwAQX171ZCVpatQpyTqVefEfhs5S5dBQCShBgJWUNYGXIcn0m1N4bB6nL9HLJyfy1GJ12U5xx/e80CBQnLAqNrUcTQyhZmHv9GVXE2pbtjw1xD0Hu2o27qt0PFzf4xHZycflWqepQ7jwNhrOvyauoacEAFQvsO0A6tSjaGGbcXQoyP+hsQnUCrbeDBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrdQsd6G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrdQsd6G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbky22hbz3c5N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:55:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 304D741B29;
	Wed,  4 Nov 2026 19:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF51F00A16;
	Wed,  4 Nov 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822104;
	bh=R1VqjUGL5+J0t5hj5seZeRe1Maiv3S9hp7Jj5OG0/0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrdQsd6GTay34FYuGXCa8EK220wd8dcVKmmCUL2H6AN8qybgYu3VWX8QWdUPAcmTQ
	 k7Hh4kIxo+HBWYfqIhyCM4t5TutFpDBfRkmXCuGDnrCDs2kRigWisxosjbx2JTilsl
	 pRLqKsHm9QtEr1md47IXW0nBzRwFYpbJ+AsEXB9Aw5/BASW5ehNYPMEN3WtGHRfiwA
	 OzbZlgAyMFwrKZD+fvajfs9VLVkX7k/jZfqjP/IWM7eHh8GU1TOBliTxs7YYEjoU7C
	 tTvFESzDRyM4Rii2YLzF38phnQomDRBM6gq5STKW4qtXTlnb0Rqa4901faLCQGhySy
	 mMgweD+fFjsdQ==
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
Subject: [PATCH RESEND v2 21/30] kallsyms: let procfs own the seq_file of /proc/kallsyms
Date: Wed,  4 Nov 2026 20:54:49 +0100
Message-ID: <20261104-work-procfs-fs-v2-21-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=brauner@kernel.org; h=from:subject:message-id; bh=X1hXUo+P6dAEkQI4HVxBka/iuP3neD063cymPGxvXEU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97nH59Orc+7n3eLifScgo8Jj8qyzNWnT19Mol2qc4a 58vWjHboqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPWcZ/nCKtL2fd32F2F95 vx9SGZf0t36r5ma6o/N8y3elH9e2NU1l+F8fo55wKcT3fXtS7NoKxUWhugwWHOV/0+b/kah+n3N uBjcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and the size of the iterator and let procfs
open and free the seq_file. ->proc_open() only initializes the iterator
now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/kallsyms.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858af..2d309fcee730 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -888,10 +888,9 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * s_start from where we left off, so we avoid doing
 	 * using get_symbol_offset for every symbol.
 	 */
-	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
-	if (!iter)
-		return -ENOMEM;
+	struct seq_file *m = file->private_data;
+	struct kallsym_iter *iter = m->private;
+
 	reset_iter(iter, 0);
 
 	/*
@@ -923,10 +922,9 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 #endif	/* CONFIG_KGDB_KDB */
 
 static const struct proc_ops kallsyms_proc_ops = {
+	.proc_seq_ops	= &kallsyms_op,
+	.proc_state_size = sizeof(struct kallsym_iter),
 	.proc_open	= kallsyms_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release_private,
 };
 
 static int __init kallsyms_init(void)

-- 
2.53.0


