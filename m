Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF36070D9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNnLcX8e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFLY5KLxz2xlY;
	Tue, 03 Nov 2026 02:02:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631765;
	cv=none; b=YG9tCTJq+ETx+Mx01glIuzPPIVeJfxlMz5jaVN1ThhfXKBiBJm/+7OTJZhOCXmGdpcWMtd68XRrXX6ChfSIkGuIgRrD447N90MgIXCXeiag1TVaNrv+ssPrUMtNYYGUm+y+FLILiIrRHXfoLInxwHI8hXd4ZqIfs2He2qXHYP8TczvI0d2Z+Jsz0kyh1gLGiHC4u4o4/yGwaLnSPmzvmoBD4jKPqdBs5y5sQl1pJeYFRk4sAcRIqcVnhaOmi6bphks3YhuJontUqFHYvnpOHMzv6aHFB5IbOZ5k64Q7vwx/O5DFMeb0N7IEMIrgkTx4JbiyMmN0chaIGX0I8mbRRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631765; c=relaxed/relaxed;
	bh=pQQ1Vs9Ggdq4tGJpsZZ2KAKh5WKICEOKhSgV+25xKrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2q9R4x/0T2xfVeI8S+mhoCPpPiH4MCD+NnGxXPPwhibtWKpaQ+G0FV4dgsHsiRx8/albXZw8+AeWhgURPVWmIniUfKddzaFrAsv4gWuKgY+w4T8iRkoBOg5PkOpe1Sm1TLeKiIvJs/ok+wSWbeWRQvT5Xck2W7K+wm3se33hXsMDmnhsA7cASNnhR9iTmqthBwKc3sAT7tE84wVlNUroSM9qKeXSPXc5sjtOFKTYvWRMAV+5/UzimMJYhUyTEvVzV4EfOBzzJwY5Oksq5D0tKV5vSlcttG4GiE7pst1dpw0HgW3EH177VRJg4AD5TFa3j+s3/hjF3MOb/eVv05JOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNnLcX8e; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNnLcX8e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFLX5KbKz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:02:44 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E276434BC;
	Mon,  2 Nov 2026 15:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B61F00A16;
	Mon,  2 Nov 2026 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631763;
	bh=pQQ1Vs9Ggdq4tGJpsZZ2KAKh5WKICEOKhSgV+25xKrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RNnLcX8egvEl5rPbLFMIscYDo1QnoOrpG6e02ikgGgR/Z2oamdimB42SLpFro378t
	 USbuYkcNHDjjzryLCSmr+2mmsvc3Atos4MVc28LQXLDJayaUp2uu3SYOz50KP5/BKt
	 3u8kERoVbEfv90E7PC1AQzopGHBD/M7WfJWVvb4TNCYwjGxWo6SsNG7sq/Lq8yJIja
	 zntE5mo3Bhg9BDYczlvI4bibAH3u2IIBa/7c1DzqGQ/HgRro22a3o66odi6Je5Ttco
	 L0BW9ZHBEZJkGL3uRb7ev3sdiVhk7xK/B7muXSKuAHvnwQSKK0opx2IHD1lw9HfJa5
	 LqGcvESsuLu/A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:30 +0100
Subject: [PATCH RFC 03/22] ARM: atags: let procfs copy out reads of
 /proc/atags
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
Message-Id: <20261102-work-procfs-arch-v1-3-c9492ab08480@kernel.org>
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
 arch/arm/kernel/atags_proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 8411fbfbcb8b..ff28bf24dd30 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -10,15 +10,15 @@ struct buffer {
 	char data[] __counted_by(size);
 };
 
-static ssize_t atags_read(struct file *file, char __user *buf,
+static ssize_t atags_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos)
 {
 	struct buffer *b = pde_data(file_inode(file));
-	return simple_read_from_buffer(buf, count, ppos, b->data, b->size);
+	return memory_read_from_buffer(buf, count, ppos, b->data, b->size);
 }
 
 static const struct proc_ops atags_proc_ops = {
-	.proc_read	= atags_read,
+	.proc_read_buf	= atags_read,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


