Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 47AD5681D3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 18:54:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Wed, 31 Aug 2005 16:51:24 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865068@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: ??: Question about SMC serial port on MPC8270 in u-boot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Denk:
  thanks  a lot ! I had found the reason: I use brg7 instead of brg1 in =
code, but the hardware is use brg1 to UART.=20
 Now the UART can work. But another question comes :
 The u-Boot reboot forever when enter
     "	*((ulong *) addr_sp)-- =3D 0;
	*((ulong *) addr_sp)-- =3D 0;   "
   The code is in lib_ppc/board.c   line 474-475,function board_init_f. =
I found the pointer addr_sp is valid.
   I erase the *((ulong *) addr_sp)-- =3D 0 code, but no use.
     What's the prblem?  can you give me some hints ? thanks !

=20


-----????-----
???: wd@denx.de [mailto:wd@denx.de]
????: 2005?8?31? 15:04
???: FCG WANG Baohua
??: linuxppc-embedded@ozlabs.org; wd@denx.de; =
Tsi-Chung.Liew@freescale.com; jdl@freescale.com; Jack_liu@usish.com
??: Re: Question about SMC serial port on MPC8270 in u-boot=20


In message <A9DE2BAF233E444FA9C5E77A5825A01E865067@ydmail.sbell.com.cn> =
you wrote:
>=20
>  When i port the u-boot 1.1.3 on my MPC8270 board, the serial port has

Your question is off topic on this list. Please send  U-Boot  related
questions to the u-boot-users list instead.

>   1. the Dual port ram cannot be revised manually, but can be revised =
by
> the u-boot code. What's the problem?

You're doing something wrong.

>    2. the serial_putc() in serial_smc.c is loop forever on  "while
> (tbdf->cbd_sc & BD_SC_READY);". How to slove the bug?

Make sure your clocks / BRG's are configured correctly.

>    3. the speed.c calc the wrong cpm, cpu, brg_clk, I had hard coded =
the
> right   cpm, cpu, brg_clk values. But the "m8260_cpm_setbrg()" is =
still
> wrong? Why?

Your system is misconfigured.

>         data structures, they all seems right, but the UART cannot =
work.
> How could I find the problem?=20

Fix the problems as you encounter them. If the clocks show  up  wrong
you  should fix this problem first. Then all the rest might just fall
into place.

> Content-Type: text/html;
> Content-Transfer-Encoding: quoted-printable
>=20
> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
> <HTML>

And please don't post HTML.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.
