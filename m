Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6732EDDE9C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 03:33:51 +1100 (EST)
Message-ID: <47333A69.3030606@tiscali.nl>
Date: Thu, 08 Nov 2007 17:33:45 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com
Subject: [PATCH] balance ioremap/iounmap in {sycamore, walnut}_setup_arch()
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I guess it should be done after the last usage of kb_data or fpga_status?
--
Balance ioremap/iounmap

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
index 8689f3e..4f3bac1 100644
--- a/arch/ppc/platforms/4xx/sycamore.c
+++ b/arch/ppc/platforms/4xx/sycamore.c
@@ -99,28 +99,30 @@ sycamore_setup_arch(void)
 	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
 	if (!kb_data) {
 		printk(KERN_CRIT
 		       "sycamore_setup_arch() kb_data ioremap failed\n");
 		return;
 	}
 
 	kb_cs = kb_data + 1;
+	iounmap(kb_data);
 
 	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
 		printk(KERN_CRIT
 		       "sycamore_setup_arch() fpga_status ioremap failed\n");
 		return;
 	}
 
 	fpga_enable = fpga_status + 1;
 	fpga_polarity = fpga_status + 2;
 	fpga_trigger = fpga_status + 3;
 	fpga_brdc = fpga_status + 4;
+	iounmap(fpga_status);
 
 	/* split the keyboard and mouse interrupts */
 	fpga_brdc_data = readb(fpga_brdc);
 	fpga_brdc_data |= 0x80;
 	writeb(fpga_brdc_data, fpga_brdc);
 
 	writeb(0x3, fpga_enable);
 
diff --git a/arch/ppc/platforms/4xx/walnut.c b/arch/ppc/platforms/4xx/walnut.c
index 2f97723..8cfeb94 100644
--- a/arch/ppc/platforms/4xx/walnut.c
+++ b/arch/ppc/platforms/4xx/walnut.c
@@ -81,28 +81,30 @@ walnut_setup_arch(void)
 	kb_data = ioremap(WALNUT_PS2_BASE, 8);
 	if (!kb_data) {
 		printk(KERN_CRIT
 		       "walnut_setup_arch() kb_data ioremap failed\n");
 		return;
 	}
 
 	kb_cs = kb_data + 1;
+	iounmap(kb_data);
 
 	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
 		printk(KERN_CRIT
 		       "walnut_setup_arch() fpga_status ioremap failed\n");
 		return;
 	}
 
 	fpga_enable = fpga_status + 1;
 	fpga_polarity = fpga_status + 2;
 	fpga_trigger = fpga_status + 3;
 	fpga_brdc = fpga_status + 4;
+	iounmap(fpga_status);
 
 	/* split the keyboard and mouse interrupts */
 	fpga_brdc_data = readb(fpga_brdc);
 	fpga_brdc_data |= 0x80;
 	writeb(fpga_brdc_data, fpga_brdc);
 
 	writeb(0x3, fpga_enable);
 
