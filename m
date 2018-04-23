Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V0Fh5NpRzF245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:37:28 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 1/5] powerpc: always enable RTC_LIB
Date: Mon, 23 Apr 2018 10:36:38 +0200
Message-Id: <20180423083642.2608886-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to use the rtc_tm_to_time64() and rtc_time64_to_tm()
helper functions in later patches, we have to ensure that
CONFIG_RTC_LIB is always built-in.

Note that this symbol only controls a couple of helper functions,
not the actual RTC subsystem, which remains optional and is
enabled with CONFIG_RTC_CLASS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..de2cda320fdd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
+	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS			if !PPC64
-- 
2.9.0
