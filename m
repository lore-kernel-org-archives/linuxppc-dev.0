Message-ID: <3C0676EE.BAE43398@mvista.com>
Date: Thu, 29 Nov 2001 09:57:02 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: Adrian Cox <adrian@humboldt.co.uk>, paulus@samba.org
Subject: Re: include/asm-ppc/platforms/
References: <15363.31192.101536.919771@gargle.gargle.HOWL>	<3C2B376F.9070508@embeddededge.com>	<15364.32906.728532.676746@gargle.gargle.HOWL>	<3C04A483.6070206@humboldt.co.uk> <15365.22636.100149.747039@gargle.gargle.HOWL> <3C055B2E.9020801@humboldt.co.uk>
Content-Type: multipart/mixed;
 boundary="------------F15193F279862E69CC6C0769"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F15193F279862E69CC6C0769
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Adrian Cox wrote:
>
> Paul Mackerras wrote:
>
> > Perfectly reasonable - I wish all the platforms used early_serial_setup.
> > Would you mind posting your code that does the early_serial_setup calls?
>
> Mangled by Mozilla below. This is a 7400 board with a memory mapped
> uart. It is important to zero out the entries for serial ports that
> aren't present, otherwise the serial driver will attempt to use the
> traditional locations.
>
> static void __init
> tpe3_setup_arch(void)
> {
>         struct serial_struct req;
>
>         ...
>
>         memset(&req, 0, sizeof (req));
>         req.line = 0;
>         req.io_type = SERIAL_IO_MEM;
>         req.iomem_base = (void *) (tpe3_uart_base + 0x10);
>         req.baud_base = 6144000 / 16;
>         req.irq = 3;
>         req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
>         early_serial_setup(&req);
>         memset(&req, 0, sizeof (req));
>         req.line = 1;
>         early_serial_setup(&req);
>         req.line = 2;
>         early_serial_setup(&req);
>         req.line = 3;
>         early_serial_setup(&req);
>
>         ...
> }


And a more generic approach (that can pull the port definitions from
a header file) is attached...


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
--------------F15193F279862E69CC6C0769
Content-Type: text/plain; charset=us-ascii;
 name="example"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="example"

Date: Wed, 27 Jun 2001 17:55:06 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
Subject: Paulus, Trini: here's how to dynamically register serial port

You guys were discussing how to get rid of all the #ifdef ... includes for
the serial ports, and wondering how to dynamically register ports.  The
interface the serial driver provides for this is early_serial_setup().
Here's an example of using it (this example uses the SERIAL_PORT_DFNS from
ppc4xx_serial.h just because it was already defined there):


        {
#include <linux/serialP.h>

                int k;
                struct serial_struct req;
                struct serial_state tmp_rs_table[RS_TABLE_SIZE] = {
                        SERIAL_PORT_DFNS   /* Defined in ppc4xx_serial.h */
                };

                for (k = 0; k < RS_TABLE_SIZE; k++) {
                        if (tmp_rs_table[k].iomem_base != 0) {

        req.baud_base       = tmp_rs_table[k].baud_base;
        req.port            = tmp_rs_table[k].port;
        req.port_high       = 0;
        req.irq             = tmp_rs_table[k].irq;
        req.flags           = tmp_rs_table[k].flags;
        req.close_delay     = tmp_rs_table[k].close_delay;
        req.io_type         = tmp_rs_table[k].io_type;
        req.hub6            = tmp_rs_table[k].hub6;
        req.iomem_base      = ioremap((int)tmp_rs_table[k].iomem_base, PAGE_SIZE);
        req.iomem_reg_shift = tmp_rs_table[k].iomem_reg_shift;
        req.type            = tmp_rs_table[k].type;
        req.xmit_fifo_size  = tmp_rs_table[k].xmit_fifo_size;
        req.custom_divisor  = tmp_rs_table[k].custom_divisor;
        req.closing_wait    = tmp_rs_table[k].closing_wait;

                                early_serial_setup(&req);
                        }
                }
        }


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc


--------------F15193F279862E69CC6C0769--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
