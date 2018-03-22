Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNQ2TYMzF20B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:10 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id c24so9993504wrc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:10 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 16/19] powerpc/powermac: Add missing include of header pmac.h
Date: Thu, 22 Mar 2018 21:20:02 +0100
Message-Id: <20180322202007.23088-17-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
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

The header `pmac.h` was not included, leading to the following warnings,
treated as error with W=1:

  arch/powerpc/platforms/powermac/time.c:69:13: error: no previous prototype for ‘pmac_time_init’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:207:15: error: no previous prototype for ‘pmac_get_boot_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:222:6: error: no previous prototype for ‘pmac_get_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:240:5: error: no previous prototype for ‘pmac_set_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:259:12: error: no previous prototype for ‘via_calibrate_decr’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:311:13: error: no previous prototype for ‘pmac_calibrate_decr’ [-Werror=missing-prototypes]

The function `via_calibrate_decr` was made static to silence a warning.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..5cc6fa40fcc4 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -34,6 +34,8 @@
 #include <asm/nvram.h>
 #include <asm/smu.h>
 
+#include "pmac.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -256,7 +258,7 @@ int pmac_set_rtc_time(struct rtc_time *tm)
  * Calibrate the decrementer register using VIA timer 1.
  * This is used both on powermacs and CHRP machines.
  */
-int __init via_calibrate_decr(void)
+static int __init via_calibrate_decr(void)
 {
 	struct device_node *vias;
 	volatile unsigned char __iomem *via;
-- 
2.11.0
