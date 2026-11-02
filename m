Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D436087631
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/SfkjWl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG0X4xJKz3bcy;
	Tue, 03 Nov 2026 02:32:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633532;
	cv=none; b=V/7E1Y9jsuCWliuOS420zSrPhvm2xkA2G79B1ytLX8tPxilvDmu6EqsIeYNeZn3aWiZC76nmXkl1WXvNNvDqZCBl5XsorJ5W79kH8KutA5PJfVtlZzIHUPhLhkQlgQKvj1eUJxEGf4g2bnpF0zpaLCaDFAO+5BwjKoKvcgVMPt8CvMRHUbNHT3v6NdU+RYEX7AYxUQflxPIkLuy4msmN+8gfpr3tVmEujzji95upCGiIq+yo1wdKlf2jQaGI57FqezUphktm4J4o/i1rfqgXwbSfjajFusArwqXOhGIa6dJlaORAVts7IVFepf9J0j/qoWa8C2c2cRNg7jIz5avF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633532; c=relaxed/relaxed;
	bh=/ScPPr5h13RwAGNd5LaTn6V2vw4rEmThm0/Me/ibEcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSVTaHrtwPe/9hg4fzAfY6aqxkGPUPmRaeXri5gY3Q4Oba/A16yX7vLwL+340l7kbnNL54EUF4A5VRuOzR3YYjLDVrxjaTGqkADSahXHsgBI5z2UAEfJC5zhbB5j/ZUeRPH6Ez8MoAQ9MNNgJ6WYKIk/5+Nbu5QRLfi9+wbpH8gMAAoVVZE0Hh+KjYCShkvb0Tx2ZRhxoFVC+Iwzsk8PKC5hWnIWvhb0hebvc/IHVubaRO5Lwl+9r7HkAw0FDsc8yQplQ8a1lEJQyNSKhbmYW4dzIyjUiwg7uH0jVHIhGzPQod+OaevpdNN6lLVDDgOh505muX6aL+QDlXeW/MJ7gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/SfkjWl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/SfkjWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG0W4rymz3bVh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:32:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 125BD406F4;
	Mon,  2 Nov 2026 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834041F00A17;
	Mon,  2 Nov 2026 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633529;
	bh=/ScPPr5h13RwAGNd5LaTn6V2vw4rEmThm0/Me/ibEcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R/SfkjWlo0adylJibXR66wVpuLzM40UvXOuxgQkxjIb27PygVO01Xo6Y9Cxv0DOYF
	 U8vDJ9Lvryykt72BGFLhvtk7I7gcq7QnZbl3EX+DRor36ZfRQHoTy18ofbXZVWub8x
	 loiIMfSMmDrRidXBlhwmW9M/yF25pKJxozll8XYRFV3naaaJjgabiBmeWltQ5KlU4n
	 dqnB3zZZgSK5jXLooPwqv5t5ovJ4Em+lKQ2n3lQJaucJaYsVzo74JlgcgBbH86bHgB
	 0MidtBYGMNMDITSh0GhFH6xUCs+aKDllisLXlyelzfW76HVNTln7h8X9MMKkJGiQHg
	 RdbysmIcQlqDw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:18 +0100
Subject: [PATCH RFC 04/11] netfilter: xt_recent: let procfs own the
 seq_file
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
Message-Id: <20261102-work-procfs-net-v1-4-982104a4f592@kernel.org>
References: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
In-Reply-To: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TskCtPEUarxCx4EqZA92+8BIMcoYThcQZwAI90/Y1gc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG78b6LTCzn9/5cEdq8IeS3ee1vyt0J0uonutwlHf
 mXckYq90FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRHwsYGRryxfz51WWu+Ex4
 dvLygrAe7uvesdzsTw4nh8VUHdhTcoKR4UfM5V4bl2lCh997aOft/3BEUfL2u5mz19wX1cw4cIM
 vnw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and the size of the iterator state and let
procfs open and free the seq_file. ->proc_open() only fills in the table
now. Reading /proc/net/xt_recent/<table> then no longer holds up the
removal of the table.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/netfilter/xt_recent.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 11acb9a50d4b..b771cc463aab 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -546,11 +546,7 @@ static const struct seq_operations recent_seq_ops = {
 
 static int recent_seq_open(struct inode *inode, struct file *file)
 {
-	struct recent_iter_state *st;
-
-	st = __seq_open_private(file, &recent_seq_ops, sizeof(*st));
-	if (st == NULL)
-		return -ENOMEM;
+	struct recent_iter_state *st = ((struct seq_file *)file->private_data)->private;
 
 	st->table    = pde_data(inode);
 	return 0;
@@ -626,11 +622,10 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 }
 
 static const struct proc_ops recent_mt_proc_ops = {
+	.proc_seq_ops	= &recent_seq_ops,
+	.proc_state_size = sizeof(struct recent_iter_state),
 	.proc_open	= recent_seq_open,
-	.proc_read	= seq_read,
 	.proc_write	= recent_mt_proc_write,
-	.proc_release	= seq_release_private,
-	.proc_lseek	= seq_lseek,
 };
 
 static int __net_init recent_proc_net_init(struct net *net)

-- 
2.53.0


