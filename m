Return-Path: <peri@aqua.aspd.pwr.wroc.pl>
Received: from aqua.aspd.pwr.wroc.pl (aqua.aspd.pwr.wroc.pl [156.17.17.24])
	by ozlabs.org (Postfix) with ESMTP id BBB182BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2004 02:25:00 +1000 (EST)
Date: Mon, 27 Sep 2004 18:24:59 +0200 (CEST)
From: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20040927065758.B25288@home.com>
Message-ID: <Pine.LNX.4.21.0409271812010.17898-100000@aqua.aspd.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 27 Sep 2004, Matt Porter wrote:
> Since you are failing in ocp_add_one_device() and you have a
> processor which doesn't have a chip definition in 2.6, the
> problem is probably somewhere there.  Doublecheck your
> arch/ppc/platforms/4xx/ibm405cr.c (you do have one, right?)
> against a known good one in arch/ppc/platforms/4xx/ibm405gp.c
>
 
I use ibm405cr.c that works with our running kernel 2.4.23.

const struct ocp_def core_ocp[]  /*__initdata*/ = {
     45         { .vendor       = OCP_VENDOR_IBM,
     46           .function     = OCP_FUNC_OPB,
     47           .index        = 0,
     48           .paddr        = OPB_BASE_START,
     49           .irq          = OCP_IRQ_NA,
     50           .pm           = OCP_CPM_NA,
     51         },
     52         { .vendor       = OCP_VENDOR_IBM,
     53           .function     = OCP_FUNC_16550,
     54           .index        = 0,
     55           .paddr        = UART0_IO_BASE,
     56           .irq          = UART0_INT,
     57           .pm           = IBM_CPM_UART0
     58         },
     59         { .vendor       = OCP_VENDOR_IBM,
     60           .function     = OCP_FUNC_16550,
     61           .index        = 1,
     62           .paddr        = UART1_IO_BASE,
     63           .irq          = UART1_INT,
     64           .pm           = IBM_CPM_UART1
     65         },
     66         { .vendor       = OCP_VENDOR_IBM,
     67           .function     = OCP_FUNC_IIC,
     68           .index        = 0,
     69           .paddr        = IIC0_BASE,
     70           .irq          = IIC0_IRQ,
     71           .pm           = IBM_CPM_IIC0
     72         },
     73         { .vendor       = OCP_VENDOR_IBM,
     74           .function     = OCP_FUNC_IIC,
     75           .index        = 1,
     76           .paddr        = IIC1_BASE,
     77           .irq          = IIC1_IRQ,
     78           .pm           = IBM_CPM_IIC1
     79         },
     80         { .vendor       = OCP_VENDOR_IBM,
     81           .function     = OCP_FUNC_GPIO,
     82           .paddr        = GPIO0_BASE,
     83		  .irq          = OCP_IRQ_NA,
     84           .pm           = IBM_CPM_GPIO0
     85         },
     86
     87 /*
     88         { .vendor       = OCP_VENDOR_IBM,
     89           .function     = OCP_FUNC_USB,
     90           .paddr        = USB_BASE,
     91           .irq          = USB0_IRQ,
     92           .pm           = IBM_CPM_USB
     93         },
     94 */
     95         { .vendor       = OCP_VENDOR_INVALID
     96         }
     97 };

I was given clean and ported 2.4.23 kernel and was told to port
2.6.8.1. Based on differences I noticed between two 2.4.23 I tried to do
same (almost) in 2.6.8.1. But all I can
get is:

loaded at:     00400000 009EA220
board data at: 009E713C 009E7190
relocated to:  00405384 004053D8
zimage at:     004058D7 004F2F8B
initrd at:     004F3000 009E6782
avail ram:     009EB000 08000000

Linux/PPC load: console=ttyS0,115200 console=tty0 root=/dev/ram0
init=/linuxrc rw
Uncompressing Linux...done.
Now booting the kernel
