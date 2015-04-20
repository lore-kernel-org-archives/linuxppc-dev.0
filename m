Return-Path: <baolin.wang@linaro.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E38BE1A1D79
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:58:11 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so196473792pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 22:58:10 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 00/11] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
Date: Mon, 20 Apr 2015 13:57:28 +0800
Message-Id: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 baolin.wang@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series changes the 32-bit time type (timespec/itimerspec) to the 64-bit one
(timespec64/itimerspec64), since 32-bit time types will break in the year 2038.

This patch series introduces new methods with timespec64/itimerspec64 type,
and removes the old ones with timespec/itimerspec type for posix_clock_operations
and k_clock structure.

Also introduces some new functions with timespec64/itimerspec64 type, like current_kernel_time64(),
hrtimer_get_res64(), cputime_to_timespec64() and timespec64_to_cputime().

Baolin Wang (11):
  linux/time64.h:Introduce the 'struct itimerspec64' for 64bit
  timekeeping:Introduce the current_kernel_time64() function with
    timespec64 type
  time/hrtimer:Introduce hrtimer_get_res64() with timespec64 type for
    getting the timer resolution
  posix timers:Introduce the 64bit methods with timespec64 type for
    k_clock structure
  time/posix-timers:Convert to the 64bit methods for k_clock callback
    functions
  char/mmtimer:Convert to the 64bit methods for k_clock callback
    function
  time/alarmtimer:Convert to the new methods for k_clock structure
  time/posix-clock:Convert to the 64bit methods for k_clock and
    posix_clock_operations structure
  cputime:Introduce the cputime_to_timespec64/timespec64_to_cputime
    function
  time/posix-cpu-timers:Convert to the 64bit methods for k_clock
    structure
  k_clock:Remove the 32bit methods with timespec type

 arch/powerpc/include/asm/cputime.h    |    6 +-
 arch/s390/include/asm/cputime.h       |    8 +-
 drivers/char/mmtimer.c                |   36 ++++----
 drivers/ptp/ptp_clock.c               |   26 ++----
 include/asm-generic/cputime_jiffies.h |   10 +--
 include/linux/cputime.h               |   15 ++++
 include/linux/hrtimer.h               |   12 ++-
 include/linux/jiffies.h               |    3 +
 include/linux/posix-clock.h           |   10 +--
 include/linux/posix-timers.h          |   18 ++--
 include/linux/time64.h                |   13 +++
 include/linux/timekeeping.h           |   14 ++-
 kernel/time/alarmtimer.c              |   43 ++++-----
 kernel/time/hrtimer.c                 |   10 +--
 kernel/time/posix-clock.c             |   20 ++---
 kernel/time/posix-cpu-timers.c        |   83 +++++++++--------
 kernel/time/posix-timers.c            |  157 +++++++++++++++++++--------------
 kernel/time/time.c                    |   21 +++++
 kernel/time/timekeeping.c             |    6 +-
 kernel/time/timekeeping.h             |    2 +-
 20 files changed, 302 insertions(+), 211 deletions(-)

-- 
1.7.9.5
