Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7365EDDFBF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 11:10:04 +1100 (EST)
Date: Fri, 1 Feb 2008 18:09:58 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc: fsl_soc: fix mpc83xx_spi device registration
Message-Id: <20080201180958.7c66bff3.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

calling platform_device_register after platform_device_alloc causes
this:

kobject (c3841a70): tried to init an initialized object, something is seriously wrong.
Call Trace:
[c381fe20] [c0007bb8] show_stack+0x3c/0x194 (unreliable)
[c381fe50] [c01322a8] kobject_init+0xb8/0xbc
[c381fe60] [c01591cc] device_initialize+0x30/0x9c
[c381fe80] [c015ee34] platform_device_register+0x1c/0x34
[c381fea0] [c02f1fe0] of_fsl_spi_probe+0x21c/0x22c
[c381ff30] [c02f2044] fsl_spi_init+0x54/0x160
[c381ff60] [c02f3924] __machine_initcall_mpc832x_rdb_mpc832x_spi_init+0x120/0x138
[c381ff70] [c02e61b4] kernel_init+0x98/0x284
[c381fff0] [c000f740] kernel_thread+0x44/0x60

fixed by calling platform_device_add (second half of
platform_device_register) instead.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e48b20e..2c5388c 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1342,7 +1342,7 @@ static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 		if (ret)
 			goto unreg;
 
-		ret = platform_device_register(pdev);
+		ret = platform_device_add(pdev);
 		if (ret)
 			goto unreg;
 
-- 
1.5.2.2
