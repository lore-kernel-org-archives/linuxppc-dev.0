Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BE606A7EE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXuPQ0ie
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY1z6l64z2yDD;
	Thu, 05 Nov 2026 04:52:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814775;
	cv=none; b=fLSd5F2YDgoieZawRiUxC7i9pe7GE624v4jWdlyInqXApe6gHWujj7IXYNj0dW9rhlgltM9FWnhlj4AajthQDGyAfzKS2SkkAACo5aSmIjnO3ON+Isb9CZn0m88YAL1SBe3kel15KBD0PsQGokVIu1/VRYFPxEIIngyDKG8OP7nroDM9vsx8g6cEXD9Dj6LcQMHPnoFMoKoMYqWetJrGkU0sagoLDqLsI/MfmiAbXjP6B4++DTG0vrWFOaJWBdUTRgBveEYy+1mGelDKI6j+1PwS/aCxJMgvMLJoMW5th0bFSYVDftMSU+DpSENy5b3T0EOd1gVCdRfPiKZiSAEDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814775; c=relaxed/relaxed;
	bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbpS22Cu8W8exz2NYjQEGleSiY/QNI26yy+vtxt3FtdB8oCBgbqlqrR/rOOSsF40P4YbUe43DFiNnUHlq9Wje7vCkSOFiJikAjxSKCix1tCoxqAbtbgkZGAIB7Ey+EO7PTB5mxDi0XTBQPXGLZH31qOrmdY7Au+9bupTwei0UqVw2bxEGI23jnxnfe3vCR/ObMucBgzc3O3/RfRphfyaL135xwiLXTYF7s7ze9Tow9IWpWXHS0v/wwnrA9Uic+E5A5Q7o3VcUJUfE302I5fO5KWix+9NErOVRhZfKbCR3g6obRGTaAL6NPNMw+GpWiO+QXj2BfoXWo8UUMIV8sGYog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXuPQ0ie; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXuPQ0ie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY1z0qvFz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:52:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F25C6022E;
	Wed,  4 Nov 2026 17:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D51F0093A;
	Wed,  4 Nov 2026 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814772;
	bh=LkQzylMBPw/rjuFeKsFyNpbMkN4WRhLixyhJUzJNoRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXuPQ0ieI1SmEXC52KDOcGy2C42dUQXH2gWt2mtcU1/uOST36dyA2aX/TbZituA2X
	 Uhu3k1qct8vUKtDQH86VU1fhcBrjtbnzssmyZOcNcGl5JFmkchB4Gpruy1pXNgGar2
	 VxVKlSU3xlY2ad6FO1CicLCPJyfh4ydr4gwsesh5g7agPQ4ipkIS7Cs9Wpj/e9EmLS
	 Jm7RvFMHC/cB0vL14NXKg9Z/LHaENtZFhX3CEfJQZj2LcqrxZuIhRnv467SSOX8+tP
	 0daQmY4DIeH2JUseA+pOpqhVDaW3Hc6WCgGMkzhZymUpdndKfNcU8aZ5068txhavYL
	 LTnnyBYHI3CAQ==
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
Subject: [PATCH v2 28/51] ntfs3: don't warn when a huge label is written
Date: Wed,  4 Nov 2026 18:47:14 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-28-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=CQmQXvWqu+qpRxwX3Ai9kAzqqtrenD8xJsc3ckb17sQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znv41bfhRbr0hB7+QH1DQe2NteXb2LY+9z1XbHd4a cOjhdu2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkohAjw4rCmq+PWwJsL999 t/rf/719dR9cv2g/ad2gpsY5lzHE/RYjw7O2xVsFYh6FLFHbxmXmqiNfEK+8fvH1tXZe9j8O88X sYQIA
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


