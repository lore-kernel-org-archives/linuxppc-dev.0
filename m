Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98C9D2C030F
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 14:48:09 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 28 May 2013 10:13:43 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AB56C394004E
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 10:18:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4S4lsZT52690994
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 10:17:54 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4S4m0ws006046
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 04:48:00 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 0/2] Improvement and fixes for BHRB
Date: Tue, 28 May 2013 10:17:30 +0530
Message-Id: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
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

Anshuman Khandual (2):
  powerpc, perf: Ignore separate BHRB privilege state filter request
  powerpc, perf: BHRB filter configuration should follow the task

 arch/powerpc/perf/core-book3s.c |  5 ++++-
 arch/powerpc/perf/power8-pmu.c  | 12 ++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
1.7.11.7
