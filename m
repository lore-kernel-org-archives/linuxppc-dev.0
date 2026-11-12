Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB64606A89F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct0ieuZx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQR045Dm0z3bNr;
	Fri, 13 Nov 2026 03:38:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501492;
	cv=none; b=ieCR6V+zhfYydpHHe8y/VIXuxDy2mprbvVs/aCXPPUq/5C4L168dta+3avU+T7MdJUiYGAmde/pdFWn7KyzXWQbqDsDVLGS6dIHxO3uO3BdNIyOo9CRHKoUwjkaxoV//o6uuDIIhIF972BbBGFYirNzmIBVChRT01NQVN1/kcPX87TVcsti8I3IOuntZlOHyAP1ajovB8GD+yNwjRKQRT3bNb0WGtj3XNT5V/q8GHOXxnUd8+eZj8qdEs96ITdiFGi+BuAF9QJsnRCIiSQBX7hcQWz82OhNb1D++pQkDkz+TE746HIBFXXf3iiVRZTljPQECrGK/8UZSfZMtb3C9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501492; c=relaxed/relaxed;
	bh=tg11reGp6/y5YQodUEdH2NhfRCo1EXpa30JYKUFUCXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ddrg05UejTmAiAK4zIo4lL/hI37gM9AlG4Xws+nj2qRqQsKYB8f7oe7YQR77tEbqjzzBuR+ihD/BdWUZ/ZUoWeIMt3oU2OmwUVFtR4+1HxzZauxjYzYphexlhBKNQSabRGbPWm0BHVAqo1oI9aR36razK39/Z1f90eHewZrDpClzlSIPhdjHTjGQixqV9W+ht/SioTSNYc3mhjH5l9iiseg2d/m9+91JhnepXNbdw7qsyTryddFxA5AYSG2InEfa6vmC2bkqvhG0oVZMzwhufjuSpZyWpj4ZJ0j/HnNeMegOFpbTwLujEjP+fl85lar7j0MFxuavjd6m/ytlNvqp1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct0ieuZx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct0ieuZx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQR0403Zlz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:38:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68849417B5;
	Thu, 12 Nov 2026 16:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB811F000CA;
	Thu, 12 Nov 2026 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501490;
	bh=tg11reGp6/y5YQodUEdH2NhfRCo1EXpa30JYKUFUCXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ct0ieuZxSJF+C+3ekWtkvAswjSRq4utdVYRR2Up0NV9RTebUlZoXzOhsIU/+KplNf
	 ccN1LqvaaNLSUHQd0D+H20oJ3lpDi6ORwoV3yLJ+NgqCKlZDl2jJ6l3wI8RB1Cpqd5
	 TCMm9RkkrkvH1E6ksAn/xeprzyVqWxnvDs48gDgZaIZ7GoT0nrLHnMmsHytnv6Bk8N
	 HZ3QslM6AfZV5kRsVDR1ubxLCuvA4t/bJVlIzlj4B4jb8rZcNoxSg54HPWCtn+8wYv
	 pWxhkZNv2N8USDXoiD8N/gzD9UMg6XSt8CIykxIKSvwsyDfzm3HedgLlY8x0GB5Ljj
	 yg0tKyys8okmw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:10 +0100
Subject: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter() everywhere
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
Message-Id: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4472; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rv3dL5CVw/xI5rVNJEEjG9zaPNbP1VG9+iQug4VKJfg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR3DKnst5cjfG5xsdgbCavdne+wN+Nkh/pffe02Mp
 N6xtffudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkoADD/wT5NYIcQd67a3j/
 1sc1zRBc6nxzfcAJjYgZL6b0veNRkGX4Hx0wbQHPbdM/b5N2z70xc5nvM/uz5dt/rBdy3nhl8Yc
 gcUYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the remaining copy_oldmem_page() implementations copy the page of
the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
do. None of these architectures has a machine check safe copy today, so
for them this is copy_to_iter() under another name. But the copy of a
page of the old kernel is in one place now, and an architecture that
gains ARCH_HAS_COPY_MC later gets the recovery without touching its
crash dump code.

s390 stays as it is. It copies the old kernel's memory through its real
address mode window in memcpy_real_iter(), and an uncorrected storage
error is fatal on s390 anyway (cf. s390_handle_damage()).

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm/kernel/crash_dump.c       | 2 +-
 arch/arm64/kernel/crash_dump.c     | 2 +-
 arch/loongarch/kernel/crash_dump.c | 2 +-
 arch/mips/kernel/crash_dump.c      | 2 +-
 arch/riscv/kernel/crash_dump.c     | 2 +-
 arch/sh/kernel/crash_dump.c        | 2 +-
 arch/x86/kernel/crash_dump_32.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 938bd932df9a0..0f2628872b00c 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -28,7 +28,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 
 	iounmap(vaddr);
 	return csize;
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 670e4ce818223..c774b3aba107d 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -24,7 +24,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 
 	memunmap(vaddr);
 
diff --git a/arch/loongarch/kernel/crash_dump.c b/arch/loongarch/kernel/crash_dump.c
index e559307c10929..03a136b8be8da 100644
--- a/arch/loongarch/kernel/crash_dump.c
+++ b/arch/loongarch/kernel/crash_dump.c
@@ -15,7 +15,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 
 	memunmap(vaddr);
 
diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 6e50f49024094..078c0d1e8df46 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -12,7 +12,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		return 0;
 
 	vaddr = kmap_local_pfn(pfn);
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 	kunmap_local(vaddr);
 
 	return csize;
diff --git a/arch/riscv/kernel/crash_dump.c b/arch/riscv/kernel/crash_dump.c
index ea2158cee97b3..0820e3db12603 100644
--- a/arch/riscv/kernel/crash_dump.c
+++ b/arch/riscv/kernel/crash_dump.c
@@ -21,7 +21,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 
 	memunmap(vaddr);
 	return csize;
diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 85c0e58f1a59f..2a5988b6e9d7a 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -23,7 +23,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 	iounmap(vaddr);
 
 	return csize;
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 5f4ae5476e193..cb202d4e1f703 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -40,7 +40,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
 		return -EFAULT;
 
 	vaddr = kmap_local_pfn(pfn);
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 	kunmap_local(vaddr);
 
 	return csize;

-- 
2.53.0


