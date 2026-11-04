Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2460A5BC0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoGLsylU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY5b6gs9z2yLg;
	Thu, 05 Nov 2026 04:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814963;
	cv=none; b=aKP0btIE+TwxvOFXz73f3KZiJ/pO6MefuoKg2PRwIy4vuda3+PM20wborGrHxzrYw1e1VMqaCOf0fZ+c+TlT9KvvTAdKpTsi/R18Lf5CdD2iOMhCCcH+icaz2TkFF4rBwRpVqyxuhKEaXnYrBqoAwjwzkCAErIZTwEK8pFS1JYH22VSHlbMqrrBkkeKLOSjaKVvzTZxrqqQtSGr0rowiKrTYyHjYRanbay/AV6e7/wv2195eMIRJcnn6Pdcxz/C+XczOZLTXArk32tar/tK7cGRiefeTMY/+NDMv2XN6U8gyUGHvOo1Pt4MA97nkQ9jOZW86IW+TuMXeePvyROkaow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814963; c=relaxed/relaxed;
	bh=x8nH5QJkKiZNUTowDxB/hMOFyVkHqFnuwosL7qreMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oc5RZFZJdu4a1flYSX3T02fudN6UV4i3sRXXXIF1kjrgDofROd3OzvnD/VwsZ52xzU5p/LwR9l3A5xNjegpQ36CYxtuHGnc4DhWHaTM3BOKbh8YXtPSo2UE+f1/gg+452EnBzx9n6kJCEbrb7XmngRn3ZpDjX2xdPJvQXDFzQt+mgLzdgbzzf9SyqurWeZIlHvuqUvrWf5HMZTHmYEp4/KDayDjjUD4f/KNBOTXNg0j9MoIWyJd+JhxhxBgRszxMckDBLYOAFg2pMoTzkyHyic8sBMh70BsmQFL0tUmjC2XDgHTlnqCTyWqdDQxjAXPhsbKsFct1qehIhxgkanIp9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoGLsylU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoGLsylU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY5b0dz5z2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:56:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A53660A06;
	Wed,  4 Nov 2026 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC61F000C1;
	Wed,  4 Nov 2026 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814960;
	bh=x8nH5QJkKiZNUTowDxB/hMOFyVkHqFnuwosL7qreMAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoGLsylUTixNPsM6JjA8vEQ97GS0PU64B/S8mW42LCSUIEW0+Oup1fKeKwWKQdTUs
	 7hA+IwbT8SOA6SNIASsjDmnoUBtHx7XyqRnT7bzWmyNx3XbQeq35t1VBobNh34XJek
	 TdXWkSK6MqCihvsWYtZOw1/JX14O29VjTCo9F+UA4nJfcs4I9UbzXBW1IEI742yd39
	 aSY2cFacXu9jS6PUQxhQcjsZmHKA5h2Hba77Wfcqi3vnGnQV+UzZn74wBpWJjO9vss
	 WWfchnn/2CaHA/1giIf/i0HUORN8nxETI0UgTQa+bm9oE2krXPKY7Xy+xru556UT4i
	 GtoMTdnZo42Nw==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 36/51] proc: don't let NOMMU map procfs files
Date: Wed,  4 Nov 2026 18:47:22 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-36-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847; i=brauner@kernel.org; h=from:subject:message-id; bh=JTUUxaAv8g+OiylD/jB4kSfUdacg86Bjtrwx1fOwQ90=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znst+bi3gVMj0u9q8/OL7/9NXaGRp93F4cL6Kpxd9 LWzfr9TRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ89Rn+WS/RVtYXufbh4oFN 2w/v2mu6PuPztYBDb9L+TapKvCWZJs3IsLjj1Za9+0LefPka4qY2Q+HryzrJUraItnPnOr5YHLr PxwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
nothing. That covers every entry and not just /proc/maps, procfs can't
know which entry's read takes nommu_region_sem. Mapping a procfs file
then fails with -ENODEV, like mapping a file without ->mmap did before
786d7e1612f0. NOMMU never called ->proc_mmap() for a regular file
anyway, procfs never offered NOMMU_MAP_DIRECT.

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


