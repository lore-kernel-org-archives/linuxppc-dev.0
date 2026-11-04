Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29B606D61B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyBwaL0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXXP3cpDz2yd7;
	Thu, 05 Nov 2026 04:30:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813445;
	cv=none; b=dmaBHcwwIUnvIR2S90vQmC5yxNPwWKxiKXiiKJQCsCort11eideZfxV3lDqK8vSbwcd6hNdEN2r8JRCwaWz3Pdg72cirEKkjhrn7OOj4Oe3GjNUAKHe0aGZ5Z4O8OCfNc1X515VqGiVs+frNb1G6hNWND5UABSYzwtYhHjx/7nxYYfystMbsHskn5l9QdZJzrqcPLngUDjZGxSABTZ2XmZDc4RGrST/Om+e26E+/T+17aBEyvH3wAQPxXqE8xzi0zkWcyW7ZsADTSUNqB7dayLiobczf1Omm4DgM+0RgqQJBHHivTlP9EvYAiKtULwlyiMNzTl81LBFUEIKaIvMQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813445; c=relaxed/relaxed;
	bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCqynZMngzXRkm5zXIrDksK8QncZNu4qp7MMsbRQT/9ZPqGCyeHGjbK9szEtqk4/1ouEpKpyNM8LjlRgGCLvuFNHJ4Nm95lLLdLYrh6RDV52kIXiLTcxEF0fuV9J4Ogbc8gtOZppptlgVSxPsIdU3LPI8LuFG+TmIWgE5upCkWoth2Q9H4PLadQqkoi/lk72OyNmVMAjPAQ1nvv6XpDIg1oUQesy+z8KLJahMns/jqh+JraAjEsHzAQCyBPQ1dVEYHZzY1rhNoGh2xBKI/EdOtmjZQ3naljUJ3cW9FxprYXlWTITL7BetoqZ0/NnmlXvD+g2qmWe+ovwAi1AIccUhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyBwaL0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyBwaL0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXXN5FhMz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:30:44 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BA3040BCA;
	Wed,  4 Nov 2026 17:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318C11F0093A;
	Wed,  4 Nov 2026 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813443;
	bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BpyBwaL0/aYVXoHwq05IXwkJfbiN+sH/NMlrIciQjG65t4BqcyIJFg2nSk8XDCCkV
	 c7rAC5Gwt0eJ+/2lGcpbp0ALBTDjeOzJXNQqmnuVDle4iduB5dvN2rzhDckY+qtIzb
	 gs1CNuM6mGLr4omD5X5lb2yIJHjoEFVFY17i90YDIqHEiBZHsPoN/pZZJkVTJ0KPFp
	 EUeGwANAMrg4AicMXKhoLnEodEFkU0cutq7m4urrRAjYhUQUJ5q8o2+x5TkfWHjCPD
	 i91uDDI+3s3/ZTdD9a7P2TXIzuGYqpzF7L202zVk0SuzYL1uXQEo7tJ52MN1ssXopq
	 kuzwiBlPYX93w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:26 +0100
Subject: [PATCH v2 09/51] profiling: report it when /proc/profile can't be
 created
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
Message-Id: <20261104-work-procfs-bugfixes-v2-9-bbf7d5546809@kernel.org>
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
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tYIXM5EjsYRFpz3d9CdZ23LhMvzI2JA5U8qSrxldqzY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zmb5c+HYnPYns6fufFrw5b7Y3/kPP5ytKnep0a7Jn
 RU85ZS3VkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDoUzMjw1q1TdWGx2OGny
 nwfxD9yf9a1xbZhUXGz4leXXTAWLvycZ/tmE5T+0eFcqb8S9dXuWRJTqOn+e0/UWz2+d/yn/trX
 0PxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

create_proc_profile() returns 0 whether proc_create() worked or not, so
a write to /sys/kernel/profiling that turned profiling on but didn't
get the file reports success and there is no file to read the profile
from. Return -ENOMEM like the other failures of that write do.

Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtime")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index e7defa90a34c..820d5ec909d4 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -216,15 +216,15 @@ static const struct proc_ops profile_proc_ops = {
 int __ref create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
-	int err = 0;
 
 	if (!prof_on)
 		return 0;
 	entry = proc_create("profile", S_IWUSR | S_IRUGO,
 			    NULL, &profile_proc_ops);
-	if (entry)
-		proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
-	return err;
+	if (!entry)
+		return -ENOMEM;
+	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
+	return 0;
 }
 subsys_initcall(create_proc_profile);
 #endif /* CONFIG_PROC_FS */

-- 
2.53.0


