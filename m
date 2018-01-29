Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVN7F4zYWzDr4x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 19:32:57 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0T8OPKX045729
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 03:32:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fsys517bx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 03:32:53 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 08:32:51 -0000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
 linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
 tmricht@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf trace powerpc: Remove libaudit dependency for
 syscalls
Date: Mon, 29 Jan 2018 14:04:14 +0530
Message-Id: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is almost identical set of patches recently done for s390.

With this, user can run perf trace without libaudit on powerpc
as well. Ex,

  $ make
    ...     libaudit: [ OFF ]

  $ ./perf trace ls
    0.221 ( 0.005 ms): ls/43330 open(filename: 0xac1e2778, flags: CLOEXEC   ) = 3
    0.227 ( 0.003 ms): ls/43330 read(fd: 3, buf: 0x3ffff9c4d678, count: 832 ) = 832
    0.233 ( 0.002 ms): ls/43330 fstat(fd: 3, statbuf: 0x3ffff9c4d4b0        ) = 0
    ...

  $ ./perf trace -e "open*" ls
    0.000 ( 0.014 ms): ls/43342 open(filename: 0x793d8978, flags: CLOEXEC   ) = 3
    0.038 ( 0.006 ms): ls/43342 open(filename: 0x793f2778, flags: CLOEXEC   ) = 3
    ...

Ravi Bangoria (3):
  tools include powerpc: Grab a copy of
    arch/powerpc/include/uapi/asm/unistd.h
  perf powerpc: Generate system call table from asm/unistd.h
  perf trace powerpc: Use generated syscall table

 tools/arch/powerpc/include/uapi/asm/unistd.h       | 399 +++++++++++++++++++++
 tools/perf/Makefile.config                         |   2 +
 tools/perf/arch/powerpc/Makefile                   |  21 ++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  35 ++
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/util/syscalltbl.c                       |   4 +
 6 files changed, 462 insertions(+)
 create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
 create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl

-- 
1.8.3.1
