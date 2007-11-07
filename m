Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85865DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 09:22:54 +1100 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IptIQ-0004HI-92
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 23:22:50 +0100
Message-ID: <47323AB8.3060804@tiscali.nl>
Date: Wed, 07 Nov 2007 23:22:48 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ioremap/iounmap issue in yucca_setup_pcie_fpga_rootpoint();
	arch/ppc/platforms/4xx/yucca.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

iounmap pcie_reg_fpga_base in default case

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
index a83b0ba..66a44ff 100644
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -211,6 +211,7 @@ static void __init yucca_setup_pcie_fpga_rootpoint(int port)
 		break;
 
 	default:
+		iounmap(pcie_reg_fpga_base);
 		return;
 	}
 
