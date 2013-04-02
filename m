Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15A972C07CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 18:18:30 +1100 (EST)
Received: from mail50-ch1 (localhost [127.0.0.1])	by mail50-ch1-R.bigfish.com
 (Postfix) with ESMTP id 67F3F100143	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Apr 2013 07:18:26 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail50-ch1.bigfish.com (Postfix) with ESMTP id
 DD58D48004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 07:18:24 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 3/4] powerpc/mpic: create mpic subsystem object
Date: Tue, 2 Apr 2013 14:40:39 +0800
Message-ID: <1364884840-28635-3-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
References: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
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
index 50d1ee1..f07cfe0 100644
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
