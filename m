Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C04606CA61
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKrAUcOe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXX85QYYz2xrC;
	Thu, 05 Nov 2026 04:30:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813432;
	cv=none; b=G4efk0Q5FjueViSxMT7VcOdb04o/UDWaR63ru+0rs5eCZWP0sP0OujROgMV0/p/w8LYkLMJuuF0X+cClxOORCUv2Zd/G2qXkBQJ081Er6QDwNmS5hX0tQnnzGl1d48ET0YUkutzImNrwwxQC/kJnpusiGhgO+74GiKv+FaQ9kSQtwfxAvpluaCJWt1tjLc2VLR2teL69v9Fx5cbdrIOkynxilOxIpOs8Wk6nOzih94kcTm8qSyOArlg+IclN4/IOyKB18UZdu2qoCm1MH29wXeRQUGzHvlDGACe6jgsB2Ut0dc/gNtkyr0Q80JEqVET4irmETFxAtAJmwoSHb9Ug6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813432; c=relaxed/relaxed;
	bh=gnzz2fT926tAung/y7Xzshf60AQanFXIqjFC5KSqJW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4NxUH2wCcff/YmU7veyuDAXZ0fyiEfCrBzvJ1xTtIku6gKbqFQsKTRhSXkBBLjzTym8DNwlsG8aSxNSLOZcSxiMWrsJbLSOgjFdRdXkNFsNiEm2YsWfufuUbZjPOeRUFpE1yVZk36xRnV/5TlZa9CWO+yYkiDTEoLNO56G/lJHvvrFoOL00EhDZPbn+QobzgM4A1j4ZdMZ6neQRGPIDkeeQnzBYe2R605LTHk0h/ly1+pQ1o1qZoYXQ+/pCH+IylskjTH3c3aPiNjaoRQkEFJDPV2qUVOPXL77IiGWRwogFEZ9UxgTCl5NQl292NkjYn8C6HO4Q/eh6zRtcwPtNLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKrAUcOe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKrAUcOe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXX76M5Zz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:30:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 00A7260A9D;
	Wed,  4 Nov 2026 17:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D051B1F00A20;
	Wed,  4 Nov 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813429;
	bh=gnzz2fT926tAung/y7Xzshf60AQanFXIqjFC5KSqJW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bKrAUcOeVzlg83/euOIHnVFterm+vHdMFNuNi2Dt0LF9VzWRfSHdWlR7H5c2KTzRF
	 naRK5w+k54/QDDCRMfWgLxdTPqv4FCwBsr1kXOzQqhEOlC8vy1IWJ41ODhEZLno2LS
	 jjGH8/XSd1jADyBL1p3Hc3Qgb7ui9/GDGzwbwzjY67qrbN3GQL5NP2Jybx4qUpUZX3
	 CQMNjfOnMG5qtjvL2qoA6KmgJggxXjaC2t2PuKCscK2/RkukWsmgaXtZ0l6oKz5iz+
	 P64zZ0Jt2cdani8OUoo4/+XjtpVm+osPlwpgz43htAz/C7aUhFTjPEXATp/jT4GDYM
	 7OqOzge6sGwYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:25 +0100
Subject: [PATCH v2 08/51] powerpc/pseries/lparcfg: don't drop the last byte
 of a write
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
Message-Id: <20261104-work-procfs-bugfixes-v2-8-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org;
 h=from:subject:message-id; bh=N2rHHHUzfsZsGLUBvdMxa3o2qGAAPzh8wsvUFn8S2uA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zmYqts+f6c771jBc691PB/aNiq5rYmuWq7o9SdKKM
 Ga7qdvUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFb8gz/a+f8MlT+0SWxMsTk
 QerGWIU8g/w227Ptd+ManyhO269pzsgwb7VmgtgD7UuXjjF+CvlTU3NkGv8+HhW+PC2DOSyTg2v
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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


