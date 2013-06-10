Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 745B92C02C7
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:51 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 15:19:55 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EFA602BB0053
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5A5BAe264291008
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:11:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5A5PeCQ031329
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:41 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V3 0/2] Improvement and fixes for BHRB
Date: Mon, 10 Jun 2013 10:55:08 +0530
Message-Id: <1370841910-28695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(1) The first patch fixes a situation like this

Before patch:-
------------

./perf record -j any -e branch-misses:k ls
Error:
The sys_perf_event_open() syscall returned with 95 (Operation not supported) for event (branch-misses:k).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

Here 'perf record' actually copies over ':k' filter request into BHRB
privilege state filter config and our previous check in kernel would
fail that.

After patch:-
-------------

/perf record -j any -e branch-misses:k ls
perf  perf.data  perf.data.old  test-mmap-ring
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (~102 samples) ]

(2) The second patch fixes context migration for BHRB filter configuration

Changes in V2
-------------
(1) Updated the comment section of the code
(2) Removed the informational print
(3) Updated the commit section of the first patch

Changes in V3
-------------
(1) Fixed the compilation warning problem after removing the unused variable

Anshuman Khandual (2):
  powerpc, perf: Ignore separate BHRB privilege state filter request
  powerpc, perf: BHRB filter configuration should follow the task

 arch/powerpc/perf/core-book3s.c |  5 ++++-
 arch/powerpc/perf/power8-pmu.c  | 13 ++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
1.7.11.7
