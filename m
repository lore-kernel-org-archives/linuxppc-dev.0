Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9D606A903
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwaRh4oG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFPV1b2jz3bl6;
	Tue, 03 Nov 2026 02:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631918;
	cv=none; b=AJI0zc0NdWiInhUsMwbGiJdtb5PTJf4P2doznyo0SCKfO/5Ij+VDkEnRCpz/rbNK92riopNADJFhWESgdsXbV4Qs4kl9DfoAwV8C3m0HLdYT5Ia9HEnXZgkwrjYF/YpnYPlHwtxW+e6rHi/zSgh27EdCcwfI8M2l3i16HxQi7dRPBR/tyjC+lGl0NiQimrv4wQSfTHe2pwttkIv1BSXfqNZAjQneIF9GLF7RTPTCcY7Fnb4Ud5s78GKhuJebJBO84pdkVkjJKXmee9qj3eMnu/HYF7bG3hQLOnjh8/+7fyVH3KdUtcXOFiGlRb7QXgWiIDLGA//usauSlBK8avLr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631918; c=relaxed/relaxed;
	bh=/usm8OdHJAbA2hfj2koEwGvMkvG3A+8dTBDDaCx7vxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZhfq6ZBrbOKLel8+4iMZlmaVDhsyPJlQc4AEiaLxWtrqqERUGFlg4HUq57cgp6biYteA7bkNo5SIUf5Wqqy6FlVho5CZNpDOrjRPqJbWCH08KZMNjsX0LJLsAxTOTEg4x+oX0s38H62VGWJq+M+4J7+3cuzf/JgrSmDKEQ+TU9E2Cf1aMSjjuL/eRaVmbHRR5h+kGEsz+Xq4jI++Fn8TvFN1Bk1nar47Z85StlweGwbMcU48wfWTesFVneanVjzlPAIeIvx+UWge7eTUUMvc09ks0sQlsuNmINCP/PYQuRSpGMooYY0H5h+2UUdJgu8HGL/CXPYYYGARM2gWPlBgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwaRh4oG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwaRh4oG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFPT2X9Qz3bWn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:05:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C414605C8;
	Mon,  2 Nov 2026 15:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1171F00A1B;
	Mon,  2 Nov 2026 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631915;
	bh=/usm8OdHJAbA2hfj2koEwGvMkvG3A+8dTBDDaCx7vxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GwaRh4oGylUX6g6CEqPXd69Ibpr3KQmakI0Nld+n+JLGApofu8ygx4WwNRI60EvYf
	 DSOWIV++3VospwIjrvRsrg0mfaY7gRgUeihp43Au6D6HgV7Xv8KolBhRU7xFnfQdC1
	 T7WNrsjJHzUGFZHB3CY8jnJ95TWdIrLVspjluFdHIKRvTNa2WFPvdVn+u5eXib/14W
	 9Mf7AL8v6CpiYBfwScgPVzymR7ApEayesBtx54t9q1NbuhjbVtR1b4mKqnuDg4Wxmn
	 KCXgiDmRsG7or4q0U1UicO9HEaUHCZVEQAI8u1qAq9b4HgJ4PMYdAOqXF8iMKD4/CK
	 FsxoDOM8JDDag==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:38 +0100
Subject: [PATCH RFC 11/22] um: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-arch-v1-11-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for the mconsole and exitcode files so
procfs copies in what is written before it pins the entry. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now.

exitcode parses procfs' copy as is, so it no longer stops at the first
six bytes of what is written.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/drivers/mconsole_kern.c | 11 ++---------
 arch/um/kernel/exitcode.c       | 14 ++++----------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index f01b7d8a07bc..a4370470286f 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -769,21 +769,14 @@ static int __init mconsole_init(void)
 __initcall(mconsole_init);
 
 static ssize_t mconsole_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buf, size_t count, loff_t *pos)
 {
-	char *buf;
-
-	buf = memdup_user_nul(buffer, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
 	mconsole_notify(notify_socket, MCONSOLE_USER_NOTIFY, buf, count);
-	kfree(buf);
 	return count;
 }
 
 static const struct proc_ops mconsole_proc_ops = {
-	.proc_write	= mconsole_proc_write,
+	.proc_write_buf	= mconsole_proc_write,
 	.proc_lseek	= noop_llseek,
 };
 
diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index c71657df38f5..8f76e3b20c18 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -32,18 +32,12 @@ static int exitcode_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t exitcode_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
-	char *end, buf[sizeof("nnnnn\0")];
-	size_t size;
+	char *end;
 	int tmp;
 
-	size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, buffer, size))
-		return -EFAULT;
-	buf[size] = '\0';
-
-	tmp = simple_strtol(buf, &end, 0);
+	tmp = simple_strtol(buffer, &end, 0);
 	if ((*end != '\0') && !isspace(*end))
 		return -EINVAL;
 
@@ -53,7 +47,7 @@ static ssize_t exitcode_proc_write(struct file *file,
 
 static const struct proc_ops exitcode_proc_ops = {
 	.proc_show	= exitcode_proc_show,
-	.proc_write	= exitcode_proc_write,
+	.proc_write_buf	= exitcode_proc_write,
 };
 
 static int make_proc_exitcode(void)

-- 
2.53.0


