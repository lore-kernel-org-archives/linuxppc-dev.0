Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAB6070A88
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTvTLYti
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb772j0pz30Sv;
	Thu, 05 Nov 2026 06:27:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820451;
	cv=none; b=DcHDQ5PTOVUCNwqA4Q2zFmEZYCxhkIotdEM7i/59yqdqplBdFjfgdKoKFg2G0F9QR99TrL4EoxoAqDEjMO4qLFv5+/kE6EFGhvvnhzW7K1Itcf5/hpovuq1s2kTPa8OxX/+qK30eavIOLyWf8vEtv6abDqMW8Qk5ui6osUN7i8Cy7iln7Xujawx+pmpSdTppTCIMXebQXgeuZtNosGreYGR4bgv/rTi7E1tM5gs/mNdDvSZpRs/SSX0goYbbxDVifYNqGHFTrKtuAmFUSeL/hm44dehJn4i6UivRuDOU/7a7zMuJGA0QZVXIscfCnUHfQ4pgJSFVwyEYwfz5dhTRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820451; c=relaxed/relaxed;
	bh=SGZXtenDzDnzN/hAwCoJvR7nlijFBob6FQl7GJGEPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjybwfpvwnGRiK/uffC1YquvYpv5YuJoTauV2xNWuXrCKBl1q69F1Jt5XEdmumt4zvaOWXeo0TR4HOypdclmqplsOU+ou70SM7ILP657VdY9JDrByDPK8Z+ClfnY7OKuEf6ewr81bZhu+GPEJ9KQI+BSfYMHmzN68Al3pa54SK6STmoOGij8ZoPi4fDaGjv7zxCNbbvwfR93HSHnzaufB+QGowPO/xk4YNYp5hr7Xi2X9Ymcn06dmK8/HVQGNGehopCaQUacQwfYW+6viLvyemePBWZEBXG0LaF/Kb4yo4az5cpBAGohr7HlfNEQdiGsmG8i2EBhJu8j+e2wmIj39w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTvTLYti; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTvTLYti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb764wZWz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:27:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3074440168;
	Wed,  4 Nov 2026 19:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E111F000C1;
	Wed,  4 Nov 2026 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820449;
	bh=SGZXtenDzDnzN/hAwCoJvR7nlijFBob6FQl7GJGEPCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTvTLYtifxKVDAKFEwxAEpP+KqKkmbss0O3FvCVjbPGqXrJpDoCPGQ5oGFz8SBrvF
	 tD4WfYtmmvZefQl5gXXU+H6104nXZB3j0cHwCa26xKcGLASKW04PHQjju0x3TofBoF
	 S79TIjcYh1lweJqcaNbaT/pbmq+p2weA2MdCekZKRls0X/Ylguuocf58PMZMsqe6iU
	 WvCIu6r2l53iIdxnn8bil7C8dwL66KwhqW+O2kINiXOW3Ed+Ri+kkytDZR5IK/8kso
	 n+9Fdzr9qEImJtKrDVp1BycV7REVcXz7sk4DiO2Lwzvv9u/aZkCNq9czsaCkPV2+GQ
	 KdO70U2m2nATw==
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
Subject: [PATCH RESEND v2 46/51] proc: sysctl: copy to and from userspace without holding the table
Date: Wed,  4 Nov 2026 20:27:15 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-46-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702; i=brauner@kernel.org; h=from:subject:message-id; bh=+LAd81fwJIRlW5EjEhH8yOMnOBiQOQqVJycA7u6Pdz8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bmJ1eDRjm+PEc3vLTC2v/lkZcX9ytWi95Scpc5nVn y74amrGd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEMJzhvx/PlO0lwpvb3J5V fmKL8G+eIrrAz/ZQTsb51hX150VF7Rj+abVIqjzO1EzVz7t77eLZC5a9v0xatB6dWHvCQsyFq2M 7IwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_sys_call_handler() grabs the table, copies in what is written,
calls the handler and copies what it produced out to userspace before
it lets go of the table again. Unregistering a table waits until nobody
uses it anymore. So a reader or writer whose copy faults for as long as
it wants, with userfaultfd or a stalled FUSE mapping, keeps
unregister_sysctl_table() waiting, and its callers like to hold locks
while they do that. addrconf unregisters the ipv6 sysctls of a device
with RTNL held, so a stalled read of /proc/sys/net/ipv6/conf/<dev>/mtu
holds up every RTNL user until the reader gives up.

Copy in before grabbing the table and copy out after letting go of it,
like procfs and kernfs do for their files. The buffer is ours, nothing
needs the table for the copies.

That moves the allocation and the copy in before the permission check.
A write that can't be copied in, or a request that is too large, now
fails with -EFAULT or -ENOMEM where it used to fail with -EPERM.

Fixes: 330d57fb98a9 ("[PATCH] Fix sysctl unregistration oops (CVE-2005-2709)")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/proc_sysctl.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index ba52f13eb8f3..f5c9f04e8509 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -602,14 +602,36 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 		int write)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct ctl_table_header *head = grab_header(inode);
 	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	struct ctl_table_header *head;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
 
-	if (IS_ERR(head))
-		return PTR_ERR(head);
+	/* don't even try if the size is too large */
+	if (count >= KMALLOC_MAX_SIZE)
+		return -ENOMEM;
+	kbuf = kvzalloc(count + 1, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	/*
+	 * Copy in before grabbing the table and copy out after letting go of
+	 * it. Unregistering the table waits for us and a copy that faults can
+	 * take as long as userspace wants.
+	 */
+	if (write) {
+		error = -EFAULT;
+		if (!copy_from_iter_full(kbuf, count, iter))
+			goto out_free_buf;
+		kbuf[count] = '\0';
+	}
+
+	head = grab_header(inode);
+	if (IS_ERR(head)) {
+		error = PTR_ERR(head);
+		goto out_free_buf;
+	}
 
 	/*
 	 * At this point we know that the sysctl was not unregistered
@@ -624,28 +646,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (!table->proc_handler)
 		goto out;
 
-	/* don't even try if the size is too large */
-	error = -ENOMEM;
-	if (count >= KMALLOC_MAX_SIZE)
-		goto out;
-	kbuf = kvzalloc(count + 1, GFP_KERNEL);
-	if (!kbuf)
-		goto out;
-
-	if (write) {
-		error = -EFAULT;
-		if (!copy_from_iter_full(kbuf, count, iter))
-			goto out_free_buf;
-		kbuf[count] = '\0';
-	}
-
 	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
 					   &iocb->ki_pos);
 	if (error)
-		goto out_free_buf;
+		goto out;
 
 	/* careful: calling conventions are nasty here */
 	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
+out:
+	sysctl_head_finish(head);
 	if (error)
 		goto out_free_buf;
 
@@ -658,9 +667,6 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	error = count;
 out_free_buf:
 	kvfree(kbuf);
-out:
-	sysctl_head_finish(head);
-
 	return error;
 }
 

-- 
2.53.0


