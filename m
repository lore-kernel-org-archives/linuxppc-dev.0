Message-ID: <002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Matt Porter" <porter@cox.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr> <20020528062351.A2267@home.com>
Subject: Re: map iomem in linux_2_4_dev
Date: Wed, 29 May 2002 13:57:34 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
>
> You don't need io_block_mapping.  Follow one of the many examples to
> use early_serial_init with an ioremap call for your UART.
>
> The only reason your method works is that the io_block_mapping is
> actually using a BAT on our classic PPC platform.  ioremap will
> look for an existent BAT mapping and just return the translated
> virtual address in this case.  Relying on this is bad practice
> since it will not work on other PPC systems.
>
Right, I exactly wanted to do that.
I called io_block_mapping() on initialization code.
More precisly on <board name>_map_io(),
which is in arch/ppc/platforms/<board_name>_setup().
It has nothing to do with competibility.
And... Is there any ppc without BAT?
I didn't know that.

> As David correctly pointed out, only use io_block_mapping when
> you absolutely must control the placement of the virtual address.
Than, if the system initialization code is changed,
the driver code should be changed too.

> There are cases when this is necessary since the hardware engineers
> always send us garbage to support.  Mapping a UART at init time is
> not one of these.
>
Actually, I'm a hardware guy.
In most cases, mapping UART is not needed,
but on the hardware I designed, it is needed.
Because its physical addres is 0x78000000.
Don't blame us too much.
It takes much money to change hardware.

- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
