Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 9180FDE4A9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 02:44:13 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 455A93CC067
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:44:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id C3179E3C09
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:41:42 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id A9DDCE3C09
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:41:42 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id D34CF536
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:44:09 +0200 (CEST)
Message-ID: <48175059.9080001@matrix-vision.de>
Date: Tue, 29 Apr 2008 18:44:09 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: EXT_IRQ0 @ MPC834x
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

actually I'm having trouble getting the IRQ0 work on a MPC8343 with
2.6.25-rc8.
There's an external PCI device connected to it ....


Regarding to the manual IRQ0 is somewhat special and has Vector 48 assigned.

Therefore my dts entry for this device looks like :

interrupt-map = <0x5800 0 0 1 &ipic 0x30 0x8
                                 ... >;

Having a look on virq mapping gives :

mvBL-M7> cat /sys/kernel/debug/powerpc/virq_mapping
virq   hwirq    chip name        host name
   16  0x0000e   IPIC            /soc@e0000000/pic@700
   17  0x0000f   IPIC            /soc@e0000000/pic@700
   18  0x00009   IPIC            /soc@e0000000/pic@700
   20  0x00010   IPIC            /soc@e0000000/pic@700
   32  0x00020   IPIC            /soc@e0000000/pic@700
   33  0x00021   IPIC            /soc@e0000000/pic@700
   34  0x00022   IPIC            /soc@e0000000/pic@700
   38  0x00026   IPIC            /soc@e0000000/pic@700
   48  0x00030   IPIC            /soc@e0000000/pic@700


After loading the device driver (=mvbcdma) the irq shows up correctly.

mvBL-M7> cat /proc/interrupts
           CPU0
 16:        603   IPIC   Level     i2c-mpc
 17:          8   IPIC   Level     i2c-mpc
 18:        295   IPIC   Level     serial
 20:        341   IPIC   Level     mpc83xx_spi
 32:          2   IPIC   Level     enet_tx
 33:          3   IPIC   Level     enet_rx
 34:          0   IPIC   Level     enet_error
 38:          0   IPIC   Level     ehci_hcd:usb1
 48:          0   IPIC   Level     mvbcdma0
BAD:          0


As soon as the device generates an interrupt I get :

irq 48: nobody cared (try booting with the "irqpoll" option)
handlers:
[<d18d66e8>] (mvbcdma_irq+0x0/0x180 [mvbcdma])
Disabling IRQ #48


The handler _would_ have returned IRQ_RETVAL(1).
Obviously the handler isn't called at all - but why ?


Using "nm" on the kernel module gives :

000006e8 t mvbcdma_irq

->offset 0x6e8 inside module matches with output regarding handler.


Any help is welcome !


regards,
Andre Schwarz












MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
