Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id EE85A679F9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:51:25 +1100 (EST)
Subject: Re: [PATCH 4/6] L2 Cache support for 440SP
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141257021.25761.26.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
	<1141256751.25761.19.camel@rhino.az.mvista.com>
	<1141256859.25758.22.camel@rhino.az.mvista.com>
	<1141257021.25761.26.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-kVHuDaSPP9R94RvlnUfo"
Message-Id: <1141257084.25758.28.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:51:24 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-kVHuDaSPP9R94RvlnUfo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds L2 Cache support for the 440SP.

--Wade

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-kVHuDaSPP9R94RvlnUfo
Content-Disposition: attachment; filename=luan-l2c.patch
Content-Type: text/x-patch; name=luan-l2c.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -408,6 +408,11 @@ luan_setup_arch(void)
 	printk("Luan port (MontaVista Software, Inc. <source@mvista.com>)\n");
 }
 
+static void __init luan_init(void)
+{
+	ibm440gx_l2c_setup(&clocks);
+}
+
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
@@ -422,4 +427,5 @@ void __init platform_init(unsigned long 
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = luan_early_serial_map;
 #endif
+	ppc_md.init = luan_init;
 }

--=-kVHuDaSPP9R94RvlnUfo--
