Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD8B0B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 19:04:25 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 849A4DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 19:04:25 +1000 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Workaround MPC8536 GPIO 1 errata.
Date: Tue, 11 Aug 2009 12:04:18 +0300
Message-Id: <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
In-Reply-To: <>
References: <>
Cc: Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MPC8536 Rev 1.0 the status of GPIO pins configured
as output cannot be determined by reading GPDAT register.
Workaround by reading the status of input pins from GPDAT
and the status of output pins from a shadow register.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 103eace..0b996f3 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -56,9 +56,13 @@ static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
 
 static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
+	u32 val;
 	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	
+	val = in_be32(mm->regs + GPIO_DAT) && ~in_be32(mm->regs + GPIO_DIR);
 
-	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
+	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
 }
 
 static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-- 
1.5.4.3
