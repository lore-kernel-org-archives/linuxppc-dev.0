Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLr1Q57X9zDsQ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 06:01:13 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VJx4KD174373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c26dsx97j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:11 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 16:01:10 -0400
Subject: [RFC PATCH 0/3] Separate LMB data from device tree format
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com
Date: Mon, 31 Jul 2017 15:48:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the upcoming introduction of a new device tree property format
for memory (ibm,dynamic-memory-v2), we should separate LMB data
from the device tree format used to represent them. Doing this
allows any consumer of LMB information, currently the mm/numa
and pseries/hotplug-memory code, to access it directly without
having to worry about device tree format and how to parse it.

This patch set attempts to solve this by creating an array of LMB
information at boot time which holds all relevant data presented in
the device tree for each LMB; base address, drc index, associativity
array index, and flags.

The first two patches are small updates to two routines to have them
look up the memory device node instead of having it passed to them.
This is needed since the new code will not need to look at the
device tree when getting LMB information.

The third patch introduces the new LMB data array in lmb.h and the
set of routines needed to initialize and access the array. The data
is intialized from parse_numa_properties() and the routines in numa.c
are updated to use the new LMB array.

A few notes:

This code has only been boot-tested. I would like to get some feedback
on this approach before venturing too far down this design path.

I considered intializing the lmb array in prom.c to avoid having to
write a new routine there to parse the -v2 property. My concern is
allocating the array for this information that early in boot, the
number of LMBs can get very large on systems with 16, 32 TB.

The code for memory DLPAR (pseries/hotplug-memory.c) still needs
to be updated to use the new LMB array.


Any thoughts, feedback, comments (good and bad) would be appreciated.

Thanks,
-Nathan
---

Nathan Fontenot (3):
      powerpc/numa: Get device node whenn retreiving associativity arrays
      powerpc/numa: Get device node whenn retreiving usm memory
      powerpc/mm: Separate LMB information from device tree format


 arch/powerpc/include/asm/lmb.h |   44 ++++++++
 arch/powerpc/mm/Makefile       |    2 
 arch/powerpc/mm/lmb.c          |  146 ++++++++++++++++++++++++++++
 arch/powerpc/mm/numa.c         |  211 ++++++++++------------------------------
 4 files changed, 244 insertions(+), 159 deletions(-)
 create mode 100644 arch/powerpc/include/asm/lmb.h
 create mode 100644 arch/powerpc/mm/lmb.c
