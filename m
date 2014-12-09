Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94B6C1A01F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:34:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 20FEE2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:47 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HYlWZ36765788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:47 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HYk7D011860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:46 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [RFC PATCH 0/8] Fix perf probe issues on powerpc
Date: Tue,  9 Dec 2014 23:03:58 +0530
Message-Id: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes various issues with perf probe on powerpc
across ABIv1 and ABIv2:
- in the presence of DWARF debug-info,
- in the absence of DWARF, but with the symbol table, and
- in the absence of debug-info, but with kallsyms.

Applies cleanly on v3.18 and on -tip with minor changes to patch 6.
Tested on ppc64 BE and LE.

- Naveen

Naveen N. Rao (8):
  kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2
  perf probe powerpc: Fix symbol fixup issues due to ELF type
  perf probe: Improve detection of file/function name in the probe
    pattern
  perf probe powerpc: Handle powerpc dot symbols
  perf probe powerpc: Allow matching against dot symbols
  perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
  perf probe powerpc: Use DWARF info only if necessary
  perf probe powerpc: Fixup function entry if using kallsyms lookup

 arch/powerpc/include/asm/code-patching.h      | 26 ++++++++----
 arch/powerpc/include/asm/kprobes.h            | 58 ++++++++++++++++++---------
 tools/perf/arch/powerpc/Makefile              |  1 +
 tools/perf/arch/powerpc/util/elf-sym-decode.c | 27 +++++++++++++
 tools/perf/config/Makefile                    |  1 +
 tools/perf/util/elf_sym.h                     | 13 ++++++
 tools/perf/util/probe-event.c                 | 57 ++++++++++++++++++++++++--
 tools/perf/util/symbol-elf.c                  | 11 ++++-
 tools/perf/util/symbol.c                      |  6 +++
 9 files changed, 170 insertions(+), 30 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/elf-sym-decode.c
 create mode 100644 tools/perf/util/elf_sym.h

-- 
2.1.3
