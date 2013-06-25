Return-Path: <runzhen@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2BFD2C02F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:35:57 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <runzhen@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 11:31:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B49962CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:35:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PEKckn5177610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:20:39 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PEZa6S008957
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:35:36 +1000
From: Runzhen Wang <runzhen@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf tools: Power7 events name available for perf 
Date: Tue, 25 Jun 2013 22:35:31 +0800
Message-Id: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: acme@redhat.com, xiaoguangrong@linux.vnet.ibm.com, paulus@samba.org,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com
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

There is the Change Log for v2:

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
