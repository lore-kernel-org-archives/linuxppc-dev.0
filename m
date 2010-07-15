Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id E4BDCB6F35
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 08:33:07 +1000 (EST)
Received: by iwn36 with SMTP id 36so1314272iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jul 2010 15:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
References: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
Date: Thu, 15 Jul 2010 15:33:04 -0700
Message-ID: <AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
Subject: Re: cpm_uart_console_write() stuck in waiting for transmitter fifo
	ready
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The problem is that after/when the kernel switches to the real console
> from the boot console, printk() calls cpm_uart_console_write() to
> print the first (?) message using the cpm_uart driver. But the
> transmitter buffer never becomes ready. It's shown below with the gdb
> session.
>
> Program received signal SIGSTOP, Stopped (signal).
> 0xc00f3510 in cpm_uart_console_write (co=3D<value optimized out>,
> s=3D0xc017703e "console [ttyCPM0] enabled, bootconsole disabled\n",
> count=3D0x30) at /home/code/linux-2.6.33.5/arch/powerpc/include/asm/io.h:=
154
> (gdb) next
> (gdb) x/4h bdbase
> 0xfddfa020: =A0 =A0 0xffff =A00xffff =A00xffff =A00xffff
> (gdb)
>
> Why would the TxBD be filled with all 0xF? Would it be possible that
> the bdbase actually points somewhere else other than the TxBD?

The virtual address 0xfddfa000 is mapped to 0xfa202000. I suspect that
the TxBD of my MPC870 may not start at 0xfa202020.

I notice that for adder875, ep88xc and mpc885ads, the muram data's reg
=3D <0 0x1c00> but for mgsuvd, its reg =3D <0x800 0x1800>. How does the
kernel use muram for 885 family SoCs? How much muram should be
reserved for data?

My RCCR=3D0x1, meaning the first 512B is for microcode. So the data and
the TxBD should really be starting at 0xfa202200? Then my muram data's
reg should be <0x200 ?>? What size shall I specify?

Scott, you instructed
(http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-July/083788.html)
me to change the buffer address to 0xfa203fb8 from 0xfa202008 for the
bootwrapper's cpm-serial driver, assuming reg=3D<0 0x1c00>. If I need to
change to the reg not starting at 0x0, how should I accordingly change
this buffer address?

Thanks a lot,
-Shawn.

I went back to 2.4.18 kernel and noticed that the
