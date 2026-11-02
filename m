Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137646098140
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht8IvPAW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFLt5mHxz2y8m;
	Tue, 03 Nov 2026 02:03:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631782;
	cv=none; b=WNeCh4FrsEA0xssfFLqDmeDq+h4+wmvPykOawbRk7VOXsiMouRvkdVCUmiJoBsSgZkgQBNe7SkyOXtWj6oZZGcoOAYXd/wiO9uEiOuPRbEJJ/xqJVqixVrVFbHGyVsc/jz/fX8nDZusgtzgYAHDigoTNS258bBgk9Q48CYIUdyKo6XKgT7sYVMZJfCUK9kj7q6izjwtjaJYLUH8t97dbt0pOGztkdfSKQsocCVZAdT3vHkpg0kIjGwWiQHw7izD8Rigugbe3gttlncKZQ2mR0Vza4nPi4zFPFzcF9jTGWMGhd1/vJOIziOvdcaJKVPbAWT/PlqdVeRIKbPFtPI9Nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631782; c=relaxed/relaxed;
	bh=wEPnWAoxjJOkMqmLZaf/U9t0SZ8y5Jr9Z0MZeAu0+Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTpmz6wBWZ3u7D1ZKLUN22e8oLWX/zUuefJTjQkKBdk3xN7d3rR3pz02yxCZHf3+ceiV0X/fU90mgTv7mzswpPsG2WbKYyc17twRnz3xWtN7BKqSXnuuRjHRHrI+d2D5/YNSD0FhrLoSjgFN/RTrtwBGphBXqwASlobT2ASZBehQwFJJIk31NHRL2ai/c24D+8YmK906hE0UJ3i8LkZ4QI093dISZKPFU1lW424qq+GVBXPm6uBPyeAaS5TyUdGdu1BDpL2EiEVrsXgGUZY4c++gronMsSnOVHaJRihKsCncwpMBZ/zz3byyGiCR5jO8XUEbWFEM2KNEUy7ydfxozA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht8IvPAW; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht8IvPAW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFLs6xqNz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:03:01 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09B946022F;
	Mon,  2 Nov 2026 15:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993D81F00A1C;
	Mon,  2 Nov 2026 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631779;
	bh=wEPnWAoxjJOkMqmLZaf/U9t0SZ8y5Jr9Z0MZeAu0+Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ht8IvPAW4mof6T3nGFwGbeVcaglGOl5mlj1CVqepMvEvFGz+8PKgoWLHL9+bJs9L7
	 53v2AQN+tBMkiLzgkeml7gGU+OB8Qm2CYhl3PTcPVXGN5OADSQkZJx/YRkKTS8i052
	 B5XpuKPR4lfAkar6kmgYTuxdr92sz56IZFvIKuF1+wppZQEyaU5GTMiW0VyOvuqR23
	 IRN/l76vPa7aqwWxy1j21njn6oagnIsGH3fmLYqTV/WDWTC2VC/h/xgzC3mEcucqJ4
	 Ga/T8yFZ4NOj4fhKsZdAeiJjq2g3w2I4SHbAhfhyRvJrP9tLFJXFNtfFbKv/jX0P31
	 EU9eTVpIjSIzQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:31 +0100
Subject: [PATCH RFC 04/22] m68k/bootinfo: let procfs copy out reads of
 /proc/bootinfo
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
Message-Id: <20261102-work-procfs-arch-v1-4-c9492ab08480@kernel.org>
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

Implement ->proc_read_buf() so procfs copies what is read to userspace
after it unpinned the entry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/m68k/kernel/bootinfo_proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/bootinfo_proc.c b/arch/m68k/kernel/bootinfo_proc.c
index 857fa2aaa748..4936cf44e86a 100644
--- a/arch/m68k/kernel/bootinfo_proc.c
+++ b/arch/m68k/kernel/bootinfo_proc.c
@@ -19,15 +19,15 @@ static char bootinfo_tmp[1536] __initdata;
 static void *bootinfo_copy;
 static size_t bootinfo_size;
 
-static ssize_t bootinfo_read(struct file *file, char __user *buf,
+static ssize_t bootinfo_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, bootinfo_copy,
+	return memory_read_from_buffer(buf, count, ppos, bootinfo_copy,
 				       bootinfo_size);
 }
 
 static const struct proc_ops bootinfo_proc_ops = {
-	.proc_read	= bootinfo_read,
+	.proc_read_buf	= bootinfo_read,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


