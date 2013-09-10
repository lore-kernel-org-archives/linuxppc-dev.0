Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FC1B2C0116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 11:38:11 +1000 (EST)
Received: by mail-pd0-f171.google.com with SMTP id g10so6932833pdj.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Sep 2013 18:38:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Export cpu_to_chip_id() to fix build error
Date: Mon,  9 Sep 2013 18:37:56 -0700
Message-Id: <1378777076-4699-1-git-send-email-linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc allmodconfig build fails with:

ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!

The problem was introduced with commit 15863ff3b (powerpc: Make chip-id
information available to userspace).

Export the missing symbol.

Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 442d8e2..8e59abc 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
 	of_node_put(np);
 	return of_get_ibm_chip_id(np);
 }
+EXPORT_SYMBOL(cpu_to_chip_id);
 
 /* Helper routines for cpu to core mapping */
 int cpu_core_index_of_thread(int cpu)
-- 
1.7.9.7
