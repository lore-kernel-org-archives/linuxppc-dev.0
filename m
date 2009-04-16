Return-Path: <geoff@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B11BDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:27:11 +1000 (EST)
Message-Id: <20090416190536.626536145@am.sony.com>>
References: <20090416190536.540992667@am.sony.com>>
In-Reply-To: <20090416190536.540992667@am.sony.com>>
Date: Thu, 16 Apr 2009 12:05:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 1/4] powerpc/ps3: Fix no SMP build error
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A non-SMP version of smp_send_stop() is now included in smp.h.
Remove the unneeded def in the PS3 smp.c.

Fixes build errors like these when CONFIG_SMP=n:

  arch/powerpc/platforms/ps3/setup.c:49: error: redefinition of 'smp_send_stop'
  include/linux/smp.h:125: error: previous definition of 'smp_send_stop' was here

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -45,10 +45,6 @@
 DEFINE_MUTEX(ps3_gpu_mutex);
 EXPORT_SYMBOL_GPL(ps3_gpu_mutex);
 
-#if !defined(CONFIG_SMP)
-static void smp_send_stop(void) {}
-#endif
-
 static union ps3_firmware_version ps3_firmware_version;
 
 void ps3_get_firmware_version(union ps3_firmware_version *v)

-- 
