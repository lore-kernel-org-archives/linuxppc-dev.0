Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCr0P2FzDrHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:03 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0JmkB053678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:01 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1twcd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:01 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:22:58 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 00/12] Deal with TM on kernel entry and exit
Date: Tue, 20 Feb 2018 11:22:29 +1100
Message-Id: <20180220002241.29648-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is very much a proof of concept and if it isn't clear from the
commit names, still a work in progress.

I believe I have something that works - all the powerpc selftests
pass. I would like to get some eyes on it to a) see if I've missed
anything big and b) some opinions on if it is looking like a net
improvement.

Obviously it is still a bit rough around the edges, I'll have to
convince myself that the SPR code is correct. I don't think the
TM_KERNEL_ENTRY macro needs to check that we came from userspace, if
TM is on then we can probably assume. Maybe a check not in the
fastpath. Some of the BUG_ON()s will probably go.

Background:
Currently TM is dealt with when we need to. That is, when we switch
processes, we'll (if nessesary) reclaim the outgoing process and (if
nessesary) recheckpoint the incoming process. Same with signals, if we
need to deliver a signal, we'll ensure we've reclaimed in order to
have all the information and go from there.
I, along with some others got curious to see what it would look like if
we did the 'opposite'.
At all kernel entry points that won't simply just zoom straight to an
RFID we now check if the thread was transactional and do the reclaim.
Correspondingly do the recheckpoint quite late on exception exit. It
turns out we already had a lot of the code pathes set up on the exit
path as there were things that TM had special cased on exit already.
I wasn't sure it it would lead to more or less complexity and though
I'd have to try it to see. I feel like it was almost a win but SPRs
did add some annoying caveats.

In order to get this past Michael I'm going to prove it performs, or
rather, doesn't slow anything down - workload suggestions welcome.

Thanks,

Cyril Bur (12):
  powerpc/tm: Remove struct thread_info param from tm_reclaim_thread()
  selftests/powerpc: Fix tm.h helpers
  selftests/powerpc: Add tm-signal-drop-transaction TM test
  selftests/powerpc: Use less common thread names
  [WIP] powerpc/tm: Reclaim/recheckpoint on entry/exit
  [WIP] powerpc/tm: Remove dead code from __switch_to_tm()
  [WIP] powerpc/tm: Add TM_KERNEL_ENTRY in more delicate exception
    pathes
  [WIP] powerpc/tm: Fix *unavailable_tm exceptions
  [WIP] powerpc/tm: Tweak signal code to handle new reclaim/recheckpoint
    times
  [WIP] powerpc/tm: Correctly save/restore checkpointed sprs
  [WIP] powerpc/tm: Afterthoughts
  [WIP] selftests/powerpc: Remove incorrect tm-syscall selftest

 arch/powerpc/include/asm/exception-64s.h           |  25 ++++
 arch/powerpc/kernel/entry_64.S                     |  20 ++-
 arch/powerpc/kernel/exceptions-64s.S               |  31 ++++-
 arch/powerpc/kernel/process.c                      | 145 ++++++++++++++++++---
 arch/powerpc/kernel/ptrace.c                       |   9 +-
 arch/powerpc/kernel/signal.c                       |  11 +-
 arch/powerpc/kernel/signal_32.c                    |  16 +--
 arch/powerpc/kernel/signal_64.c                    |  41 ++++--
 arch/powerpc/kernel/traps.c                        |   3 -
 tools/testing/selftests/powerpc/tm/Makefile        |   5 +-
 .../powerpc/tm/tm-signal-drop-transaction.c        |  74 +++++++++++
 .../testing/selftests/powerpc/tm/tm-syscall-asm.S  |  28 ----
 tools/testing/selftests/powerpc/tm/tm-syscall.c    | 106 ---------------
 .../testing/selftests/powerpc/tm/tm-unavailable.c  |   4 +-
 tools/testing/selftests/powerpc/tm/tm.h            |  10 +-
 15 files changed, 319 insertions(+), 209 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-drop-transaction.c
 delete mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
 delete mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

-- 
2.16.2
