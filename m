Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id 2A73F1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 07:48:28 +1100 (EST)
Received: by ewy7 with SMTP id 7so6199112ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Dec 2009 12:48:26 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] asm/gpio.h: support gpio_to_irq()
Date: Tue,  1 Dec 2009 21:48:13 +0100
Message-Id: <1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
In-Reply-To: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gpiolib returns -ENXIO if struct gpio_chip::to_irq isn't set, so it's
safe to always call.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/include/asm/gpio.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/gpio.h b/arch/powerpc/include/asm/gpio.h
index ea04632..38762ed 100644
--- a/arch/powerpc/include/asm/gpio.h
+++ b/arch/powerpc/include/asm/gpio.h
@@ -38,12 +38,9 @@ static inline int gpio_cansleep(unsigned int gpio)
 	return __gpio_cansleep(gpio);
 }
 
-/*
- * Not implemented, yet.
- */
 static inline int gpio_to_irq(unsigned int gpio)
 {
-	return -ENOSYS;
+	return __gpio_to_irq(gpio);
 }
 
 static inline int irq_to_gpio(unsigned int irq)
-- 
1.6.5
