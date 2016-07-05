Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkK6j4GD8zDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 19:57:01 +1000 (AEST)
In-Reply-To: <1467297277-12494-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v3] powerpc/boot: Add OPAL console to epapr wrappers
Message-Id: <3rkK6j3kX2z9t0T@ozlabs.org>
Date: Tue,  5 Jul 2016 19:57:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-30-06 at 14:34:37 UTC, Oliver O'Halloran wrote:
> This patch adds an OPAL console backend to the powerpc boot wrapper so
> that decompression failures inside the wrapper can be reported to the
> user. This is important since it typically indicates data corruption in
> the firmware and other nasty things.
...
> Cc: stable@vger.kernel.org

I've dropped stable, something this big needs to get some wider testing before
it goes to stable.

It was also giving me:

  arch/powerpc/boot/opal.c:30:12: warning: ‘opal_con_open’ defined but not used [-Wunused-function]

So I applied the following patch to fix it:

diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 3a2ce1e1f048..1f37e1c1d6d8 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -13,6 +13,8 @@
 #include <libfdt.h>
 #include "../include/asm/opal-api.h"
 
+#ifdef __powerpc64__
+
 /* Global OPAL struct used by opal-call.S */
 struct opal {
 	u64 base;
@@ -70,7 +72,6 @@ static void opal_init(void)
 	opal.entry = be64_to_cpu(opal.entry);
 }
 
-#ifdef __powerpc64__
 int opal_console_init(void *devp, struct serial_console_data *scdp)
 {
 	opal_init();
@@ -94,4 +95,4 @@ int opal_console_init(void *devp, struct serial_console_data *scdp)
 {
 	return -1;
 }
-#endif
+#endif /* __powerpc64__ */

cheers
