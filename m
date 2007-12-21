Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2245EDDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:17:54 +1100 (EST)
Date: Fri, 21 Dec 2007 15:17:36 +0900 (JST)
Message-Id: <20071221.151736.-1300524616.kouish@swc.toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: kernel stops at probing MTD CFI driver
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I build the MTD Common Flush Interface(CFI) driver as modules,
the kernel stops at BUG() in symbol_put_addr() called by
cfi_cmdset_unknown()[gen_probe.c] and shows the following message. 

I found this problem on Toshiba Cell Reference Set. I think this
problem relates with powerpc64 ABI.

kernel BUG at kernel/module.c:783!
cpu 0x1: Vector: 700 (Program Check) at [c000000002723070]
    pc: c00000000007faac: .symbol_put_addr+0x34/0x64
    lr: c00000000007faa4: .symbol_put_addr+0x2c/0x64
    sp: c0000000027232f0
   msr: 9000000000029032
  current = 0xc00000000271c000
  paca    = 0xc00000000047c380
    pid   = 762, comm = modprobe
kernel BUG at kernel/module.c:783!
enter ? for help
[c000000002723370] d0000000001040f0 .check_cmd_set+0xf0/0x138 [gen_probe]
[c000000002723430] d000000000104464 .mtd_do_chip_probe+0x32c/0x650 [gen_probe]
[c000000002723550] d000000000100334 .cfi_probe+0x1c/0x34 [cfi_probe]
[c0000000027235d0] d0000000000fd20c .do_map_probe+0x84/0xc0 [chipreg]
[c000000002723670] d000000000171348 .of_physmap_probe+0x280/0x4f0 [physmap_of]
[c000000002723780] c00000000001bd44 .of_platform_device_probe+0x78/0xb0
[c000000002723810] c0000000001e1708 .driver_probe_device+0x140/0x208
[c0000000027238a0] c0000000001e1a00 .__driver_attach+0xdc/0x164
[c000000002723930] c0000000001e0550 .bus_for_each_dev+0x7c/0xd4
[c0000000027239f0] c0000000001e1470 .driver_attach+0x28/0x40
[c000000002723a70] c0000000001e0a6c .bus_add_driver+0x90/0x1fc
[c000000002723b10] c0000000001e1e28 .driver_register+0x94/0xb0
[c000000002723b90] c00000000001c150 .of_register_platform_driver+0x28/0x3c
[c000000002723c00] d000000000171608 .of_physmap_init+0x1c/0x4e4 [physmap_of]
[c000000002723c80] c00000000007f8b8 .sys_init_module+0x1608/0x17c8
[c000000002723e30] c000000000008634 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff0f4b4

symbol_put_addr() tests the address by module_text_address(). Because
the address is not in .text section on powerpc64 system,
module_text_address() fails and symbol_put_addr() calls BUG().

Though we can avoid this problem by using __symbol_put() instead of
symbol_put_addr(), I don't think this is proper way. Does anyone have
better solutions for this problem?

Best regards,
Kou Ishizaki


--- linux-2.6.24-rc5.org/drivers/mtd/chips/gen_probe.c  2007-12-19 19:05:56.000000000 +0900
+++ linux-2.6.24-rc5/drivers/mtd/chips/gen_probe.c      2007-12-19 19:44:23.000000000 +0900
@@ -222,7 +222,7 @@ static inline struct mtd_info *cfi_cmdse

 		mtd = (*probe_function)(map, primary);
		/* If it was happy, it'll have increased its own use count */
-		symbol_put_addr(probe_function);
+		__symbol_put(probename);
 		return mtd;
 	}
 #endif
