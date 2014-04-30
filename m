Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E92B14010E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 16:04:10 +1000 (EST)
Received: by mail-ob0-f176.google.com with SMTP id wp4so1441413obc.21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 23:04:06 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] powerpc: fix skipping call to early_init_fdt_scan_reserved_mem
Date: Wed, 30 Apr 2014 01:03:52 -0500
Message-Id: <1398837832-30052-1-git-send-email-robherring2@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <robh@kernel.org>

The call to early_init_fdt_scan_reserved_mem will be skipped if
reserved-ranges is not found. Move the call earlier so that it is called
unconditionally.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Tested-by: Stephen Chivers <schivers@csc.com>
---
I found this issue in testing of my fdt clean-up series (thanks to 
Stephen). Since the reserved memory support is new, I don't think it is 
critical to fix this for 3.15. I plan to include this with my fdt series 
for 3.16 unless I hear otherwise.

Rob

 arch/powerpc/kernel/prom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 668aa47..d657549 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -567,6 +567,8 @@ static void __init early_reserve_mem_dt(void)
 	unsigned long i, len, dt_root;
 	const __be32 *prop;
 
+	early_init_fdt_scan_reserved_mem();
+
 	dt_root = of_get_flat_dt_root();
 
 	prop = of_get_flat_dt_prop(dt_root, "reserved-ranges", &len);
@@ -589,8 +591,6 @@ static void __init early_reserve_mem_dt(void)
 			memblock_reserve(base, size);
 		}
 	}
-
-	early_init_fdt_scan_reserved_mem();
 }
 
 static void __init early_reserve_mem(void)
-- 
1.9.1
