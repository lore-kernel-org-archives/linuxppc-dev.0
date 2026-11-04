Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10B606D812
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc/lpKFD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZyw52MHz2y89;
	Thu, 05 Nov 2026 06:20:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820024;
	cv=none; b=Yk5vLdPcDVdziSfEhMW8QBfWxuhCh8mmreJuowM6JD3tRhMtw63/a7rGCh0dW9CljXLwpGjDyp7E+gK9+XxlOE3IjlKUslsQ3Z+pPGNYU+aWYNdWF00PkFr8zySmzDRC1VKUrt04T9Jfo7L+BFioetdotXN9O4d37DkfkW5UTDVzmIltXpYQGjVnoFiSHc7JPMmG2lgKbYc3etHbSbwf3ypv6WFDyDryRS4llC8qeCEbZtXrMMzwiDoiuc84BFBIKs+hQ4UbCveeMC60Onb8dwUptmfXXx0h9qhtAdWdev1QBt5Fq2thW1hiZRyymEt4soNMKE0BXYz/qYfODYPmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820024; c=relaxed/relaxed;
	bh=bDYBcNUn+VWuCpTwTZF6KvGO9475Dcj2RU9o+tvUNt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYROSWq6NuUm04aIJ/QeoNFv7pvlyEFAOxfg864hx6e8yegHXimQ8cJPuiIR/CPQY0MdWV0EmtVOb39YMKMm+GLlZtYjYTVkZLWJBynpIkl371CwyvsApVoAUGKU5t72G3MUEZCQZMkubC0mdqKcN249ocVZ3SvflwI9yyf6MqkbdKL1I+sNoDJJBsp2Dv1Mc9eV15kHI9Qi4qmnyKKXPQwdKFoKGb8zIZ778cmlBmDkKsD5L3fm0jxQBkm4QP3ubcP2KP9OJ7RgqXRVesFRwli2CKWC6Yp9Q89ho5LgsC5s7Tt7wF2HhugVL/ZC2OaCQN9E0dlKx5v7ggX6E3UPQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc/lpKFD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc/lpKFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZyv6LJQz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:20:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 06D7E60D89;
	Wed,  4 Nov 2026 19:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53051F00919;
	Wed,  4 Nov 2026 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820021;
	bh=bDYBcNUn+VWuCpTwTZF6KvGO9475Dcj2RU9o+tvUNt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc/lpKFDn4s3PLh92W7MP/0EYRbr9DtSlo+aTgCoiS4rp456CG2OTm4mdzAcBJWEq
	 Ldjk5qAoEyhPyjStEGoJwwsLF6muQudRMZSm3dpoh/6WOOqikDwAONtjMuVpHReos4
	 Y67yz+y4bnZfnPjGe5X72XzUWZlpcgaEPlqDhTQSTzjJGylhHoAXVkmsvgtRloeENx
	 Ezkm9787vd7BxlmMILJww46DT1dWDqRcMPOg2nMKQMVCbPmPG41MkkecEf01xpeInf
	 S+AV+2Ll9y4McQGjdLnxElbFeubshKJGcRNGF7y6UPi9zZBWMvJNlUtStZmpr1zHH6
	 a4kGFVBEfnA0w==
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
Subject: [PATCH RESEND v2 17/51] s390/dasd: don't look in front of the buffer on an empty write
Date: Wed,  4 Nov 2026 20:20:07 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-17-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=brauner@kernel.org; h=from:subject:message-id; bh=vNxDJDpmoyfXJahneUuQ9vEH9eL70g/8w71rNTJgUxc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bnywlMF3yW3bTMV5otIz0k5cNnaUnbRb6akLs2LWJ ybd53uyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyczUjw+J7+6Q6zp3ZqLzq nmj5ZNvI96xHteJ17jyP5eFsniikWcrIcPHN7+NqVe8Wda9KbvPRPx9rN23XpqQDn9ky+1XSGSp leAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dasd_get_user_string() strips a trailing newline by looking at the last
byte that was written. For an empty write that's the byte in front of
the buffer it just allocated. Only look if something was written.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/s390/block/dasd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 2ffe404b890f..e97891e58957 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -933,7 +933,7 @@ char *dasd_get_user_string(const char __user *user_buf, size_t user_len)
 		return ERR_PTR(-EFAULT);
 	}
 	/* got the string, now strip linefeed. */
-	if (buffer[user_len - 1] == '\n')
+	if (user_len && buffer[user_len - 1] == '\n')
 		buffer[user_len - 1] = 0;
 	else
 		buffer[user_len] = 0;

-- 
2.53.0


