Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E82607A8BE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcbte5hd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDYV2Wgmz2yTQ;
	Tue, 03 Nov 2026 01:27:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629630;
	cv=none; b=j+vcsFBS/0/Ygcu+wGoufByAgh3N+HXjLJi/p6gydPE2VZfVirGtU8wW73fphzXS/5PQbbUOAH1dEm8e7UZSWESLb4a0wNB6tvV9BM3P0vwvzfdAJmzR2/cbKktqQLGfcOHseeRR+BO/fOWa8xSb29Kk9DC97Pxm81z7h7z9RONxSxrIUgwHbdbZ9lB3+POpN8f7papyeNcrGG+jr8aHAB/O9GGUiwQ2irVeP7TOlErEeepsjMiizkJU0etxDH1gDSwxUay8g3/WrjKPWrUSiKIkb3baK9g980AEr3FAxRDDvlxrIwpIgVK2U3Chp4BTx6ETFM+m63qcvLL+gwoTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629630; c=relaxed/relaxed;
	bh=vzxa9WYWKU2hIPXRh8KIDL7iPDal71uWut2R3PeQ4Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RijlGeXwfNPkgCGE0rrrvW8HzsX7PLPr453mcq92bEd1kQ8KJ8KtqZPN3o2Vk7rJoLCI9pL8JexW7GrO5a65x7bMizd6eiD1nLYt6js02hluDMgYFpJ5PY7O3Ww6gNREbYrDH/ixTKlp0p/17spDSiaXRf5jwnUVxmH2prh3yz2weURjyRyQohNaLTCIWMrekkVXs7nY8znK/v19Yk4bVfHi2gsQAodEKNAMM2m8XhAQAyf6i4Jp2oavdrrybTGUWAjWFV+W6pZP6vooHlYEhozVGqByatgK3SU/typKuNRCvlHf5We0OEjoyKp8C8BPPQE2Sbq/2tOClwrxNbNtuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcbte5hd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcbte5hd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDYS6NpMz2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:27:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 47F0B41ADB;
	Mon,  2 Nov 2026 14:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929881F00A1A;
	Mon,  2 Nov 2026 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629627;
	bh=vzxa9WYWKU2hIPXRh8KIDL7iPDal71uWut2R3PeQ4Y0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dcbte5hdW7xjuWRdXMJ9nUGRptVMxwMDxFZD2ZHCRvhATLFLbmCjO/p7ODwW6VkxD
	 y7TF4q7FxSh3ont9POQCTTY0PwswUZV/ZqG4O8wvRMxs5F8284pF+mcGzm4MaK93NQ
	 QpE3IepC7NC3BeKk4OMULpvVs62kxU/MrowPIKoZY6XO5y1lgBCb/ZkDGZhuIEq6NW
	 CebUwpQ9Bu8ybMNIDU6UpP7VHTtt7ORw+YnjUGlgQRZHNtXQRbikAiiBKHiyiL/Vym
	 Kt3ER8pjmFooN4uaNfApJD5LlOSUElugetgObusGmTVg7V6wXoTDdDCVHauOcLAVDL
	 k6v5tGZIFoVqg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:38 +0100
Subject: [PATCH RFC 23/38] proc: don't let NOMMU map procfs files
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
Message-Id: <20261102-work-procfs-bugfixes-v1-23-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z8wCFpT+9QBGZHOy3TWX3BTOUWtbXQrp/PYYpjal0N4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJPtsd9LyTjxn8etT/1L5/2vmRnbF3jUb0ZGzE+VN
 WutAza+7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwGxGhonbJLQPhS/4cP0g
 78WZUsuMuwP0t0uVRT6JrMjxPpyY/4WR4cI2pcs8h/Usw6/eF8xTrDD7dyb70sRAec7Qk5mztX6
 2cwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every procfs file has a ->mmap since commit 786d7e1612f0 ("Fix
rmmod/read/write races in /proc entries"), whether the entry has a
->proc_mmap or not. On NOMMU validate_mmap_request() takes that to mean
the file can be mapped. procfs has no ->mmap_capabilities so a regular
file gets NOMMU_MAP_COPY, and a private mapping never calls ->mmap at
all. Instead do_mmap() takes nommu_region_sem for writing and
do_mmap_private() reads the file into the copy with kernel_read().

Reading /proc/maps takes nommu_region_sem as well:

  mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, open("/proc/maps", O_RDONLY), 0)

  do_mmap()                          // down_write(&nommu_region_sem)
  -> do_mmap_private()
     -> kernel_read()
        -> seq_read_iter()
           -> nommu_region_list_start()   // down_read()

The task hangs for good, holding nommu_region_sem and its own mmap_lock,
and every mmap(), munmap() and exit after that hangs behind it.
/proc/maps is 0444 so any user can do that.

Give the procfs files a ->mmap_capabilities on NOMMU that allows
nothing. Mapping a procfs file then fails with -ENODEV, like mapping a
file without ->mmap did before 786d7e1612f0. NOMMU never called
->proc_mmap() for a regular file anyway, procfs never offered
NOMMU_MAP_DIRECT.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 786d7e1612f0 ("Fix rmmod/read/write races in /proc entries")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/inode.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b7634f975d98..9933f03ab9fb 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -466,6 +466,18 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 	return rv;
 }
 
+#ifndef CONFIG_MMU
+/*
+ * NOMMU never calls ->proc_mmap() for a regular file. It reads the file into
+ * a private copy instead, with nommu_region_sem held for writing, which
+ * reading /proc/maps takes as well. Don't map procfs files at all.
+ */
+static unsigned int proc_reg_mmap_capabilities(struct file *file)
+{
+	return 0;
+}
+#endif
+
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
 	struct proc_dir_entry *pde = PDE(inode);
@@ -559,6 +571,9 @@ static const struct file_operations proc_reg_file_ops = {
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
+#ifndef CONFIG_MMU
+	.mmap_capabilities = proc_reg_mmap_capabilities,
+#endif
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
@@ -572,6 +587,9 @@ static const struct file_operations proc_iter_file_ops = {
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
+#ifndef CONFIG_MMU
+	.mmap_capabilities = proc_reg_mmap_capabilities,
+#endif
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
@@ -586,6 +604,9 @@ static const struct file_operations proc_reg_file_ops_compat = {
 	.compat_ioctl	= proc_reg_compat_ioctl,
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
+#ifndef CONFIG_MMU
+	.mmap_capabilities = proc_reg_mmap_capabilities,
+#endif
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
@@ -600,6 +621,9 @@ static const struct file_operations proc_iter_file_ops_compat = {
 	.compat_ioctl	= proc_reg_compat_ioctl,
 	.mmap		= proc_reg_mmap,
 	.get_unmapped_area = proc_reg_get_unmapped_area,
+#ifndef CONFIG_MMU
+	.mmap_capabilities = proc_reg_mmap_capabilities,
+#endif
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };

-- 
2.53.0


