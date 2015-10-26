Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7E2D1A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 04:49:36 +1100 (AEDT)
Date: Mon, 26 Oct 2015 18:49:30 +0100
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [PATCH v3 0/8] ftrace with regs + live patching for ppc64 LE (ABI v2)
Message-ID: <20151026174930.GA29592@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

here is the current status of ftrace with regs, trace ops and live patching
for ppc64le. It seems I broke the ftrace graph caller and I spent most of
last week trying to fix it; Steven, maybe you could have a look? I startet
out with -mprofile-kernel and now found that the ordinary -pg is very
different. -mprofile-kernel only does the very bare minimal prologue
(set TOC, save LR) and then calls _mcount, which poses some problems.
I managed to get them resolved up to the point of the graph return ...

I tested intensively with the ftrace self tests, and, without the graph
caller, this set passes all of them on ppc64le. I tried not to break BE,
but may have missed an ifdef or two.

patch 2 (ftrace_modify_all_code default) is an independent prerequisite,
I would even call it a fix -- please consider applying it even if you
don't like the rest.

patch 5 has proven to be very useful during development; as mentioned earlier,
many of these functions may get called during a recoverable fault. The whole
recursion will probably terminate if all goes well, but I'd rather be
defensive here.

Torsten Duwe (8):
  ppc64le FTRACE_WITH_REGS implementation
  ppc use ftrace_modify_all_code default
  ppc64 ftrace_with_regs configuration variables
  ppc64 ftrace_with_regs: spare early boot and low level
  ppc64 ftrace: disable profiling for some functions
  ppc64 ftrace: disable profiling for some files
  Implement kernel live patching for ppc64le (ABIv2)
  Enable LIVEPATCH to be configured on ppc64le and add livepatch.o if it
    is selected.

 arch/powerpc/Kconfig                 |   7 ++
 arch/powerpc/Makefile                |   7 ++
 arch/powerpc/include/asm/ftrace.h    |   5 ++
 arch/powerpc/include/asm/livepatch.h |  27 +++++++
 arch/powerpc/kernel/Makefile         |  13 +--
 arch/powerpc/kernel/entry_64.S       | 153 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/ftrace.c         |  88 +++++++++++++++-----
 arch/powerpc/kernel/livepatch.c      |  20 +++++
 arch/powerpc/kernel/module_64.c      |  39 ++++++++-
 arch/powerpc/kernel/process.c        |   2 +-
 arch/powerpc/lib/Makefile            |   4 +-
 arch/powerpc/mm/fault.c              |   2 +-
 arch/powerpc/mm/hash_utils_64.c      |  18 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c |   2 +-
 arch/powerpc/mm/hugetlbpage.c        |   4 +-
 arch/powerpc/mm/mem.c                |   2 +-
 arch/powerpc/mm/pgtable_64.c         |   2 +-
 arch/powerpc/mm/slb.c                |   6 +-
 arch/powerpc/mm/slice.c              |   8 +-
 kernel/trace/Kconfig                 |   5 ++
 20 files changed, 359 insertions(+), 55 deletions(-)
 create mode 100644 arch/powerpc/include/asm/livepatch.h
 create mode 100644 arch/powerpc/kernel/livepatch.c

-- 
1.8.5.6
