Return-Path: <roel.kluin@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id D55AEDEED9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:43:43 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so11053nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:43:41 -0700 (PDT)
Message-ID: <48AAEA2A.3010107@gmail.com>
Date: Tue, 19 Aug 2008 11:43:38 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Subject: [PATCH v2] powerpc, scc: duplicate SCC_UHC_USBCEN
References: <20080819.220200.-1300539182.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080819.220200.-1300539182.kouish@swc.toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kou Ishizaki wrote:
> 
> Roel,
> 
>> untested, is it correct?
> 
> Your patch is correct.
> 
> Thanks for your pointing it out and sending the patch. I tested your
> patch and it works good.
> 
> Fortunately, this bug is not fatal because it seems that the SCC-UHC
> sets SCC_UHC_USBEN and SCC_UHC_USBCEN at once.
> 
> 
> Your patch does not contain 'Signed-off-by' line. Could you re-post it
> with your sign?

Sorry for that and thanks for testing.
---
duplicate SCC_UHC_USBCEN

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
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
 
