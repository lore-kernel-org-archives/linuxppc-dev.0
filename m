Return-Path: <linuxppc-dev+bounces-21727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF5CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmc5Z3sz2yrt;
	Sat, 30 May 2026 01:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066944;
	cv=none; b=XzgUiARWg8ghXoxzFUpzWIweOc+Xp/m42ZYJj/FodpkkE6JcPATbxkB1gUCFtZigsSZTJvnlYi6iC5AAIQXwOLoNu4vy46EMcA00MFeU0XQ4R3DPYOeodPjOFKcuEMRRts9Op5v6OEiccnB7sOFdRlOh0/BfagpNay8dtWNVZEGKBa5MKIZubh+O8IAztH1/0CMv0qcks1pRPTspTjIP1JBYg8qMB+RCq7tZbgWtaXxYFnBjLmzP6JSDebs3yt+UUHDS9sbcWAb9wKjx/8mpO9+AQOfpJhwlv/OeUd57DD8HIUiCJyXKoBws4cZ48hliVK8763xZZFb8GG0e4RYiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066944; c=relaxed/relaxed;
	bh=HpQ+gbfLV3ep0KH+7DICYy7iPk4t74I7YHv+Lp6qVhM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AVxAtq4WuIvqFxZ9gRje78d7MX8+OKzNl55p+LXHdehdAu9v1gU+ddaDBxxwHVYcom5uMR5YYTwxhQ+jb+ZV1VX02vYUAH+sZ2c2ZOP3jHfpR826uwc9cyK/7/jgR1B45vlrxS5ymcwYZFtnPrdqc0NiEMuew0G/+nySLVyrlrO18H7q8pNQl0vxNq5A4dwcf8Wx7DZt4XDSfVjzwJF/a/9almyL+nwI2yJlUiKp58xEQZ/9ZgY01g5HfWVmmW8rVEhwLG6DVkSwXsBpeLcYaXxFiVzx5+uNdQv92C0BpD0muQbdatdzPNNzNi9+4Wp2GcMjIXfY8fiDAs/f1jHWGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KV6Q3leo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::64a; helo=mail-ej1-x64a.google.com; envelope-from=3ekozaggkdisp6sq+vx8v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KV6Q3leo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::64a; helo=mail-ej1-x64a.google.com; envelope-from=3ekozaggkdisp6sq+vx8v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmZ5Hb3z2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:22 +1000 (AEST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bcb28103aeeso892779166b.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066937; x=1780671737; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HpQ+gbfLV3ep0KH+7DICYy7iPk4t74I7YHv+Lp6qVhM=;
        b=KV6Q3leochy6J5ehbgqE/cH/0zA88Mi63nzSVy2Q770xyulT3zVkGe2k+QVU1yFf2e
         TTgTvOEeb746XUpsiIys5BckPvoiqlHWyluNHrNWxg3M15ZGytFSJePb5WpukMyXRWKq
         DhN3SkOKPxX4uUcykYBvr0VthK4s0XakIUd1TCWjB1PGqocJv73mRV7cuNOmRHtE7Mzd
         8TtJ6ZKlb5rLj80zyUHQ7Z8OhNqx9/mnzty2jb5IpVvR5HixuX2wivyuTmMjFR1pNQ49
         56bvd3GXLhrlS8XBSt6YPHiOtV/cDCo5fIUSZFqM1qRdcWKeYAWP7x+hFAlUDSvnc0K8
         yYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066937; x=1780671737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpQ+gbfLV3ep0KH+7DICYy7iPk4t74I7YHv+Lp6qVhM=;
        b=Mq5y1TtXuDNMzdpLt7DEh8tApnL5i4snlv/zjlv7Vax2CGNiwSI0ijRLyVwEe8cRdX
         4Vq+xH8sOTwKGFeT2wFsQZg804brxz3fvyIwBJ9jwabc6kKqy8bpe7AJrYtNqcPpTfDW
         uCUmevn0kZ1KGczmjpJM5V7KLTWgYhIOx+JgfvB8WnehzjOk1u9TujTDmmuzGGMwY2qQ
         uVjIouB2gm9ZfYt279RhYukzmPy7n76Sc7cmbdkpvvP+olNs9tJ4nBgTrJF5hibu8S2e
         24xaX+k00fxyZam694fZQFZtNGt3iHMikAIOcNmdzKUSHvWfQ+lI3u17WUsaEABN8Wvw
         HxAw==
X-Forwarded-Encrypted: i=1; AFNElJ+xuWKFrr3Xea07foAYW6Z1m8EvoRrwi7DEA9Yasfi7UsgGK1wx2DCgrNeP1vhgfWN61VH72STpcov3CU0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRhiN6kj5aqgklsjD+p+PkM/DeBHEk1ELIjqOj6Il0lTZuNiQc
	wxciB6e7dBc4+Z1d9OnTuqryRwGo50VROpXiHtiHQi251rypXDUMEy7NGp27osTKHayhhdSrmg=
	=
X-Received: from wrub1.prod.google.com ([2002:a5d:4d81:0:b0:43d:77d4:5f14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7945:b0:bce:a1fc:6877
 with SMTP id a640c23a62f3a-be9cad0b276mr172778166b.24.1780066936607; Fri, 29
 May 2026 08:02:16 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:51 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6016; i=ardb@kernel.org;
 h=from:subject; bh=1J4/eBxWUzNbzISy66s5wYlPFITBFouUFXFgBmOizGU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVbx/uurJFp+7lxfraxzxO+j8qpt7ylXD8r3Oblc1D
 1q97K/sKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZzcnwPzZyX86SrtObDbx+
 z714VZhZY8c1Kb2LJRHXPl3UVlXMUGL4X+DuW1oyQ1zWb99Z/cx301JrXATZI7vYmbc++evbL/u BEwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-17-ardb+git@google.com>
Subject: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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

Changes since v6:
- Improve commits logs and comments
- Add acks from Kevin
- Reorder patches so remapping data/bss R/O occurs after moving the zero
  page into .rodata
- Drop zero page cache flush from SuperH rather than casting away the
  constness
- Map kfence pool with NO_EXEC_MAPPINGS

Note that Sashiko had some comments on patch 15/15 [1] but none of those
seem accurate. (I have tested both suspend/resume and hibernate under
QEMU and both work as expected)

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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
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
[1] https://sashiko.dev/#/patchset/20260526175846.2694125-17-ardb%2Bgit%40google.com

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
  powerpc/code-patching: Avoid r/w mapping of the zero page
  sh: Drop cache flush of the zero page at boot
  mm: Make empty_zero_page[] const
  arm64: mm: Map the kernel data/bss read-only in the linear map
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/mmu.h     |   2 +
 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/kernel/vmlinux.lds.S  |   8 +-
 arch/arm64/mm/fixmap.c           |   6 +-
 arch/arm64/mm/kasan_init.c       |   2 +-
 arch/arm64/mm/mmu.c              | 164 ++++++++++++--------
 arch/powerpc/lib/code-patching.c |  52 +------
 arch/sh/mm/init.c                |   3 -
 include/linux/pgtable.h          |   2 +-
 mm/mm_init.c                     |   2 +-
 10 files changed, 121 insertions(+), 124 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.823.g6e5bcc1fc9-goog


