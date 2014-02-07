Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC6D92C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 19:09:38 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 7 Feb 2014 01:09:34 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 160F1C90026
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:09:28 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1789U8D7668132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:09:30 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1789TtW020973
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 03:09:30 -0500
Subject: [PATCH V4 0/3] time/cpuidle: Support in tick broadcast framework in
 absence of external clock device
To: linux-pm@vger.kernel.org, peterz@infradead.org, benh@kernel.crashing.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 07 Feb 2014 13:35:56 +0530
Message-ID: <20140207075618.17187.20149.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, fweisbec@gmail.com, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset provides support in the tick broadcast framework for such
architectures so as to enable the CPUs to get into deep idle.

Presently we are in need of this support on certain implementations of
PowerPC. This patchset has thus been tested on the same.

This patchset has been based on the idea discussed here:
http://www.kernelhub.org/?p=2&msg=399516

Changes in V4:
1. Cleared the stand by CPU from the oneshot mask. As a result PATCH 3/3
was simplified.
2. Fixed compile time warnings.
---

Preeti U Murthy (2):
      time: Change the return type of clockevents_notify() to integer
      time/cpuidle:Handle failed call to BROADCAST_ENTER on archs with CPUIDLE_FLAG_TIMER_STOP set

Thomas Gleixner (1):
      tick/cpuidle: Initialize hrtimer mode of broadcast


 drivers/cpuidle/cpuidle.c            |   14 +++--
 include/linux/clockchips.h           |   15 ++++-
 kernel/time/Makefile                 |    2 -
 kernel/time/clockevents.c            |    8 ++-
 kernel/time/tick-broadcast-hrtimer.c |  105 ++++++++++++++++++++++++++++++++++
 kernel/time/tick-broadcast.c         |   60 ++++++++++++++++++-
 kernel/time/tick-internal.h          |    6 +-
 7 files changed, 189 insertions(+), 21 deletions(-)
 create mode 100644 kernel/time/tick-broadcast-hrtimer.c

-- 
