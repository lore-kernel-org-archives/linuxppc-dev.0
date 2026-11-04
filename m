Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCF606D809
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME/FJRfX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbK50vk3z2ygW;
	Thu, 05 Nov 2026 06:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820969;
	cv=none; b=oak6edV71m832p1Ke9aT7lrKAKebjYADthw51QUwtChENTCf5mM5BrqwA2msT22aJAGRCbLLgDysuTMEsi8KBHz2rSDs0GpTsvwuDOfj3X6LB1k4/+I2NDtPM4DeQq4f707E+bPoRj42hTXxmi+j0LxpeHqLO2EqmvfWWOYWIH87VHxn/elpV/A67GL8y472uBtEw0ExtHih012IODL2Ymklq2FO58/aaDWtyrvrYwyVRgmOtBEj8dwLuHQvXc5dS+aEQ914XLL7lmUgwqtKcMAj7TFeY/E78TrJ6ofnbHeiif6Ja2z28w9246O4IEDUWcAFgg2kbEvMqmhMljxPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820969; c=relaxed/relaxed;
	bh=RCWYzTdROaZ//Ublq96X/PsjFPNs26aKqDomYMjplOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC0CfAuU/FMM5IVf917KtPDGJ0CCPXFHO/K6mSrmBrSxNzwG6B6ErmUOfXGIDOrvEgbJRWdaRy+PMXnO0Ey5hMzJtHlGY4m1V+mAkGm7x9IkPsQlRJj5MnBzz+TzdgAEOlaNi/EaD7R8PQl7DpqcF44xMRy6LSSuGd7/Q1SY8U6KDmJLL3d9+F+yX9BytCkC3RGDxXqBn6ngvAMDzYOsaSs87zA3XK+9N/pMDUcDixJlNE2SFFC1SrI3RwreOR/QjX/H5pgwcpf2GsJkf4ijY8c7cP2Jv3CFTY+Pqj4dPrAZLKrACAamr3OLEps/IW/gQ9TkyBrS7crfDMbSz9BS0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME/FJRfX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME/FJRfX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbK42f8Sz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:36:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B748743B3B;
	Wed,  4 Nov 2026 19:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AA31F000C1;
	Wed,  4 Nov 2026 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820966;
	bh=RCWYzTdROaZ//Ublq96X/PsjFPNs26aKqDomYMjplOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ME/FJRfXHJFiJdRPuFY8HbJeu+GJeM1uYMSHhRXC3OyCBFoBbHe/D+KeCbkSHUcc+
	 kLRnw4KPAQXBd/Lm2rxl+osnRqATeVzThclIJcTYxyw83fwPKWjsdttrzz2MJEJ/6F
	 npCV8gjOwaHDC61e0ru1NTfEA8b0b9x7dSf/HzSrhuivx0LurSS5jZoyjtt0F/X5HF
	 VXCm5Gcq8bWGfXJvVTfcnPDEXQVmN0yImiDrAgCIzYQ7ciRBherm+QOR9W6FvpFf9V
	 +E2b6pif2bObHvbMb8emuD8Je5Z+LHQE+m9YVr5ffRfEUXrIRpnoiS5t/MTpZE9nue
	 yYDTpnmmsO8rw==
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
Subject: [PATCH RESEND v2 01/23] alpha: srm_env: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:35:52 +0100
Message-ID: <20261104-work-procfs-arch-v2-1-2aeb952c9597@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=brauner@kernel.org; h=from:subject:message-id; bh=ud6jo66qun6GxlQdhdvRvLMRIAP9XF8+raIGbqJmJWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97ngrnBxmYyak9tmw1FJNeJLkRYtVzupn21htlqi1O tScYHfuKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjpJkaGRUtzVix3XJqTVWf1 dU6h87OwGM+PZ2ve597KXb144TfGWIZ/ZoovQk90zVv4S5HDJPnSp5RpZyfb5iyb8PbjaTdr44T nLAA=
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
/proc/srm_environment/* before it pins the entry, and hand that copy to
the console callback through the page it used before.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/alpha/kernel/srm_env.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/srm_env.c b/arch/alpha/kernel/srm_env.c
index faafc2df7886..6a1742b09a82 100644
--- a/arch/alpha/kernel/srm_env.c
+++ b/arch/alpha/kernel/srm_env.c
@@ -81,7 +81,7 @@ static int srm_env_proc_show(struct seq_file *m, void *v)
 	return ret;
 }
 
-static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
+static ssize_t srm_env_proc_write(struct file *file, char *buffer,
 				  size_t count, loff_t *pos)
 {
 	int res;
@@ -92,13 +92,8 @@ static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 	if (!buf)
 		return -ENOMEM;
 
-	res = -EINVAL;
-	if (count >= PAGE_SIZE)
-		goto out;
-
 	res = -EFAULT;
-	if (copy_from_user(buf, buffer, count))
-		goto out;
+	memcpy(buf, buffer, count);
 	buf[count] = '\0';
 
 	ret1 = callback_setenv(id, buf, count);
@@ -109,14 +104,13 @@ static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 		res = (int) ret1;
 	}
 
- out:
 	free_page((unsigned long)buf);
 	return res;
 }
 
 static const struct proc_ops srm_env_proc_ops = {
 	.proc_show	= srm_env_proc_show,
-	.proc_write	= srm_env_proc_write,
+	.proc_write_buf	= srm_env_proc_write,
 };
 
 static int __init

-- 
2.53.0


