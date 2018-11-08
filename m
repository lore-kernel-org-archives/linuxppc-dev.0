Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C981ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 18:14:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C9220825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 18:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="buc3UhoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C9220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rWdb3YgxzF3G8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 05:14:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="buc3UhoK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="buc3UhoK"; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rWb23qpmzF3Rm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 05:12:13 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id q19-v6so6906715pll.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 10:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B0gA8LsXswfrIAmbtYisG71JTJmLmakfJ+ILccJByaU=;
 b=buc3UhoKkeYLzhfy1LFvSgTevjKzuw+S/EPNcM7/J1DWFKB4AczvPH1MMD5Ak06Z9l
 1Xlxhv1dwM8hMSb36qsqIYc3EEW/DmX/L4l/q+89z1P8aLicH26pXwnG2h8/KhPOVHe+
 TvMvNwTMBp+zR1I4QvrRyuY93K0+fxHhDJoc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B0gA8LsXswfrIAmbtYisG71JTJmLmakfJ+ILccJByaU=;
 b=A5MzOz8g/67r8WjTRwtju0f4FMeCEfeuXUgYMaSsXc/l7eGgNzQrzMcA649DVzAmKB
 FsjKSU8QPMy5DVhWgF2xkNceReKhjWZTU2UvYZuXUkXAqwvuXKYqBr0Rijxu9OobhuB3
 U681n0al22K+GhlHfJVHh9e8o3daSYKUbajtbARvR6JS0wVLHsTGxivedPDzvm+i6QIY
 lwnx5ohdwH6yt/ofKRURfMVPkN5PIO2RWH++wzC1em6ZW/X7Du060NO2LzDiCUQTCfoV
 k8TOFnTlwVSPW33tHnP0e2XIpRkdT++d+wKtn+mY0vkoa9hOK7h0byxex8gNWfUn/ojC
 Va6w==
X-Gm-Message-State: AGRZ1gK0tO336R+4uDnXYBtaWZInRV6osYCX11sIL683dkSTLVCLNVai
 67mHEKdWwwj8GHTMqxmXIaWcQA==
X-Google-Smtp-Source: AJdET5dLCU23zzCHPNag7xR8IOaOFzKVkGtOPwTljtbBZ3ntwXCVtlPSlP8LPHJ3t2lbqbPj9+G8OQ==
X-Received: by 2002:a17:902:4583:: with SMTP id
 n3-v6mr5496253pld.53.1541700730786; 
 Thu, 08 Nov 2018 10:12:10 -0800 (PST)
Received: from joelaf.mtv.corp.google.com
 ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 64-v6sm10028533pfa.120.2018.11.08.10.12.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 10:12:09 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next-akpm 0/3] Add support for fast mremap
Date: Thu,  8 Nov 2018 10:11:58 -0800
Message-Id: <20181108181201.88826-1-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
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
Cc: Joel Fernandes <joelaf@google.com>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@kot-begemot.co.uk, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Here is the "fast mremap" series. This just a repost with Kirill's Acked-bys
added and William's Reviewed-by added. Also fixed a UML build error reported
last week. I would like this to be considered for linux -next. The performance
numbers in the series are for testing on x86. The config enablement patch for
arm64 will be posted in the future after testing (see notes below).

List of patches in series:

(1) mm: select HAVE_MOVE_PMD in x86 for faster mremap

(2) mm: speed up mremap by 20x on large regions (v5)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)
v2->v3: Updated commit message to state the optimization may also
	run for non-thp type of systems (Daniel Col).
v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
	Rebased ontop of Linus's master, updated perf results based
        on x86 testing. Added Kirill's Acks.
v4->v5: Added William's Reviewed-by. Fixed arch/um build error
	due to set_pmd_at not defined. Rebased on linux-next/akpm.

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
mm: speed up mremap by 20x on large regions (v5)
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
mm/mremap.c                                  | 64 +++++++++++++++++++-
mm/userfaultfd.c                             |  2 +-
virt/kvm/arm/mmu.c                           |  2 +-
46 files changed, 165 insertions(+), 147 deletions(-)

--
2.19.1.930.g4563a0d9d0-goog

