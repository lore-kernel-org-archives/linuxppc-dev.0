Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB1F82C00BE
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 16:54:05 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 11:24:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 651F0394005E
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G5uh4432768134
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:26:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G5rxB2002196
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:59 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Export POWER8 PMU raw event codes through sysfs
Date: Wed, 16 Oct 2013 11:22:58 +0530
Message-Id: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	This patchset adds some missing event list for POWER7 PMU raw
events which are exported through sysfs interface. Also adds a new
set of raw PMU events list for POWER8. I have completed some amount
of initial testing to verify the working of POWER8 raw event codes
through sysfs.

Before the patch
================
directory contents: /sys/bus/event_source/devices/cpu/
format  perf_event_mux_interval_ms power  subsystem  type  uevent

After the patch
===============
(1) directory contents: /sys/bus/event_source/devices/cpu/
'events'  format  perf_event_mux_interval_ms power  subsystem  type  uevent

(2) contents inside new directory: /sys/bus/event_source/devices/cpu/events/
............................
............................
............................
PM_ANY_THRD_RUN_CYC
PM_BR_2PATH
PM_BR_CMPL
PM_BR_MRK_2PATH
PM_BR_TAKEN_CMPL
PM_CMPLU_STALL_BRU
PM_CMPLU_STALL_BRU_CRU
PM_CMPLU_STALL_COQ_FULL
PM_CMPLU_STALL_DCACHE_MISS
PM_CMPLU_STALL_DMISS_L21_L31
PM_CMPLU_STALL_DMISS_L2L3
PM_CMPLU_STALL_DMISS_L2L3_CONFLICT
PM_CMPLU_STALL_DMISS_L3MISS
PM_CMPLU_STALL_DMISS_LMEM
PM_CMPLU_STALL_DMISS_REMOTE
PM_CMPLU_STALL_ERAT_MISS
PM_CMPLU_STALL_FLUSH
PM_CMPLU_STALL_FXLONG
PM_CMPLU_STALL_FXU
PM_CMPLU_STALL_HWSYNC
PM_CMPLU_STALL_LOAD_FINISH
...........................
............................
............................

Sample tests:
================================================================
perf stat -e 'cpu/PM_CMPLU_STALL_ERAT_MISS/'  ls

 Performance counter stats for 'ls':

             56762 cpu/PM_CMPLU_STALL_ERAT_MISS/                                   

       0.003643785 seconds time elapsed
       
perf stat -e 'cpu/PM_CMPLU_STALL_BRU/' ls

 Performance counter stats for 'ls':

            208615 cpu/PM_CMPLU_STALL_BRU/                                     

       0.003600713 seconds time elapsed
=================================================================

Anshuman Khandual (2):
  power7, perf: Make some new raw event codes available in sysfs
  power8, perf: Export raw event codes through sysfs interface

 arch/powerpc/perf/power7-events-list.h |  10 +++
 arch/powerpc/perf/power8-events-list.h | 146 +++++++++++++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c         |  30 +++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

-- 
1.7.11.7
