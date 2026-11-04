Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2060A2616
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSonnJ4f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb226wBqz2ySk;
	Thu, 05 Nov 2026 06:23:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820186;
	cv=none; b=M0XxZJ1R/j9133UvwWkOOxnnwS1lhK2DjmTNM+vHzEl4pvAxC5Hrz+919kgqhHu3UvF3ZRXvasBgoNX7gX+5wO+SoHgyllLxZhBrT3ACTkU4JYCbaeDDuiPrMEKbRvXUMBm9Ew84YEanJXlsa7tR6vjhd7kh4xYUO8tHca9AbPEoQCuqDh5uLbTZmIj4Bdd5XZWludNhLuTLx93Vyh5idDaROedOTSc8dJBQLWNES8F0UPSNMGoncLoFOed5KolCtw6DJ9mvnP9RlUYQOYl0z/3D4rUQT7cv4AB9z4IBHisFeGY2E+i0nNfeoTPvJOWCcy+eNhcaBk3svhOpK227CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820186; c=relaxed/relaxed;
	bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfyDXI7nIEJTxn/X3ZYAw2yQ2s9nWrVqKbpCeixDyuloHuopYf3MZ2h4n+HylhHEc4q2EvWC0Ioz2ZTdhIozwLA0pfaDrrdQrfReLgWXO2/KGONWa5uOrZI/vbCvZ2iK2isGKXItJr+bb6d1gz/PBkZcfLRXrqQkUsW+QkvjrpTQa4fgWEjqo1SkfNo/arQUoPcqpTcJUqxVFai1gIZ9Z+2UwgcWzxJXf23OOTVyFj8lLZcz0GpG22AlGWDCavDuYoJQOvBdA30wp0D8LfvFpn86XCUes0BYQUBi66z058gn882frePJPL2ZJ62ef/eCDC6dNmVuIC95xV0rH+2NKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSonnJ4f; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSonnJ4f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb221Z7xz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:23:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A854417F8;
	Wed,  4 Nov 2026 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF251F000C1;
	Wed,  4 Nov 2026 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820184;
	bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSonnJ4f7yMH1lOXY4xKOkMixSuWwienI9M9D7I6GKt/5EQqTgA/iQ2QAehjV234u
	 YFAT2O6XmzTeX9l9nI78c+OuI+vrlyGDMu28/cFZIebS7LVWB5yQYSIHuBROdXKmV/
	 POjWxbi8h52DJlKnFdWShCkvORSC+wER9+m5Nc5I6YVlHAPNaszz5jWURsoc99UxNe
	 HtvfWbnrw5mLr/fLV64EYTb0o/e2FYPIZl4AGyyNRZpEiF3Dc+H3TPm7clGTz3Hei1
	 RJrKLHUu/lKQlBjZQXWIB8Dd4bHzwpk5JakS/D+nuaTqJL6rz4xnryqSZJ8XfbWmNB
	 KVSx5DWPRFPdg==
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
Subject: [PATCH RESEND v2 28/51] ntfs3: don't warn when a huge label is written
Date: Wed,  4 Nov 2026 20:22:49 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-28-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=CQmQXvWqu+qpRxwX3Ai9kAzqqtrenD8xJsc3ckb17sQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bnz7K1goQOfBzlUZyTmXuaJF8js/Rb7//OzHk6rr7 JYtL5/6d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEvIKRYcP67G2i6Wf/B2W2 7txs3neapZ43c+rjv8+u3w5s27n+2X+Gv2LPNsjtr59gXDV90xsjczOOh182+JoIeRm6VIqkhV3 i5wQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ntfs3_label_write() allocates as many bytes as are written with plain
kmalloc(). A write that is larger than what kmalloc() can hand out then
trips the page allocator's warning, which panics a panic_on_warn kernel.
Use memdup_user(), which fails such an allocation quietly with -ENOMEM
like before.

Fixes: 7832e123490a ("fs/ntfs3: Add support /proc/fs/ntfs3/<dev>/volinfo and /proc/fs/ntfs3/<dev>/label")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ntfs3/super.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 29aabdc8a801..37e27b73b7a5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -576,15 +576,10 @@ static ssize_t ntfs3_label_write(struct file *file, const char __user *buffer,
 	if (sb_rdonly(sb))
 		return -EROFS;
 
-	label = kmalloc(count, GFP_NOFS);
+	label = memdup_user(buffer, count);
+	if (IS_ERR(label))
+		return PTR_ERR(label);
 
-	if (!label)
-		return -ENOMEM;
-
-	if (copy_from_user(label, buffer, ret)) {
-		ret = -EFAULT;
-		goto out;
-	}
 	while (ret > 0 && label[ret - 1] == '\n')
 		ret -= 1;
 

-- 
2.53.0


