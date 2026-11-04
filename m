Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA796071A0C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWisENYU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbPf35pDz2xly;
	Thu, 05 Nov 2026 06:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821206;
	cv=none; b=LE01KRPc/FT4eAt3XJVw8rFp5HTU+/bUhh1hd3b+aFWsS5XyJzEiTbRiVdhwMJ7qIoXTLt1UtS6tUpcZ9Yjsv5bR0nxLvZx/ISmSZ2gG80ZpQXnF/fXL20BAS1o62IokX/I4oG1AmQiV1EQgkyTZv0MyGNhwB3oWE2Qga/Gj2dzwWUWqmI++mRi4GCZXDaFhDhjOkqwBiDsCvzRoFEciiUFkOK0uI0KPJZ7nVhB9s3Q0+u/kG5jl52ob+hmaxCbELFZswgqWqNS+waHLq0gMOtJf10NAgfH7hYRxDYWe+6XaxjXEDRiS7LobO0YT6dMdpLtxSqVpkckiSryV1KAGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821206; c=relaxed/relaxed;
	bh=I1miZOwU+uS7OyZJ+vljGqgplXbL3g+w9Z/kHpw+0Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpCqCWgYhw41heunOTlagwU0T1C3Xd2tgcU5X826oqS3QkH6XQlNpoj1JN/h9a0J6IMgxKCFDIWU6YJ86pxkLcLEuqkFPdRgdjjSErjxm68qvi5e1VjqD4KJ1YSEBqse1UrQqUjw1OEb2PkEBP6JpmbuoNfF1c2v6LlaxtcO9dPEDtKdpFD+BKB3ngqa9BMFSlD36aPPw7xhYXr9wkiIb8cL2DWhw1XjYInKn+yLIfGEcWy2bLr01JOisNvWALmjWYRKmIFqnQGY9zkqFTnyKmsdI3vm4yke3hDA3UGXuGWXld8kG3SGRnQRfWb9R4qwBJrj7HmRx4OPUIXMVyB0JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWisENYU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWisENYU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbPd4WCcz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:40:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BC3D160F17;
	Wed,  4 Nov 2026 19:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400AF1F000C1;
	Wed,  4 Nov 2026 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821203;
	bh=I1miZOwU+uS7OyZJ+vljGqgplXbL3g+w9Z/kHpw+0Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWisENYUjAJsAzBSE3lGImGvChgp+BG03nV/9zJNmEmVEQqMUuspDJmWqJOL8vdCY
	 oHV2GpTw7nzhZ8YSayGsDUlJzGRv0ThytArIl/pXnKxEHGqUREbYMyptK2QRO4tWb+
	 0MJ2nNe6OsnVhX9kRXAgGrur5t53VezJ+BwOWZY1lK1M/S2AcooFeGbuJTcHh6MMK5
	 Q0olsGHFDarOPT5Tg5XxJr8bNViO7g5QRvPbnb/bbKcsghMepoAlwc9fQuisDpBdNj
	 xEFmyHVac3X4qFr6hW2l+JvJkyvtiVxI0WdyYW/zK53nj9PA2sh6Z3KYMrD0GYvMbO
	 MorJYVNGc2nSQ==
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
Subject: [PATCH RESEND v2 17/23] xtensa: simdisk: let procfs copy out reads
Date: Wed,  4 Nov 2026 20:39:48 +0100
Message-ID: <20261104-work-procfs-arch-v2-17-2aeb952c9597@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=brauner@kernel.org; h=from:subject:message-id; bh=lmVHOivhxd1ieO/qCxQCbfFgZys6nsQ8zrRpqRkdZ/o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mTUYCmvn7tj1bZ3nRPePsj/znEsO+Ut/5eb7fKhN Rlbli062VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR3UKG/45fU9K/nja5HyLM 7nljky3/puSce6cM0zZzlOzMKnx6ch0jQ/vS7+rz7ONa9NtY1Yu1H+1jtI6Tci9wC2pP5fa2eZP IAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
 arch/xtensa/platforms/iss/simdisk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 26c2fa39a66e..cfddfcd06be7 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -234,7 +234,7 @@ static int simdisk_detach(struct simdisk *dev)
 	return err;
 }
 
-static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
+static ssize_t proc_read_simdisk(struct file *file, char *buf,
 			size_t size, loff_t *ppos)
 {
 	struct simdisk *dev = pde_data(file_inode(file));
@@ -250,7 +250,7 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 	len = scnprintf(temp, PAGE_SIZE + 2, "%s\n", dev->filename ?: "");
 	spin_unlock(&dev->lock);
 
-	len = simple_read_from_buffer(buf, size, ppos, temp, len);
+	len = memory_read_from_buffer(buf, size, ppos, temp, len);
 	kfree(temp);
 	return len;
 }
@@ -280,7 +280,7 @@ static ssize_t proc_write_simdisk(struct file *file, char *buf,
 }
 
 static const struct proc_ops simdisk_proc_ops = {
-	.proc_read	= proc_read_simdisk,
+	.proc_read_buf	= proc_read_simdisk,
 	.proc_write_buf	= proc_write_simdisk,
 	.proc_write_size = PAGE_SIZE,
 	.proc_lseek	= default_llseek,

-- 
2.53.0


