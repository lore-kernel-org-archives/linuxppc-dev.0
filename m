Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A960607D86A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g53FbUkZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbKN0pjhz3cMF;
	Thu, 05 Nov 2026 06:36:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820984;
	cv=none; b=BCZ2PVJ+Az572IHWQ8T7s1PuyegjXGaBxcZV9MGrxaUIOOrNI7/Xe/FGeoXtpqQK6dwe6NFMUI6or3Z58+A4/zwfgEgHMe6hmOfXu7nSKgeKZX6rBap7KMoGn1PMxFPbXMtRih5Hh/dKw3bvAZfhhj+h+7YCfJG9sqZOO/LGqEejyM4BAOpnzLOVS2mgzc8v7pmI+JXybij8CGJbNSH34Y/57If6KLA2yqXWpCozVlO6c/RE1zt0sBIU37z+63YxRoFWcrowuPFsV4dicyGRFVBOJr9iOtWnlZ2UwNu8+TbcCLn4+F27QPN76Ll5PqAP4I0PA7boE8o5FhdkVjwSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820984; c=relaxed/relaxed;
	bh=qVgyj+FYQ9g7uHqmkN/6kOivRqdCDmjAyQM7m79vY9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glOm9ldgECxqgmSJBRJvz9+HOH16mFwstahYmM+iGwWtG5b3VYBKGMo7cholnFJ7230vS7fntBWwb3uQGPUAxX1cECyQZv8AZKpuLqYQjUvLk/PIoP288GPElOl+2iZMTxnDszUtNFPXGuWL3tJb8qomGALXeKzQFAir6OGsnva2R36oDKxgqWrqiBPevDga0cjnywJauCnJBtEA23e67Bei1VQJg1Yz0x4kYLXH+Nf/cX5U14UPDaPjPKJcgusPjo40ZFJOpIPwKBlv5vSeohsb2B4TDbBXZaW5ysg1bC7XshoXCmUG/ztecRpPGfxN/9wb8ib3NEboVW+/rM9nCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g53FbUkZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g53FbUkZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbKM1yPDz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:36:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 58AFE4307F;
	Wed,  4 Nov 2026 19:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3312C1F00A17;
	Wed,  4 Nov 2026 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820981;
	bh=qVgyj+FYQ9g7uHqmkN/6kOivRqdCDmjAyQM7m79vY9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g53FbUkZCSWNwnfejXhy6s2nelprEnvO5Q4YohPFBJHS+h/+Bis4YhN2/N/AQPc6j
	 fzYwibXDmXurtiMkWQn5u+VqbndlNGJtHCg2mWpnoK5k3yXNh3AEwdUXjS/Wn8YgAp
	 DsbkdUjLTcZjtiVPGmJw8p0/O2ZWUM6qG/u1JQ1LS7FQsul73LZQiypnKRi3hmBJNn
	 pWa+EONoOhGPwjSkAXUgj9sc5Wf8Ushz0fe45yGX+M0rWNNO/OogEaHlzCPeH+AsK7
	 UOZddBvu39FXQ3nOy8HZZvj2XFYHPYSGv2QlAmtdpAP6TIhnKozmF8NTYKArJ9/gig
	 pdBxHcmOh0+mA==
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
Subject: [PATCH RESEND v2 02/23] ARM: alignment: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:36:07 +0100
Message-ID: <20261104-work-procfs-arch-v2-2-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=brauner@kernel.org; h=from:subject:message-id; bh=zhi1nqFEpiSFVRrnQoKgWCc9KudbEGTZB0sdbQtmzK0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97njXfbbxoNI5d7tgS3+dmRcrGv6d2Z0Tv6xkukLGh 2eO1xfe6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiITgLDX+mF5S+vT7n7/+IW 5t66y78vbZh5fg+zoqqy103BXpsgljCGf/rni1NaxQ39Co13b8868UXRoW/v43tTZjz4Lhnc/Iu pmREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/cpu/alignment before it pins the entry, and take the mode from
that copy. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm/mm/alignment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 3e5e30968634..11ceefdfa388 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -144,14 +144,13 @@ static int alignment_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t alignment_proc_write(struct file *file, const char __user *buffer,
+static ssize_t alignment_proc_write(struct file *file, char *buffer,
 				    size_t count, loff_t *pos)
 {
 	char mode;
 
 	if (count > 0) {
-		if (get_user(mode, buffer))
-			return -EFAULT;
+		mode = buffer[0];
 		if (mode >= '0' && mode <= '5')
 			ai_usermode = safe_usermode(mode - '0', true);
 	}
@@ -160,7 +159,7 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 
 static const struct proc_ops alignment_proc_ops = {
 	.proc_show	= alignment_proc_show,
-	.proc_write	= alignment_proc_write,
+	.proc_write_buf	= alignment_proc_write,
 };
 #endif /* CONFIG_PROC_FS */
 

-- 
2.53.0


