Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA2EE2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 18:01:05 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 24 Jan 2014 00:01:02 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 54C3EC4000D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 00:00:27 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s0O4wXXe10092848
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 05:58:33 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0O70v36029241
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 00:00:59 -0700
Subject: [PATCH V2 0/2] time/cpuidle: Support in tick broadcast framework in
 absence of external clock device
To: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 galak@kernel.crashing.org, paul.gortmaker@windriver.com,
 paulus@samba.org, mingo@kernel.org, mikey@neuling.org,
 shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, agraf@suse.de,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, tglx@linutronix.de,
 chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 24 Jan 2014 12:27:08 +0530
Message-ID: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This earlier version of this patchset can be found here:
https://lkml.org/lkml/2013/12/12/687. This version has been based on the
discussion in http://www.kernelhub.org/?p=2&msg=399516.

This patchset provides the hooks that the architectures without an external
clock device and deep idle states where the local timers stop can make use of.

Presently we are in need of this support on certain implementations of
PowerPC. This patchset has been used on PowerPC for testing with

---

Preeti U Murthy (1):
      time: Change the return type of clockevents_notify() to integer

Thomas Gleixner (1):
      tick/cpuidle: Initialize hrtimer mode of broadcast


 include/linux/clockchips.h           |   15 ++++-
 kernel/time/Makefile                 |    2 -
 kernel/time/clockevents.c            |    8 ++-
 kernel/time/tick-broadcast-hrtimer.c |  102 ++++++++++++++++++++++++++++++++++
 kernel/time/tick-broadcast.c         |   51 ++++++++++++++++-
 kernel/time/tick-internal.h          |    6 +-
 6 files changed, 171 insertions(+), 13 deletions(-)
 create mode 100644 kernel/time/tick-broadcast-hrtimer.c

-- 
