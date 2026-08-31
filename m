Return-Path: <linuxppc-dev+bounces-26265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803BCC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMZ21WyGz2yCt;
	Mon, 31 Aug 2026 18:27:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164874;
	cv=none; b=I3c8D38OS0CNinat7MD1s8SLGmVE+hVtw85lk1ZkV3KOSSmfJTEH3TTSm0RvWqLDMgsbvmIHEYHu9vms24jdyoQgXf+bR3+gQNHIP5JuCiariATmPv+DPvJ9G99vJwRLzLBL1Esoyl3vWd3CAfuiykz1+6ThqggEn71HvQ++BM25e3X8yxM5lpc/zM167oI0LDpI0J4vV9vicsZN+D9WpPr4u9qyZbb2sEBLGGC0u+cKafGIDwiorC/R3aDJeFkII4o33NZX/0Q6sZkPwm0EKRCswX+ccCHZekpDn1wx26fJr+sROmlcR7MugBh6xu7dK/mxQFL0cLIzfV4iJTbiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164874; c=relaxed/relaxed;
	bh=sdnDSnE27149BUcPj7rnlsDQtbHL0lCszRlaB8rnvRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BM3OgDVmCJIaBhUmcQr5tFVKStivu85iL4nzgOL+M+7qjBo19CDtje4RTVDeHim8CuNpIAWET7PB2X5rmrS3tELcWPfZMltGoBAeqREPhs3RtMHbXf/+rgIpMXILncq84BV1+7Hd4ZWPXLNtNuev8EPM+eN5wWCG5Yw7oUqNW++xFqEHTMgwqzCktpxZPjCvYMzvueESOXZPnriUcurI0bzK0bR52SudHSBf41qLkzxwXyd1yTdAiLpSWW8rjGPCIneSrQwyg6He8W/tkYIHFVmDodrpfrCSitB2ZTTzMXVJHTBzFPe2MW6UbsopsFeGXA4elZlPlAXPPqAacMV+Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWpmUpON; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWpmUpON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMZ10gFhz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:27:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 046D760120;
	Mon, 31 Aug 2026 08:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237EA1F000E9;
	Mon, 31 Aug 2026 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164870;
	bh=sdnDSnE27149BUcPj7rnlsDQtbHL0lCszRlaB8rnvRg=;
	h=From:Subject:Date:To:Cc;
	b=jWpmUpONIzS8DwMc97TLTkDvp8xhwhffGlQU+Gw9Em5B9/M5J/Cen3D8DG3Ny5rXA
	 /X3Zg8kghs4opYX4bsP2kTLk7XDnWbqMZL1Vzm8Jn5XuxlWYWT4hHFfEGvfrdd8c9H
	 NzVseV+IXY50R4md+TZPLh5gPD1MHVOAhL0DHzfVzpTNJglk+qDD37TlvsX99DW0Xt
	 9isP1ngUcA7K4+tMAixOnjetJSa3kcD67YzuGUckxXQs2OqW8bg80rihAolDXHb6Md
	 TAMBYtTxtXGKbCNm7OumQSKQVq06YANUkHxfDCqBserLdiA6hvWA6Ga4/Iplu5R8Ir
	 yc49DsjUUXjFg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/3] tty: replace page allocator calls with k[mz]alloc()
Date: Mon, 31 Aug 2026 11:27:42 +0300
Message-Id: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OzQ6CMBCEX4X0bMlSsPycfA/Doa0LVE0x20okh
 HeXVo/fzOzMbswjWfSsyzZGuFhvZ3eAOGXMTMqNyO3tYCZASGhEy0NYeVMNcNZ11Uih2JF8EQ7
 2k1qu/Y/9W9/RhHgaE1p55JqUM1OUEtZ5Ga3J+jDTmj5YiljxHyshjS0FBw5GoyxqkFWrLw8kh
 898ppH1+75/AVqHITrEAAAA
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
v2 changes:
* change xmit_buf type in uart_{alloc,free}_xmit_buf() to u8 *

v1: https://patch.msgid.link/20260830-tty-v1-0-0cbe6170649b@kernel.org

---
Mike Rapoport (Microsoft) (3):
      tty: port: replace get_zeroed_page() with kzalloc()
      serial: core: replace get_zeroed_page() with kzalloc()
      tty: hvcs: replace __get_free_page() with kmalloc()

 drivers/tty/hvc/hvcs.c           |  6 +++---
 drivers/tty/serial/serial_core.c | 18 +++++++++---------
 drivers/tty/tty_port.c           |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-tty-84f05b74862a

--
Sincerely yours,
Mike.


