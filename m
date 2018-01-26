Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSSn622DgzF0RQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 16:55:38 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0Q5sJ1F019263
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 00:55:36 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fqwvhsc4r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 00:55:35 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 26 Jan 2018 00:55:34 -0500
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Testcases for protection keys feature in powerpc/next
Date: Fri, 26 Jan 2018 03:55:21 -0200
Message-Id: <20180126055523.29456-1-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai submitted a separate series containing the rework of the x86 test and
also the powerpc-specific tests:

https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=24741

There's a bug in the powerpc tests where they expect the AMR, IAMR and UAMOR
registers to be zeroed when a process starts. This is currently true on powernv
but isn't on LPARs, where key 31 is reserved and its bits are set. This causes
the tests to fail on that platform.

This series fixes the bug and now the tests pass on both powernv and LPAR
machines running powerpc/next. I think it's worth submitting these tests
separately from the one coming from x86 so here they are.

Thiago Jung Bauermann (2):
  selftests/powerpc: Add ptrace tests for Protection Key registers
  selftests/powerpc: Add core file test for Protection Key registers

 tools/testing/selftests/powerpc/include/reg.h      |   1 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |   8 +-
 tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++
 tools/testing/selftests/powerpc/ptrace/core-pkey.c | 460 +++++++++++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  37 ++
 6 files changed, 961 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/child.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
