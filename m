Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEC606B0D5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htIvLzE5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFS75rGrz3bSF;
	Tue, 03 Nov 2026 02:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632055;
	cv=none; b=Ea8PVnRb5BMk2fbbuFkybvZkwu+xK+Wf1+Mu58JyQRTqmaypV2gjKbkdUInOxZ7bS5auEhMNKmzHmizNLKjYHedeBpIY+8v+TdXP6G4RAlFT0Kom3Mg2W/bfcpHCfAEAmijCuhxB9vr8I7coXvJuQmS4R11/NA8LDroyzbj0/l4TRF7bILGX9iC6KfDUgZlBgegpzAWausTWcO5D5vX5IyswH/7IZyBTno3fEgTHdUK01riedMl4HQiPJkbPUG/DVLWElHvFUNHNYcsBVckeDl9FdGhfPQwUP0dOTlxryCWcVsDCmCEZs7dH2BZ3xIqo5NOc7CnH5DBtiBriOGxG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632055; c=relaxed/relaxed;
	bh=Jqve5dom8G0YagWg0DUi21Qt2CUJnz11dMCfHhOCDkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9xXunRubLrTqb60rQNWbBdBRYz2Pv0DFdJEBRyriMwERg5i96kAfzu25Wsz8NzO+xRb/25072a3hwNluaPGSYCiHPYf+RKyMXc+c1YsWYgGCa0JGIm7Ak6LsKh4ZppLEV79nLKmbK6edY0hNEbfTJJcqMctT/XNZAil1qt+moJpflAqlubvCe/np69EKSlJl5G/Di7IHQfXstYYPVMa8E+YKlbulxQINMHrXY9XTQJkvAEj9rbeBAOKi3Fl3uPumF05mYneIVK5BqshuOOF4kIAssgCFNyBFR+E0r91E5pTl3/zbygRhNQv6tcXK6LoCF/VaiBCpQt/M1O9/DwxCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htIvLzE5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htIvLzE5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFS70C4Jz3bQm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:07:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 44AD541132;
	Mon,  2 Nov 2026 15:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC3F1F00A16;
	Mon,  2 Nov 2026 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632053;
	bh=Jqve5dom8G0YagWg0DUi21Qt2CUJnz11dMCfHhOCDkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=htIvLzE5mRDE3y0tqv1kyv8W5k1g/Ii7ANwuWhratSAOFS7tbxL3BToIPDpZE85DE
	 FNEsXXzLmfR4qQugMxmA9eyhIHm6Q6dJAmTZKLeIUK1bHgaHB6rg72WkRZftlCgoe6
	 E2QfeUCqIA0Nboam57Dh1SlJUtOEamqW0FpuXdYHq09VCiD2DRiKvdUgmVI6MwZESI
	 HWhsjmhK16tI0mtjDz6fsLrdm37sQrZUo7icVQ6YX0Qr2rzi5YjsmWINl56IQd0nMx
	 zqjv85Bp1EemyFNq5w6kuaSNgOUZ321NOGqFqL1mOki6ZfyR8nruUh1khBiylH7rMN
	 bCkpWmWU3eNXw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:44 +0100
Subject: [PATCH RFC 17/22] ACPI: proc: let procfs copy in writes to
 /proc/acpi/wakeup
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
Message-Id: <20261102-work-procfs-arch-v1-17-c9492ab08480@kernel.org>
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and take the device name from that copy. Writes
larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/acpi/proc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index b8a0bd4580e0..feb8283fd855 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -86,7 +86,7 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
 
 static ssize_t
 acpi_system_write_wakeup_device(struct file *file,
-				const char __user * buffer,
+				char *buffer,
 				size_t count, loff_t * ppos)
 {
 	struct acpi_device *dev, *tmp;
@@ -96,8 +96,7 @@ acpi_system_write_wakeup_device(struct file *file,
 	if (count > 4)
 		count = 4;
 
-	if (copy_from_user(strbuf, buffer, count))
-		return -EFAULT;
+	memcpy(strbuf, buffer, count);
 	strbuf[count] = '\0';
 	sscanf(strbuf, "%s", str);
 
@@ -123,7 +122,7 @@ acpi_system_write_wakeup_device(struct file *file,
 
 static const struct proc_ops acpi_system_wakeup_device_proc_ops = {
 	.proc_show	= acpi_system_wakeup_device_seq_show,
-	.proc_write	= acpi_system_write_wakeup_device,
+	.proc_write_buf	= acpi_system_write_wakeup_device,
 };
 
 void __init acpi_sleep_proc_init(void)

-- 
2.53.0


