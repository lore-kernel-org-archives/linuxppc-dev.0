Return-Path: <ldoktor@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWmKZ4h6zzDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 18:46:10 +1000 (AEST)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: ldoktor@redhat.com, a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org,
 sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
 alexandre.belloni@free-electrons.com, linux-kselftest@vger.kernel.org,
 john.stultz@linaro.org, tglx@linutronix.de, shuah@kernel.org,
 linux-rtc@vger.kernel.org
Subject: [PATCH v2 1/1] rtc: rtctest: Improve support detection
Date: Tue, 15 Aug 2017 10:46:00 +0200
Message-Id: <20170815084600.6285-2-ldoktor@redhat.com>
In-Reply-To: <20170815084600.6285-1-ldoktor@redhat.com>
References: <20170815084600.6285-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rtc-generic and opal-rtc are failing to run this test as they do not
support all the features. Let's treat the error returns and skip to the
following test.

Theoretically the test_DATE should be also adjusted, but as it's enabled
on demand I think it makes sense to fail in such case.

Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>
---
 tools/testing/selftests/timers/rtctest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index f61170f..411eff6 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -221,6 +221,11 @@ int main(int argc, char **argv)
 	/* Read the current alarm settings */
 	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
 	if (retval == -1) {
+		if (errno == EINVAL) {
+			fprintf(stderr,
+					"\n...EINVAL reading current alarm setting.\n");
+			goto test_PIE;
+		}
 		perror("RTC_ALM_READ ioctl");
 		exit(errno);
 	}
@@ -231,7 +236,7 @@ int main(int argc, char **argv)
 	/* Enable alarm interrupts */
 	retval = ioctl(fd, RTC_AIE_ON, 0);
 	if (retval == -1) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL || errno == EIO) {
 			fprintf(stderr,
 				"\n...Alarm IRQs not supported.\n");
 			goto test_PIE;
-- 
2.9.4
