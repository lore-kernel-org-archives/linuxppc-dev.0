Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlNys4MmCzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 22:53:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 0/5] Live patching for powerpc
Date: Wed, 13 Apr 2016 22:53:18 +1000
Message-Id: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds live patching support for powerpc (ppc64le only ATM).

It's unchanged since the version I posted on March 24, with the exception that
I've dropped the first patch, which was a testing-only patch.

If there's no further comments I'll put this in a topic branch in the next day
or two and Jiri & I will both merge that into next.

cheers

Michael Ellerman (5):
  ftrace: Make ftrace_location_range() global
  livepatch: Allow architectures to specify an alternate ftrace location
  powerpc/livepatch: Add livepatch header
  powerpc/livepatch: Add livepatch stack to struct thread_info
  powerpc/livepatch: Add live patching support on ppc64le

 arch/powerpc/Kconfig                   |  3 ++
 arch/powerpc/include/asm/livepatch.h   | 62 ++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h |  4 +-
 arch/powerpc/kernel/asm-offsets.c      |  4 ++
 arch/powerpc/kernel/entry_64.S         | 97 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/irq.c              |  3 ++
 arch/powerpc/kernel/process.c          |  6 ++-
 arch/powerpc/kernel/setup_64.c         | 17 +++---
 include/linux/ftrace.h                 |  1 +
 kernel/livepatch/core.c                | 34 ++++++++++--
 kernel/trace/ftrace.c                  | 14 ++++-
 11 files changed, 232 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/livepatch.h

-- 
2.5.0
