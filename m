Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E14E0DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 09:14:33 +1100 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out3.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IptAL-00066A-5d
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 23:14:29 +0100
Message-ID: <473238C2.9050402@tiscali.nl>
Date: Wed, 07 Nov 2007 23:14:26 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] another ioremap/iounmap issue in sycamore_setup_arch();
	arch/ppc/platforms/4xx/sycamore.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

not yet tested
--
iounmap kb_data on error

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
index 8689f3e..c4ac63d 100644
--- a/arch/ppc/platforms/4xx/sycamore.c
+++ b/arch/ppc/platforms/4xx/sycamore.c
@@ -99,22 +99,23 @@ sycamore_setup_arch(void)
 	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
 	if (!kb_data) {
 		printk(KERN_CRIT
 		       "sycamore_setup_arch() kb_data ioremap failed\n");
 		return;
 	}
 
 	kb_cs = kb_data + 1;
 
 	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
+		iounmap(kb_data);
 		printk(KERN_CRIT
 		       "sycamore_setup_arch() fpga_status ioremap failed\n");
 		return;
 	}
 
 	fpga_enable = fpga_status + 1;
 	fpga_polarity = fpga_status + 2;
 	fpga_trigger = fpga_status + 3;
 	fpga_brdc = fpga_status + 4;
 
 	/* split the keyboard and mouse interrupts */
