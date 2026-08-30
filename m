Return-Path: <linuxppc-dev+bounces-26191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C157C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:48:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkkd158Pz2xr2;
	Sun, 30 Aug 2026 17:48:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076089;
	cv=none; b=GNZ19aRuv0/TdNlX5+T9UV1GZNiPMEMOjDas/BHpjBNtGpQStDm23xA/qUCI7If3WuUqhUlDmLSMykrbuOFnEsaqLzxqbw6J3OxB89Z7R4n9YRxvHNEtMZs8pHrKD4ouR9KUjscxcywXdoBcj0h9mF2OjyULxBN4mJfHCEW0vePeCw/zVp0nU8JgntLG2eSP7+tUXkKwYfPL9N8JT2/rnKPfLYTzE0+A9sNuA9wnx6qKgLqJ3i6JoKEtXHm6Kpw+FIKvN76uPIORx3+CKK05dqYl5mcvFFgmkEzkfAt/CGC7cBA7/C2eGTGo1klw1gM1vt9ZFq3zUJ6hRFkxMTkv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076089; c=relaxed/relaxed;
	bh=OUSBuPbkgvvs7WqRcGgbke6rpMilgaQ3CVPiWBPYFtU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BGv6T3lmoQ5wrzV8UF6OfzDZe/RAbh+ykWb2aFtJ9iic/KxpLAOLXPy7EuGvZ1iE3WLs7l5LrmYA02GmSxF7gI3rJRgEFssmPffWv0Gory1sBvh128X1ZjljQTOsbEQ+l1Rz6tdaUclbKIbs1Q49PFK+/3AkISSQAFxmsyL69nlleC4HbqQOBmINng5b+rmVHB/NMUbBBl9wCR+OGps4N/yMO/32hsQ5y/eJZKtsWFnPKo9Q9VglGaEy0RDiCHhVE4ENH/q5ulEc4JjxS65SvyBkuMJRHxlatA3u0CNqgZZajINPNOWK1b/yRfp6xKpSmhuXH9+XACaKmJIM3E6E6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXZjfJn/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXZjfJn/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkkb5r3Fz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:48:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3791843C76;
	Sun, 30 Aug 2026 07:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1DB1F00A3D;
	Sun, 30 Aug 2026 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076085;
	bh=OUSBuPbkgvvs7WqRcGgbke6rpMilgaQ3CVPiWBPYFtU=;
	h=From:Subject:Date:To:Cc;
	b=XXZjfJn/l9reN3sv2uNRKT5zpSYocUtRxKxv0hFlqrV2qAEv3KArYO1bQ5PW/ZzXH
	 +6kirRWN0MtdcbEr5t8AcnRqqDN66u266Jz0y749SjJeez9cY1jd8xVH+zOXVcsSxm
	 NcWySLa70EOYMctxt31QjbYGu6nLpYSWa94OkoknlcjRT99gYC8/e3M0BDRsRXw8c1
	 cfK8mDOHqBmw+Vbj+guW2u5KC6quklkb6MC7Xhw1DQ4T8CGy41suH4Ce++HEwiMPGC
	 1uQU3w+ur5AR/DGX88A29qzh3rDHzoaB9MRDS/t/K9w32a77MxjoBFVTMOBOaxewBa
	 33LT3VS739U6w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] char/misc: replace page allocator calls with
 k[mz]alloc()
Date: Sun, 30 Aug 2026 10:47:57 +0300
Message-Id: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2chsxU5/RXxo08xFsEqiIoz9u
 +18vOO4GYxV2ODUzaD8EZNHqbDbdEBTLFdGyZXB9e7QD+6I1SrexQgz0Z69D2EYM9T+qTzKd32
 dL3+2d7oxvdqgFSkaY9JYaGpqxbD1sCw/fME+7YgAAAA=
X-Change-ID: 20260829-char-misc-dcc4e33778fd
To: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>, 
 Eli Billauer <eli.billauer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

The patches are deliberately kept small: each one deals with a single
driver or subsystem and with a single type of allocation, so that every
conversion can be reviewed, and if needed reverted, on its own.

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

Note that the xillybus 'salami' buffer in xillybus_core.c is left alone: it
is allocated with __GFP_DMA32 which kmalloc() does not support.

---
Mike Rapoport (Microsoft) (4):
      char: xilinx_hwicap: replace page allocator calls with k[mz]alloc()
      char: xillybus: replace __get_free_pages() with kmalloc()
      misc: ibmvmc: replace get_zeroed_page() with kzalloc()
      platform: goldfish: pipe: replace __get_free_page() with kmalloc()

 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 18 +++++++++---------
 drivers/char/xillybus/xillyusb.c           | 25 +++++++------------------
 drivers/misc/ibmvmc.c                      |  6 +++---
 drivers/platform/goldfish/goldfish_pipe.c  | 22 ++++++++++------------
 4 files changed, 29 insertions(+), 42 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-char-misc-dcc4e33778fd

--
Sincerely yours,
Mike.


