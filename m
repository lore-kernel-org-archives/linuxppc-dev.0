Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56A606AC3A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNR1RL0M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbfN450Nz30Pn;
	Thu, 05 Nov 2026 06:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821868;
	cv=none; b=OcqO0VmHI6JKjSTuIjEE+mQ4uRhmwKaxHmhdDEzbQ3xGgt+/rywDZbSlWNZMP1QPNacp4EmXq1gzCjgUbDcIsi5IRrZ0z3sHuocUx10BDM0j6FodBeM7f8UD4jYdNWUV1XafP0KhXqNCdyQ96qqYGXdVE5X/nMYyYjj6SkcSoVj/FPBQt1nQ2w8M7d1R6yBBl9lxU0Fzv9BmjxlEq2ER2qJbP1hcQYwK1zZAEvqQpllKNBYnEtCFhVSa5rSoQdEHwDKaq5Llyfw2NAaGf1/kxBOb+0bH/FCE373mvribVnvNY2sd+v+/rhFAaVpF9xjoad5M+OU7f284tIiFF5P8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821868; c=relaxed/relaxed;
	bh=nEQe0uyLMhpY0v6D+NYVpfdWFgM7DE6SumWpafCq12g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpIL44SzR84GaFrRQ0SNh09hNRAQffxVR9tcNbiOY0AtqQI3gg/l/ia6B1IOEQQUSaZvsRdIUUAgcFJyZlMl9EEUNXqg3YHgXYcpfa37PWyNQztMiyS6X8/FFTxXnamgAKQRqs8boRXv7mAH+tFZJgF/76kpFV7bXp4JKpaxF/VZ/8AlmfWn3yMJvKik4v9rh8ByJaJpzB4xow2iUwrjr/Lw6F1OxxZTHPGF1uTnzVPsCMfY4dxWjPsAyO0wLJeNKRJo+jIb8BfXJU7liGpyUsh/xo2+nkxKXeray8IpRAfp2zcNcS8B9tnhj5LJrqbG8T7YLpzA3VVIUF10OJqoog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNR1RL0M; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNR1RL0M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbfM5QDZz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:51:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA4A34047F;
	Wed,  4 Nov 2026 19:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE711F000C1;
	Wed,  4 Nov 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821865;
	bh=nEQe0uyLMhpY0v6D+NYVpfdWFgM7DE6SumWpafCq12g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNR1RL0MdGjcQerL1pRweO0sDyx5srKRXEN8HDA+Rakv7ORmxGv0M2c4pYe9RS1TQ
	 0hEIzB+5FOF0UCUZDy2W4t4c7HuYIzaQJTIIdmOzZYD7DdxjyO4UPMNhgtsSPIcilP
	 VKQkCD781my0Xdy0OOhH6pW79rQPVmEqRIUUxd2NdY92712CXUTz6e3VpbB0hBPCek
	 OuNQy8Ti5KEKBVAOmNI7xjQ/es+OJejnGIOCcQv3TLP2VhuvJQoptNjkpFmMJ9AFiD
	 0pSOj7vYCxBvgAkRaIbFsX+qFB2wBAEL9TsIawHW/SCRe0fGQn34mw49XBQgFh27d6
	 NX3UXBJy8hndg==
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
Subject: [PATCH RESEND v2 05/30] nfsd: factor out setting up the exports seq_file
Date: Wed,  4 Nov 2026 20:50:51 +0100
Message-ID: <20261104-work-procfs-fs-v2-5-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=brauner@kernel.org; h=from:subject:message-id; bh=vD80ghFjEqER+DW0z2Tx247oQHe2lrzCvRX/1X8RBv4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97jE4HGMmWSWebTGtb+f+qbf6t/93PO9leHL1HTEbl YAwmQUfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayJpThr5Txruw7h8z+75d5 n1L9ZprSX0ON4zl3v9jMV5lvl7Zx8waG/4W80ze0KR4rWpY6/3hi66zKk8tmbsxvP1RSWORQnvT 3OCsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move setting up ->private and taking the reference to the network
namespace into exports_net_init() and dropping it into
exports_net_put(). The procfs file needs them without the seq_open()
and seq_release() around them.

No functional changes.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfsd/nfsctl.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f32311f2d7cf..f8ce3c0fb077 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -143,28 +143,36 @@ static const struct file_operations transaction_ops = {
 	.llseek		= default_llseek,
 };
 
+static void exports_net_init(struct net *net, struct seq_file *seq)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	seq->private = nn->svc_export_cache;
+	get_net(net);
+}
+
+static void exports_net_put(struct seq_file *seq)
+{
+	struct cache_detail *cd = seq->private;
+
+	put_net(cd->net);
+}
+
 static int exports_net_open(struct net *net, struct file *file)
 {
 	int err;
-	struct seq_file *seq;
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	err = seq_open(file, &nfs_exports_op);
 	if (err)
 		return err;
 
-	seq = file->private_data;
-	seq->private = nn->svc_export_cache;
-	get_net(net);
+	exports_net_init(net, file->private_data);
 	return 0;
 }
 
 static int exports_release(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq = file->private_data;
-	struct cache_detail *cd = seq->private;
-
-	put_net(cd->net);
+	exports_net_put(file->private_data);
 	return seq_release(inode, file);
 }
 

-- 
2.53.0


