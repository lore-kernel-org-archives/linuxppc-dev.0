Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB88608E09D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEtEk3Xg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFXB1nV4z3bpG;
	Tue, 03 Nov 2026 02:11:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632266;
	cv=none; b=bleyPeJVf4Jbh2Jfnr2egiWS9p0+1Lzp+xcM4idh2yR1ir0N1reLuRRGsk83Xv0EQAbyGjLulxr7HR6TGBPu84cBkC0jpuaLru1VIeooGJJDJKjxmmZydoIWAAHdEu9dXwdc1YUvvHqbq0fYvNvUz751xgkIs/7CvZFsQG9qt+MIXue6JEYHXR5499NUf+966kN4t0SraOdZUafYf9B9J+DzvIrAHNgpkE7sABzLhAdmZS6TM4k2uZDj3GkVeD9zDzogeUTnh4M8ZYj29yN8P5zyxFmP90mFrynILO4LY2a9fRvu+XRpGfb5o88u/l6/Rj48KxHnsM6wkk8DjnqbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632266; c=relaxed/relaxed;
	bh=gEfU3T2fMjgdZUubap6/Nt8I8xKTHWl/++QTJaSUEcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9sU/0neeJQ7xXVBqigv2wlzwwSEIlMJDb219+W00rvcSQfMtCynx4PBQGLZKsFPbtoTsK3n/YwxoSQYPPMpAqE9CfMNU2f+zJtZ1i2KFSYymvvw7F7e2Fu11AfOypOJ+0Ir/Xxp9QKWbgWhVRMemqAiLQI2N0RCSEki3YWFGsffk2iaYSsMd8xtJxwO+cDWXGQuRcSKImi7jiXMze/BHMVRuzxcRPiq6YyNKx/JI/OEcVglcpIiwV4Ixf3j0+h6buBg9zu0QP52NltvWa8b5XcydG8KZfqTbB1RrN5uj6/TdP6WNf4zPrL/zm+7y3V6G0K6xE3LgYsFU+aj6Sck8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEtEk3Xg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEtEk3Xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFX31x8tz3bcj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:10:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 600A660924;
	Mon,  2 Nov 2026 15:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFB91F00A18;
	Mon,  2 Nov 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632257;
	bh=gEfU3T2fMjgdZUubap6/Nt8I8xKTHWl/++QTJaSUEcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JEtEk3XgkB7h/KCKSpjSx/GQWpU/P/7tvtCdnnzCxrDpIn594psdLHFTrmfuke6dM
	 slBqHYXHnT54x/QPrsmxH3yeqxfZQPD2y0pgY1+PEiyIIJsHQEmrStcSZUBzYnriXr
	 z1cAZ9kaI1mij4Fc3B7DH9EC4k1fIQp6BDZOK3UL5awrKforvD4qmdeHd8pveKvbcx
	 iZMvCpnYB/tvXMP/UoxQpEd6uLwjQn9oT2yIsRi+8s3j66mGWx98OAk1gVJO1c+yd/
	 xAonphmuY1qwZTlY+D0zGjvzNIJDEogTrjTuIG2qL99CLq6eIn2OG7zpSiKwd/V4oF
	 8+lGx05vpGPgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:09 +0100
Subject: [PATCH RFC 02/23] zorro: let procfs copy out reads
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
Message-Id: <20261102-work-procfs-drivers-v1-2-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0V4WXwhQL5pRZKlAhpvNvMMTbS/E9DKCsIQEEH9Ob/I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7AIbrx5h2jApOfJWsWGW9hzDP7Z1n71GbDkhKjd
 1G75+1S7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/UaG36wcDIusu3nPOnFM
 /P+8oNKCR/ZZrpFyDV/sHU9NRa7UTIb/YfZNrhe7BR60inb8XH12tpIKe1zQvdmbziyrv3LhEYc
 VLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_read_buf() so procfs copies what is read from
/proc/bus/zorro/<slot> to userspace after it unpinned the entry.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/zorro/proc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/zorro/proc.c b/drivers/zorro/proc.c
index f916bf60b312..4e4ba04752ea 100644
--- a/drivers/zorro/proc.c
+++ b/drivers/zorro/proc.c
@@ -28,7 +28,7 @@ proc_bus_zorro_lseek(struct file *file, loff_t off, int whence)
 }
 
 static ssize_t
-proc_bus_zorro_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+proc_bus_zorro_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
 {
 	struct zorro_dev *z = pde_data(file_inode(file));
 	struct ConfigDev cd;
@@ -49,8 +49,7 @@ proc_bus_zorro_read(struct file *file, char __user *buf, size_t nbytes, loff_t *
 	cd.cd_BoardAddr = cpu_to_be32(zorro_resource_start(z));
 	cd.cd_BoardSize = cpu_to_be32(zorro_resource_len(z));
 
-	if (copy_to_user(buf, (void *)&cd + pos, nbytes))
-		return -EFAULT;
+	memcpy(buf, (void *)&cd + pos, nbytes);
 	*ppos += nbytes;
 
 	return nbytes;
@@ -58,7 +57,7 @@ proc_bus_zorro_read(struct file *file, char __user *buf, size_t nbytes, loff_t *
 
 static const struct proc_ops bus_zorro_proc_ops = {
 	.proc_lseek	= proc_bus_zorro_lseek,
-	.proc_read	= proc_bus_zorro_read,
+	.proc_read_buf	= proc_bus_zorro_read,
 };
 
 static void * zorro_seq_start(struct seq_file *m, loff_t *pos)

-- 
2.53.0


