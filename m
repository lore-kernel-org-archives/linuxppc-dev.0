Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A494EDDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 03:49:02 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 5BDCC8817
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 22:48:59 +0500 (SAMST)
Date: Fri, 11 Jul 2008 21:48:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping, otherwise
	kernel will oops
Message-ID: <20080711174859.GA24260@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Firstly kernel warns at set_irq_chip, and then dies completely:

Trying to install chip for IRQ-1
------------[ cut here ]------------
Badness at c00463b0 [verbose debug info unavailable]
NIP: c00463b0 LR: c00463b0 CTR: c0158e80
REGS: cf821cd0 TRAP: 0700   Not tainted  (2.6.26-rc8-next-20080704-20216-g7bcfaff-dirty)
MSR: 00029032 <EE,ME,IR,DR>  CR: 24044042  XER: 20000000
TASK = cf81f8a0[1] 'swapper' THREAD: cf820000
GPR00: c00463b0 cf821d80 cf81f8a0 00000024 000015cb ffffffff c015c1fc 00004000
GPR08: c035e960 c0350000 c035e4b8 000015cb 84044042 00000000 0fffd000 00000000
GPR16: 0fff3028 0fff6cf0 00000000 0fff8390 0ff494a0 00000004 00000000 c02ef520
GPR24: cf934210 cf821dfc c02ef4f8 c035ac08 00000000 ffffffff ffffffff 00000000
NIP [c00463b0] set_irq_chip+0x90/0x9c
LR [c00463b0] set_irq_chip+0x90/0x9c
Call Trace:
[cf821d80] [c00463b0] set_irq_chip+0x90/0x9c (unreliable)
[cf821da0] [c004641c] set_irq_chip_and_handler+0x1c/0x40
[cf821dc0] [c0005a64] irq_dispose_mapping+0x70/0x13c
[cf821df0] [c01ebf10] of_register_i2c_devices+0x124/0x504
[cf821e50] [c0276f78] 0xc0276f78
[cf821e70] [c01eba20] of_platform_device_probe+0x5c/0x84
[cf821e90] [c0160724] really_probe+0x78/0x1a8
[cf821eb0] [c016095c] __driver_attach+0x84/0x88
[cf821ed0] [c015fc14] bus_for_each_dev+0x5c/0x98
[cf821f00] [c016056c] driver_attach+0x24/0x34
[cf821f10] [c0160220] bus_add_driver+0xb4/0x1cc
[cf821f30] [c0160c4c] driver_register+0x5c/0x114
[cf821f40] [c01eb8e8] of_register_driver+0x54/0x70
[cf821f50] [c032a2e0] fsl_i2c_init+0x24/0x54
[cf821f60] [c0310244] do_one_initcall+0x34/0x198
[cf821fd0] [c03103e0] do_initcalls+0x38/0x58
[cf821fe0] [c0310464] kernel_init+0x30/0x90
[cf821ff0] [c000f944] kernel_thread+0x44/0x60
Instruction dump:
80010024 bba10014 38210020 7c0803a6 4e800020 3d20c034 3be977b8 4bffffac
3c60c02d 7fc4f378 386329e0 4bfd6465 <0fe00000> 3860ffea 4bffffc8 9421ffe0
Trying to install type control for IRQ-1
Unable to handle kernel paging request for data at address 0x3863ce7c
Faulting instruction address: 0xc0005a68
Oops: Kernel access of bad area, sig: 11 [#1]
MPC837x RDB
Modules linked in:
NIP: c0005a68 LR: c0005a64 CTR: c0158e80
REGS: cf821d10 TRAP: 0300   Not tainted  (2.6.26-rc8-next-20080704-20216-g7bcfaff-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24044042  XER: 20000000
DAR: 3863ce7c, DSISR: 20000000
TASK = cf81f8a0[1] 'swapper' THREAD: cf820000
GPR00: c0005a64 cf821dc0 cf81f8a0 0000002c 00001d4f ffffffff c015c1fc 00004000
GPR08: c035e960 3863ce74 c035e4b8 00001d4f 24044042 00000000 0fffd000 00000000
GPR16: 0fff3028 0fff6cf0 00000000 0fff8390 0ff494a0 00000004 00000000 c02ef520
GPR24: cf934210 cf821dfc c02ef4f8 c035ac08 cf821df8 fffffff8 ffffffff c000d9f0
NIP [c0005a68] irq_dispose_mapping+0x74/0x13c
LR [c0005a64] irq_dispose_mapping+0x70/0x13c
Call Trace:
[cf821dc0] [c0005a64] irq_dispose_mapping+0x70/0x13c (unreliable)
[cf821df0] [c01ebf10] of_register_i2c_devices+0x124/0x504
[cf821e50] [c0276f78] 0xc0276f78
[cf821e70] [c01eba20] of_platform_device_probe+0x5c/0x84
[cf821e90] [c0160724] really_probe+0x78/0x1a8
[cf821eb0] [c016095c] __driver_attach+0x84/0x88
[cf821ed0] [c015fc14] bus_for_each_dev+0x5c/0x98
[cf821f00] [c016056c] driver_attach+0x24/0x34
[cf821f10] [c0160220] bus_add_driver+0xb4/0x1cc
[cf821f30] [c0160c4c] driver_register+0x5c/0x114
[cf821f40] [c01eb8e8] of_register_driver+0x54/0x70
[cf821f50] [c032a2e0] fsl_i2c_init+0x24/0x54
[cf821f60] [c0310244] do_one_initcall+0x34/0x198
[cf821fd0] [c03103e0] do_initcalls+0x38/0x58
[cf821fe0] [c0310464] kernel_init+0x30/0x90
[cf821ff0] [c000f944] kernel_thread+0x44/0x60
Instruction dump:
5400d97e 0f000000 2f9f0000 41beffc8 801f0008 2f800000 41beffbc 7fc3f378
38800000 38a00000 480409a1 813f0018 <80090008> 2f800000 419e0014 7fe3fb78
---[ end trace 1db4087de5c456f2 ]---

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/of_i2c.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index b2ccdcb..95a24de 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 		if (info.irq == NO_IRQ)
 			info.irq = -1;
 
-		if (of_find_i2c_driver(node, &info) < 0) {
-			irq_dispose_mapping(info.irq);
-			continue;
-		}
+		if (of_find_i2c_driver(node, &info) < 0)
+			goto err;
 
 		info.addr = *addr;
 
@@ -107,9 +105,12 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			printk(KERN_ERR
 			       "of-i2c: Failed to load driver for %s\n",
 			       info.type);
-			irq_dispose_mapping(info.irq);
-			continue;
+			goto err;
 		}
+		continue;
+err:
+		if (info.irq > 0)
+			irq_dispose_mapping(info.irq);
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
-- 
1.5.5.4
