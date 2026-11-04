Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE9606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlF7tGad
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXVJ3CqDz2xfX;
	Thu, 05 Nov 2026 04:28:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813336;
	cv=none; b=cMxJcUB4eNh40X2iJExLHFPcZA3PwwWmgd5EX/N7A158SFCsIeAiFzJki74V2ZkZei7fq4KeBN3FwnYJYocNabqW+56NrIWz+seT2Uygfzvpf7npp/e9a+4rLYc01Oirl4BKpPM22aYwa0KfACBPqRMPyOyIquCRoFawJ7hRp3eAkGxpPTNpqStO/rHz5JI27Dfn/ROnuZGHHNUJY3G/Fevjwsa9z7M0XhcpzebSAbupVqBKotoVSK3RTlnL/m4eCAvpG66whCIHmXJPDLpMrVWNgXlYy9TlCYZMR2zIVDs01EoTvV4ju0L8dj67LWV4jCZ+JqOBMMx9HgwvCGvvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813336; c=relaxed/relaxed;
	bh=Em8mdDwLTSxa5ZBRNu+oIoQ2F8Zgf6ZNSHVwHsLTxqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpYAcyfogMnC/qUSqNfEeNLsAFEnYj0C8DngBbp8oE3o8rCG9eQbFrHLpvHrKgdcP/dcukwctyZKVExy/8+TulLqaX7RmnbvX5yB+jFih1wNgJXWtVaU34rwI9ry7E1LOd4idHNEVDT7TGRWzl3pvSsN8Hote6BgEO0cFORCn/vnOqN1lgDjWroUN7f5yfFVyyzf4ILewu0ZMxG4vyZfKA3TrlMoYZ41AHLQJNzxf/ctVV8+9e1JiReVlCbTZXCzDrln49WLiMOnggTkrCGKAGv9bwL/ccLUx1D3fwJZFvE2EvlrixPger51Aj9uBacJ54jJytukBhGZw0ozVk8fjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlF7tGad; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlF7tGad;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXVH5JNSz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:28:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A11AB43E87;
	Wed,  4 Nov 2026 17:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F761F00919;
	Wed,  4 Nov 2026 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813333;
	bh=Em8mdDwLTSxa5ZBRNu+oIoQ2F8Zgf6ZNSHVwHsLTxqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WlF7tGadWEgcoZaI1uK4E88iTTgepprrifasds75i7VthYlwDtZlbOT38njQBleEb
	 UPbfRvu/3NbdJdmajozNFYEjQ7CLKo3CQ2J3GJ8KprOwgxaPeKR/tPjmsa1SVubVZc
	 1en2pZ6ZJTtEVyIRxb8Akk8hz+i5vksUw5t9jkHwoekjj/VsrPO/9oQMYE5lUZ/Gmm
	 GUjsDpi349fDqaFLbiGR7qDbPwtf9QbhpGmf9fVBlF6p4pM0JpJvP1ofrRorpGAY+w
	 2xFkMHZ1ZzA18zc8/hnvV/Wnix3shLePBWHi7TeHk0dW6WQ7yqtTL3j1rmlfaIJEkz
	 qVzdX/epmct3g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:18 +0100
Subject: [PATCH v2 01/51] alloc_tag: don't remove /proc/allocinfo under the
 codetag module lock
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
Message-Id: <20261104-work-procfs-bugfixes-v2-1-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C5Mw1tWGzCvAVdyOdBCkcSqd8MeBZuRbzsUttoDJMVc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zvplOalNaKKt8vuu2b8lsnQOcTE/KzbYPv1ll+Xp5
 mmPQhjTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSn8/wm81Zr+lISs2Ek/OM
 L7KdEcq5v/O1XVLdtyWXdiY8F0/he8vwV96O52JXaCnv3ctHP3V8+3Zga6R61CzWK7HM88uSHpZ
 tYwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

codetag_alloc_module_section() takes the codetag type's mod_lock for
writing and calls reserve_module_tags() with it held. When that can't
reserve the tags, because the section's alignment doesn't fit, because
there are too many tags for the page flag bits or because the memory
for them can't be allocated, it shuts memory allocation profiling down
and removes /proc/allocinfo, still with mod_lock held.

remove_proc_entry() waits until every reader of the entry has let go of
it, and a reader of /proc/allocinfo takes mod_lock for reading in
allocinfo_start() while it holds the entry. So a module load that hits
one of those paths while /proc/allocinfo is being read waits for the
reader and the reader waits for the module load, for good.

Let a work item remove the entry in that case. The profiling is shut
down right away like before, the file just goes a moment later.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 mm/alloc_tag.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 82e2c3448dcf..7d7ad6704953 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/string_choices.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 #include <linux/kmemleak.h>
 #include <uapi/linux/alloc_tag.h>
 
@@ -604,6 +605,26 @@ static void shutdown_mem_profiling(bool remove_file)
 	mem_profiling_support = false;
 }
 
+static void remove_allocinfo_file(struct work_struct *work)
+{
+	remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
+}
+static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
+
+/*
+ * A module's tags are reserved with the codetag module lock held for
+ * writing, and a reader of /proc/allocinfo takes that lock with the entry
+ * pinned. Removing the entry there would wait for that reader for good, so
+ * let a work item do it.
+ */
+static void shutdown_mem_profiling_async(void)
+{
+	if (!mem_profiling_support)
+		return;
+	shutdown_mem_profiling(false);
+	schedule_work(&remove_allocinfo_work);
+}
+
 void __init alloc_tag_sec_init(void)
 {
 	struct alloc_tag *last_codetag;
@@ -855,7 +876,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		align = 1;
 
 	if (!ensure_alignment(align, &prepend)) {
-		shutdown_mem_profiling(true);
+		shutdown_mem_profiling_async();
 		pr_err("%s: alignment %lu is incompatible with allocation tag indexing. Memory allocation profiling is disabled!\n",
 			mod->name, align);
 		return ERR_PTR(-EINVAL);
@@ -905,14 +926,14 @@ unlock:
 
 		module_tags.size = offset + size;
 		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
-			shutdown_mem_profiling(true);
+			shutdown_mem_profiling_async();
 			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
 				mod->name, NR_UNUSED_PAGEFLAG_BITS);
 		}
 
 		grow_res = vm_module_tags_populate();
 		if (grow_res) {
-			shutdown_mem_profiling(true);
+			shutdown_mem_profiling_async();
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
 			return ERR_PTR(grow_res);

-- 
2.53.0


