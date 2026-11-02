Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24802606A924
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZiOx3qz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDW566sJz30V0;
	Tue, 03 Nov 2026 01:25:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629505;
	cv=none; b=JkA0KHkHto2DVR7RnX+cjscboe9f6B/llFBWBMJTlWQrllXyeWaSk0uxP+dSsZQ/kszQaSolO9wWX23Z+VQBtYtRLU2EaGWLQa9shg3DEGAA74M3J5ELgIOUTKzOyqPw2j/SDDmYpDmlwsxtin6xx85w7Rpt8A84TAu3+zW9aN7hcCyikp0D6iRbdirNXMVFXryCejuCTvyPq5rEBr9YSI4MXx34LxbJW8Vw8VgSCHgQSIpDgXsIZrbXvaVDdL+/g4V5y0E9gE9ril5qeqMJwhe6n/iFErpdie68WXxCXm3Fk3M9QsRc8IvZoKf6N2qJS86X1Yy65QFiPvpTBp5fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629505; c=relaxed/relaxed;
	bh=yb3WLcVokXU6BuV8DQIS3cnoxrtkXR+HXTNSt4lhnr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2nt9dXDpdjifdigJqh+EABGF7/pfXBTy7pw+z4ehwWCZEFW3FaAtygdpsgB0Fhc9Zv6UhQvF5ccipKLLSc5epDzprkRSyhnHE2kkEhFkh/Ctb3JnAMsPK1iqg2gV88neLZudjClaFQtv/wToEnF6iO559EjEv6B8L12C0IP3wCBy6IHx70QlxduguCMkap01uhEP/YDq7KzOZ7ZX13vgA78AlxoloSX5vkO4IOgAlB4GeD1iMmr34YSMRBLkG8GKaQQojkR2Dpkf59QGgmgKu3UJ7bVvO2Ry7ef7zanmwpeBZM6zZ6mPrcfe9G/x7YNQob8AfkaCk0o6ZPiFGwPYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZiOx3qz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZiOx3qz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDW50mDpz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:25:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 988FC41838;
	Mon,  2 Nov 2026 14:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514531F00A16;
	Mon,  2 Nov 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629503;
	bh=yb3WLcVokXU6BuV8DQIS3cnoxrtkXR+HXTNSt4lhnr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GZiOx3qz574i7G4sq7Qj5FW+poGzHx4xdod9v+c0wQs044ndbo8YtJuzjzz+Le7ql
	 5cTxXE9CzWg6EPV4MxszbcLp2C6ZsWzp9oeVP6uoHj7upUPwwroLqNsh41Sz3JVXM5
	 yckoX19xo0T3oBfUMO+m7+UdClsC4AicPeSVsnbkVWlzvS64GY4fx7NtE/3cBm/jGz
	 ZM9+DG2Es/IdFoi9n/atozhLfqSzs42elqcEif/j8WN8Ox6UI8UdLXG/RdqSvOSB81
	 382CcANAMk/or+82KJJBXqoD4yYyV3R1x7/mjd7dPFt85mMcg0lpgdBZ0yY6v8VJOz
	 OgF1Yl254onGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:29 +0100
Subject: [PATCH RFC 14/38] um: NUL-terminate what is written to
 /proc/exitcode
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
Message-Id: <20261102-work-procfs-bugfixes-v1-14-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wRElBRQ5ywf1BhvCA77KtICLks8yyr6GFoKnZLCCyMo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJOdsKVmvtvqn+l+CqJcqhVTz8/M753i1MLdtPdJz
 RS2GwlqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5E8LI8LBw7tKUPiXhmasU
 BGdI++krPrfymz85hq3qxbk0wQO2RowMt9ZWzojz1tO+4XPUNkxeX7nqYWvpvKrUmfx7rnks+Nv
 HBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

exitcode_proc_write() copies up to sizeof(buf) bytes of the write into
buf and hands it to simple_strtol() without terminating it. So
"echo -n 5" parses whatever the stack held after the '5', and a write of
seven bytes or more reads past the end of buf. Terminate the copy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/kernel/exitcode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 43edc2aa57e4..0230354f4812 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -43,9 +43,10 @@ static ssize_t exitcode_proc_write(struct file *file,
 	size_t size;
 	int tmp;
 
-	size = min(count, sizeof(buf));
+	size = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, buffer, size))
 		return -EFAULT;
+	buf[size] = '\0';
 
 	tmp = simple_strtol(buf, &end, 0);
 	if ((*end != '\0') && !isspace(*end))

-- 
2.53.0


