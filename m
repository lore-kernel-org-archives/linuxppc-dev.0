Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A5606B0E1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIoUwWZI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFSS0Dwtz3btn;
	Tue, 03 Nov 2026 02:07:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632071;
	cv=none; b=WqEB/URTKUbn0/Pl916duSm3mmZpdzoLd+nk3auQDg6bqyJJKlzizTNgQeZrB2GF38pspyXoe+wbLv9Ey2tJK1BC1MpkfDkTUDO/zkIL/ZVSk4mXZJPAidJsHesaCP1MLGuswsoHHgL3IrCrteYcezo3rl2YbdvTDTq8LTnNVGxQu3PIkv097PoByL//brtJfHSmkEZ3+MUrKFE7SzljHqkhKrruNq90jERNpzexXnRgCHbUWtkeUu2/u6EE+i2l770cgw4IDGeFtinPphg7kNC2my2xE/gb5kPrR8VggvC3sI7iuVkoHuCf//PySyGqQZwKAMGxmGhOcd2v1nQyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632071; c=relaxed/relaxed;
	bh=lzi0v2Iw6r5Nf2GLOsMSQBwdPNX93e2TzGzGfD3oQvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBqN9EPcxatrrzd3mRMjzTtO/TUj8CVN++gKPOtO6fnkT/et4B9nWljzf+2smWQfaIzaqZeE4SEsIo4mzrKG2U8ldEMWcw45yLaUrazF2ei+PS0u6myg4ynxVRVq+NS0Tm0vdA9yfoT9yQ2VYOA86vxGlj4FWgazRhtT85GGxxoG4yHezxZ9VVmd7pr33ym+pHDewVF5mgujZdv/sh+7SwcjTab6W5DmqyxtF2O8rjx2NBojCRBwN5UVrPF89RGLuPrRdkcn8VSDvAlcUx8ynfBlPLA4dS28Mi7ai8uJhtpeWJwTe18XYi1uwqAdokIJt1pYMrG2djdBaeG7GB2Kmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIoUwWZI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIoUwWZI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFSR1csMz3bj7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:07:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B1FD84378E;
	Mon,  2 Nov 2026 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6921F00A18;
	Mon,  2 Nov 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632069;
	bh=lzi0v2Iw6r5Nf2GLOsMSQBwdPNX93e2TzGzGfD3oQvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kIoUwWZIZJmPIDGcbCqUMn+ysgkkYH4B9KIOKwQcxHvHBenqGMDwfSExIyruQhbFw
	 GSvSuGXqLlsS/+2bX4zY15r68FSJdvY7PhgxxV9bnP9Q3PrAcl12NmKthDnezkWdzA
	 YQcdsHreaTBVFGkt5/ixU0O685iwRTrAmT2xH295OHXHJaGkHJFEIXEMqGqXCeqbKp
	 nkpHGaPfZ7GY12qU7tMKJN88syBFW289W+duXDc1qru1IIyFkTan4orRc22NIVl3pP
	 G9JHqYUFv0jVxFqVlQXSQgnsHBo0FeNBeFWC+sINyeJMsGIfziINB34GYCGOVyuJWO
	 tkxpbHP0pDc6g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:45 +0100
Subject: [PATCH RFC 18/22] macintosh/via-pmu: let procfs copy in writes to
 the options file
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
Message-Id: <20261102-work-procfs-arch-v1-18-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and parse the option from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/macintosh/via-pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 49f929ae10e4..079c085be5d2 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -913,7 +913,7 @@ static int pmu_options_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t pmu_options_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	char tmp[33];
 	char *label, *val;
@@ -923,8 +923,7 @@ static ssize_t pmu_options_proc_write(struct file *file,
 		return -EINVAL;
 	if (count > 32)
 		count = 32;
-	if (copy_from_user(tmp, buffer, count))
-		return -EFAULT;
+	memcpy(tmp, buffer, count);
 	tmp[count] = 0;
 
 	label = tmp;
@@ -958,7 +957,7 @@ static ssize_t pmu_options_proc_write(struct file *file,
 
 static const struct proc_ops pmu_options_proc_ops = {
 	.proc_show	= pmu_options_proc_show,
-	.proc_write	= pmu_options_proc_write,
+	.proc_write_buf	= pmu_options_proc_write,
 };
 #endif
 

-- 
2.53.0


