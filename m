Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 958EF1A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 16:50:23 +1100 (AEDT)
Received: by mail-pf0-x233.google.com with SMTP id 78so44770292pfw.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 21:50:23 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	mpe@ellermen.id.au
Subject: [PATCH 0/5] Rebase powerpc selftests
Date: Wed, 23 Dec 2015 16:49:49 +1100
Message-Id: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rebase the previous powerpc selftests against the current next tree.

Rashmica Gupta (5):
  selftests/powerpc: Make reg.h common to all powerpc selftests
  selftests/powerpc: Standardise TM calls
  selftests/powerpc: Add test for forking inside transaction
  selftests/powerpc: Add TM test to check if TAR is corrupted
  selftests/powerpc: Add test to check if TM SPRs are corrupted

 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |   1 -
 tools/testing/selftests/powerpc/pmu/ebb/reg.h      |  49 -------
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |   1 -
 tools/testing/selftests/powerpc/reg.h              |  43 +++++++
 tools/testing/selftests/powerpc/tm/.gitignore      |   3 +
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 tools/testing/selftests/powerpc/tm/tm-fork.c       |  42 ++++++
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |  16 +--
 .../testing/selftests/powerpc/tm/tm-signal-stack.c |   4 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c        |  90 +++++++++++++
 tools/testing/selftests/powerpc/tm/tm-tmspr.c      | 143 +++++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h            |   1 +
 12 files changed, 331 insertions(+), 65 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
 create mode 100644 tools/testing/selftests/powerpc/reg.h
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tar.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tmspr.c

-- 
2.5.0
