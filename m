Message-Id: <5.1.0.14.2.20021103112108.02d28380@pop.prodigy.net>
Date: Sun, 03 Nov 2002 11:29:41 -0800
To: "Aman" <aman@mistralsoftware.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Base Baud Calculation
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000c01c28330$29c684a0$370da8c0@aman>
References: <20021017164026.4E674FAA7@denx.denx.de>
 <002901c2832b$ee845ec0$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aman,

At 03:57 AM 11/3/2002, you wrote:
>  How is the base_baud in linux for PPC 440GP calculated?.

Here is the piece of code I use on our custom 440GP board (works also on
Ebony):

static void __init XXXXXXX_serial_init(void){

     struct serial_struct serial_req;
     int baud_base;

     /* Determine baud base */
     unsigned long cpc0_cr0 = mfdcr(DCRN_CPC0_CR0);

     if (cpc0_cr0 & 0x00400000){
         /* External UART0 clock (eval board uses 6*1.8432 MHz clock) */
         baud_base = (6 * 1843200) / 16;
     }
     else {
         /* Internal UART0 clock */
        int uart_div = ((cpc0_cr0 & 0x001f0000) >> 16) + 1;
         baud_base = (XXXXXX_clocks.plb * 1000000) / uart_div / 16;
     }

     /* Setup ioremapped serial port access */
     memset(&serial_req, 0, sizeof(serial_req));
     serial_req.line = 0;
     serial_req.baud_base = baud_base;
     serial_req.port = 0;
     serial_req.irq = UART0_INT;
     serial_req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
     serial_req.io_type = SERIAL_IO_MEM;
     serial_req.iomem_base = ioremap64(PPC440GP_UART0_ADDR, 8);
     serial_req.iomem_reg_shift = 0;

     if (early_serial_setup(&serial_req) != 0) {
         printk(KERN_ALERT"Early serial init of port 0 failed\n");
     }
}

One comment, XXXXXX_clocks - structure that holds different clocks in MHz.
For example, XXXXXX_clocks.plb is equal to 133.

Usually, this value can be hardcoded, but I find this way more convenient,
especially when running the same image on different boards with different
clock setup.

Regards,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
