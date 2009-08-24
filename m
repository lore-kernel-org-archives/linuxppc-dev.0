Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C64C5B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 18:54:34 +1000 (EST)
Date: Mon, 24 Aug 2009 10:54:32 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH for 2.6.31] powerpc/ps3: Add missing check for PS3 to rtc-ps3
	platform device registration
In-Reply-To: <1251099552.19818.4.camel@concordia>
Message-ID: <alpine.LRH.2.00.0908241053190.31587@vixen.sonytel.be>
References: <4A923AD3.1020507@in.ibm.com> <1251099552.19818.4.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On non-PS3, we get:

| kernel BUG at drivers/rtc/rtc-ps3.c:36!

because the rtc-ps3 platform device is registered unconditionally in a kernel
with builtin support for PS3.

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/time.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index b178a1e..40b5cb4 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+#include <asm/firmware.h>
 #include <asm/rtc.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
@@ -84,6 +85,9 @@ static int __init ps3_rtc_init(void)
 {
 	struct platform_device *pdev;
 
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return -ENODEV;
+
 	pdev = platform_device_register_simple("rtc-ps3", -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
-- 
1.6.2.4

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
