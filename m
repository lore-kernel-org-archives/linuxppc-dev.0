Message-ID: <4034C37D.20909@ru.mvista.com>
Date: Thu, 19 Feb 2004 17:09:01 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Xilinx ML300 board support in linuxppc-2.4 tree
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The patch fixes/updates ML300 support in linuxppc-2.4 tree.
This is mostly a move from linuxppc_2_4_devel tree with few
additions:

- /proc/interrupts now contains correct information about whether
   the interrupt is edge triggered or level sensitive
   (linuxppc_2_4_devel tree shows all the interrupts as edge
   triggered).
   For this arch/ppc/platforms/xilinx_ml300.c sets the proper
   bit in irq_desc[], and arch/ppc/kernel/xilinx_pic.c uses
   this information to decide when to acknowledge the interrupt.

- GPIO driver is fixed to support the GPIO IP as it is in EDK
   (GPIO IP changed from V2PDK to EDK).

- xilinx_ml300_defconfig matches the EDK reference design
   (http://www.xilinx.com/ise/embedded/edk_examples.htm, example #6).
   The following devices are supported by default:
     GPIO, IIC/RTC, UARTs (two 16x50 compatible ones), SPI, TFT LCD,
     PS/2 (kbd and mouse), System ACE, touchscreen, 10/100 ethernet.
   UART Lite driver is included in the patch. But the reference
   design doesn't have UART Lites, so none is in the default configuration.


The patch itself can be found here:
http://source.mvista.com/~ank/xilinx_ml300.03.diff

The patch is against the kernel version 2.4.25-rc2.

Best regards,
Andrei Konovalov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
