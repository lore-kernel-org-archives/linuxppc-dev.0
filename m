Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109ED606A7E1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt+YaIK4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXyG5j2bz2xrC;
	Thu, 05 Nov 2026 04:49:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814582;
	cv=none; b=nB3uboDQTG1FBfvCTzj6sXaUcD8eN4tHg31X37PSM9fab/VNKNNIU2mR/Igd6SxOkRF14KIg1TKzrIAhnOdA4gsrf6yNgaxKZLiS0klCi/3OPIQpEGB+GI2OwvXQayeeE+sHJWn5iEOJvQbcuyoUGrfESb9VZr2Fl9GqEWDCBNx+utR2ujcwveqcBnoWV6SVjLwgyBXCOjFUFZaCSuGjC9ZLa+UEuudmDgzh+Z9DOdDlfCkVLD85q/0sGBhGNjVUYNWkqv0pvXw8Ks8Vt4keApk/L/dwcRkqq7tLdQULxG7VOaTi7eFlo+1vnJCnAF22YZRljncPrekQFH5f96JICw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814582; c=relaxed/relaxed;
	bh=WXeWRtHDTvlcvQqGcGXKpHSOkC75TIYAS6cttW7V/+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6AsJiclHMz0wfZR8xNXPd11Dr5whEcS+Y//od/oL4GdnXHxq65Bg9hEoLSGrMB/CFwk+pXpHhXYb4FscCsVVaQEts4OK9UfJsfqg843XADCZMmyIXe5/DNllgi1cULfY2wwce7Mj9dwLQYdUGeUqHkAzFOgITBT9mixdESytpxr/2zFQhQ66KqL2Q+vPavK8QWyd6Hf+nH9usZYvZhrd/Kq5AqCcMw5rNu/A5xLMgrP5L7EtKfYW9tj9qDaZiRuAo0T3MnSmg/gIdb7r1YOLmLjl/NHIABqznUl8SPzlg1B4ifwZhrzOMtp5VCmSwCygfs5zkW3gL4hqjzlYtsfbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt+YaIK4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt+YaIK4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXyF6nNvz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:49:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA84D44098;
	Wed,  4 Nov 2026 17:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC01F00A02;
	Wed,  4 Nov 2026 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814579;
	bh=WXeWRtHDTvlcvQqGcGXKpHSOkC75TIYAS6cttW7V/+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lt+YaIK4iwvhO88yz6f+jCVQ4EeVtRm3q99whbt1o/jNi7xtD4GqEdXZoJFzfX6Mp
	 WhMZbYdWqf2DxTyriqyK8bk+1pkoMOeKNlWc1KnsmnTw9VPIopuCsvCi1M52TYyyYy
	 mLRpfJ5+g7TTPX7fTPYeQh+RWFIoWO07NXukL0yXrI10YEQ4gET0I5LF9DVoDQmUfc
	 lxhs2rswNnIdaIHeRhuWnBLDBlekuRGf9w/PHx4KPTJhR73a5GVIB+8eRNFo3DUyff
	 XmvJcy95iTPua8zzn9tBaoG3qUN1vOZ1Duxa0Dj2HpRO0snpxh5ps1EWgqor16H8rg
	 xLTK+rVahkKTw==
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
Subject: [PATCH v2 18/51] platform/x86: toshiba_acpi: reject malformed brightness and fan writes
Date: Wed,  4 Nov 2026 18:47:04 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-18-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=brauner@kernel.org; h=from:subject:message-id; bh=dBPyRrfA4AE5uU+SDwP01KQAXBYhly7L9ZsRpXHhzrM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zruys4H5zATJQ56FL4QUZwrEz3fqPb76g29l8a1fL 34Us/t+6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIpPMMf0V6J05hXXkg4U7m Il2PkyIVrevVp6rG3zbnfJ6waxtPdw/D/+K7i173sLVVenL7Mu5oFdvPFn8nM9t33dyDiXp7bPP NWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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


