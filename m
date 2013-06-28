Return-Path: <runzhen@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5233F2C0524
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:15:57 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <runzhen@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 18:06:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BCFF72BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:15:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S80sUp6226204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:00:54 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S8Fj0l029049
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:15:46 +1000
From: Runzhen Wang <runzhen@linux.vnet.ibm.com>
To: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf tools: Power7 events name available for perf
Date: Fri, 28 Jun 2013 16:14:55 +0800
Message-Id: <1372407297-6996-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: icycoder@gmail.com, runzhew@clemson.edu, xiaoguangrong@linux.vnet.ibm.com,
 acme@redhat.com, paulus@samba.org, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank for Sukadev Bhattip and Xiao Guangrong's help.
Thank for Michael Ellerman's review. 

ChangeLog: v2 -> v3:

1. Adding a leading zero to all the events code in "power7-events-list.h" 
   which don't have a PMC, so that they all line up vertically.


ChangeLog: v1 -> v2:

1. As Michael Ellerman suggested, I added runtime overhead information 
   in the 0002 patch's description.

2. Put the events name in a new head file which is named "power7-events-list.h",
   and use several macros, such as, 

   #define EVENT(_name, _code)     POWER_EVENT_ATTR(_name, _code)
   #include "power7-events-list.h"
   #undef EVENT
  
   to generate different outputs.

Thanks
Runzhen Wang


Runzhen Wang (2):
  perf tools: fix a typo of a Power7 event name
  perf tools: Make Power7 events available for perf

 .../testing/sysfs-bus-event_source-devices-events  |    2 +-
 arch/powerpc/include/asm/perf_event_server.h       |    4 +-
 arch/powerpc/perf/power7-events-list.h             |  548 ++++++++++++++++++++
 arch/powerpc/perf/power7-pmu.c                     |  150 ++----
 4 files changed, 584 insertions(+), 120 deletions(-)
 create mode 100644 arch/powerpc/perf/power7-events-list.h

-- 
1.7.9.5
