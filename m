Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71D602C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 16:53:46 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 22:53:44 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B450619D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 22:53:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s165raBu11665702
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 06:53:41 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s165rKfQ007166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 22:53:21 -0700
Subject: [PATCH V3 0/3] time/cpuidle: Support in tick broadcast framework in
 absence of external clock device
To: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 fweisbec@gmail.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 benh@kernel.crashing.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 06 Feb 2014 11:19:35 +0530
Message-ID: <20140206054158.4595.17827.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some architectures, the local timers of CPUs stop in deep idle states.
They will need to depend on an external clock device to wake them up. However
certain implementations of archs do not have an external clock device.

This patchset provides support in the tick broadcast framework for such
architectures so as to enable the CPUs to get into deep idle.

Presently we are in need of this support on certain implementations of
PowerPC. This patchset has thus been tested on the same.

V1: https://lkml.org/lkml/2013/12/12/687.
V2: https://lkml.org/lkml/2014/1/24/28

Changes in V3:
1. Modified comments and code around programming of the broadcast hrtimer.

---

Preeti U Murthy (2):
      time: Change the return type of clockevents_notify() to integer
      time/cpuidle:Handle failed call to BROADCAST_ENTER on archs with CPUIDLE_FLAG_TIMER_STOP set

Thomas Gleixner (1):
      tick/cpuidle: Initialize hrtimer mode of broadcast


 drivers/cpuidle/cpuidle.c            |   38 +++++++-----
 include/linux/clockchips.h           |   15 ++++-
 kernel/time/Makefile                 |    2 -
 kernel/time/clockevents.c            |    8 ++-
 kernel/time/tick-broadcast-hrtimer.c |  105 ++++++++++++++++++++++++++++++++++
 kernel/time/tick-broadcast.c         |   51 ++++++++++++++++-
 kernel/time/tick-internal.h          |    6 +-
 7 files changed, 197 insertions(+), 28 deletions(-)
 create mode 100644 kernel/time/tick-broadcast-hrtimer.c

-- 
