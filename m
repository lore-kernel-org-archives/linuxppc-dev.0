Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1886D1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:15 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 301F7E0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:38:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC69JK26476792
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC67Xg004021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:08 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 0/7] Fixes for perf probe issues on ppc
Date: Tue, 28 Apr 2015 17:35:33 +0530
Message-Id: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
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

Arnaldo,
I have moved all patches to use __weak functions. Kindly take a look and let me
know if this is what you had in mind.

Thanks!
- Naveen

----
Changes since v2:
The primary change is with the use of __weak functions instead of compiler
macros. Along with that, I have also addressed all previous review comments
(*). Individual patches have the detailed changelog. Please note that I have
dropped the first (kernel) patch from the last series since it has been pushed
upstream. This series now only includes the rest of the patches.

(*) http://thread.gmane.org/gmane.linux.kernel/1851128



Naveen N. Rao (7):
  perf probe: Improve detection of file/function name in the probe
    pattern
  perf probe/ppc: Fix symbol fixup issues due to ELF type
  perf probe/ppc: Use the right prefix when ignoring SyS symbols on ppc
  perf probe/ppc: Enable matching against dot symbols automatically
  perf probe/ppc64le: Fix ppc64 ABIv2 symbol decoding
  perf probe/ppc64le: Prefer symbol table lookup over DWARF
  perf probe/ppc64le: Fixup function entry if using kallsyms lookup

 tools/perf/arch/powerpc/util/Build          |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c | 80 +++++++++++++++++++++++++++++
 tools/perf/util/map.c                       |  5 ++
 tools/perf/util/map.h                       |  3 +-
 tools/perf/util/probe-event.c               | 42 +++++++++++++--
 tools/perf/util/probe-event.h               |  3 ++
 tools/perf/util/symbol-elf.c                | 12 ++++-
 tools/perf/util/symbol.c                    | 25 +++++----
 tools/perf/util/symbol.h                    | 10 ++++
 9 files changed, 164 insertions(+), 17 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/sym-handling.c

-- 
2.3.5
