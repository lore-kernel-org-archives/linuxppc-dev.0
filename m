Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDjQ6494KzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 15:42:38 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v1so3679754pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 22:42:38 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, anton@samba.org,
 npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH 1/2] powerpc/powernv: Add config option for removal of memory
Date: Fri, 28 Apr 2017 15:42:26 +1000
Message-Id: <20170428054227.9176-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 arch/powerpc/platforms/powernv/Kconfig  | 4 ++++
 arch/powerpc/platforms/powernv/Makefile | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6a6f4ef..1b8b3a8 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -30,3 +30,7 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config HARDWARE_TRACING
+	bool 'Enable removal of memory for hardware memory tracing'
+	depends on PPC_POWERNV && MEMORY_HOTPLUG
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..e61be1b 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_HARDWARE_TRACING)	+= memtrace.o
-- 
2.9.3
