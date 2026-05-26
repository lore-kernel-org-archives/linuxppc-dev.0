Return-Path: <linuxppc-dev+bounces-21536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F3CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ77p1DS6z2yZ8;
	Wed, 27 May 2026 08:43:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818370;
	cv=none; b=RTWZWJQ4emkCP1PIJhYU281EWmvc98jpN4QVjDZAH9oyfgIiBI9hmfnD8LCFktvCLtwiHd1hvLsER5U1Wguc61pLxOZJWsS4SDRckw8I4YFuWaxgG+sXHMAetM3W/SCiMGjBa3RsfiwTP0Fblm4vEAafWpUpUrROfvWA5W3Nx7dZEl8u7ZZ1bqITzBvikyv8Tx8u5Xq6Q6VtV2mQdAPO8lerojx+8Cv+xLjEmOWy8OgggfecDdktZFUb8YReNX3U494QaIhQBDuAc/vo3fNBdT7UoQqJDIHXDaL9K1gK9dzfKBUx1Hq3Q9MAbPTgDu+WjdAbwy50NjSy4v5eHuJCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818370; c=relaxed/relaxed;
	bh=n0vWMvJYNWuq9BUtLKfBugHf8I5ifX5auG02Ilaszzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=netNhe9KJzt5h6IEZa/8e9h4eG7JRq+bcuXjm2asWS6iCITBxoPuaONXvIJAJSuBqTe+IOrvHqnBJIR3VLifhc+Ibg6VEWrT/OkclmMh/YaX2v+3Zl4ZEBwuE34JzArMp0WOqtmV99OZnwHJ9WpxOWDTF+YK3icvm2LA6u06boSBE4iwuW2t2WBerT2ilaT/mkp2OOf7ZJBa5iXutVQmWvoCBJ4cYuS5HBT9dV0e7BkAwRVFoDYeo4/ia5nF8VfMsHtk2QJFae15spG3S72NgOV09Nn/hZ9hOtY5lrfAB7iHn5Ft9wbd1K5HFFswMoaMinTiyDWw4Fg3o6+Nnvcyxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DWgunEPl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3en8vaggkdouhyki+npanvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DWgunEPl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3en8vaggkdouhyki+npanvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rJ4Qwmz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:28 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-49045243094so63727615e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818360; x=1780423160; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0vWMvJYNWuq9BUtLKfBugHf8I5ifX5auG02Ilaszzw=;
        b=DWgunEPl+jv/RrYmP3NLEzmN2llLHLCuQTPLlWN9Jem7h0fKrU6MzYHlk8CeiVqJ9F
         tL8okAkjuu5CBzrvUWUpZogBCdagNfhu1SCqm42qagnfAdX84+suQlyabdlnB2V8cnOT
         W2/WLjcm5ptUMbDxKmx+b39WB4j96eUJGNhPxwa0qLnHm69YEPaRJpF0EQF6QUHxtbJg
         eHmIskDqVTij5ZDadLdVtpiqyxp8Z0zyEmRclEnsR6nsQwdw1kaTzp5j6Au42GLux3jj
         RGojpWAUba3+SkyxdmH6EuDOikUeR6QFPSb6zEheisw5ZD48a1qnX0k/XFVTotfuQDS5
         gEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818360; x=1780423160;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0vWMvJYNWuq9BUtLKfBugHf8I5ifX5auG02Ilaszzw=;
        b=afC/g8/1hAWstZrduPFm7HPldZOrgBjDBa0xnvbgM8cOtBsqC/ipFq8uY8Q0NAonzd
         4v3IOO9Wxb4TOrBRa7T2sd8MGaV6o2AVpEMYX1tcEaq6l4pFx+AQ3aLzvZANxxG8o166
         KgU+49E2uGI/T1yj/f3a3u8Ba5PYVyUclfxR3zQmij1HBR+2iDCNfUnVWEQgu/vK1OvM
         ehsXtoKcpuhosri8HSBUZdaSAUyV7sYneufLLwE5RxLrLvBib97JNSV8bsxhMgntaaPT
         DYDciV58ExBZ/bu1xJeUPkCvWic3zDnQsrEXXd4rPkEJWdKeu+O+X1QuT2HicgTT6136
         FDLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VK8bgaP20NERZ6+1UlxKUg+KCTfN5rO2tnhvblvqqYBRySWUQb2vE9dAw9+BkZWRcUNe3/ZgKP6w52kk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxxhp7C/30JFNvHK+Easd5rZBDWVsp6uGtVLDs62Sed5SOYwR2G
	aRDChsso4MbGcbUZtXLRI8cGiydzESI/Gu2t3J9qr5Tg08JntA50C2P/yuA29zqSpnE6T0LLXw=
	=
X-Received: from wmbfj10.prod.google.com ([2002:a05:600c:c8a:b0:489:1f67:5a81])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3581:b0:490:482c:4391
 with SMTP id 5b1f17b1804b1-490482c4586mr347539725e9.23.1779818360071; Tue, 26
 May 2026 10:59:20 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:47 +0200
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
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5484; i=ardb@kernel.org;
 h=from:subject; bh=U8803ZhDPt8GJ8Atx6VTFHHmARjJ+nX3UDhXHVYH9xo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0frj6sbw7T/xOHgou4E0vMGDKO3VgAmdWo+XnCVG6T
 1oEOto7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERU7jL8L1Z3r3IPnBwlZzZh
 j9LEyREPWzJrNh55n6V8I1KW299LiZHhyvMT6w/KRn2cG6r8u+luO6dv1+6fH92Tg3pK51buVHT gBAA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-17-ardb+git@google.com>
Subject: [PATCH v6 00/15] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the reasons the lack of randomization of the linear map on arm64
is considered problematic is the fact that bootloaders adhering to the
original arm64 boot protocol (i.e., a substantial fraction of all
Android phones) may place the kernel at the base of DRAM, and therefore
at the base of the non-randomized linear map. This puts a writable alias
of the kernel's data and bss regions at a predictable location, removing
the need for an attacker to guess where KASLR mapped the kernel.

Let's unmap this linear, writable alias entirely, so that knowing the
location of the linear alias does not give write access to the kernel's
data and bss regions.

Changes since v5:
- Reorder series in ascending order of impact, so that the first few can
  be merged earlier if desired. This also makes the patch that remaps
  the data/bss linear alias as tagged redundant, which is therefore
  dropped.
- Add patch #3 to address an existing issue spotted by Sashiko
- Fix thinko in contiguous region check (#5), where the whole region
  needs to be considered and not only the first entry (dropped Rb as
  well) - this addresses the kfence issue Sashiko reported on v5 [0]
- Update commit log on #6 to clarify that changing permission bits on
  PTE_CONT entries is safe as long as PTE_CONT itself does not change
- Likewise, drop hunk that adds the PTE_CONT bit to the 'permitted' mask
  in pgattr_change_is_safe(), as changing it is not safe. (#8)
- Move kasan's additional page table to pgdir BSS as well
- Use (NOLOAD) on the .pgdir.bss section so it does not get emitted into
  vmlinux
- Add powerpc and SuperH patches to deal with empty_zero_page[] being
  made const

Changes since v4:
- Update the correct [early] mapping in patch #1
- Make empty_zero_page[] const instead of __ro_after_init
- Drop patches that remap the fixmap page tables r/o for now
- Don't force page mappings for the data/bss linear alias, as it is no
  longer needed for set_memory_valid()
- Add acks

Changes since v3:
- Drop bogus patch adding hierarchical PXN to the fixmap mapping, which
  breaks the KPTI trampoline (thanks to Sashiko)
- Add generic patch to move the empty_zero_page to __ro_after_init, as
  it now lives in generic code.
- Add patches to remap the linear aliases of the fixmap page tables
  read-only too - these live at an a priori known offset in the linear
  map if physical KASLR was omitted, and control a priori known
  addresses in the virtual kernel space.
- Rebase onto v7.1-rc1

Changes since v2:
- Keep bm_pte[] in the region that is remapped r/o or unmapped, as it is
  only manipulated via its kernel alias
- Drop check that prohibits any manipulation of descriptors with the
  CONT bit set
- Add Ryan's ack to a couple of patches
- Rebase onto v7.0-rc4

Changes since v1:
- Put zero page patch at the start of the series
- Tweak __map_memblock() API to respect existing table and contiguous
  mappings, so that the logic to map the kernel alias can be simplified
- Stop abusing the MEMBLOCK_NOMAP flag to initially omit the kernel
  linear alias from the linear map
- Some additional cleanup patches
- Use proper API [set_memory_valid()] to (un)map the linear alias of
  data/bss.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc; Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org

[0] https://sashiko.dev/#/patchset/20260519151616.2557018-15-ardb%2Bgit%40google.com

Ard Biesheuvel (15):
  arm64: mm: Remove bogus stop condition from map_mem() loop
  arm64: mm: Drop redundant pgd_t* argument from map_mem()
  arm64: mm: Check for pud_/pmd_set_huge() failures on kernel mappings
  arm64: mm: Preserve existing table mappings when mapping DRAM
  arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
  arm64: mm: Permit contiguous descriptors to be manipulated
  arm64: kfence: Avoid NOMAP tricks when mapping the early pool
  arm64: mm: Permit contiguous attribute for preliminary mappings
  arm64: Move fixmap and kasan page tables to end of kernel image
  arm64: mm: Don't abuse memblock NOMAP to check for overlaps
  arm64: mm: Map the kernel data/bss read-only in the linear map
  powerpc/code-patching: Avoid r/w mapping of the zero page
  sh: cast away constness from the zero page when flushing it from the
    cache
  mm: Make empty_zero_page[] const
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/mmu.h     |   2 +
 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/kernel/vmlinux.lds.S  |   8 +-
 arch/arm64/mm/fixmap.c           |   6 +-
 arch/arm64/mm/kasan_init.c       |   2 +-
 arch/arm64/mm/mmu.c              | 153 ++++++++++++--------
 arch/powerpc/lib/code-patching.c |  52 +------
 arch/sh/mm/init.c                |   2 +-
 include/linux/pgtable.h          |   2 +-
 mm/mm_init.c                     |   2 +-
 10 files changed, 111 insertions(+), 122 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.794.g4f17f83d09-goog


