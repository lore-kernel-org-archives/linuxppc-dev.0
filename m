Return-Path: <hkallweit1@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5jgM6bHjzDvT1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 01:29:19 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id p190so5222040wmp.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 07:29:19 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/3] powerpc/fsl_soc: improve and simplify fsl_get_sys_freq
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <f60d2b4b-4d82-b92f-5fa4-f067feba460d@gmail.com>
Date: Sat, 29 Oct 2016 16:27:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of_property_read_u32 instead of the generic of_get_property to
simplify the code. In addition move the declaration of sysfreq
into fsl_get_sys_freq because it's private to this function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d93056e..48fc36b 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -77,13 +77,10 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
-static u32 sysfreq = -1;
-
 u32 fsl_get_sys_freq(void)
 {
+	static u32 sysfreq = -1;
 	struct device_node *soc;
-	const u32 *prop;
-	int size;
 
 	if (sysfreq != -1)
 		return sysfreq;
@@ -92,12 +89,9 @@ u32 fsl_get_sys_freq(void)
 	if (!soc)
 		return -1;
 
-	prop = of_get_property(soc, "clock-frequency", &size);
-	if (!prop || size != sizeof(*prop) || *prop == 0)
-		prop = of_get_property(soc, "bus-frequency", &size);
-
-	if (prop && size == sizeof(*prop))
-		sysfreq = *prop;
+	of_property_read_u32(soc, "clock-frequency", &sysfreq);
+	if (sysfreq == -1 || !sysfreq)
+		of_property_read_u32(soc, "bus-frequency", &sysfreq);
 
 	of_node_put(soc);
 	return sysfreq;
-- 
2.10.1
