Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE72F1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:59 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:50:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D3D1F3578060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEor6941943134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEoq0c004362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:53 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 0/8] Fix perf probe issues on powerpc
Date: Mon, 15 Dec 2014 20:20:30 +0530
Message-Id: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes various issues with perf probe on powerpc across ABIv1 and
ABIv2:
- in the presence of DWARF debug-info,
- in the absence of DWARF, but with the symbol table, and
- in the absence of debug-info, but with kallsyms.

Applies cleanly on -tip. Tested on ppc64 BE and LE.

Changes from previous version:
Addressed various review comments from Mike Ellerman largely to generalize
changes. Some of the simpler patches have been retained in their previous form
to limit code churn, while others have been generalized by introducing arch
helpers. Individual patches have more details.


- Naveen

Naveen N. Rao (8):
  kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2
  perf probe: Improve detection of file/function name in the probe
    pattern
  perf probe powerpc: Fix symbol fixup issues due to ELF type
  perf probe powerpc: Handle powerpc dot symbols
  perf probe powerpc: Allow matching against dot symbols
  perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
  perf probe powerpc: Use DWARF info only if necessary
  perf probe powerpc: Fixup function entry if using kallsyms lookup

 arch/powerpc/include/asm/kprobes.h          | 63 +++++++++++++++++++---------
 tools/perf/arch/powerpc/Makefile            |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c | 64 +++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |  2 +
 tools/perf/util/probe-event.c               | 48 ++++++++++++++++++----
 tools/perf/util/probe-event.h               | 21 ++++++++++
 tools/perf/util/symbol-elf.c                |  5 ++-
 tools/perf/util/symbol.c                    |  6 +++
 tools/perf/util/symbol.h                    |  6 +++
 9 files changed, 188 insertions(+), 28 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/sym-handling.c

-- 
2.1.3
