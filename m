Return-Path: <baolin.wang@linaro.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1DDE1A0CD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 18:23:26 +1000 (AEST)
Received: by pdea3 with SMTP id a3so53745291pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:23:24 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: benh@kernel.crashing.org
Subject: [PATCH v2 13/15] cputime:Introduce the
 cputime_to_timespec64/timespec64_to_cputime function
Date: Thu, 30 Apr 2015 16:23:09 +0800
Message-Id: <1430382189-26706-1-git-send-email-baolin.wang@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, riel@redhat.com,
 arnd@arndb.de, baolin.wang@linaro.org, y2038@lists.linaro.org,
 heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, tj@kernel.org,
 paulus@samba.org, fweisbec@gmail.com, schwidefsky@de.ibm.com,
 linux390@de.ibm.com, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces some functions for converting cputime to timespec64 and back,
that repalce the timespec type with timespec64 type, as well as for arch/s390 and
arch/powerpc architecture.

And these new methods will replace the old cputime_to_timespec/timespec_to_cputime
function to ready for 2038 issue. The cputime_to_timespec/timespec_to_cputime functions
are moved to include/linux/cputime.h file for removing conveniently.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/powerpc/include/asm/cputime.h    |    6 +++---
 arch/s390/include/asm/cputime.h       |    8 ++++----
 include/asm-generic/cputime_jiffies.h |   10 +++++-----
 include/asm-generic/cputime_nsecs.h   |    4 ++--
 include/linux/cputime.h               |   15 +++++++++++++++
 5 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index e245255..5dda5c0 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -154,9 +154,9 @@ static inline cputime_t secs_to_cputime(const unsigned long sec)
 }
 
 /*
- * Convert cputime <-> timespec
+ * Convert cputime <-> timespec64
  */
-static inline void cputime_to_timespec(const cputime_t ct, struct timespec *p)
+static inline void cputime_to_timespec64(const cputime_t ct, struct timespec64 *p)
 {
 	u64 x = (__force u64) ct;
 	unsigned int frac;
@@ -168,7 +168,7 @@ static inline void cputime_to_timespec(const cputime_t ct, struct timespec *p)
 	p->tv_nsec = x;
 }
 
-static inline cputime_t timespec_to_cputime(const struct timespec *p)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *p)
 {
 	u64 ct;
 
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index b91e960..1266697 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -89,16 +89,16 @@ static inline cputime_t secs_to_cputime(const unsigned int s)
 }
 
 /*
- * Convert cputime to timespec and back.
+ * Convert cputime to timespec64 and back.
  */
-static inline cputime_t timespec_to_cputime(const struct timespec *value)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *value)
 {
 	unsigned long long ret = value->tv_sec * CPUTIME_PER_SEC;
 	return (__force cputime_t)(ret + __div(value->tv_nsec * CPUTIME_PER_USEC, NSEC_PER_USEC));
 }
 
-static inline void cputime_to_timespec(const cputime_t cputime,
-				       struct timespec *value)
+static inline void cputime_to_timespec64(const cputime_t cputime,
+				       struct timespec64 *value)
 {
 	unsigned long long __cputime = (__force unsigned long long) cputime;
 #ifndef CONFIG_64BIT
diff --git a/include/asm-generic/cputime_jiffies.h b/include/asm-generic/cputime_jiffies.h
index fe386fc..54e034c 100644
--- a/include/asm-generic/cputime_jiffies.h
+++ b/include/asm-generic/cputime_jiffies.h
@@ -44,12 +44,12 @@ typedef u64 __nocast cputime64_t;
 #define secs_to_cputime(sec)		jiffies_to_cputime((sec) * HZ)
 
 /*
- * Convert cputime to timespec and back.
+ * Convert cputime to timespec64 and back.
  */
-#define timespec_to_cputime(__val)	\
-	jiffies_to_cputime(timespec_to_jiffies(__val))
-#define cputime_to_timespec(__ct,__val)	\
-	jiffies_to_timespec(cputime_to_jiffies(__ct),__val)
+#define timespec64_to_cputime(__val)	\
+	jiffies_to_cputime(timespec64_to_jiffies(__val))
+#define cputime_to_timespec64(__ct,__val)	\
+	jiffies_to_timespec64(cputime_to_jiffies(__ct),__val)
 
 /*
  * Convert cputime to timeval and back.
diff --git a/include/asm-generic/cputime_nsecs.h b/include/asm-generic/cputime_nsecs.h
index 0419485..65c875b 100644
--- a/include/asm-generic/cputime_nsecs.h
+++ b/include/asm-generic/cputime_nsecs.h
@@ -73,12 +73,12 @@ typedef u64 __nocast cputime64_t;
 /*
  * Convert cputime <-> timespec (nsec)
  */
-static inline cputime_t timespec_to_cputime(const struct timespec *val)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *val)
 {
 	u64 ret = val->tv_sec * NSEC_PER_SEC + val->tv_nsec;
 	return (__force cputime_t) ret;
 }
-static inline void cputime_to_timespec(const cputime_t ct, struct timespec *val)
+static inline void cputime_to_timespec64(const cputime_t ct, struct timespec64 *val)
 {
 	u32 rem;
 
diff --git a/include/linux/cputime.h b/include/linux/cputime.h
index f2eb2ee..f01896f 100644
--- a/include/linux/cputime.h
+++ b/include/linux/cputime.h
@@ -13,4 +13,19 @@
 	usecs_to_cputime((__nsecs) / NSEC_PER_USEC)
 #endif
 
+static inline cputime_t timespec_to_cputime(const struct timespec *ts)
+{
+	struct timespec64 ts64 = timespec_to_timespec64(*ts);
+	return timespec64_to_cputime(&ts64);
+}
+
+static inline void cputime_to_timespec(const cputime_t cputime,
+					struct timespec *value)
+{
+	struct timespec64 *ts64;
+
+	*ts64 = timespec_to_timespec64(*value);
+	cputime_to_timespec64(cputime, ts64);
+}
+
 #endif /* __LINUX_CPUTIME_H */
-- 
1.7.9.5
