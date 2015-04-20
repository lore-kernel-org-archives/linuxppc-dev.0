Return-Path: <baolin.wang@linaro.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E55181A1DA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:58:31 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so196464908pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 22:58:30 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 02/11] timekeeping:Introduce the current_kernel_time64()
 function with timespec64 type
Date: Mon, 20 Apr 2015 13:57:30 +0800
Message-Id: <1429509459-17068-3-git-send-email-baolin.wang@linaro.org>
In-Reply-To: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
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

This patch adds current_kernel_time64() function with timespec64 type,
and makes current_kernel_time() 'static inline' and moves it to timekeeping.h
file.

It is convenient for user to get the current kernel time with timespec64 type,
and delete the current_kernel_time() function easily in timekeeping.h file. That
is ready for 2038 when get the current time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/timekeeping.h |   10 +++++++++-
 kernel/time/timekeeping.c   |    6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3eaae47..c6d5ae9 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -18,10 +18,18 @@ extern int do_sys_settimeofday(const struct timespec *tv,
  * Kernel time accessors
  */
 unsigned long get_seconds(void);
-struct timespec current_kernel_time(void);
+struct timespec64 current_kernel_time64(void);
 /* does not take xtime_lock */
 struct timespec __current_kernel_time(void);
 
+static inline struct timespec current_kernel_time(void)
+{
+	struct timespec64 now;
+
+	now = current_kernel_time64();
+	return timespec64_to_timespec(now);
+}
+
 /*
  * timespec based interfaces
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91db941..8ccc02c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1721,7 +1721,7 @@ struct timespec __current_kernel_time(void)
 	return timespec64_to_timespec(tk_xtime(tk));
 }
 
-struct timespec current_kernel_time(void)
+struct timespec64 current_kernel_time64(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 now;
@@ -1733,9 +1733,9 @@ struct timespec current_kernel_time(void)
 		now = tk_xtime(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return timespec64_to_timespec(now);
+	return now;
 }
-EXPORT_SYMBOL(current_kernel_time);
+EXPORT_SYMBOL(current_kernel_time64);
 
 struct timespec64 get_monotonic_coarse64(void)
 {
-- 
1.7.9.5
