Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D22606D4EA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuEw75ZJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbqd6mgKz30WJ;
	Thu, 05 Nov 2026 06:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822349;
	cv=none; b=olWzckhUIAQ62MSKPFJfMXL3xowbMHe/j9MTaeErK2IJG2cAsDxmsJnPIQRUUy7XbXWW4WskmhuCk5uGixi4ZzCXUe8wYGuBP+zEn5ziLiirYaPGdfhhIAIasgW5tgmj96NWFmiqXkRuBv7j3RthxQjirY5OwskEZTn5DcNOAB1aULRb/JXndlJetDk+0dPvc6gaMJY9aA6TVnC/1DA6FH1RkJHv1Upuwb4EzjC6twDx0hXiLWSxgwVnX9rjLhc/i7WG2mBWQa1EZD1mUEQdSa8om0VtxWrXViq2RISra5lKMX4IINcJbUMTqusX7uQPR1YE+//7N/kloDqOcZI3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822349; c=relaxed/relaxed;
	bh=Q3KuHwYfVxA2BKW9aXWNrUpzpjPKgJiiNONww6sd1HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Msasw4maYhvN34ln/6yvtAtT0RGKdxVmjRtEAocbAaAlzpyVNViGls64x2Rozfefg1Z/xRY79/4VoletblGHDXJrYnlW6IoiPOgoefo0lljo4IeJbGsOu9+phUtoNWGQLmV21lzhyVxmQv6ZaTCD/klgPv6KB7UVp6frcYqXgCdPgGbbuEY6eIo1E1PK1uPDfBcsETjYxH/ZnifqHR3HrLcUlX4Z7ABi3Hp3pVbNbLLfELK5iVdDXGXfA50Gz09dt0UBDJmS6VinOmTpOihl4TspW0v67rt2P/bdHiJF6hTRd3nqS8tG6HvKQGPodRiaH8/bu5CyDwzFBr492Shanw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuEw75ZJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuEw75ZJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbqd17Pfz30WF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:59:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EC6C61DDE;
	Wed,  4 Nov 2026 19:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D51F00919;
	Wed,  4 Nov 2026 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822346;
	bh=Q3KuHwYfVxA2BKW9aXWNrUpzpjPKgJiiNONww6sd1HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuEw75ZJhJWFk4/5j/u2bOa+7AhH2+fwulBHYqhzPzRCBHuO79mUpmvrjD0ahvKTk
	 tMMZB0uhduFqD7adhZiOSmSX6H7pUU+Iz/7fWtjCvnMrG3tjuNjl57qfHN8JLiB+Oq
	 Rm3Oh0NCtCkqXkQz/53JQM+5nP4aVm6NoL6aw41ZGwVH+gIjQScKsibl7t28PMzX8J
	 Relz0swIFmj1/UzelogqSD10+6zvUTgti41r7AxT6l0SRAeqLuXeHIz+lQBCMEudJ8
	 D0gnjIUhzk1S8cbTK7duy1QIkzoOq9EjAM3ep+eRVQ08x7iwdviy9H2Isj/FwB5UIH
	 +hsUDCjAUPclg==
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
Subject: [PATCH RESEND v2 05/13] netfilter: xt_recent: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:58:52 +0100
Message-ID: <20261104-work-procfs-net-v2-5-221e2437fed1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=brauner@kernel.org; h=from:subject:message-id; bh=gfCX4go650si/jmePs4ghyuoQlNEiWKnWuOHaoexE2I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tPgfnpmuaqac2LLJosupqrIeQbiDbdNDT4dmvzo/ DFR21+WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpn8vIMOlw/R+eP/7CM+xs f+8t/fr+Wv4HSZ077vpfLO+H/1bx0WL4n5Sf/jFhe7/3hinn+vZsSZ0htMuiNFR9e88x7jnfa+s e8QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/net/xt_recent/<table> before it pins the entry, and take the
address from that copy. The removal of a table runs under recent_mutex
and doesn't wait for a writer that faults on its buffer anymore. Writes
larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/netfilter/xt_recent.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index a43fff5308da..72407eeaa9a6 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -553,8 +553,7 @@ static int recent_seq_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-recent_mt_proc_write(struct file *file, const char __user *input,
-		     size_t size, loff_t *loff)
+recent_mt_proc_write(struct file *file, char *input, size_t size, loff_t *loff)
 {
 	struct recent_table *t = pde_data(file_inode(file));
 	struct recent_entry *e;
@@ -568,8 +567,7 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 		return 0;
 	if (size > sizeof(buf))
 		size = sizeof(buf);
-	if (copy_from_user(buf, input, size) != 0)
-		return -EFAULT;
+	memcpy(buf, input, size);
 
 	/* Strict protocol! */
 	if (*loff != 0)
@@ -625,7 +623,7 @@ static const struct proc_ops recent_mt_proc_ops = {
 	.proc_seq_ops	= &recent_seq_ops,
 	.proc_state_size = sizeof(struct recent_iter_state),
 	.proc_open	= recent_seq_open,
-	.proc_write	= recent_mt_proc_write,
+	.proc_write_buf	= recent_mt_proc_write,
 };
 
 static int __net_init recent_proc_net_init(struct net *net)

-- 
2.53.0


