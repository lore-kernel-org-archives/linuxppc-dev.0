Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 85D5267A82
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 20:47:35 +1000 (EST)
Message-ID: <42511CAE.3060600@ru.mvista.com>
Date: Mon, 04 Apr 2005 14:53:34 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: using drivers/serial/8250.c with platform bus (Virtex 2 Pro and
	85xx/83xx)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Inspired by 85xx, 83xx, and 52xx ports, I've tried to make Xilinx ML300 board to initialize
the 16x50 UART as a platfrom device.
This happened to work after quite a lot of code relying on hard #defines was thrown away
(e.g. arch/ppc/boot/common/ns16550.c needs SERIAL_PORT_DFNS).

Another problem was that serial8250_probe(struct device *dev) from 8250.c walks through the
dev->platform_data[] until the flags field is zero. So I've had to replace

   static struct plat_serial8250_port serial_platform_data = {
         .mapbase        = XPAR_UARTNS550_0_BASEADDR + 3,
         .irq            = XPAR_INTC_0_UARTNS550_0_VEC_ID,
         .uartclk        = XPAR_UARTNS550_0_CLOCK_FREQ_HZ,
         .regshift       = 2,
         .iotype         = UPIO_MEM,
         .flags          = UPF_BOOT_AUTOCONF,
   };

   struct platform_device v2pro_platform_devices[] = {
   #ifdef CONFIG_SERIAL_8250
         {
                 .name = "serial8250",
                 .id     = 0,
                 .dev.platform_data = &serial_platform_data,
         }
   #endif /* CONFIG_SERIAL_8250 */
   };

used originally with

   static struct plat_serial8250_port serial_platform_data[] = {
         {
                 .mapbase        = XPAR_UARTNS550_0_BASEADDR + 3,
                 .irq            = XPAR_INTC_0_UARTNS550_0_VEC_ID,
                 .uartclk        = XPAR_UARTNS550_0_CLOCK_FREQ_HZ,
                 .regshift       = 2,
                 .iotype         = UPIO_MEM,
                 .flags          = UPF_BOOT_AUTOCONF,
         },
         {
                 .flags = 0
         }
   };

   struct platform_device v2pro_platform_devices[] = {
   #ifdef CONFIG_SERIAL_8250
         {
                 .name = "serial8250",
                 .id     = 0,
                 .dev.platform_data = serial_platform_data,
         }
   #endif /* CONFIG_SERIAL_8250 */
   };

That { .flags = 0 }
is missing from 85xx / 83xx code, and my guess is that in that case
the data following serial_platform_data[2] array look like something
with .flags = 0 to the 8250.c.
But wouldn't it be safer to add the { .flags = 0 } terminator
to serial_platform_data[] for 85xx/83xx as well?

Thanks,
Andrei

P.S.
All these XPAR_*'s will be removed when the OF device tree come into play.
