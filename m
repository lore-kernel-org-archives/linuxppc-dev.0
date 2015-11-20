Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E21061A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 15:15:38 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH v2 0/3] powerpc/tm: MSR oops printing and selftests
Date: Fri, 20 Nov 2015 15:15:31 +1100
Message-Id: <1447992934-18905-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are 3 non-urgent TM patches.  These were left off my other post
of the urgent fixes.

v2:
  - Added invalid stack with signal delievery during tm selftest
  - Added selftest binaries to .gitignore
  - Improved signal return selftest based on mpe's feedback
  - Improved oops message printing based on mpe's feedback
  - Dropped get_tm_stackpointer() renaming patch in leui of more
     extensive rewrite later

Michael Neuling (3):
  powerpc: Print MSR TM bits in oops message
  selftests/powerpc: Add TM signal return test
  selftests/powerpc: Add TM signal with invalid stack test

 arch/powerpc/kernel/process.c                      | 51 ++++++++++++---
 tools/testing/selftests/powerpc/tm/.gitignore      |  2 +
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 .../selftests/powerpc/tm/tm-signal-msr-resv.c      | 71 +++++++++++++++++++++
 .../testing/selftests/powerpc/tm/tm-signal-stack.c | 73 ++++++++++++++++++++++
 5 files changed, 190 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-stack.c

-- 
2.5.0
