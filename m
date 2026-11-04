Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA5607816B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q32w5rFD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKblp4jdzz3dWH;
	Thu, 05 Nov 2026 06:55:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822150;
	cv=none; b=jN4oNyHO9mTbMLvEpaJeth5/8bwy19Xu7VzMZo5FwAOuWAA+lBRySXWU5YUvmNqFjUmXVY83rK9rgip5eyVLIQil1swNXYQcaSPr9JGfQyplUHBay4+26qMyPgcvW1dCQfyXfRBTu1OcJMOlaV6PmuMTg5Byy4jFbgvvpzz9R6YCSSmSFt8Rzbu0DaMKeFo6CROsla5zGpJbgy1qDsY2fv3OSiaNAE3oyRQuKhVaBt7RVmkCW362lNLAwM+G66ixZLp/XpheCpBdlykZc9iMK7+GDgyuZbYNovNyjwS9TpSBoQ6VqBUTsgNrG20mKAge7uK1Q1WlB2+D6VckPkhTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822150; c=relaxed/relaxed;
	bh=fVQTaeb1oaPXPKdbaoAayfOvKvQGNQ+1mlgyJVhAprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gzm9e203dzgVZ+ypgNIvGcI/fx1CtaCUxvUsrirhdIrNvaFzQpjmOruOk0cppnbHTYQPn/MpL8SNg+GG/AZ5i0lHWOzYbrX/5gZtJ2VdqgONGhknA/C04W4jxIHaftXuWlNnDnzwvNuNCPGiqvWK9SBmC0XPlk0AW/nwSzupjH4TBzSBcyq4++Tr4tOn4lyZAqFhkvjE/8uwCd7gIqfjbjxQ4xxoIWFbiCDQsBiv0bDsYlQjAQdnTjwAvPkaHw/PPEfpIRzHDssbRJ4JkVw5cnmJvSX1gn8q7EbDtv9FWfxoTe8weHoU8eUAwSTnoxINtQUZkd/VzVtf6vWbduUlWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q32w5rFD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q32w5rFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbln6f77z3dWJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:55:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E94D411B8;
	Wed,  4 Nov 2026 19:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2F21F000C1;
	Wed,  4 Nov 2026 19:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822148;
	bh=fVQTaeb1oaPXPKdbaoAayfOvKvQGNQ+1mlgyJVhAprY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q32w5rFDw7m4TPU///ekwITsZbRvjQsHLd+6HFlNz2/NJu79jBf1XLpN0vUw391T2
	 uw96M48YWvTVTZOd/quiW9tkip+To4fCWmrYtjAqEca7mU3cvv7TLSkJ2I5flbMddx
	 tnPejpzcW7k6dl9zEzi4pAyQEWKRu7sTsR/gjlQf9B6G5OOj4qWhqpT4XCaI3CnMh/
	 hxKIIlGSI2qxyvUVW6X5ewWtQ1YzM/tMkeLctqfK5X9ilrcEsCf6wf/+VMmbGZTiDJ
	 imQFLXZ9BYFgkxP3LT/ycmK7E4KCrG3osBwTZ7XN2hZPdxLRGjjZgnJNCE/fKk2Vgg
	 56mAj3Jb003tQ==
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
Subject: [PATCH RESEND v2 24/30] ipc: let procfs own the seq_file of the sysvipc files
Date: Wed,  4 Nov 2026 20:55:33 +0100
Message-ID: <20261104-work-procfs-fs-v2-24-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=brauner@kernel.org; h=from:subject:message-id; bh=X6b7xxVI9/mXpsMyNcc27ZCzqI3OxIvLBKPC0zeU++I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vFwli/OP28gcU6x0u9Lr20hZ/OW/Ux3Hlh8PSj+1 evPFOuKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4qjIyLNJbG8P2lu3B9+35 Hbo2fLdXVFnr727TUf79truJg3VZOyPDvTu51vy7Xnq5Jd/Q1ROI0K0O+HE2ZInIk8iog5PXrYn lAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and the size of the iterator and let procfs
open and free the seq_file of /proc/sysvipc/*. ->proc_open() only fills
in the iterator now and ->proc_release() drops the references it holds.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 ipc/util.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 1737d776bc08..8ec3bc328657 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -894,13 +894,11 @@ static const struct seq_operations sysvipc_proc_seqops = {
 	.show  = sysvipc_proc_show,
 };
 
+/* procfs opened the seq_file and allocated @iter */
 static int sysvipc_proc_open(struct inode *inode, struct file *file)
 {
-	struct ipc_proc_iter *iter;
-
-	iter = __seq_open_private(file, &sysvipc_proc_seqops, sizeof(*iter));
-	if (!iter)
-		return -ENOMEM;
+	struct seq_file *m = file->private_data;
+	struct ipc_proc_iter *iter = m->private;
 
 	iter->iface = pde_data(inode);
 	iter->ns    = get_ipc_ns(current->nsproxy->ipc_ns);
@@ -915,14 +913,14 @@ static int sysvipc_proc_release(struct inode *inode, struct file *file)
 	struct ipc_proc_iter *iter = seq->private;
 	put_ipc_ns(iter->ns);
 	put_pid_ns(iter->pid_ns);
-	return seq_release_private(inode, file);
+	return 0;
 }
 
 static const struct proc_ops sysvipc_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_seq_ops	= &sysvipc_proc_seqops,
+	.proc_state_size = sizeof(struct ipc_proc_iter),
 	.proc_open	= sysvipc_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_release	= sysvipc_proc_release,
 };
 #endif /* CONFIG_PROC_FS */

-- 
2.53.0


