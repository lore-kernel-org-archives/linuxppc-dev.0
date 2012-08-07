Return-Path: <B35336@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62B802C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 18:41:38 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 3/4] cpu: export cpu hotplug disable/enable functions as
 global functions
Date: Tue, 7 Aug 2012 16:43:25 +0800
Message-ID: <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpufreq driver of mpc85xx will disable/enable cpu hotplug temporarily.
Therefore, the related functions should be exported.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 include/linux/cpu.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ce7a074..df8f73d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -146,6 +146,8 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 
+extern void cpu_hotplug_disable_before_freeze(void);
+extern void cpu_hotplug_enable_after_thaw(void);
 #else	/* CONFIG_SMP */
 
 #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
@@ -167,6 +169,8 @@ static inline void cpu_maps_update_done(void)
 {
 }
 
+static inline void cpu_hotplug_disable_before_freeze(void)	{}
+static inline void cpu_hotplug_enable_after_thaw(void)	{}
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
-- 
1.6.4.1
