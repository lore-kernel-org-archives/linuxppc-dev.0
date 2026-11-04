Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD562606D4DE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG3jfP4l
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbqw48Pjz3dfg;
	Thu, 05 Nov 2026 06:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822364;
	cv=none; b=nkhH+TA5AGnP7cormwuPT/pvpVtxCKWDSW+hMWoFsVIEds3kxAcx/X2I24REi2WKRF5ZWk74GYCCmRRnFs/jAmFqU5zVZ5VvbLrEJCbHxUIxJm8d8Jaen8a9uq9dWSdnfw0vh8q+EVYF21xPKLovcNqo9PWwKNszaT7CL/atyGX9I4fMOGVYTWyrdlSQDZWzpBk10hadIT/CmtbdsSLwHpHiVoxpyHc5hwflQjdnaA4zVW4hd5MViibUgqqCl4E3QqsDf5UHnbE7/PwbUrFIhuDJA63Gf3Mg6FoSHp4qlYDIQ/220syrKySJZSIMREj8NubRgPj/unCcvbZyymeFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822364; c=relaxed/relaxed;
	bh=fxIBhh7BKiMVxtDmu4/U+E0RVHzkWKjhatO8Mz/jm1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls+pWNlxU2od6PXbB+5mB+XcyYjPMaIhzbRG+FU38HcpnS89I9aC4B8uM8ei7+vhOMrGEA1OESQdAjnGCBsMRLSJCphQD46SCKpFCO+up6rCXjXx2Vo65Pki98CpxFRm+RgaQJdXLelmZkdqZ7ENkZBiBFmO76HULZQOCi9KKsLz/lFj555kZQ3B4mAmahaQu6onGIG9b0PR5fxMuRiQEuJDWhmKEur5azhuiqAo4XaJ3jgFP/HDkj0sEHgK/aeiA+hQNFkFQMlXuHvwklGQZCVSjDapXIeW8FDyWj824uFlALdteuNOpwFT9L2y6jFp3NGy1BJ0aKjU11RIi+OCLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG3jfP4l; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG3jfP4l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbqv56Lmz3dfb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:59:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 979586154C;
	Wed,  4 Nov 2026 19:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF811F000C1;
	Wed,  4 Nov 2026 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822361;
	bh=fxIBhh7BKiMVxtDmu4/U+E0RVHzkWKjhatO8Mz/jm1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG3jfP4ltLZ0emEodeqGyV0F81UQdOK9veUjoQYm4vphxyhicVcIAruAa+hQZp+vv
	 LuOy8c/zGjrkusiVcA2VvKJPewsxQtOI7YmD/bcmyRhjnxtsLluEEVPgV3DQNWk47/
	 mSdpjmiWy5tp6Q3PNAMQqcpNrwMMBVMexQqgPaJs3Iy/UBHTYwpQM+Lc5KFKqelFF1
	 ody93CB96hEImqNd69y/UCjV7GfX81amWcZ+7LnqODBl023Evc/9fAIcSNlwwSooaK
	 2T20X1BwYkngzdsHGxYvyb9SWZRkV/ciSqqkihKqF4dLUBJm1YcXlGUFPGXCxWvkvY
	 4eJobVyd6CS9A==
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
Subject: [PATCH RESEND v2 06/13] SUNRPC: let procfs own the seq_file of the cache content file
Date: Wed,  4 Nov 2026 20:59:07 +0100
Message-ID: <20261104-work-procfs-net-v2-6-221e2437fed1@kernel.org>
In-Reply-To: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=brauner@kernel.org; h=from:subject:message-id; bh=psvvZ7JIZLE0CRNp8kUfwlc9JvUIb4uUwK5YCFxYJEI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tM6n7F9Us5PDZO+pQGKZ6Zs1PCcwb/5cVO9pcRsm 2mK1t//dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkZiUjw8UVnRyhZ297By25 0hTRu+CuzNW6RbKizFpOAUYq+3ujLRkZjva/ZpdLVCpwYrJbpltzfc1blUefGwUv7OU14v60a1o EOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and let procfs open and free the seq_file of
/proc/net/rpc/<cache>/content. ->proc_open() and ->proc_release() only
take and drop the module reference and set up ->private now. The
rpc_pipefs file is unchanged. Reading the procfs file then no longer
holds up its removal when the network namespace goes away.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/sunrpc/cache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 1ceaea7e01b9..007521e8a57f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1606,24 +1606,28 @@ static const struct proc_ops cache_channel_proc_ops = {
 	.proc_release	= cache_release_procfs,
 };
 
+/* procfs opens the seq_file */
 static int content_open_procfs(struct inode *inode, struct file *filp)
 {
 	struct cache_detail *cd = pde_data(inode);
 
-	return content_open(inode, filp, cd);
+	if (!cd || !try_module_get(cd->owner))
+		return -EACCES;
+	((struct seq_file *)filp->private_data)->private = cd;
+	return 0;
 }
 
 static int content_release_procfs(struct inode *inode, struct file *filp)
 {
 	struct cache_detail *cd = pde_data(inode);
 
-	return content_release(inode, filp, cd);
+	module_put(cd->owner);
+	return 0;
 }
 
 static const struct proc_ops content_proc_ops = {
+	.proc_seq_ops	= &cache_content_op,
 	.proc_open	= content_open_procfs,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_release	= content_release_procfs,
 };
 

-- 
2.53.0


