Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8F364B6F05
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 17:35:45 +1000 (EST)
Received: by iwn36 with SMTP id 36so1678933iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Jul 2010 00:35:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
	<20100706181811.4542df5a@schlenkerla.am.freescale.net>
	<AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
Date: Fri, 9 Jul 2010 00:35:43 -0700
Message-ID: <AANLkTinNSzP-WvxC2kqZop2kvd1kSUMDuwI01GOBXApE@mail.gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I changed my toolchain and rebuilt the kernel image. This time all the
messages below magically displayed on the serial port. :-D Are all
these the early debugging messages?

> Here is the kernel log buf dump. Anything suspicious?
>
> <6>Using My MPC870 machine description
> <5>Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.3.3 (GCC) )
> #10 Mon Jul 5 22:58:30 PDT 2010
> <7>Top of RAM: 0x8000000, Total RAM: 0x8000000
> <7>Memory hole size: 0MB
> <4>Zone PFN ranges:
...
<snipped>
...
> <7>time_init: decrementer frequency =3D 3.750000 MHz
> <7>time_init: processor frequency =A0 =3D 120.000000 MHz
> <6>clocksource: timebase mult[42aaaaab] shift[22] registered
> <7>clockevent: decrementer mult[f5c28f] shift[32] cpu[0]
> <7> =A0alloc irq_desc for 18 on node 0
> <7> =A0alloc kstat_irqs on node 0
> <7>irq: irq 4 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
> mapped to virtual irq 18

Now the kernel stuck at the while loop that waits for transmitter fifo
to be empty. It seems that the CPM UART stopped working in the middle
of printing a message. I'm using minicom to connect to the serial
port. I heard minicom is problematic. Will it be the cause here?

(gdb) target remote ppcbdi:2001
Remote debugging using ppcbdi:2001
0xc00f348c in cpm_uart_console_write (co=3D<value optimized out>,
    s=3D0xc0174df3 "console [ttyCPM0] enabled, bootconsole disabled\n", cou=
nt=3D48)
    at /home/rayan/wti/code/wti-linux-2.6.33.5/arch/powerpc/include/asm/io.=
h:154
154     DEF_MMIO_IN_BE(in_be16, 16, lhz);
(gdb) next
1161                    while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) !=3D 0=
)
(gdb) next
154     DEF_MMIO_IN_BE(in_be16, 16, lhz);
(gdb) next
1161                    while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) !=3D 0=
)
(gdb) list
1156            for (i =3D 0; i < count; i++, s++) {
1157                    /* Wait for transmitter fifo to empty.
1158                     * Ready indicates output is ready, and xmt is doin=
g
1159                     * that, not that it is ready for us to send.
1160                     */
1161                    while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) !=3D 0=
)
1162                            ;
1163
1164                    /* Send the character out.
1165                     * If the buffer address is in the CPM DPRAM, don't

Thanks,
-Shawn.
