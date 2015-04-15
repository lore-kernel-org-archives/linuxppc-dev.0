Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F3E41A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:24:22 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 00:24:20 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CE5613E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 00:24:17 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3F6O15840829148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 23:24:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3F6OHtR011697
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 00:24:17 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] powerpc: powernv: Fastsleep workaround behavior
Date: Wed, 15 Apr 2015 11:54:06 +0530
Message-Id: <1429079049-5955-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 preeti@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fastsleep is one of the idle state which cpuidle subsystem currently
uses on power8 machines. In this state L2 cache is brought down to a
threshold voltage. Therefore when the core is in fastsleep, the 
communication between L2 and L3 needs to be fenced. But there is a bug 
in the current power8 chips surrounding this fencing.

OPAL provides a workaround which precludes the possibility of hitting
this bug. But running with this workaround applied causes checkstop
if any correctable error in L2 cache directory is detected. Hence OPAL
also provides a way to undo the workaround.

In the existing implementation, workaround is applied by the last thread
of the core entering fastsleep and undone by the first thread waking up. 
But this has a performance cost. These OPAL calls account for roughly
4000 cycles everytime the core has to enter or wakeup from fastsleep.

This patchset introduces a sysfs attribute (fastsleep_workaround_state)
to choose the behavior of this workaround.

Patch 1/3 fixes cpu_online_cores_map which is used by Patch 3/3. 
Patch 2/3 is a clean up patch. It moves all cpuidle related code into 
a new file. 
Patch 3/3 introduces the sysfs attribute to control fastsleep workaround
behavior


Changes in v5:
- Fix potential race with hotplug with get_online_cpu/put_online_cpu

Changes in v4:
-------------
-Handling patch_instruction and OPAL call errors
-Sysfs attribute takes string ("dynamic" vs "applyonce") as input. 
-Improved changelogs

Changes in v3:
--------------
-Kernel parameter changed to sysfs attribute

Changes in v2:
--------------
-Changed commit message to accurately describe the downside
 of running workaround always applied.

Shreyas B. Prabhu (3):
  powerpc: Fix cpu_online_cores_map to return only online threads mask
  powerpc/powernv: Move cpuidle related code from setup.c to new file
  powerpc/powernv: Introduce sysfs control for fastsleep workaround
    behavior

 arch/powerpc/include/asm/cputhreads.h          |  13 +-
 arch/powerpc/include/asm/opal-api.h            |   7 +
 arch/powerpc/include/asm/opal.h                |   1 +
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/idle.c          | 323 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/setup.c         | 171 -------------
 7 files changed, 341 insertions(+), 177 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/idle.c

-- 
1.9.3
