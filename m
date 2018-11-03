Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 04:25:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9952082E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 04:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hQZEI/5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9952082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42n5Sz2bTKzF37c
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 15:25:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hQZEI/5I";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="hQZEI/5I"; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42n4wz5cnxzF36s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 15:00:50 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id b11-v6so1884523pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 21:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wauWrsOYZ4NO7yzxN9r9ffJEchMQCnKRjhBqfvcq730=;
 b=hQZEI/5IkmDKiwTPcEpeRj5mdJ5f2khCIYUC+tRjECkBSTU7A0nmPfUa+oKun3ZvpC
 QBKK3UGjzZVXQ1U3TcxSBsjIIEAUExiO5kioNqzsBdpusaZSc1GEsUpTdFXIZs++dzNb
 Oce3FxvhzDGCV4UEuF2dXGfauQd44vDoSo9M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wauWrsOYZ4NO7yzxN9r9ffJEchMQCnKRjhBqfvcq730=;
 b=jNrWjwjsKKk4vdmPM75gRnuanJmPr2oy6k7Fy+HgU5g0NNL+D2/zQFxuwZFvbIh0hl
 /Eu5640QonL1o2Wd3xjhdcCe2sHNy9Wp7g0tHzGtqkEey4A3dzgGZx73uHFuQkKIxEsm
 KBIrkY/EbLsWLYgkhoBbvjECneVgPmz5dCol2fw+7VLyN+VV4IiR7bTrR19aNJjaa5L+
 YWX++EQVImRMgepqfaiRoyhQqNEcHZudfs9KAYeKEMOV6srsQHiK/fQu9fiphfrsRUoc
 LuQDQbWgeWnjmK2H78g23/8GrT57E6/wmaK/0wv+KU5e0Ewv3RvGC4U0SZ1TwD0yZKhs
 izFw==
X-Gm-Message-State: AGRZ1gK0471S2pHlRpsKUBoFgP3wZR+77d52LCcPp7ej7p8osySVg+Ex
 AIGHbYVxbUdyZcayiVw8UL9R+g==
X-Google-Smtp-Source: AJdET5cSoldQI3hr9VnkPhkTOPGPi4e4hyOBk5/0PfLyEPfalVwQIW1MKjDzIap7cLOClQG72ynqpQ==
X-Received: by 2002:a63:a441:: with SMTP id
 c1-v6mr13210874pgp.49.1541217647914; 
 Fri, 02 Nov 2018 21:00:47 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com
 ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id x36-v6sm35836232pgl.43.2018.11.02.21.00.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Nov 2018 21:00:46 -0700 (PDT)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/3] Add support for fast mremap
Date: Fri,  2 Nov 2018 21:00:38 -0700
Message-Id: <20181103040041.7085-1-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Nov 2018 15:21:23 +1100
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
Cc: Joel Fernandes <joelaf@google.com>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 kvmarm@lists.cs.columbia.edu, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, pantin@google.com, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,
Here is the latest "fast mremap" series. This just a repost with Kirill's
Acked-bys added. I would like this to be considered for linux -next.  I also
dropped the CONFIG enablement patch for arm64 since I am yet to test it with
the new TLB flushing code that is in very recent kernel releases. (None of my
arm64 devices run mainline right now.) so I will post the arm64 enablement once
I get to that. The performance numbers in the series are for x86.

List of patches in series:

(1) mm: select HAVE_MOVE_PMD in x86 for faster mremap

(2) mm: speed up mremap by 20x on large regions (v4)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)
v2->v3: Updated commit message to state the optimization may also
	run for non-thp type of systems (Daniel Col).
v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
	Rebased ontop of Linus's master, updated perf results based
        on x86 testing. Added Kirill's Acks.

(3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
        update changelog with manual fixups for m68k and microblaze.

not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
    This patch is dropped since last posting pending further performance
    testing on arm64 with new TLB gather updates. See notes in patch
    titled "mm: speed up mremap by 500x on large regions" for more
    details.


Joel Fernandes (Google) (3):
  mm: treewide: remove unused address argument from pte_alloc functions
    (v2)
  mm: speed up mremap by 20x on large regions (v4)
  mm: select HAVE_MOVE_PMD in x86 for faster mremap

 arch/Kconfig                                 |  5 ++
 arch/alpha/include/asm/pgalloc.h             |  6 +-
 arch/arc/include/asm/pgalloc.h               |  5 +-
 arch/arm/include/asm/pgalloc.h               |  4 +-
 arch/arm64/include/asm/pgalloc.h             |  4 +-
 arch/hexagon/include/asm/pgalloc.h           |  6 +-
 arch/ia64/include/asm/pgalloc.h              |  5 +-
 arch/m68k/include/asm/mcf_pgalloc.h          |  8 +--
 arch/m68k/include/asm/motorola_pgalloc.h     |  4 +-
 arch/m68k/include/asm/sun3_pgalloc.h         |  6 +-
 arch/microblaze/include/asm/pgalloc.h        | 19 +-----
 arch/microblaze/mm/pgtable.c                 |  3 +-
 arch/mips/include/asm/pgalloc.h              |  6 +-
 arch/nds32/include/asm/pgalloc.h             |  5 +-
 arch/nios2/include/asm/pgalloc.h             |  6 +-
 arch/openrisc/include/asm/pgalloc.h          |  5 +-
 arch/openrisc/mm/ioremap.c                   |  3 +-
 arch/parisc/include/asm/pgalloc.h            |  4 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 ++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  4 +-
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 +-
 arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
 arch/powerpc/mm/pgtable_32.c                 |  4 +-
 arch/riscv/include/asm/pgalloc.h             |  6 +-
 arch/s390/include/asm/pgalloc.h              |  4 +-
 arch/sh/include/asm/pgalloc.h                |  6 +-
 arch/sparc/include/asm/pgalloc_32.h          |  5 +-
 arch/sparc/include/asm/pgalloc_64.h          |  6 +-
 arch/sparc/mm/init_64.c                      |  6 +-
 arch/sparc/mm/srmmu.c                        |  4 +-
 arch/um/include/asm/pgalloc.h                |  4 +-
 arch/um/kernel/mem.c                         |  4 +-
 arch/unicore32/include/asm/pgalloc.h         |  4 +-
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/pgalloc.h               |  4 +-
 arch/x86/mm/pgtable.c                        |  4 +-
 arch/xtensa/include/asm/pgalloc.h            |  8 +--
 include/linux/mm.h                           | 13 ++--
 mm/huge_memory.c                             |  8 +--
 mm/kasan/kasan_init.c                        |  2 +-
 mm/memory.c                                  | 17 +++---
 mm/migrate.c                                 |  2 +-
 mm/mremap.c                                  | 62 +++++++++++++++++++-
 mm/userfaultfd.c                             |  2 +-
 virt/kvm/arm/mmu.c                           |  2 +-
 46 files changed, 163 insertions(+), 147 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
