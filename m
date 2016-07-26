Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz5CF2xmnzDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:45:13 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so12611112pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:45:13 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sgy_cts1000: Fix gpio_halt_cb()'s signature
Date: Mon, 25 Jul 2016 21:45:01 -0700
Message-Id: <1469508301-14645-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Halt callback in struct machdep_calls is declared with __noreturn
attribute, so omitting that attribute in gpio_halt_cb()'s signatrue
results in compilation error.

Change the signature to address the problem as well as change the code
of the function to avoid ever returning from the function.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 79fd0df..21d6aaa 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -38,18 +38,18 @@ static void gpio_halt_wfn(struct work_struct *work)
 }
 static DECLARE_WORK(gpio_halt_wq, gpio_halt_wfn);
 
-static void gpio_halt_cb(void)
+static void __noreturn gpio_halt_cb(void)
 {
 	enum of_gpio_flags flags;
 	int trigger, gpio;
 
 	if (!halt_node)
-		return;
+		panic("No reset GPIO information was provided in DT\n");
 
 	gpio = of_get_gpio_flags(halt_node, 0, &flags);
 
 	if (!gpio_is_valid(gpio))
-		return;
+		panic("Provided GPIO is invalid\n");
 
 	trigger = (flags == OF_GPIO_ACTIVE_LOW);
 
@@ -57,6 +57,8 @@ static void gpio_halt_cb(void)
 
 	/* Probably wont return */
 	gpio_set_value(gpio, trigger);
+
+	panic("Halt failed\n");
 }
 
 /* This IRQ means someone pressed the power button and it is waiting for us
-- 
2.5.5
