Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 574351A1262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 19:41:23 +1100 (AEDT)
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 659FF1402EC
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 19:41:22 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id 68so27121611pfc.1
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 00:41:22 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc: add va_end()
Date: Thu, 17 Dec 2015 19:41:00 +1100
Message-Id: <1450341660-31305-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cppcheck picked up that there were a couple of missing va_end()
calls in functions using va_start().

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/prom_init.c              | 1 +
 arch/powerpc/platforms/powermac/bootx_init.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 92dea8df6b26..da5192590c44 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -389,6 +389,7 @@ static void __init prom_printf(const char *format, ...)
 			break;
 		}
 	}
+	va_end(args);
 }
 
 
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 76f5013c35e5..c3c9bbb3573a 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -84,6 +84,7 @@ static void __init bootx_printf(const char *format, ...)
 			break;
 		}
 	}
+	va_end(args);
 }
 #else /* CONFIG_BOOTX_TEXT */
 static void __init bootx_printf(const char *format, ...) {}
-- 
2.6.2
