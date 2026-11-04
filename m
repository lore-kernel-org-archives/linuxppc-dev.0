Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E226098F54
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAw6s8BB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbkP4pyrz30V1;
	Thu, 05 Nov 2026 06:54:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822077;
	cv=none; b=UzUKZJor1NJ93Q8VTIw6dBarLn79zNwZwV6z0N1mo/BjZSEthb/8EaWy7eMjYfymVABkpPJRBa82mhRs8IzniWJqZ5gaRHL3Bjo2sGGNlS6GbdV3smc3sif0KHd6UOKVp1s40YiFjgpEVJzNM4eSJPoyr1M54qGjANpF+VGwHxEd8hAoC1PB7TRph4Zba3WW6lTSF9J5ER+EMsyJw6LFXzTnyJWUZ64d+GoPTQl3phae85ztfvBrKYvP7drjbdtyKcZJOq480sRMJPGN+zPhzVVTar+UkFBvNu/deFxDojwPATUyaezVNEWN3itZGKMw+CAIve8+htwV4GiApiL8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822077; c=relaxed/relaxed;
	bh=MznRqphvtEZQp5npCZI4V0Q6Ll7VzqUvC+SM21Py/Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0KQzHzUWmw8PSoT9yeyv/hvZHgZpHOufBtoJPTaS2AkEU9hHMUwDc1+Csl26bKsvUUK+NcLl7dsgSPqIK/uc3FMnHuGXzhtqMzf+UcvGW7mP0rlUu8pt74Wj7WiAlxGAI/JbYnswCLcT3rIIBYuVavkzY0a9ljm/BDh+jiDbz7eO5cqA52WQj+uNjviRps3eq7yV7MmnchY4XHY78oCYuK9uwSzlTV0PZLhH6dsPS2wsIQZ4lgJOBwdEExSlieY6DnWz+s3erhisw2VQ/PDI5I/kPjqIwbN8/V8DglKdkMUz8wLkg98iEROzizEY0HqxQi7MBCEEkoqQHuKEsaGxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAw6s8BB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAw6s8BB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbkN6GH7z30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:54:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 02D6B60DD5;
	Wed,  4 Nov 2026 19:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34F1F00919;
	Wed,  4 Nov 2026 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822074;
	bh=MznRqphvtEZQp5npCZI4V0Q6Ll7VzqUvC+SM21Py/Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAw6s8BBQpMyHhrBN/asRF3MyBAYmvDQG77oX4IdbQ/Fvo+Dc9HrA+ohRms91kTq1
	 tGhNQ04Nlq/t5AfIo9I0c2aXY/M5rtDTWUuPNd15k0EftQU6IZz/1TwoK5ymzaduHR
	 KvYeTEdLCNXdmy5ayLOGUZDs71r+gh7UBQKBI6RxE/xvbUti6reVcmIlIBukQg/oVZ
	 3GplheA6ivbtF04reRE084gkHonlgWY7/SEBNKSZb4CeUx9EDq8ilSbzdKz6xramV4
	 xWoLAYuCOzLrRq2otfJd3P7rRpoURXvc8stKQzocl2lC26pljUbnGmCOVptz3/wPze
	 zCe5glH7FfhIg==
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
Subject: [PATCH RESEND v2 19/30] sched/psi: mark the pressure files permanent
Date: Wed,  4 Nov 2026 20:54:20 +0100
Message-ID: <20261104-work-procfs-fs-v2-19-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=brauner@kernel.org; h=from:subject:message-id; bh=Q4lGavm4ZGBXo39Ieuspgksaf3Gh3Wa2s1ilX3Hj4ok=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97nE6m3h911tVzfl3TOQ+HGv+VCMdmrs1riUii6Fn/ h6jaTe6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyOoXhv3tM6SuHq3u6jjOp iTG8jZr+w3t5XtOCK765Bxxfv0uo9GVkmHSW9bDFvZMHG36nuv3fEtB3J4a7ZO+RCd52Z7kzO6s y+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

/proc/pressure/* are created when psi initializes and never removed.
Say so with PROC_ENTRY_PERMANENT, procfs then calls into them without
pinning them, like it does for /proc/profile.

That also takes care of a rule the files bent. psi_write() takes the
seq_file's lock to serialize the triggers. A reader holds that lock
while it copies to userspace, and now that procfs owns the seq_file it
does that with the entry unpinned. So nothing that runs with the entry
pinned may wait for that lock, and psi_write() ran pinned. Nothing ever
waited for it since the files are never removed, but with the files
permanent nothing runs pinned at all.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/sched/psi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9b99099017e1..cdb7a832333a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1622,6 +1622,7 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops psi_io_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_io_show,
 	.proc_write_buf	= psi_io_write,
 	.proc_poll	= psi_fop_poll,
@@ -1629,6 +1630,7 @@ static const struct proc_ops psi_io_proc_ops = {
 };
 
 static const struct proc_ops psi_memory_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_memory_show,
 	.proc_write_buf	= psi_memory_write,
 	.proc_poll	= psi_fop_poll,
@@ -1636,6 +1638,7 @@ static const struct proc_ops psi_memory_proc_ops = {
 };
 
 static const struct proc_ops psi_cpu_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_cpu_show,
 	.proc_write_buf	= psi_cpu_write,
 	.proc_poll	= psi_fop_poll,
@@ -1655,6 +1658,7 @@ static ssize_t psi_irq_write(struct file *file, char *buf, size_t nbytes,
 }
 
 static const struct proc_ops psi_irq_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_show	= psi_irq_show,
 	.proc_write_buf	= psi_irq_write,
 	.proc_poll	= psi_fop_poll,

-- 
2.53.0


