Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF6EF2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 21:57:19 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v1 1/1] powerpc/512x: dts: remove misplaced IRQ spec from
 'soc' node
Date: Tue,  3 Dec 2013 11:56:52 +0100
Message-Id: <1386068212-11484-1-git-send-email-gsi@denx.de>
Cc: devicetree@vger.kernel.org, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the 'soc' node in the common .dtsi for MPC5121 has an '#interrupt-cells'
property although this node is not an interrupt controller

remove this erroneously placed property because starting with v3.13-rc1
lookup and resolution of 'interrupts' specs for peripherals gets misled,
emits 'no irq domain found' WARN() messages and breaks the boot process

  irq: no irq domain found for /soc@80000000 !
  ------------[ cut here ]------------
  WARNING: at /home/gsi/SRC/linux-torvalds/drivers/of/platform.c:171
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.13.0-rc1-00001-g8a66234 #8
  task: df823bb0 ti: df834000 task.ti: df834000
  NIP: c02b5190 LR: c02b5180 CTR: c01cf4e0
  REGS: df835c50 TRAP: 0700   Tainted: G        W     (3.13.0-rc1-00001-g8a66234)
  MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 229a9d42  XER: 20000000

  GPR00: c02b5180 df835d00 df823bb0 00000000 00000000 df835b18 ffffffff 00000308
  GPR08: c0479cc0 c0480000 c0479cc0 00000308 00000308 00000000 c00040fc 00000000
  GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 df850880
  GPR24: df84d670 00000000 00000001 df8561a0 dffffccc df85089c 00000020 00000001
  NIP [c02b5190] of_device_alloc+0xf4/0x1a0
  LR [c02b5180] of_device_alloc+0xe4/0x1a0
  Call Trace:
  [df835d00] [c02b5180] of_device_alloc+0xe4/0x1a0 (unreliable)
  [df835d50] [c02b5278] of_platform_device_create_pdata+0x3c/0xc8
  [df835d70] [c02b53fc] of_platform_bus_create+0xf8/0x170
  [df835dc0] [c02b5448] of_platform_bus_create+0x144/0x170
  [df835e10] [c02b55a8] of_platform_bus_probe+0x98/0xe8
  [df835e30] [c0437508] mpc512x_init+0x28/0x1c4
  [df835e70] [c0435de8] ppc_init+0x4c/0x60
  [df835e80] [c0003b28] do_one_initcall+0x150/0x1a4
  [df835ef0] [c0432048] kernel_init_freeable+0x114/0x1c0
  [df835f30] [c0004114] kernel_init+0x18/0x124
  [df835f40] [c000e910] ret_from_kernel_thread+0x5c/0x64
  Instruction dump:
  409effd4 57c9103a 57de2834 7c89f050 7f83e378 7c972214 7f45d378 48001f55
  7c63d278 7c630034 5463d97e 687a0001 <0f1a0000> 2f990000 387b0010 939b0098
  ---[ end trace 2257f10e5a20cbdd ]---

  ...
  irq: no irq domain found for /soc@80000000 !
  fsl-diu-fb 80002100.display: could not get DIU IRQ
  fsl-diu-fb: probe of 80002100.display failed with error -22
  irq: no irq domain found for /soc@80000000 !
  mpc512x_dma 80014000.dma: Error mapping IRQ!
  mpc512x_dma: probe of 80014000.dma failed with error -22
  ...
  irq: no irq domain found for /soc@80000000 !
  fs_enet: probe of 80002800.ethernet failed with error -22
  ...
  irq: no irq domain found for /soc@80000000 !
  mpc5121-rtc 80000a00.rtc: mpc5121_rtc_probe: could not request irq: 0
  mpc5121-rtc: probe of 80000a00.rtc failed with error -22
  ...

[ best viewed with 'git diff -U5' to have DT node names in the context ]

Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/mpc5121.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index bd14c00e5146..2d7cb04ac962 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -75,11 +75,10 @@
 
 	soc@80000000 {
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		ranges = <0x0 0x80000000 0x400000>;
 		reg = <0x80000000 0x400000>;
 		bus-frequency = <66000000>;	/* 66 MHz ips bus */
 
 
-- 
1.7.10.4
