Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57F6079920
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoFGcx0p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFbx3Z0bz3bkP;
	Tue, 03 Nov 2026 02:14:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632461;
	cv=none; b=GfaHJfyC4nw1EsWSiA4si+wh8s2ilvF59pYXJH26FJRd6hEeS7SpjuhgcHznwDQobUXGykkWJQrWuKUfKMXa2npoiWdKGhwa0ZB30bvDWEAoCpCCzsN0OqMst3gbTkMleaErnC7O09xNUgu0NXSWr+6Ps8tMZiMdd+WkJFrgsEX4D7UDCQwGQEMaXyl8fj1kl5An4I2gbUNSoXHOzOBnKRzaSefPZs8ex/MhKdn9PR6g25x2J0JMayxoXqE8fJlDOU8DfLX+ga33XqUuO+FbAypFggyr3gUAdUDytJ6F9bGbuv99hjCPWW7nsjhk3iStrXJUyz38OrNZDDmsGgTtng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632461; c=relaxed/relaxed;
	bh=CTj8vGUhriHCrFXvGM0jGNx3xl9ERozaQgV9GXGsY38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJmj1B8YCpu2fHM01P/oT10Bw67ZpgPDrEJ39Fbu74yH8kzmaumq3IR/y8xOlfNLy8dM76ecZKtFJc2nVA79qRkhmNlns6H8QIAQ09tG2x9kRNqpkV8JtKffSZCDlcK5myzUO+AUUCa/KnxgPHHrG3H00OvN5JKR1D0RRvpajaNgLZHKytoUKfLYSEn2xL02+9JXbauQ0oPcq2a0SEeRaJppeLoTtcp4pRb9Wx2qKKiB4K7bNzaYi2twJmtuAxNLZ/Cnso2niD/TZNK4fAyGZB8A6ZbN8/RJxybRMb86G6OTYdo4ghJbMSVG9l7gjqOIF3BEPeJbMT0VpxB4RRiZZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoFGcx0p; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoFGcx0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFbw4lm9z3bkG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:14:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89AA960230;
	Mon,  2 Nov 2026 15:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8441C1F00A1D;
	Mon,  2 Nov 2026 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632458;
	bh=CTj8vGUhriHCrFXvGM0jGNx3xl9ERozaQgV9GXGsY38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aoFGcx0pELaJ5RYWtke+xC5t7aNB65DB/8p1Zyd+Mct0qYV4hXDTpFdt2jN92OjLm
	 cm9P26FLH82HHv9uw3dBZcgwAFDEPF2a3BUk5VP4UipyUvYMQBZsfzU8GWvk6Denxt
	 E+8h+vKxlfMsymem4bXtYNAdw6PVC20yhamxn7bhY3LAKScGG+UHFtjCsk/SsEKeLw
	 mKt9GtlF0fXNneJBDl1wbvMAkvsv60mfPqz6Wg5a7kgDUDRlelGwablxe1YjuJDu/A
	 zVy69YNLIhqAiQvfFY8ZlaEu8v/NK9WoKplt79CxDhcQu2uFCnSjhECk0F4Ds7DT4j
	 Xm4j29KusNR9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:19 +0100
Subject: [PATCH RFC 12/23] scsi: sg: let procfs own the seq_file of
 allow_dio and def_reserved_size
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
Message-Id: <20261102-work-procfs-drivers-v1-12-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3098; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i7XPA6oQ9lTisv2fJhwkVTww2SSinfY9aqbIviKN0Rk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6Qf8grL/vRBPOFfc2hW3RiHI9mZiQELndpn9khL
 RHPWBrfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBH+LIZ/Znxfdj0svxz/x0KW
 cdfJXz/uVP2z5WL92Rx27MvazyK/WhgZXtf0pV+c73nSVO8zu/lFWSMbjbVtv7ecN4xQ/S9ns82
 bDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass the integer they show as the data of the entry and declare the
show function, procfs then opens and frees the seq_file. That makes the
open functions unnecessary.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/sg.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3f9e08725602..c7386fbe5580 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2287,26 +2287,18 @@ sg_get_dev(int dev)
 #ifdef CONFIG_SCSI_PROC_FS
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
-static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
 static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
 			          size_t count, loff_t *off);
 static const struct proc_ops adio_proc_ops = {
-	.proc_open	= sg_proc_single_open_adio,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= sg_proc_seq_show_int,
 	.proc_write	= sg_proc_write_adio,
-	.proc_release	= single_release,
 };
 
-static int sg_proc_single_open_dressz(struct inode *inode, struct file *file);
 static ssize_t sg_proc_write_dressz(struct file *filp, 
 		const char __user *buffer, size_t count, loff_t *off);
 static const struct proc_ops dressz_proc_ops = {
-	.proc_open	= sg_proc_single_open_dressz,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= sg_proc_seq_show_int,
 	.proc_write	= sg_proc_write_dressz,
-	.proc_release	= single_release,
 };
 
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
@@ -2347,9 +2339,11 @@ sg_proc_init(void)
 	if (!p)
 		return 1;
 
-	proc_create("allow_dio", S_IRUGO | S_IWUSR, p, &adio_proc_ops);
+	proc_create_data("allow_dio", S_IRUGO | S_IWUSR, p, &adio_proc_ops,
+			 &sg_allow_dio);
 	proc_create_seq("debug", S_IRUGO, p, &debug_seq_ops);
-	proc_create("def_reserved_size", S_IRUGO | S_IWUSR, p, &dressz_proc_ops);
+	proc_create_data("def_reserved_size", S_IRUGO | S_IWUSR, p,
+			 &dressz_proc_ops, &def_reserved_size);
 	proc_create_single("device_hdr", S_IRUGO, p, sg_proc_seq_show_devhdr);
 	proc_create_seq("devices", S_IRUGO, p, &dev_seq_ops);
 	proc_create_seq("device_strs", S_IRUGO, p, &devstrs_seq_ops);
@@ -2364,11 +2358,6 @@ static int sg_proc_seq_show_int(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int sg_proc_single_open_adio(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_int, &sg_allow_dio);
-}
-
 static ssize_t 
 sg_proc_write_adio(struct file *filp, const char __user *buffer,
 		   size_t count, loff_t *off)
@@ -2385,11 +2374,6 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 	return count;
 }
 
-static int sg_proc_single_open_dressz(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_int, &def_reserved_size);
-}
-
 static ssize_t 
 sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 		     size_t count, loff_t *off)

-- 
2.53.0


