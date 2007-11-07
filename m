Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD618DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 09:17:36 +1100 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IptDI-0001iL-5v
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 23:17:32 +0100
Message-ID: <4732397A.8020607@tiscali.nl>
Date: Wed, 07 Nov 2007 23:17:30 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] very similar, now in walnut_setup_arch();
	arch/ppc/platforms/4xx/walnut.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

iounmap kb_data on error

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/walnut.c b/arch/ppc/platforms/4xx/walnut.c
index 2f97723..04d3f3f 100644
--- a/arch/ppc/platforms/4xx/walnut.c
+++ b/arch/ppc/platforms/4xx/walnut.c
@@ -81,22 +81,23 @@ walnut_setup_arch(void)
 	kb_data = ioremap(WALNUT_PS2_BASE, 8);
 	if (!kb_data) {
 		printk(KERN_CRIT
 		       "walnut_setup_arch() kb_data ioremap failed\n");
 		return;
 	}
 
 	kb_cs = kb_data + 1;
 
 	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
+		iounmap(kb_data);
 		printk(KERN_CRIT
 		       "walnut_setup_arch() fpga_status ioremap failed\n");
 		return;
 	}
 
 	fpga_enable = fpga_status + 1;
 	fpga_polarity = fpga_status + 2;
 	fpga_trigger = fpga_status + 3;
 	fpga_brdc = fpga_status + 4;
 
 	/* split the keyboard and mouse interrupts */
