Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 829D72C0098
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:20 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:13:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4F8371258052
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:20:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M5m8kd9109992
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:18:08 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M5mD86017733
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:13 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Improvement and fixes for BHRB
Date: Wed, 22 May 2013 11:17:45 +0530
Message-Id: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
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

Anshuman Khandual (2):
  powerpc, perf: Ignore separate BHRB privilege state filter request
  powerpc, perf: BHRB filter configuration should follow the task

 arch/powerpc/perf/core-book3s.c |  5 ++++-
 arch/powerpc/perf/power8-pmu.c  | 17 +++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.7.11.7
