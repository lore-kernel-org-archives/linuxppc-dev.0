Return-Path: <baolin.wang@linaro.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E72641A1A24
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:58:22 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so197597571pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 22:58:21 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 01/11] linux/time64.h:Introduce the 'struct itimerspec64' for
 64bit
Date: Mon, 20 Apr 2015 13:57:29 +0800
Message-Id: <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
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

This patch introduces the 'struct itimerspec64' for 64bit to replace itimerspec,
and also introduces the conversion methods: itimerspec64_to_itimerspec() and
itimerspec_to_itimerspec64(), that makes itimerspec to ready for 2038 year.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/time64.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index a383147..3647bdd 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -18,6 +18,11 @@ struct timespec64 {
 };
 #endif
 
+struct itimerspec64 {
+	struct timespec64 it_interval;  /* timer period */
+	struct timespec64 it_value;     /* timer expiration */
+};
+
 /* Parameters used to convert the timespec values: */
 #define MSEC_PER_SEC	1000L
 #define USEC_PER_MSEC	1000L
@@ -187,4 +192,12 @@ static __always_inline void timespec64_add_ns(struct timespec64 *a, u64 ns)
 
 #endif
 
+#define itimerspec64_to_itimerspec(its64) \
+	({ (struct itimerspec){ .it_interval = timespec64_to_timespec((its64).it_interval), \
+				.it_value = timespec64_to_timespec((its64).it_value) }; })
+
+#define itimerspec_to_itimerspec64(its) \
+	({ (struct itimerspec64){ .it_interval = timespec_to_timespec64((its).it_interval), \
+				  .it_value = timespec_to_timespec64((its).it_value) }; })
+
 #endif /* _LINUX_TIME64_H */
-- 
1.7.9.5
