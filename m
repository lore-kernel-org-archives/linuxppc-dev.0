Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF082C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:17:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC57207C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZUnJ6jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC57207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BY4rC0Hh4zDrBh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2020 01:17:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kZUnJ6jz; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BY4km4HMpzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 01:12:31 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id m71so1217834pfd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lRxrDToJB/xPOxG5kGdgUWQPtXDsSaGWKdRXIKBnLww=;
 b=kZUnJ6jz2FEkjkC4B07sDG1MjmzhjlUML84kGzNbhSDyDdfVyIkBqQ1JVaKnlcpnsW
 O4/rnCdzXc5wLDuh66q0rTTJxxarsRrbbSJ3CBzYgOl2Kiph/wZYJr1Qvco+GQ7avZZF
 Dbs74MOkriYYn3Uv1eGMGWPeNA1bNr83Aa+YHScAmKLmebvgMrUyej9FYoVnkrCPjtE3
 /d9DU7qLsc96xQiWL8n/lPwiBLfzsLbk3ZLdsUeHAbC9H8xLy9KN7b5omTiIo5lCszfb
 4BIvgj0FwaU6x9/I2bYSDZEgvwAguArcSIW9qjKYuZ90qn8CQH/xh3SQ44OCN04qHdb/
 qz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lRxrDToJB/xPOxG5kGdgUWQPtXDsSaGWKdRXIKBnLww=;
 b=bGflXC/d/+uv2pWzWpXcTNVjVWK85sZZZLAJI42qzzQd2kY+R0Y2ZN/nnX546reIFH
 r9XdA4j10WEoZFV0lYBubXPtLGSLBfZOzPUhbQfnvM1LkOJAQudOhOpdI+ur8TdFmM6K
 5nFyu9nMsySjdV/dXzSx6jdcnI5zIiI8bTRGlLTi4V/DNFot8FU+MitH2G6QR10xmKkE
 Laeek+30q+9pWvCQ21sO26LcLtJpjPb4N/Uj80CUYC5edbMrkop5kUlkimKGMyvhA0in
 L5foEKcJDfpOJjx1UorsZlloBhQanEmD/JvQro81HO2Q5WbtLFRU26jrtfXmPTImMo+q
 kx/A==
X-Gm-Message-State: AOAM533Jt80PV6n4Fi5MPYoIyAtWutCO+oSZb6tbbo5mgPMkfKn7HHEC
 nDMGLDxOvVZF8X1lbhRJ1II=
X-Google-Smtp-Source: ABdhPJxt6gfGs7RCQ4HiMUqjAvNGZuzKIyZP+qM+HUnYFTtKpiyJhyFCAA1UxFk4xgMqZ7BnAojcJw==
X-Received: by 2002:aa7:8757:: with SMTP id g23mr2825194pfo.283.1598022748057; 
 Fri, 21 Aug 2020 08:12:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
 by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:12:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 00/12] huge vmalloc mappings
Date: Sat, 22 Aug 2020 01:12:04 +1000
Message-Id: <20200821151216.1005117-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Zefan Li <lizefan@huawei.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks Christophe and Christoph for reviews.

Thanks,
Nick

Since v5:
- Split arch changes out better and make the constant folding work
- Avoid most of the 80 column wrap, fix a reference to lib/ioremap.c
- Fix compile error on some archs

Since v4:
- Fixed an off-by-page-order bug in v4
- Several minor cleanups.
- Added page order to /proc/vmallocinfo
- Added hugepage to alloc_large_system_hage output.
- Made an architecture config option, powerpc only for now.

Since v3:
- Fixed an off-by-one bug in a loop
- Fix !CONFIG_HAVE_ARCH_HUGE_VMAP build fail
- Hopefully this time fix the arm64 vmap stack bug, thanks Jonathan
  Cameron for debugging the cause of this (hopefully).

Since v2:
- Rebased on vmalloc cleanups, split series into simpler pieces.
- Fixed several compile errors and warnings
- Keep the page array and accounting in small page units because
  struct vm_struct is an interface (this should fix x86 vmap stack debug
  assert). [Thanks Zefan]

Nicholas Piggin (12):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  lib/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  powerpc: inline huge vmap supported functions
  arm64: inline huge vmap supported functions
  x86: inline huge vmap supported functions
  mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings
  powerpc/64s/radix: Enable huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/Kconfig                                  |   4 +
 arch/arm64/include/asm/vmalloc.h              |  25 +
 arch/arm64/mm/mmu.c                           |  26 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/vmalloc.h            |  21 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  21 -
 arch/x86/include/asm/vmalloc.h                |  23 +
 arch/x86/mm/ioremap.c                         |  19 -
 arch/x86/mm/pgtable.c                         |  13 -
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  10 +
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 225 +--------
 mm/memory.c                                   |  60 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 443 +++++++++++++++---
 17 files changed, 515 insertions(+), 393 deletions(-)

-- 
2.23.0

