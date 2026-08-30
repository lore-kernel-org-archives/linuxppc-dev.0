Return-Path: <linuxppc-dev+bounces-26196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D19C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:49:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkmT4v9lz2ygg;
	Sun, 30 Aug 2026 17:49:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076185;
	cv=none; b=gz1N1jtcseVen8AXUvpgMlU4+4Yp2ySSrPzHBPzZNCAZMdcdVvZGo/oxuonSDgl21yzChUypab+hQoBTA5c/Wd6xQi3/I6rjmmwEHCrBetCJ4qpxS+OeHOzgNgYEdaO90u8HaPAMF5v+3KJmUZWCgJ2bApAMeBa4i3ednHC4s3scUq2NyceeTTsAlN1J1/PUcmW6RN9ltMF18fbZ4F5o9cB7XUlCVyU9JhYIDxHAtzGhQxnaUOfkupZbGYiItu00ebExtVBsiE33TPnOvuImhARdnt2xmaBi6RrOqcxK0LoFRSSSQNZ0yML4MR1MfWrZK7zbq1FADNPikwa10wYOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076185; c=relaxed/relaxed;
	bh=Kmf7UNuR3TJfz0wmHchwj7E8FCZ4Ng6XB4qrntzPsXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nBuKCn26ZCF7kG94/dm3Z52OfTxEUkUCNX+l3hUSyoPewvSJLmji+xhIRTUofWMWJlOB2ZVcNr0ScnC5cU63EcLM466MEi0YqiHDyu3JqA8TU80Ijxz9/tFE2K5xZ0h1kDf6UCUIX2NdGgQryXaz2irz7ljyIZam2GvDF2lrp20JRxPOVyt87VUrQuMKm2NM49Qts7hsPOeu7DUP/Jp7mpxbxSkNaQsskoN76AtRvX/t+9gudjVUvYmAnzxYV3DjahTfNkLiqIm/Fviq+aDghgbE1Y61u7x+yZRzJbgEifZQHCnFuEb9gceqsscWlnqztEL7ONqACzVM/AeXCeEB7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNe9x6Un; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNe9x6Un;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkmS4Q2qz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:49:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B5E54059D;
	Sun, 30 Aug 2026 07:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A190A1F000E9;
	Sun, 30 Aug 2026 07:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076182;
	bh=Kmf7UNuR3TJfz0wmHchwj7E8FCZ4Ng6XB4qrntzPsXg=;
	h=From:Subject:Date:To:Cc;
	b=eNe9x6UnAK5IeFqG2g12NDUx45i6Sa7NrF/9OqdSg+uGiEVFvzk5LFJM1blh/UbMy
	 BZdDLd/DVd8TX6VxnkN9vZ8z4Y0G81c3wDyXh6pV3V/c/msuMtzKI1ivKcA4LbE3GJ
	 SMADYzhe0EHnAp8QVn9iHnc4HAwNqZp0DizycG89nBIv7RLinZsDF8J5uANqqAdMd5
	 +2quL2ySSSXwdofmmFlhwgLBxah6rWfg7/YTIT0DhFiGrsE+iIVRR1rSgfZmODmmmW
	 bYJFZfVqhJVUepBerrCFkXFvHkrqPe7aFeEXQg2zv7dE5mUBz907gwL1aKOKkqXg2T
	 KV2IanmTnRHOw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/3] tty: replace page allocator calls with k[mz]alloc()
Date: Sun, 30 Aug 2026 10:49:36 +0300
Message-Id: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6DIBAE0F8xey4NRavUX2k8AF3r9kAbFhsN8
 d8FPb7JzCRgDIQMfZUg4J+Yvj7jdqnATca/UdArG5RUrdTqIWJchW5Gebddo1tlIDd/AUdajpf
 ncJpn+0EXy7Q0rGEUNhjvphId7K41bNsOOOCfDYIAAAA=
X-Change-ID: 20260829-tty-84f05b74862a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

---
Mike Rapoport (Microsoft) (3):
      tty: port: replace get_zeroed_page() with kzalloc()
      serial: core: replace get_zeroed_page() with kzalloc()
      tty: hvcs: replace __get_free_page() with kmalloc()

 drivers/tty/hvc/hvcs.c           |  6 +++---
 drivers/tty/serial/serial_core.c | 16 ++++++++--------
 drivers/tty/tty_port.c           |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-tty-84f05b74862a

--
Sincerely yours,
Mike.


