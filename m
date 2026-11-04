Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AB6070E59
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXAwkLYs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbKx4N64z3cNj;
	Thu, 05 Nov 2026 06:36:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821013;
	cv=none; b=OjDl0iMxDfxAxMJFiYeTngtU9B70pUSQ6TSg6ZmlfapxW0kppSLeBMxw75Hico6X8BuR+9PHj2O40TpfrKvf6sKW5cnjijxcbT+omlNCa7mkzq6VA2QpsGswxzFq2d/DJ7iLRU/+bDbh69Oy6xnORXtanm/9SP/BvGqwAM3iMrobjeUF6WlqkmB3mBjPZcS86KBGLHP1sbFqnW3vw3UN11e8bdNG/PWkb8vq9x7qNIgcHRP/PqfkUNW6oiKHLoobFW037NGrV7FbBndMEtddy3XC6g87CstbrEi0kAzW5bq2y58Cv/Ix/9xXqOQoXLUhgKAL34PtRRG12652riyphg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821013; c=relaxed/relaxed;
	bh=wEPnWAoxjJOkMqmLZaf/U9t0SZ8y5Jr9Z0MZeAu0+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGCIman6XnEMIzpgRztf5n8p+nO12YGNHjNjg9JJ88d1Jh8ehUfIw7V4SyC+vPs4IelLULu0d7AlXoy/pFRia1XmLM24lUv5KceKoT2S+Hm+0uyPs4r3QZ0xbsKc7vdBMuCHnrjzam45idIGAZF1opQrBrK5GFOB6PDjQObaFUMJpD8LUKvlqp/gkatEYyi+bDYb51PzyfTVkqtL09/ffu5yZ8v3ewAh8VoQadn43GrWwEHIDrS9736wFUxd0wyRB/5pgYfaFBjtgEByaptBKWGoSJagHj11bVJ1gKHLPQhXiKFgEXGBC5plRjVf0na8usUyMGl0xl3mkDtY9pnKyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXAwkLYs; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXAwkLYs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbKw58PGz3cNg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:36:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CEDA060DA5;
	Wed,  4 Nov 2026 19:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B64E1F000C1;
	Wed,  4 Nov 2026 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821010;
	bh=wEPnWAoxjJOkMqmLZaf/U9t0SZ8y5Jr9Z0MZeAu0+Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXAwkLYs5CMjRrIik+svwhbWUt5bDEP/6QOWaHqgQGnGt34I1o6T853RqAuV7Hurk
	 nJguWnT7WS2BCr/MHOaCcfo/y2YF8uonfqwKBD1vvV5BxItKSThPtia6lCKm8tXqBj
	 HyK614i5nL+pOdjZyJiH0sAw1f5liFCfXPhf+aJITyPVYu1xz3l6R95T55JjSVbsGG
	 gsd77y2zC/YQYCVOozDP6pBG6pwL8RsS6zHpDLqsqfvlDhE+Y1bJWPNUxKRk6rTJsi
	 AUUQYXCgIz2oR7YPa2yFabJiCl27Vqc82eAQrsoGb+Ydr/D+wm+kQ1Kp63UoGu/D5M
	 SSv/nmv1lJgcw==
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
Subject: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads of /proc/bootinfo
Date: Wed,  4 Nov 2026 20:36:36 +0100
Message-ID: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=brauner@kernel.org; h=from:subject:message-id; bh=Lp2WfN6gRzyIoXXnYjqLNGRBgINOkMledynPew9Qa8Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vi4tPTP9WOBc0V6N/fIbxTfPI/lUfoLfZZ8TRene TrRPhfPdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkUBPDPzO9krgvvw5fYBV+ 9H1XqQXvdO7wtZP+r/5w1yl9W/zGBWyMDK/aPsbxCnmcPB2wcdUkBYmzJVbHot9pzTMK2f0zZ9c se04A
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
 arch/m68k/kernel/bootinfo_proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/bootinfo_proc.c b/arch/m68k/kernel/bootinfo_proc.c
index 857fa2aaa748..4936cf44e86a 100644
--- a/arch/m68k/kernel/bootinfo_proc.c
+++ b/arch/m68k/kernel/bootinfo_proc.c
@@ -19,15 +19,15 @@ static char bootinfo_tmp[1536] __initdata;
 static void *bootinfo_copy;
 static size_t bootinfo_size;
 
-static ssize_t bootinfo_read(struct file *file, char __user *buf,
+static ssize_t bootinfo_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, bootinfo_copy,
+	return memory_read_from_buffer(buf, count, ppos, bootinfo_copy,
 				       bootinfo_size);
 }
 
 static const struct proc_ops bootinfo_proc_ops = {
-	.proc_read	= bootinfo_read,
+	.proc_read_buf	= bootinfo_read,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


