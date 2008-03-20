Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 532D5DE0A4
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:44:08 +1100 (EST)
Received: from outbound3-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-sin-R.bigfish.com (Postfix) with ESMTP id 8C20CD14CE
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:05 +0000 (UTC)
Received: from mail63-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound3-sin.bigfish.com (Postfix) with ESMTP id 5E40017C005B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:05 +0000 (UTC)
Received: from mail63-sin (localhost.localdomain [127.0.0.1])
	by mail63-sin-R.bigfish.com (Postfix) with ESMTP id B714112E067C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:04 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail63-sin.bigfish.com (Postfix) with ESMTP id 695C1518064
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:02 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <linnj@wolfgang-pc.public.xilinx.com>)
	id 1JcLzt-0005hI-KE
	for linuxppc-dev@ozlabs.org; Thu, 20 Mar 2008 07:44:01 -0700
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart 16550.
Date: Thu, 20 Mar 2008 07:43:52 -0700
In-Reply-To: <1206024232655-git-send-email-john.linn@xilinx.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<1206024232655-git-send-email-john.linn@xilinx.com>
Message-Id: <20080320144402.695C1518064@mail63-sin.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Xilinx 16550 uart core is not a standard 16550, because it uses
word-based addressing rather than byte-based addressing.  As a result,
it is not compatible with the open firmware 'ns16550' compatible
binding.

This code adds the Xilinx uart 16550 to the serial console
of the boot. A new initialization function for the Xilinx 16550 uart
is added to the ns16550 driver. It sets up the correct register base
and regshift properties specific to the Xilinx 16550.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/boot/ns16550.c |   24 ++++++++++++++++++++++++
 arch/powerpc/boot/ops.h     |    1 +
 arch/powerpc/boot/serial.c  |    8 ++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..5385255 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -77,3 +77,27 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
+
+int xilinx16550_console_init(void *devp, struct serial_console_data *scdp)
+{
+	int n;
+	unsigned long reg_phys;
+
+	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
+	if (n != sizeof(reg_base)) {
+		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
+			return -1;
+
+		reg_base = (void *)reg_phys + 3;
+	}
+
+	reg_shift = 2;
+
+	scdp->open = ns16550_open;
+	scdp->putc = ns16550_putc;
+	scdp->getc = ns16550_getc;
+	scdp->tstc = ns16550_tstc;
+	scdp->close = NULL;
+
+	return 0;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index a180b65..d8b864b 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -86,6 +86,7 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 int cpm_console_init(void *devp, struct serial_console_data *scdp);
 int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
 int uartlite_console_init(void *devp, struct serial_console_data *scdp);
+int xilinx16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 7fa5078..fb5c91e 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -131,6 +131,14 @@ int serial_console_init(void)
 	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
                  dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
 		rc = uartlite_console_init(devp, &serial_cd);
+	else if (dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.c") ||
+		 dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.d") ||
+		 dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.e") ||
+		 dt_is_compatible(devp, "xlnx,plb-uart16550-1.00.c") ||
+		 dt_is_compatible(devp, "xlnx,xps-uart16550-1.00.a") ||
+		 dt_is_compatible(devp, "xlnx,xps-uart16550-2.00.a") ||
+		 dt_is_compatible(devp, "xlnx,xps-uart16550-2.00.b"))
+		rc = xilinx16550_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
-- 
1.5.2.1
