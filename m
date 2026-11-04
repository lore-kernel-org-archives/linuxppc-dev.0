Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F65606A33D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJwoJhhA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZwQ6BY9z2yQn;
	Thu, 05 Nov 2026 06:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793819894;
	cv=none; b=Wm8II9KD4imZImOHDXcDvfZ5KQiKzQtlcjgqH0iIvU6PM4HbY0fb2JxuAvQAsAQipeUdqVE6boWhLlhI2s+kbP8E3dZthA2KUYbo86z2paSNlSy5Ic5ls+LO6yUQZh0U5jLmxFKc27YY3cl/jLzdI8N1lOMc4KYD9DATFE2D264lx/dVZkLAo61dGIWftP7Lxif7YICEADfqOmzYFz7gJcMi1n2C0IyiTYWIKekMniXTBcmtmwjPFi/hV3ryGlrqCXGfr10+QbGSQpokuztXkYyArZAiJhzN5BwQvzcvc1sPhVkN3v9Z4VZpUcUhqBZEC49ukGw0fCP0eQpm6JG6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793819894; c=relaxed/relaxed;
	bh=gnzz2fT926tAung/y7Xzshf60AQanFXIqjFC5KSqJW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnZsgp5cBWAPDEJTqgLZ0qzyJZ4XxzUOq/BgENAW8uFcNsZmstTHg2tOcwYSnPDSnUmth5aFCqgEzrTLl8/4uOTXhMNGYqVrc1ir41nvTWMGueWFZUwdFu7Iitymh3HY2zwhd1wjo79pSeY/LbgkTlwdFtavJZqrAhR4SMjrmDHBDkMuOYe11SiVJejf4ZWWgY8TBSQGsgTUHLZTRWLFcAwyl9UKosMzwY5BOF+NNTqTnh2O/K6AgaZSmDafTeww/ayCEG/lzhMlu9sBz83PA7f/QZMmQ4ZiSv8yYJ65y3LrAsrEm8vjugbKb3SBF3NWRlOyZGmv4EJ3Uv+1mQjUiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJwoJhhA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJwoJhhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZwQ01Twz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:18:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FA1B43827;
	Wed,  4 Nov 2026 19:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A991F000C1;
	Wed,  4 Nov 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819891;
	bh=gnzz2fT926tAung/y7Xzshf60AQanFXIqjFC5KSqJW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJwoJhhATgLL5xfXdN6OGI5pF+zFeQ4+WjDNEmYUvZTHMkMM3eFBxWoobM0WXpN6L
	 UN1K0xLPqC6xno0sP505XFwThWfbay58UK+kSTD2vpnLdKzWFKNzP1giv5JOftlPAN
	 Lav0lUTUsfF4QNMQKGO/ATVDWFOPORj+D8twGViNFcODYJUEtFOTbyZUtap9bjA0h2
	 /y/zNq9k0GXM/Wcge/kDBQjMR/uKEl2vV60dRTJ8k+gOCXzwPxktA7vZC0dRvivZpp
	 96DepXBnx1as6j7eZVnuCHwHxCErTDabWI65gJh4HFpjHVsXeCp7TMdzgalcYj5T8Y
	 Hbm2eKKFQu5Bw==
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
Subject: [PATCH RESEND v2 08/51] powerpc/pseries/lparcfg: don't drop the last byte of a write
Date: Wed,  4 Nov 2026 20:17:57 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-8-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org; h=from:subject:message-id; bh=N2rHHHUzfsZsGLUBvdMxa3o2qGAAPzh8wsvUFn8S2uA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brzSemUj37ZpfEJdHNavdhRd85506nnq/+C3P7Y+8 TFiT9g3uaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiUnIM/0u5vFweH/p6+fPx 1Xd527Vmp+13uFo968XVnftb9sQmFZYxMkz6tCVlybzJutuORSfufHxkyiSRYzOO7z4d/HTf5nt 15WbMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lparcfg_write() terminates its copy of the write by overwriting the
last byte, so a write without a trailing newline loses its last
character: "partition_entitled_capacity=5" is parsed as an empty value
and fails with -EINVAL. Terminate behind the copy instead, and refuse a
write that fills the whole buffer, which can't be terminated.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 3280b7968cab..9882f98c0efb 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -699,13 +699,12 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count == 0 || count > sizeof(kbuf))
+	if (count == 0 || count >= sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
 		return -EFAULT;
-
-	kbuf[count - 1] = '\0';
+	kbuf[count] = '\0';
 	tmp = strchr(kbuf, '=');
 	if (!tmp)
 		return -EINVAL;

-- 
2.53.0


