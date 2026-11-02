Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771D6070D92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbhUJFDn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFlv09p1z3d0w;
	Tue, 03 Nov 2026 02:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632874;
	cv=none; b=GPkqqHaiGzW4vHiPhhToYff2y6rzZl0Ro9ZJcoYhquMDeDotE8WoFuKbIV3h2j3VkCpEu0eUBdhmUxmqA5XRUeqNWJdv5FZ2Jd82QN9A1RaKFSa1Ph/iSCQE+Kt6U+ZOneWnJM6HA+guk1DaCfBUH71/zK1uavRkeHWqh2KNftlwqXUIefQgN/NX5a98IcS7YNGiG13Tma+OGSx8LVuvlNdtKMbRmT/h0eQq1J/MbbB1jPHiZIm9Tg8hRlQRA1PUGkqAz4K4gPTsDL4Le+1OUAmnqAblGi6UiNmt1s7oDtv6OtqO9li7lSYi2VIluhT+fFUqjbkTsC9cdJaT7xxuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632874; c=relaxed/relaxed;
	bh=Qv+c+5TDu4Q/teEIdzSpkmAL+eEuuwslAw9ahtaZFXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiQjRpBSJWovBE3G3CvwmEw2Q0hZHgtFPa9Kg/m2u/d++/Qr8WCk+wV4IA7LsC+6leTAJe2xCTuitnItd1/5RszfTNBvr2OoPVyGoUOn3xWB2BpKZ9AbNB/+cj2mwb+H3BiL4umRCf9jFdgfYJXeumAM0bdRgqP5DpTlIORIvWUzvCI84qFKpwPpqxtObo5740d/Y+TQp/55ZD7b4G/eWOQ1pqC40OYQBYVfj82QiXtNNHxDxckKHBcVpGlr2GZa+yXE/j9aaweJfUjXL9Jkz3yBfj/AmM12FTdtFMqmF2B6KHnlwSVcsPSsnqwZbB8ud4gIz1czOVMbizMUbJXr/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbhUJFDn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbhUJFDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFlt13F6z3clw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:21:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D6D94132F;
	Mon,  2 Nov 2026 15:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31E81F00A1A;
	Mon,  2 Nov 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632872;
	bh=Qv+c+5TDu4Q/teEIdzSpkmAL+eEuuwslAw9ahtaZFXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DbhUJFDnO++WjegqV6sjnyS3otcl2/2sebZdDMTR095f4hFRZkMTGJyBlkuj94zIa
	 oSP3D1Ac7j4cfaoTs/YOZ/3HD4OntLtKpa0LwpNCh1+JLKi4UfYnGiwu0CoVUtic+M
	 /EOwTs/jPaQwpILuGPGbb/lTH5xfB3ImCVRAHdrO8lvkKmi+OSz4QkxvnUntYfmDLy
	 qsb4GyhuZqoOiqLcQKRlgK+Q8Z7rBL8ybky3VU6Bckc3xoq03qdnURR13NFJolGiGN
	 NMeI9G1ZGK8/Pa0iYX2UzAKoC/oKZ8aXViZ1ZRVWwt4iYelFx979KqrM1W3LPfQRZF
	 /OPD4WdSZcZVw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:15 +0100
Subject: [PATCH RFC 05/27] nfsd: factor out setting up the exports seq_file
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
Message-Id: <20261102-work-procfs-fs-v1-5-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YYADF9o+HT3otr/TqTwRIyIlVsvmHiIwO/9qKSxr7WM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG74im2vw/SLgkcF9xwvCrAujmja3vZs6iUted4PB
 lv0d6u4dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8jPDP8N52YHHueeITrga
 lFLZpu2/1M/v9c0uN21dk5DSny1CfowMx1f09ARf2fUkLZKFdYNHzvT2UqEvnn+41f65szhZbrL
 iBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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


