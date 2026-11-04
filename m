Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E84606B2E5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrIOm0L/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbdp18Fhz3c3l;
	Thu, 05 Nov 2026 06:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821838;
	cv=none; b=ArBX9pvh002gxjSSezBaZjjDdsyKpkPNEwkFU12oS3XRJUqbI64TUmnk5vue/Wlr1TjPZyBYfVezZ3JswPvsRmhtW0RVVtz8faCoZSBO9UlPjOyBfU4GKYy65BXyuIe9OOf12/Ca9cDbU+vp94qoWrv7t4fNLShk4QPnFMB/gHJGA5MLVWt18ivPABUwyIrYAR5AokxU+uq5TVv3LKcgaQT+SHgg2Ibaii5MUSRdeuE4mx5oZBfvvspgOrPq+D/EylHndJ3IwsHkATrfgw4Je0cB6Si2LBrFQLL78G41GRgKenCHzQFbVFnvjNYpfvsAhQYYKjZBpnLmtqE/m59WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821838; c=relaxed/relaxed;
	bh=mLB2lug1OKcpaTlobTkzaZ+4AMl2gIULemZI4iRmrDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkgYEBvQ3i8yY5bqx2vVLy7cce9U9yysteTRXeJ47f0SwlQLRU+7PwYnkPMvbM+AhczlhDdUyDxk2St0RSjwhk3hGPI3reCR6m1H3gYCFn2TAN0TGwzAyhS0pXseSui5nN2QK0Oc3CaEIXGGd4GHBZRo3I2mYlFiD+dmmIcl9XgYXW4NSjvq51SM15QBpaqUHro4ENa1EEf53IwYdzs9mOYNqUCOfXIbnmB5glK0GIX8imA6G4V6M3qxBzjRFf6ZlHiANhe6I2bN8H8+6G6snzE3AmQe2s7LjP+LbKGY7Zj3rHm1MDkkQS+tQHW7YexhI319MEpiOf/h0CYmFjXLuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrIOm0L/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrIOm0L/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbdn3H8cz30Pr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:50:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EC01340A9A;
	Wed,  4 Nov 2026 19:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A587C1F000C1;
	Wed,  4 Nov 2026 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821835;
	bh=mLB2lug1OKcpaTlobTkzaZ+4AMl2gIULemZI4iRmrDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrIOm0L/grPWsfSZ6ocvkczbqe5CDNutaK+lDTDGBJkYNfb+vQmtT5HzyIbXGVqHH
	 hWnfF+S7ghDcf3jndcQSye5gCwb9X8DYtZdri/cLH978S1GzMeTX/+4g/zFpOiqiNK
	 nGuFtvQNq7yvniXZ/lBAZLMxXQj5TNH6p305lsSnFn9BJUumbxC//DQvRndQEXtUIa
	 VsDikB9RkzCyzs7pmF52v+oL+Q+io92cATYHoyvEmPEV6i1rQ6jpin6iZ1aKk7/AxO
	 XxSIj8Dyg+41tnOPmTEYgnhNZHK5o6ae9seSm1c3a/IOfHTAzonXKhXGQctCWgRh8w
	 JPeajEykQHbCQ==
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
Subject: [PATCH RESEND v2 03/30] lockd: let procfs copy in writes to nlm_end_grace
Date: Wed,  4 Nov 2026 20:50:21 +0100
Message-ID: <20261104-work-procfs-fs-v2-3-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=brauner@kernel.org; h=from:subject:message-id; bh=QwlEC6TnrlqFxD7H1NEPhBXC4WfFu5kv5jak1b43Ypw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97tG7Wbqw7qWfktj9CUmzLuQuTBZfWKLcsbIl+K3pw z0MHG/ZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiI8DwP2PPpKWpiYbxYn23 5wT0zN8bdozx+0+hGoFdAkmmD+0WvmZkOLRmopvW3kn6Pu/cks9Okva45eWqIVawWoo1YVdnzJR JbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry. simple_transaction_get() was only used to get a copy
of what was written, so look at procfs' copy instead and drop the
transaction. A second write to the same file doesn't fail with -EBUSY
anymore. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL from
procfs instead of -EFBIG from simple_transaction_get(), which refused a
few bytes less.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/lockd/procfs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/procfs.c b/fs/lockd/procfs.c
index 74f7ab77535a..852cca8c3588 100644
--- a/fs/lockd/procfs.c
+++ b/fs/lockd/procfs.c
@@ -18,21 +18,15 @@
  * We only allow strings that start with 'Y', 'y', or '1'.
  */
 static ssize_t
-nlm_end_grace_write(struct file *file, const char __user *buf, size_t size,
-		    loff_t *pos)
+nlm_end_grace_write(struct file *file, char *buf, size_t size, loff_t *pos)
 {
-	char *data;
 	struct lockd_net *ln = net_generic(current->nsproxy->net_ns,
 					   lockd_net_id);
 
 	if (size < 1)
 		return -EINVAL;
 
-	data = simple_transaction_get(file, buf, size);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	switch(data[0]) {
+	switch(buf[0]) {
 	case 'Y':
 	case 'y':
 	case '1':
@@ -61,10 +55,9 @@ nlm_end_grace_read(struct file *file, char __user *buf, size_t size,
 }
 
 static const struct proc_ops lockd_end_grace_proc_ops = {
-	.proc_write	= nlm_end_grace_write,
+	.proc_write_buf	= nlm_end_grace_write,
 	.proc_read	= nlm_end_grace_read,
 	.proc_lseek	= default_llseek,
-	.proc_release	= simple_transaction_release,
 };
 
 int __init

-- 
2.53.0


