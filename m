Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4060A3813
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvHRMzqf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDSk4vXrz2y32;
	Tue, 03 Nov 2026 01:23:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629382;
	cv=none; b=I9t59LN/Cwm4JNJj7BfrtYlNY8CBv4zmhXud2YyRFQIFVJ+Z2+a94vrw+N0H1GU+VH1K1texlfYI4u6exu16I3MI0zoN7dhm7HSuRPKPIWBvEIViOJkW+DVuwSAzbOOVqGAWKWX0nzHv/mcdLyPO9DZrTbifMxyXVGVfgpUubPY336nTe15/jjXlCkFShp20P3KEcvueuKstZAvbRKv46FjS3LCrJIPnhQqbt5eNqOuteVCnLsaV0EzwoQMk/f21moB3F06ycsxFPYqxLga1Krj4J9H6JvhyI/CNRRJCdDQ9SIePidpjFPD0+E3MkWMZPE7sXxvpUkiEtRBcVxPnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629382; c=relaxed/relaxed;
	bh=WXeWRtHDTvlcvQqGcGXKpHSOkC75TIYAS6cttW7V/+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcCJfHLYIJ+ZjH0rijDqvexoC2zDFEkhFWxjOaTCbrWUyRIIH1MLNewrdXbh4cMR4jJX/Mwg8ZRATLtoC/0Hg9Zo9E9/Mpi0C3BdYbQqyzNmHmgHjkNQlBJsdH4gF8VvFi27+ZQ/dxPyFnF4oUtgODybZzi9UVD9EVGxQghEe2sfA8GLqZ2QgHkkJ8lbWRFDWUBqYQCI+16Z0xBdddx5n0WghlHRYarN4e/WrQIGs5hf1tJkVWQ+V/5yRHLRDo1GV+gt7g3ls6SEONld0WoEcl9N+U9pskHHxGjYZurgRvRHj9VJiDvavYWGNR2JUAeEfiiTmTb/upbFgxtxeGZLGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvHRMzqf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvHRMzqf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDSj3bJ5z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:23:01 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09D3C602C4;
	Mon,  2 Nov 2026 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA61F00A17;
	Mon,  2 Nov 2026 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629378;
	bh=WXeWRtHDTvlcvQqGcGXKpHSOkC75TIYAS6cttW7V/+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kvHRMzqfiFxfaykdXJncqNCKytFOYdWEA6z2XKwrpx1cXAUWC/1f6IelPxZz69lt3
	 bZzGsPY7tAF+nhMSErY6rPc/3QL/4TA7hlVU8tM89mYfPX9Z6KS6p4IW1PsDrhG0OQ
	 bkcIKIyEY1GGRPu5UaBXvghHdY/CIfOPJbzAJZHTg7fVeaIOTOcs6v9yzyjdbAXIjO
	 eLo1eYZ4IN84HHP6CrAMeFl9oPgWiHXBV4hrBwe2eZenA/caTo8Hx2CSrazCqEHP19
	 DS3uVg+WucdQObp90U98MCzPe1bAhdyoN7eZZYLpOUglkgctnTto/e3gh/m1uyI5m1
	 KND/LIH3rUy8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:20 +0100
Subject: [PATCH RFC 05/38] platform/x86: toshiba_acpi: reject malformed
 brightness and fan writes
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
Message-Id: <20261102-work-procfs-bugfixes-v1-5-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dBPyRrfA4AE5uU+SDwP01KQAXBYhly7L9ZsRpXHhzrM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJP1X33fLpsJXpWBaifTEsT2SLto6RSE/d33f+fli
 mfvjj3d3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRafMYGSYH7L886UKoRuDq
 G9c+FRp4acs2loQbL5Kbz/ZCoj25bhYjw/4HhzpE/VP23N4kdd2x9P4SBZmAjRbxpyfu2bkqlD9
 1GTMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When lcd_proc_write() and fan_proc_write() were refactored their checks
were inverted but the && stayed. They only fail if sscanf() didn't
parse anything and the value is out of range at the same time, and for
the brightness value < 0 && value > levels can't be true at all. So an
out of range brightness or fan setting is passed on to the hardware,
and so is the uninitialized value if nothing could be parsed.

Restore the checks as they were before the refactoring.

Fixes: e1a949c1b988 ("toshiba_acpi: Refactor *{get, set} functions return value")
Fixes: 3e07e5baa2af ("toshiba_acpi: Add set_fan_status function")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/platform/x86/toshiba_acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index a0b8060836d0..9eb8f1e5aeda 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1498,8 +1498,8 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 	cmd[len] = '\0';
 
 	levels = dev->backlight_dev->props.max_brightness + 1;
-	if (sscanf(cmd, " brightness : %i", &value) != 1 &&
-	    value < 0 && value > levels)
+	if (sscanf(cmd, " brightness : %i", &value) != 1 ||
+	    value < 0 || value >= levels)
 		return -EINVAL;
 
 	if (set_lcd_brightness(dev, value))
@@ -1678,8 +1678,8 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 		return -EFAULT;
 	cmd[len] = '\0';
 
-	if (sscanf(cmd, " force_on : %i", &value) != 1 &&
-	    value != 0 && value != 1)
+	if (sscanf(cmd, " force_on : %i", &value) != 1 ||
+	    value < 0 || value > 1)
 		return -EINVAL;
 
 	if (set_fan_status(dev, value))

-- 
2.53.0


