Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372260703DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dr8wSvAV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY6Q2Mm1z2xwL;
	Thu, 05 Nov 2026 04:56:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793815006;
	cv=none; b=lB/9SJ4RwXRK/zmLqDhWm3QCgLUUziYRCctbtO8dyQfPounfwEr9A35ovIttFIzLILf7sScZsRHNg33RnFDtFAdxgeFlpG+j8tCQHTvlQh7qmq50Um9BqxDJ9LANN5DWUVSKBqd2guk3oOkdlY5kFHCva+Deeb40p8sa6Hi3V+4krlO2PstJMwoF7XLbvZWDqAnNpp/o5VLViuh1X+fGZAQ8Stro/Iv6/FMnbQwH1aHVB8LZlVl2bGjGcrbEHKZ0AX2wTtWZHn+PjKJuHbex9VwNOB7mgN24CHOoxUE7ql727qzmZ0XQFHtIwX7YOJoCrMkfK2bCL1yai1lr8tzI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793815006; c=relaxed/relaxed;
	bh=v5t8qKNo68SCWoforDimF8hL2ZYL+p0Okj8bWoZ1JT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEOyJ6HAxyIU99YULMGXYL1Gep+e+gBz8hc4GZKzYYDWrXuLsrDHedTalbzie1bcCMcfApmjiYAjTHoCDnXddjtO4bAmTvFEawtaBt8138lTMaosY1dZRsszsCOiQ38ESMEKcZY929zoMg/j3Jq3PAJhUOREMWxkkxfahT9IzgXbR4g1BqyCmv2ZUPy8zV6KNWsBkctXaEa1hNJXbXsWlCxmjeI714mUEwa5yVlrEn38tC2DB+tHUmnGbcyKiQVPAfrdSb0jWiLKB0PcjdTxkiLekuVU3t87h1jzy/8JdaVhNhUPBt5SFI/IGDsLVnAoryBpUs8Bl9Jc6mIrsAac1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dr8wSvAV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dr8wSvAV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY6P3QMzz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:56:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 688A343313;
	Wed,  4 Nov 2026 17:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33CA1F00919;
	Wed,  4 Nov 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793815003;
	bh=v5t8qKNo68SCWoforDimF8hL2ZYL+p0Okj8bWoZ1JT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dr8wSvAVbxP/ZcIFTBwPH9dzXvhuBn9mA9nVh+Xgz7CJcVvdC39CZkNme4AyXP6YJ
	 FWGyi7uuOUICVXiiTT/mIG9BdyZemGP4/ngMXLnrprJvuOVJflcC9gK/hPD0oGCWag
	 aT5p1c3BKTvIpwJq4lWpELTuhZe/zgt3mUlYbqxRoekrxsz67uxzSSFqG5FXwM9E/o
	 G1ugeyanFn0rXRDRijLJnbwzKap1acFDZxxJu4ignABfVoZxvW4pCLBHKwBhqj5cvl
	 DjsJARsAA6SkUoD00o6dTzmSQNCeteiSTEpImZSPqwk0YU1IwQ0d1qUYo0SM+byxVD
	 zCyAfk3cQXcsg==
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
Subject: [PATCH v2 38/51] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
Date: Wed,  4 Nov 2026 18:47:24 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-38-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=brauner@kernel.org; h=from:subject:message-id; bh=2dbZnDPFapx3dAW5qeN54CL6hHWBvjsrs28L3h6tsIk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znt7V9L6ks/CitImMTaFT/P3tq0qmfiJVas86t5hC 6GvD3+pdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkXpbhf8Xs/zMjY/xX/2qd /0Cs7fedC69yp7xLetqeaik/5Q+3dQEjw6/vcxdp8XXWMTbHvTmdmR79flXw2aaoGkbuF4vOPfZ YwQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_oldmem_page() maps a page of the old kernel that isn't in the
linear mapping with ioremap_cache() and copies from it without checking
whether the mapping worked. If it didn't, the copy reads from an offset
into the NULL page. That oopses unless the copy happens to be a user
copy, whose exception table entries turn the fault into a short copy.

Return -ENOMEM like the other architectures do. read_from_oldmem()
turns that into -EFAULT like any other short copy.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 103b6605dd68..1543917bd3e1 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
+		if (!vaddr)
+			return -ENOMEM;
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}

-- 
2.53.0


