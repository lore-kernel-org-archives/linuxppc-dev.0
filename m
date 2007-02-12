Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 25AEFDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Feb 2007 21:31:23 +1100 (EST)
Subject: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: Pine.LNX.4.64.0611071451130.3291@host32.eke.fi
Content-Type: text/plain
Date: Mon, 12 Feb 2007 11:33:42 +0100
Message-Id: <1171276422.14090.54.camel@Apollo>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Vitaly,

I tried the Patch from Kalle Pokki
http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025108.html

but my SMC didnt work, without this patch, it works fine. I think that
the pram_base must be set the follwing way:

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
b/drivers/serial/cpm_uart/cpm_uart_core.c
index ea85f6a..76ab6e5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1025,6 +1025,7 @@ int cpm_uart_drv_get_platform_data(struct
platform_device *pdev, int is_con)
 	struct uart_cpm_port *pinfo;
 	int line;
 	u32 mem, pram, pram_base;
+	int	base;
 
 	idx = pdata->fs_no = fs_uart_get_id(pdata);
 
@@ -1050,11 +1051,12 @@ int cpm_uart_drv_get_platform_data(struct
platform_device *pdev, int is_con)
 	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
 		return -EINVAL;
 	pram = (u32)ioremap(r->start, r->end - r->start + 1);
-
+	base = r->start;
+	
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram_base");
 	if (r) {
 		pram_base = r->start;
-		out_be16((u16 *)pram_base, pram & 0xffff);
+		out_be16((u16 *)pram_base, base & 0xffff);
 	}
 
 	if(idx > fsid_smc2_uart) {


with this patch it works fine :-)

Best regards
Heiko

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
