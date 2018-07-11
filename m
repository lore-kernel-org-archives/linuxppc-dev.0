Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QfL10LHdzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 22:59:52 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Breno Leitao <leitao@debian.org>, Mathieu Malaterre <malat@debian.org>,
 Yisheng Xie <xieyisheng1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] powerpc: xmon: use ktime_get_coarse_boottime64
Date: Wed, 11 Jul 2018 14:53:23 +0200
Message-Id: <20180711125338.1365368-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_monotonic_boottime() is deprecated, and may not be safe to call in
every context, as it has to read a hardware clocksource.

This changes xmon to print the time using ktime_get_coarse_boottime64()
instead, which avoids the old timespec type and the HW access.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent Jun 18, but this hasn't appeared in linux-next yet.

Resending to make sure this is still on the radar. Please apply
to the powerpc git for 4.19
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..45e3d0ec1246 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -918,13 +918,13 @@ static void remove_cpu_bpts(void)
 static void
 show_uptime(void)
 {
-	struct timespec uptime;
+	struct timespec64 uptime;
 
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
 
-		get_monotonic_boottime(&uptime);
+		ktime_get_coarse_boottime_ts64(&uptime);
 		printf("Uptime: %lu.%.2lu seconds\n", (unsigned long)uptime.tv_sec,
 			((unsigned long)uptime.tv_nsec / (NSEC_PER_SEC/100)));
 
-- 
2.9.0
