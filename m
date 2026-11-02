Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC96070C96
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jam/DikG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFnR4RJ8z3bkP;
	Tue, 03 Nov 2026 02:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632955;
	cv=none; b=OqP3k1opX5gW3dhyBN078VBOaEaaS6aAoKdhkR7+AzeKdZ7u0l8f+3USgBS7u+GYxuUB3L5IfdkJ3qEHuViP6+8KEtN9aHk91OhMp9cKQda3mVrz75MuQdMOQDnpLtUk0Pd2d0NzphLHngQgP+Pc35mNwkv85n9e2DMqB3sRr/84igtaX4OC8gdHpWuRdHmDQpQB+dDhYFI0TWKvPkJse+3oB1ScTquru8qDnFLehlT50d9h2WGLGwBQwCD4mmeF0NGq5i/fvyXSNupdAkZ1NKEQHoS4wEJ9+Va5SpP+s6+oBv9ZQ4i5USHWu7TSA1uwtGc1Th9vRv6+bVfREllklg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632955; c=relaxed/relaxed;
	bh=lzw2p1lwQVTXGjOVK+O2fRllw6EWFGiyVpP4wwnyOh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbsIhxn+Mx34OR8l9ds0Ifesva2CyIU7Vr8iwBy8qVt8clHJmnMR9nge5TdueqJBYwH7mYQp/J4rfbmKp/A9wyXdw4V+QlpybuaoGmzukEjSCBJIgRDwocFhoXqjsWGOsPwKHrVYSWmskIl0APqsE1K5L3atw+2i95pjJva1OjDtpsTLZW66KsnnLaGcWB164Hof3xfa8kMLojq5S1hvO46IKoKwcWxa0L6bw07O0obsUQS3rzNVSnDx/BtamNsE27dq+FGmzsRZrLIfFUHFsz9NG9x0X4IO7Fx7bAcTYepZJOK83T+4CyXuj+YWmT19nYyPvq23f1Fbb8YN9JTf5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jam/DikG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jam/DikG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFnQ5v7Dz3dJn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:22:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 50CAB40839;
	Mon,  2 Nov 2026 15:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0491F00A17;
	Mon,  2 Nov 2026 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632953;
	bh=lzw2p1lwQVTXGjOVK+O2fRllw6EWFGiyVpP4wwnyOh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jam/DikGbP3IcdUEgRo2CFdrSnYZ/3MSMU4LaHUHhtBAwB6d0wN4GG1MyQdeaC9Ok
	 wdJM+b/3RRtjlCv8z3tItr1QxtSmH9BkYdSP+SP67oPniRC+yl3OGovJKbnl6vggYQ
	 Xw6S0FI/uqQMcc4B28EcQ0DDMaWkGXvvD/9rG4J+o8qpnbTPjubCx61OEoREYP+wT+
	 n2SYcDkpCjIpsbDnXuLn3gvGvJMSkTaaQcGsDZNp5Sixc2gl8PYMoWuRLivBfr0Eti
	 JYdHka5rVsIFLmn3fwhKKgzdpuCwWerAtbnpQ53n/tpOZi1eZbO6XiCI8qo1rd8OmY
	 S9C/ymTqVEc8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:18 +0100
Subject: [PATCH RFC 08/27] smb: client: let procfs own the seq_file of the
 smbdirect files
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
Message-Id: <20261102-work-procfs-fs-v1-8-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RIZYcDqYt7NhFvt2L4C6pTMn3DylkXBLCyRwuGHjm7I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6U8n4ug8YGx1uVNoYGj8zfPCt5xX+/1GRB/J/oU
 N4J1w72dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk8ylGhs/Tfi77dN1/hsfq
 9zYVab+vKc/ddURfvDWri+u34qLfrzQY/tm3hDFcuBC2pbSmPpAxdem3TZc/mgiqPk5x3Kp2npv
 flwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the show function in PROC_FILE_DEFINE() and let procfs open and
free the seq_file. That makes the open functions unnecessary.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/smb/client/cifs_debug.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index dfcd2cdbb2a8..664072ab3342 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -873,16 +873,9 @@ static int name##_proc_show(struct seq_file *m, void *v) \
 	seq_printf(m, "%d\n", name); \
 	return 0; \
 } \
-static int name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, name##_proc_show, NULL); \
-} \
 \
 static const struct proc_ops cifs_##name##_proc_fops = { \
-	.proc_open	= name##_open, \
-	.proc_read	= seq_read, \
-	.proc_lseek	= seq_lseek, \
-	.proc_release	= single_release, \
+	.proc_show	= name##_proc_show, \
 	.proc_write	= name##_write, \
 }
 

-- 
2.53.0


