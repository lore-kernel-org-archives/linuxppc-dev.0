Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5701606E025
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB1+KIUN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFZV4LBWz3btP;
	Tue, 03 Nov 2026 02:13:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632386;
	cv=none; b=lNud6vQNNrAYp375Whjl2YczpHsE/OqYLnSZNVs9pPsAtFDtdped8nJ7HQ9ITIuTxobrLXL8hTyVE/OR3JRfpOLOR+xbwB2i71SroAehhkF3BMZOsY/P5oQueCCyElc2XMJ9eS/ypSOitQj44QchmXIInAuEgzbMWILNwe6UcFZlLkvBHALmHRJ6BIrSkZ1/VBDgZiOkoJAP0aP37NkxvBJkdDdTBrbE52omuMy8JYPDoZfH1k5SZ9I6+PMtEYgvlp6DKMX/PZOefhZYRejCZ+FNQijeCzs9CBON08yv8aD/bhZ2sgh5pGPAScF5ggBmSRndMlIgQrIxkiFOrHvcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632386; c=relaxed/relaxed;
	bh=0F908CJPgWsUmGeEXwOdb+LqVbJ68uHDJ1pDvsTQFww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Grnfzp5/c5zYW46pu7tzJZYzNtSJuZN7NzjDtrgsCq5edSAf2Ybp1FJDjW39sF7pVYmH9JZydPSfX51P0lLcFC+Vgxvu1aaXYIvI5Uca4H24CAm0/AVT6mbrnPmAgzXH3dhiOArOmBOB126qtqYyUd4iKG1KKNP8vBKePFuS/8szPIl7IkuW8HBjJBV9tNjs1ZZINFDR4wNc1pLqCVaDYYQDBcGlPXTeZWmEyvQErKWMuLG3PNNq1YNTmeLArOBovG/qEVFFign8BTlHCIDKfycji92JmnCREwN6FtMsu40IwL3AvWEm3IAgLSJV6uHpmUs6oS/DyRY9kV8tBOBSVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB1+KIUN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB1+KIUN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFZT6Bqxz3bh4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:13:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E51F941364;
	Mon,  2 Nov 2026 15:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FE71F00A16;
	Mon,  2 Nov 2026 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632383;
	bh=0F908CJPgWsUmGeEXwOdb+LqVbJ68uHDJ1pDvsTQFww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hB1+KIUNyjEbaufWPwsUCeMJp7msq4zuBEN60a9O5elRG1b2/rFlP3YTkDeZbLt5o
	 7GFV9HdREKNRcfcOalIomjHN+DuGMZHhn6rknHpTa3tT+DZMFRGXMfA02hly03O46p
	 V2N2Qok2Ifuav4DftJTStutXTufDWTPS8H20slSlH8K8iOxpQ2j6zKHZoQK+Cqa+Mm
	 WP5DYUA/m24WzubUhU3BE/pJR2GSBRAKw+06ZAK5laj5bIQXPmsUNZTzenFL6fHGwx
	 eXLRQdsgA8M74MJxLFV6Uxn9eoXqxnqEvPHT85M/ywwVem0ohuPtIdOcZVhMsskDtT
	 Oiv7mqzjJHJYw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:15 +0100
Subject: [PATCH RFC 08/23] s390/cio: let procfs copy in writes
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
Message-Id: <20261102-work-procfs-drivers-v1-8-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lEA79OgzD1RbbuI3leV0mq7RtW4au2plI+2F9ffJvH8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG5gX1lbVGp1+7n6oZV+CxdFfRW5tVltZef/QtlzB
 Z4NCik/O0pYGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy/wcjw1Y5VxW7pb/1p3xs
 usT8+v+/yZtVHxWIr5ZZcuVE9cbYgpcMP2Z+sgxZnFYro/9KTNL9v9icFmv9Ly+Dt3stcL12+dQ
 yVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for cio_ignore and cio_settle so procfs
copies in what is written before it pins the entry. cio_ignore parses
the list from that copy, up to the first NUL like strncpy_from_user()
handed it to it before. Writes larger than 64k still come up short, now
through PROC_ENTRY_SHORT_WRITES. Writes to cio_settle larger than
PAGE_SIZE - 1 bytes fail with -EINVAL now, it never looked at what was
written.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/s390/cio/blacklist.c | 33 ++++++++++-----------------------
 drivers/s390/cio/css.c       |  4 ++--
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 4e02f78f6102..1ec7915be6b3 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -12,7 +12,7 @@
 
 #include <linux/hex.h>
 #include <linux/init.h>
-#include <linux/vmalloc.h>
+#include <linux/sizes.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/ctype.h>
@@ -355,39 +355,24 @@ cio_ignore_proc_seq_show(struct seq_file *s, void *it)
 }
 
 static ssize_t
-cio_ignore_write(struct file *file, const char __user *user_buf,
+cio_ignore_write(struct file *file, char *buf,
 		 size_t user_len, loff_t *offset)
 {
-	char *buf;
-	ssize_t rc, ret, i;
+	ssize_t ret, i;
 
 	if (*offset)
 		return -EINVAL;
-	if (user_len > 65536)
-		user_len = 65536;
-	buf = vzalloc(user_len + 1); /* maybe better use the stack? */
-	if (buf == NULL)
-		return -ENOMEM;
 
-	if (strncpy_from_user (buf, user_buf, user_len) < 0) {
-		rc = -EFAULT;
-		goto out_free;
-	}
-
-	i = user_len - 1;
+	/* the parser never saw what follows a NUL */
+	i = strnlen(buf, user_len) - 1;
 	while ((i >= 0) && (isspace(buf[i]) || (buf[i] == 0))) {
 		buf[i] = '\0';
 		i--;
 	}
 	ret = blacklist_parse_proc_parameters(buf);
 	if (ret)
-		rc = ret;
-	else
-		rc = user_len;
-
-out_free:
-	vfree (buf);
-	return rc;
+		return ret;
+	return user_len;
 }
 
 static const struct seq_operations cio_ignore_proc_seq_ops = {
@@ -398,9 +383,11 @@ static const struct seq_operations cio_ignore_proc_seq_ops = {
 };
 
 static const struct proc_ops cio_ignore_proc_ops = {
+	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 	.proc_seq_ops	= &cio_ignore_proc_seq_ops,
 	.proc_state_size = sizeof(struct ccwdev_iter),
-	.proc_write	= cio_ignore_write,
+	.proc_write_buf	= cio_ignore_write,
+	.proc_write_size = SZ_64K,
 };
 
 static int
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 54b8b8639694..efd3df3e90ba 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1278,7 +1278,7 @@ static int __init channel_subsystem_init_sync(void)
 subsys_initcall_sync(channel_subsystem_init_sync);
 
 #ifdef CONFIG_PROC_FS
-static ssize_t cio_settle_write(struct file *file, const char __user *buf,
+static ssize_t cio_settle_write(struct file *file, char *buf,
 				size_t count, loff_t *ppos)
 {
 	int ret;
@@ -1292,7 +1292,7 @@ static ssize_t cio_settle_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops cio_settle_proc_ops = {
 	.proc_open	= nonseekable_open,
-	.proc_write	= cio_settle_write,
+	.proc_write_buf	= cio_settle_write,
 };
 
 static int __init cio_settle_init(void)

-- 
2.53.0


