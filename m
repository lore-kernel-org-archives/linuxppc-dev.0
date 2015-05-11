Return-Path: <baolin.wang@linaro.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 619F91A0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 21:06:42 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so107509848pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 04:06:40 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH v3 00/22] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
Date: Mon, 11 May 2015 19:06:25 +0800
Message-Id: <1431342385-29319-1-git-send-email-baolin.wang@linaro.org>
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

Changes since v2:
     	-Split the syscall conversion patch into small some patches.

*** BLURB HERE ***

Baolin Wang (22):
  linux/time64.h:Introduce the 'struct itimerspec64' for 64bit
  timekeeping:Introduce the current_kernel_time64() function with
    timespec64 type
  time/hrtimer:Introduce hrtimer_get_res64() with timespec64 type for
    getting the timer resolution
  posix-timers:Split out the guts of the syscall and change the
    implementation for timer_gettime
  posix-timers:Convert to the 64bit methods for the timer_gettime
    syscall function
  posix-timers:Split out the guts of the syscall and change the
    implementation for timer_settime
  posix-timers:Convert to the 64bit methods for the timer_settime
    syscall function
  posix-timers:Split out the guts of the syscall and change the
    implementation for clock_settime
  posix-timers:Convert to the 64bit methods for the clock_settime
    syscall function
  posix-timers:Split out the guts of the syscall and change the
    implementation for clock_gettime
  posix-timers:Convert to the 64bit methods for the clock_gettime
    syscall function
  posix-timers:Split out the guts of the syscall and change the
    implementation for clock_getres
  posix-timers:Convert to the 64bit methods for the clock_getres
    syscall function
  time:Introduce the do_sys_settimeofday64() function with timespec64
    type
  time/posix-timers:Convert to the 64bit methods for k_clock callback
    functions
  char/mmtimer:Convert to the 64bit methods for k_clock callback
    function
  time/alarmtimer:Convert to the new 64bit methods for k_clock
    structure
  time/posix-clock:Convert to the 64bit methods for k_clock and
    posix_clock_operations structure
  time/time:Introduce the timespec64_to_jiffies/jiffies_to_timespec64
    function
  cputime:Introduce the cputime_to_timespec64/timespec64_to_cputime
    function
  time/posix-cpu-timers:Convert to the 64bit methods for k_clock
    structure
  k_clock:Remove the 32bit methods with timespec/itimerspec type

 arch/powerpc/include/asm/cputime.h    |    6 +-
 arch/s390/include/asm/cputime.h       |    8 +-
 drivers/char/mmtimer.c                |   36 +++--
 drivers/ptp/ptp_clock.c               |   26 +---
 include/asm-generic/cputime_jiffies.h |   10 +-
 include/asm-generic/cputime_nsecs.h   |    4 +-
 include/linux/cputime.h               |   15 ++
 include/linux/hrtimer.h               |   12 +-
 include/linux/jiffies.h               |   21 ++-
 include/linux/posix-clock.h           |   10 +-
 include/linux/posix-timers.h          |   18 +--
 include/linux/time64.h                |   35 +++++
 include/linux/timekeeping.h           |   26 +++-
 kernel/time/alarmtimer.c              |   43 +++---
 kernel/time/hrtimer.c                 |   10 +-
 kernel/time/posix-clock.c             |   20 +--
 kernel/time/posix-cpu-timers.c        |   83 +++++-----
 kernel/time/posix-timers.c            |  269 ++++++++++++++++++++++-----------
 kernel/time/time.c                    |   22 +--
 kernel/time/timekeeping.c             |    6 +-
 kernel/time/timekeeping.h             |    2 +-
 21 files changed, 428 insertions(+), 254 deletions(-)

-- 
1.7.9.5
