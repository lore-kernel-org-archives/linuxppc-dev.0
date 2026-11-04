Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227066072FAE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY3vhRi4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbSh6F8kz3cZM;
	Thu, 05 Nov 2026 06:42:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821364;
	cv=none; b=KC13QPnmMEvDTbyefps3862ms+HbrIlM/YiThTl05J9EVXjvhYcZVhPNZeZvndcZvYJwmuG1MDxydft7XkuT5cZxfd4/mrXJF/7QXB0H2+KV52BgrnPMVR8Hw4QFSTRiTkwXz/Ico5HoFqSKrVjF48h0RIzfQfB+uQicsycijihlV6NOMBIU3iuYiMzjgB/lH0DYwpIYJy2HPpuDmkdIiQxVB4Dl+kGCC8lyfdFpLLPSFwIieR3VbYNGif/pYNJ/g19lQMczpAcW31R2nG1JnkXSML0Bi9ZOGM8+jOltFTWW6Q90PKWbfJJakEDNxwxt4u0I2jE+GavdVnnbBtnndw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821364; c=relaxed/relaxed;
	bh=uhE82sMafPzxvfPBNz7KCycPN06o3nm9WBF7ozqhvvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+lIAOtbpHhs4H1TNfaZgk3KZ/ArfVIVWQV4DsUD/niWuRFwzJuYIxeEj1n2oI3J3q+ytn8b4wXVNhQaN0rkZmhPmnop9o7E6NweBZr0yz5UnuxSHDSJ51AFwR+pSyUkUy7OB0BnBl9RMmH+PocbCfl7vZJ4hsQ7yPq4hjK3Kh4xKjg4HTNOtD1o+AWQ2BHhnjUs6CXT/DRQ1CjCJCUmTSS1RVRozIpwXC2oJb59p9Gs/xw20m6gR0a/Cq9RPDaYqcg69NJPLKc+GIZD5J/saigdasNTM+CgFOgPcEzTtVSpIHCs3CUUBdMOeSKCsRpHsizP2rg5z7+NlPbvNoV1rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY3vhRi4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY3vhRi4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbSg5dH4z3cZH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:42:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A9CCE60F10;
	Wed,  4 Nov 2026 19:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B831F000C1;
	Wed,  4 Nov 2026 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821361;
	bh=uhE82sMafPzxvfPBNz7KCycPN06o3nm9WBF7ozqhvvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CY3vhRi4hQxkqcpQ1Mm/O3l6e+OzedeN/4+37SeNZjOvlqXmy34qriVvD3TH67ywH
	 DQzl6FzuyIa5uiOv7Dc7vMjmQMkxqYHlBr0eMd+Xera9VB0QWJPHsXDK0rpkNzXBBK
	 tX9Y7Jq5/fQhLGsvIaKNSEhYv51qK+oUfD0NCrdQZjRmHE0FizjDeNxZM3dzQpWJZy
	 HRwBQTyj5k9AawVsBYNGBCFZHPpK+UsKw3yqcCB9jomRWBq8KMKMHMiOAFjbyWU1JH
	 JbXTNMiiUjnz72MrV0u90yAZ2M59tRnRkIXF5dI/J/zo2XxESLkUQl4Q5E9EaHZPuO
	 H5e07M+u+h5bw==
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
Subject: [PATCH RESEND v2 01/26] nubus: let procfs own the seq_file of the resource files
Date: Wed,  4 Nov 2026 20:42:27 +0100
Message-ID: <20261104-work-procfs-drivers-v2-1-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=brauner@kernel.org; h=from:subject:message-id; bh=x7z4QEHcj9RNvDtDgoKANKctl9Sfloc7qmQpa+Y73Ns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97ioOOa68o/Kq2fmOY5NWuTU8iP3ZEGF+bqWx4z+Wl OQWlcZPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5yMrIcHHmjxMtv47deeBR f8hmwmHx04XBoiyTn7ROi1p5ovDEfjGGf0pS7v/tJ675tu3LE5ZOszvfVmhY9L9Rd7yQdf+7rII THxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Get the inode from the file instead of ->private, declare the show
function and let procfs open and free the seq_file.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/nubus/proc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 3ea3d1738eae..cb21ad1d9964 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -107,7 +107,7 @@ nubus_proc_alloc_pde_data(unsigned char *ptr, unsigned int size)
 
 static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 {
-	struct inode *inode = m->private;
+	struct inode *inode = file_inode(m->file);
 	struct nubus_proc_pde_data *pded;
 
 	pded = pde_data(inode);
@@ -138,16 +138,8 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int nubus_rsrc_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nubus_proc_rsrc_show, inode);
-}
-
 static const struct proc_ops nubus_rsrc_proc_ops = {
-	.proc_open	= nubus_rsrc_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
+	.proc_show	= nubus_proc_rsrc_show,
 };
 
 void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,

-- 
2.53.0


