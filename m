Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 99CA6DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 09:30:29 +1100 (EST)
Message-ID: <49B1A47F.8040005@embeddedarm.com>
Date: Fri, 06 Mar 2009 15:32:31 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Subject: Re: [PATCH, RFC]
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com>
In-Reply-To: <49B19AE0.3080609@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Let's try this one more time. The last patch was using the clocks for a custom 
board based on the Yosemite board and was referencing a non-existent ethNadr( I 
forgot to pull out this code out).

Signed-off-by: Eddie Dawydiuk <eddie@embeddedarm.com>

diff -urN linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c 
linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c
--- linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c   1969-12-31 
17:00:00.000000000 -0700
+++ linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c        2009-03-06 
15:33:24.000000000 -0700
@@ -0,0 +1,23 @@
+#include "ops.h"
+#include "stdio.h"
+#include "4xx.h"
+#include "44x.h"
+
+#define TARGET_4xx
+#define TARGET_44x
+#include "ppcboot.h"
+
+static void yosemite_fixups(void)
+{
+       unsigned long sysclk = 66666666;
+
+       ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+       ibm4xx_sdram_fixup_memsize();
+}
+
+void platform_specific_init(void)
+{
+       platform_ops.fixups = yosemite_fixups;
+       platform_ops.exit = ibm44x_dbcr_reset;
+}

> diff -urN linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c 
> linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c
> --- linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c   
> 1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c        
> 2009-03-06 14:55:46.000000000 -0700
> @@ -0,0 +1,24 @@
> +#include "ops.h"
> +#include "stdio.h"
> +#include "4xx.h"
> +#include "44x.h"
> +
> +#define TARGET_4xx
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static void yosemite_fixups(void)
> +{
> +       unsigned long sysclk = 50000000;
> +
> +       ibm440ep_fixup_clocks(sysclk, 11059200, 400000000);
> +       ibm4xx_sdram_fixup_memsize();
> +       dt_fixup_mac_address_by_alias("ethernet0", eth0adr);
> +       dt_fixup_mac_address_by_alias("ethernet1", eth1adr);
> +}
> +
> +void platform_specific_init(void)
> +{
> +       platform_ops.fixups = yosemite_fixups;
> +       platform_ops.exit = ibm44x_dbcr_reset;
> +}
> 


-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
