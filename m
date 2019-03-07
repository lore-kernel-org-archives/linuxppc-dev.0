Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0223C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 13:22:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326182081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 13:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326182081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FWWX0GL0zDqCV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 00:22:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FWTZ3sY5zDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 00:20:31 +1100 (AEDT)
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 48D78FF807;
 Thu,  7 Mar 2019 13:20:17 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v6 0/4] Fix free/allocation of runtime gigantic pages
Date: Thu,  7 Mar 2019 08:20:11 -0500
Message-Id: <20190307132015.26970-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
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
Cc: Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series fixes sh and sparc that did not advertise their gigantic page
support and then were not able to allocate and free those pages at runtime.
It renames MEMORY_ISOLATION && COMPACTION || CMA condition into the more
accurate CONTIG_ALLOC, since it allows the definition of alloc_contig_range
function.
Finally, it then fixes the wrong definition of ARCH_HAS_GIGANTIC_PAGE config
that, without MEMORY_ISOLATION && COMPACTION || CMA defined, did not allow
architectures to free boottime allocated gigantic pages although unrelated.

Changes in v6:
- Remove unnecessary goto since the fallthrough path does the same and is
  the 'normal' behaviour, as suggested by Dave Hensen
- Be more explicit in comment in set_max_huge_page: we return an error
  if alloc_contig_range is not defined and the user tries to allocate a
  gigantic page (we keep the same behaviour as before this patch), but we
  now let her free boottime gigantic page, as suggested by Dave Hensen
- Add Acked-by, thanks. 

Changes in v5:
- Fix bug in previous version thanks to Mike Kravetz
- Fix block comments that did not respect coding style thanks to Dave Hensen
- Define ARCH_HAS_GIGANTIC_PAGE only for sparc64 as advised by David Miller
- Factorize "def_bool" and "depends on" thanks to Vlastimil Babka

Changes in v4 as suggested by Dave Hensen:
- Split previous version into small patches
- Do not compile alloc_gigantic** functions for architectures that do not
  support those pages
- Define correct ARCH_HAS_GIGANTIC_PAGE in all arch that support them to avoid
  useless runtime check
- Add comment in set_max_huge_pages to explain that freeing is possible even
  without CONTIG_ALLOC defined
- Remove gigantic_page_supported function across all archs

Changes in v3 as suggested by Vlastimil Babka and Dave Hansen:
- config definition was wrong and is now in mm/Kconfig
- COMPACTION_CORE was renamed in CONTIG_ALLOC

Changes in v2 as suggested by Vlastimil Babka:
- Get rid of ARCH_HAS_GIGANTIC_PAGE
- Get rid of architecture specific gigantic_page_supported
- Factorize CMA or (MEMORY_ISOLATION && COMPACTION) into COMPACTION_CORE 

Alexandre Ghiti (4):
  sh: Advertise gigantic page support
  sparc: Advertise gigantic page support
  mm: Simplify MEMORY_ISOLATION && COMPACTION || CMA into CONTIG_ALLOC
  hugetlb: allow to free gigantic pages regardless of the configuration

 arch/arm64/Kconfig                           |  2 +-
 arch/arm64/include/asm/hugetlb.h             |  4 --
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
 arch/powerpc/platforms/Kconfig.cputype       |  2 +-
 arch/s390/Kconfig                            |  2 +-
 arch/s390/include/asm/hugetlb.h              |  3 --
 arch/sh/Kconfig                              |  1 +
 arch/sparc/Kconfig                           |  1 +
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/hugetlb.h               |  4 --
 arch/x86/mm/hugetlbpage.c                    |  2 +-
 include/linux/gfp.h                          |  4 +-
 mm/Kconfig                                   |  3 ++
 mm/hugetlb.c                                 | 57 ++++++++++++--------
 mm/page_alloc.c                              |  7 ++-
 15 files changed, 50 insertions(+), 51 deletions(-)

-- 
2.20.1

