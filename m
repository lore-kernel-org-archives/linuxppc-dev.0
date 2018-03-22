Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNB4PR3zF20B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:58 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id l9so18344116wmh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:58 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 10/19] powerpc/chrp/time: Make some functions static,
 add missing header include
Date: Thu, 22 Mar 2018 21:19:56 +0100
Message-Id: <20180322202007.23088-11-malat@debian.org>
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

Add a missing include <platforms/chrp/chrp.h>.

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/time.c:41:13: error: no previous prototype for ‘chrp_time_init’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:66:5: error: no previous prototype for ‘chrp_cmos_clock_read’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:74:6: error: no previous prototype for ‘chrp_cmos_clock_write’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:86:5: error: no previous prototype for ‘chrp_set_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:130:6: error: no previous prototype for ‘chrp_get_rtc_time’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/chrp/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/time.c b/arch/powerpc/platforms/chrp/time.c
index 03d115aaa191..acde7bbe0716 100644
--- a/arch/powerpc/platforms/chrp/time.c
+++ b/arch/powerpc/platforms/chrp/time.c
@@ -28,6 +28,8 @@
 #include <asm/sections.h>
 #include <asm/time.h>
 
+#include <platforms/chrp/chrp.h>
+
 extern spinlock_t rtc_lock;
 
 #define NVRAM_AS0  0x74
@@ -63,7 +65,7 @@ long __init chrp_time_init(void)
 	return 0;
 }
 
-int chrp_cmos_clock_read(int addr)
+static int chrp_cmos_clock_read(int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
@@ -71,7 +73,7 @@ int chrp_cmos_clock_read(int addr)
 	return (inb(nvram_data));
 }
 
-void chrp_cmos_clock_write(unsigned long val, int addr)
+static void chrp_cmos_clock_write(unsigned long val, int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
-- 
2.11.0
