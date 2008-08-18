Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id E993BDE548
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 02:06:14 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so211256uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 09:06:12 -0700 (PDT)
Message-ID: <48A9F256.2000901@gmail.com>
Date: Mon, 18 Aug 2008 18:06:14 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: kou.ishizaki@toshiba.co.jp, paulus@samba.org,
	benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc, scc: duplicate SCC_UHC_USBCEN
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

untested, is it correct?
---
arch/powerpc/platforms/cell/celleb_scc.h:224:
#define SCC_UHC_USBEN           0x00010000
#define SCC_UHC_USBCEN          0x00020000

---
diff --git a/arch/powerpc/platforms/cell/celleb_scc_uhc.c b/arch/powerpc/platforms/cell/celleb_scc_uhc.c
index d63b720..b086f33 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_uhc.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_uhc.c
@@ -31,7 +31,7 @@
 
 static inline int uhc_clkctrl_ready(u32 val)
 {
-	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
+	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBEN;
 	return((val & mask) == mask);
 }
 
