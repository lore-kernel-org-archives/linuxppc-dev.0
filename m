Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXlGw0423zDqcR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:01:59 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: sysdev: simple_gpio: fix Oops in gpio save_regs
 function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, stable@vger.kernel.org
Message-Id: <20170524080156.1C4936EB78@pc13941vm.idsi0.si.c-s.fr>
Date: Wed, 24 May 2017 10:01:55 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_mm_gpiochip_add_data() generates an Oops for NULL pointer dereference.

of_mm_gpiochip_add_data() calls mm_gc->save_regs() before
setting the data, therefore ->save_regs() cannot use gpiochip_get_data()

Fixes: 937daafca774b ("powerpc: simple-gpio: use gpiochip data pointer")
Cc: stable@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/simple_gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simple_gpio.c
index ef470b470b04..6afddae2fb47 100644
--- a/arch/powerpc/sysdev/simple_gpio.c
+++ b/arch/powerpc/sysdev/simple_gpio.c
@@ -75,7 +75,8 @@ static int u8_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static void u8_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
 {
-	struct u8_gpio_chip *u8_gc = gpiochip_get_data(&mm_gc->gc);
+	struct u8_gpio_chip *u8_gc =
+		container_of(mm_gc, struct u8_gpio_chip, mm_gc);
 
 	u8_gc->data = in_8(mm_gc->regs);
 }
-- 
2.12.0
