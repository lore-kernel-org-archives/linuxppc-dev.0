Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128FF6073675
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge/hcfes
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFWl5n4Sz3cJj;
	Tue, 03 Nov 2026 02:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632243;
	cv=none; b=IGtfBXbKkqeT96wQY6yJzqxLmah+xiKClzTOsheXB5kgZKakkhNNQvm1EPcckC1+5lRma4JlkWj07s+MuT5EqOIrWakqkT7ELb+ZXd3rBpE1zrz8ezwyhs2B6AilTh9EZQcLq0pKLv4tAKNFnLe0b7pAdl25LaMc0Ws6uPdIGodHQgZmwp7igWlYHyrhQaD7SbMig+42qc0nbf2cVVptBSNJX2n32CTDxFc/d+aroGvgTIiM0ysm0nHL1cl/eZZNqYsrNDky/VX589uZXdOPMZd/wCZzy7f6V8Y4QethUV9ZC9ZAvX2/gm/PaXIyCCy47C4/Oj21zVLJd47KOtoQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632243; c=relaxed/relaxed;
	bh=uhE82sMafPzxvfPBNz7KCycPN06o3nm9WBF7ozqhvvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ec86kw6ke7Vult2PX/zwqlFKxoWAjZPg2U+Jk9c1L519CweB0gZfJgA+XIV14PM3O+NhhgAE1FzablzSg5CBt5mFiVZc6MiCH/Kf53nO72JVlZOAmsVewhiONeHQMCrNLXIBsxU1jgL7rtUIu/c67P3Jrgjwe5l93pFSJ+kIkVbjejWrPuWy6yjlVVyif6Blinl/jqkCSQHUeMqb+0x4fePp5UrA/2yBhXuKGF24lha/RvS3lo5VaTorynZyiJZeFIg/JofroIR/t94dGfpQHtG7bJ2SJK7od8HHKyVATzSgGGW6qrC1eACj/Moaa1A7ewH1qNIPR6Lxb+foZYirOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge/hcfes; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge/hcfes;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFWk1l4Rz3cJW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:10:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6028C60624;
	Mon,  2 Nov 2026 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBAA1F00A16;
	Mon,  2 Nov 2026 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632240;
	bh=uhE82sMafPzxvfPBNz7KCycPN06o3nm9WBF7ozqhvvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ge/hcfesra4b7uwUf9ZqYWB9njrsdW7ikBhB2+TOOaHniD4pDo5CkBQJygC306u5b
	 wB/PtUdGYF68K8Wo2p8YgjLfxD3D2QhC4+E4fHRnOPwNucxkzf5DU27WF/NlWY0Iqy
	 GAJgUzmaayVQyj5BRZUykLpT+rpgSNU232/4wjRYpPZguWsLgLHVBrYn151kBTwpRV
	 nXPzhip9LUf2q59LdnLw/8JsXlkcQJRIUj4EgrnieDoD7zSduQEyreNMEArDccn4Qs
	 hw/iWwFl3I5EqeuSbLMiGYZHNpZsLMqiQMwr9TKPFUnb5SsH7J+RiUYOedx6+niPBc
	 3NqMUySut53JA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:08 +0100
Subject: [PATCH RFC 01/23] nubus: let procfs own the seq_file of the
 resource files
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
Message-Id: <20261102-work-procfs-drivers-v1-1-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x7z4QEHcj9RNvDtDgoKANKctl9Sfloc7qmQpa+Y73Ns=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WK7fFm4VGPxTRVG9kNHvu4d2mV3i6b4vmrNOVrR6u
 yuKTYntKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAhfLMM/qxq9uhSer5rKl2Ql
 TFnt4xj4b6+efHfdMuZlO/bd3bPxKSPDGfl1C7eGHtq3U9NZa+MW4UvzrpQ9y/tVL3jEJn1i6Nl
 SLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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


