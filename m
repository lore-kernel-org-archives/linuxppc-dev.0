Message-ID: <3907A22C.D82EF0D1@embeddededge.com>
Date: Wed, 26 Apr 2000 22:13:00 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Baud rate problems with the EST SBC8260 board
References: <m12kcXk-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

> ..... I configured the kernel, but ran into
>         problems with arch/ppc/kernel/ppc_ksyms.c referencing things that
>         don't exist.

You probably configured way too much into the kernel.  You have to
turn of almost everything but the bare essentials.  Just like the
8xx, do not configure any serial ports, VTs, or things like that.

>         - What serial port is used for the console?  I am assuming that is
>           SMC1.

Yes, SMC1.


>           ....  Who calls serial_init?  It doesn't appear
>           to get called from head_8260.S?

The decompress_kernel in misc.c.

>           Are you relying on the monitor do this initialization for you?

No.


>           We are using the VxWorks BSP monitor, is this what is being
>           used by Dan Malek?

The MontaVista custom ROM.


>           "MontaVista has a boot rom with minimal debug support."  Is this
>           different from the VxWorks BSP monitor?

Absolutely.  How could I possibly use the VxWorks monitor in any
product?


>         - What is the baud rate of the console port?

115200.  Take a look at embed_config.c


>         - What is the speed of the crystal on SBC8260 board?  25 Mhz, 33Mhz,
>           or 50 Mhz?

33 Mhz.



>         - What clock multiplier are you using for the CPM?

I don't remember.  I think it was clock mode 0010_011, which would
be 133 MHz CPM and 166 MHz core.  This is all pretty simple.  Just
pick your own clock speed and set the board descriptor in embed_config.c
to match it.

>

> CONFIG_IP_PNP=y
> # CONFIG_IP_PNP_BOOTP is not set
> CONFIG_IP_PNP_RARP=y

You really ought to run BOOTP and not RARP......

Everything else looks fine.  Did you build this kernel from scratch
(i.e. 'make mrproper' before 'make config')?

I'll check it again....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
