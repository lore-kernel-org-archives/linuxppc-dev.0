Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D360C77C2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSlee+0X
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbXN5sN1z3cBk;
	Thu, 05 Nov 2026 06:45:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821556;
	cv=none; b=WaTeUR9ZS44PvI69M7OP2JA9VVrE/SU+Bs72E0UtaQlAMjkEDgVrGtEWuv7tN7yyo/g0uInbIAuBahLdiwxxRHdHWv8FSGV7GH6p++FhyugDmSyVKLkZU0blqvSztXbNlitE6pvjQhdtIzZEHEnleAkp46zKwSzryV22/t+RRgDxyFaRaPNWXUGcz8JvSNlLet9W5/jmLllbm5EVLMKifvzQxcWGiH8ebaT4L2YRSTwZrqm3jwHPXGws5xztBnR2KgvagZHlvtaIXJWlQ+EPNdIuE+q/BqICVXiWlFqpVvelDmUP+Y0PSjv5EBRfi41yHhZhA2Ju+Ue9WA7BcVZFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821556; c=relaxed/relaxed;
	bh=9IR2jOxQyurV4Y0UWx6k8fIXiSGUImfiuKIP9CXfPTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3P8tOJC5hwJ0c+DufOrfxbthqlkfiRrmgkwbesqOUCz2pENLo0Q5R70IqIxIU+WO4HWY6viAccOJbyvBGCP0Mrf+EdrAdf/Akiiz0n577Sp7Cj3/523/0R6DBpAqwsQg4hBesNmBCUttAIAIYwJCL/3B1F6XBJDOVLTDIgVKATAloBy3QkwvH+/jEITS5o9aU2K3BZJn7hjjx8YZ/zSqlxBg0hkQKxDrYHHkbR41INlG9NuhPCv4rs8Ac3rfbK6O1sAyT6N68iC5SrnhIC39Z2Xle3Km39shcBmB4YjvOhD9nx266dGWTbcXxjmmPyQsNmsSgqfox7rGcFhoH4s+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSlee+0X; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSlee+0X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbXN0JRxz3c13
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:45:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 01CD460F2F;
	Wed,  4 Nov 2026 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE861F000C1;
	Wed,  4 Nov 2026 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821553;
	bh=9IR2jOxQyurV4Y0UWx6k8fIXiSGUImfiuKIP9CXfPTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KSlee+0XDq+bm+ysUh8nPtikOnchu9TkIAW1VCY3OCd0AvNcw44e5Hzp54rCEEeNB
	 L3jWndaPZFN6e+WP3JcpT+3RG0ZhvSz3tOpGSVIOUGFO+0FYAr1NPl7u7cOMMQ0fPJ
	 +knaMWTjbKoGzcmxQNH3DFEm9Ec3Nl5logdXw9qRd0FXTv0BIExvBcdGtMlpPD+P5X
	 hC9PgG8J3C1XX9TXnT/LOUtJaj+Lvw1tPb/+ixseUzpgnUtzTmNqW0vZ9e3rfcGTmn
	 SADjUJW9oNfrCSPr0BRrs6Hxsxw5J/g7bKH0shcxqMZgd6mz8rvFTNgLc1cdCHqadt
	 VP8DK/LvUQzHQ==
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
Subject: [PATCH RESEND v2 14/26] scsi: sg: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:45:39 +0100
Message-ID: <20261104-work-procfs-drivers-v2-14-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2854; i=brauner@kernel.org; h=from:subject:message-id; bh=PgyqcOYZULSLqb7qnigRBp/yeFf2Hrq3aYxTKZd6WWw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mpZWdQr2n5nhfa9hbuuMma3507NEd2z6qhK4rplW k3LP34/01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRYzMZfrPUzUxT2rba7uSD Anbzi5PuGN7V3NNXoe7+56FVZPzfOCeG36y1zXIX/9lqb7zUZV/JZH9mTlfh9l/TZrc98K+uDN6 7lxEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for allow_dio and def_reserved_size so
procfs copies in what is written before it pins the entry, and parse
the number from that copy.

kstrtoul_from_user() looked at the first 66 bytes of whatever was
written. Now the whole write is parsed, and anything larger than
PAGE_SIZE - 1 bytes fails with -EINVAL from procfs before the
capability check.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/sg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index fb3ab74e8727..df955896e65f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2288,18 +2288,18 @@ sg_get_dev(int dev)
 #ifdef CONFIG_SCSI_PROC_FS
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
-static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
+static ssize_t sg_proc_write_adio(struct file *filp, char *buffer,
 			          size_t count, loff_t *off);
 static const struct proc_ops adio_proc_ops = {
 	.proc_show	= sg_proc_seq_show_int,
-	.proc_write	= sg_proc_write_adio,
+	.proc_write_buf	= sg_proc_write_adio,
 };
 
 static ssize_t sg_proc_write_dressz(struct file *filp, 
-		const char __user *buffer, size_t count, loff_t *off);
+		char *buffer, size_t count, loff_t *off);
 static const struct proc_ops dressz_proc_ops = {
 	.proc_show	= sg_proc_seq_show_int,
-	.proc_write	= sg_proc_write_dressz,
+	.proc_write_buf	= sg_proc_write_dressz,
 };
 
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
@@ -2360,7 +2360,7 @@ static int sg_proc_seq_show_int(struct seq_file *s, void *v)
 }
 
 static ssize_t 
-sg_proc_write_adio(struct file *filp, const char __user *buffer,
+sg_proc_write_adio(struct file *filp, char *buffer,
 		   size_t count, loff_t *off)
 {
 	int err;
@@ -2368,7 +2368,7 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	err = kstrtoul_from_user(buffer, count, 0, &num);
+	err = kstrtoul(buffer, 0, &num);
 	if (err)
 		return err;
 	sg_allow_dio = num ? 1 : 0;
@@ -2376,7 +2376,7 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 }
 
 static ssize_t 
-sg_proc_write_dressz(struct file *filp, const char __user *buffer,
+sg_proc_write_dressz(struct file *filp, char *buffer,
 		     size_t count, loff_t *off)
 {
 	int err;
@@ -2385,7 +2385,7 @@ sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
 
-	err = kstrtoul_from_user(buffer, count, 0, &k);
+	err = kstrtoul(buffer, 0, &k);
 	if (err)
 		return err;
 	if (k <= 1048576) {	/* limit "big buff" to 1 MB */

-- 
2.53.0


