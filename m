Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FC3E2C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 13:01:46 +1000 (EST)
Received: from mail96-ch1 (localhost [127.0.0.1])	by mail96-ch1-R.bigfish.com
 (Postfix) with ESMTP id A07DB38019E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Apr 2013 03:01:42 +0000 (UTC)
Received: from CH1EHSMHS001.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.234])	by mail96-ch1.bigfish.com (Postfix) with ESMTP id
 2A0CF8004B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 03:01:40 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v3 3/4] powerpc/mpic: create mpic subsystem object
Date: Tue, 9 Apr 2013 10:22:31 +0800
Message-ID: <1365474152-21524-3-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register a mpic subsystem at /sys/devices/system/

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
 arch/powerpc/include/asm/mpic.h | 2 ++
 arch/powerpc/sysdev/mpic.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c0f9ef9..fa70e9b 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -339,6 +339,8 @@ struct mpic
 #endif
 };
 
+extern struct bus_type mpic_subsys;
+
 /*
  * MPIC flags (passed to mpic_alloc)
  *
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index ae709d2..58e7661 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -48,6 +48,12 @@
 #define DBG(fmt...)
 #endif
 
+struct bus_type mpic_subsys = {
+	.name = "mpic",
+	.dev_name = "mpic",
+};
+EXPORT_SYMBOL_GPL(mpic_subsys);
+
 static struct mpic *mpics;
 static struct mpic *mpic_primary;
 static DEFINE_RAW_SPINLOCK(mpic_lock);
@@ -1989,6 +1995,8 @@ static struct syscore_ops mpic_syscore_ops = {
 static int mpic_init_sys(void)
 {
 	register_syscore_ops(&mpic_syscore_ops);
+	subsys_system_register(&mpic_subsys, NULL);
+
 	return 0;
 }
 
-- 
1.8.0
