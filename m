Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Mon, 15 Sep 2003 12:26:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <AB5AF73EAF23304EA1B932174137CED70303EA@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Steffen Rumler" <Steffen.Rumler@siemens.com>
Cc: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have just tested your patch on 8260 and it fixes the problem when printk is called from interrupt context while data is printed from user mode application. GREAT!

I also ported the patch to 860 (as said earlier, code is almost the same), but it hung at boot up, just after printing "Calibrating delay loop..." :-(

I remember I had such problems in the past (on 860), when calling "spin_lock_irqsave/restore" from interrupt context. If I use function "in_interrupt()" to avoid calling them from interrupt, everything works fine, and the bug is effectively fixed.

I just don't know where is the problem??? It looks like there is a bug on 860 using "local_irq_save/restore" in interrupt context?!?

I'm working with 2.4.19.

--------------------------------------------
 Jean-Denis Boyer, Eng.
 Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------


> -----Original Message-----
> From: Steffen Rumler [mailto:Steffen.Rumler@siemens.com]
> Sent: 15 septembre, 2003 06:18
> To: linuxppc
> Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
>
>
> Hi,
>
> I have seen a similar problem for the 2.4.20.
>
> When I force a lot of console output via the following command:
>
>    while true; do cd /; ls -R; done
>
> and type-in some letters in parallel, the console
> becomes crazy.
>
> I have added some instrumentation in order to dump the
> TX Buffer Descriptor Table. I have found that the
> hardware pointer (TBPTR) and the software pointer (tx_cur)
> are not more synchronized together:
>
>  >> make new rlogin session <<
> /root# cd /proc/driver
>
> /root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR
>
> TX BD table
>    (000 at 0xfff005f0) status: 0x1000 len: 0001 addr: 0x001bb084
>    (001 at 0xfff005f8) status: 0x1000 len: 0001 addr: 0x001bb0a4
> * (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
>    (003 at 0xfff00608) status: 0x3000 len: 0004 addr: 0x001bb0e4
>     SMC1_PRAM_TBPTR            0x20         2     0600
>
>     --> hardware and software pointer still synchronized
>
>     >> force console to become crazy (see above) <<
>
> /root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR
>
> TX BD table (tbptr: 0x00000088)
>    (000 at 0xfff005f0) status: 0x1000 len: 0003 addr: 0x001bb084
> * (001 at 0xfff005f8) status: 0x1000 len: 0021 addr: 0x001bb0a4
>    (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
>    (003 at 0xfff00608) status: 0x3000 len: 0001 addr: 0x001bb0e4
>     SMC1_PRAM_TBPTR            0x20         2     0600
>
>     --> hardware and software pointer NOT more synchronized
>
>     >> make additional console output: echo foo >/dev/console <<
>
> /root# cat uart-bdtables; cat mpc82xx/smc1_pram | grep SMC1_PRAM_TBPTR
>
> * (000 at 0xfff005f0) status: 0x1000 len: 0003 addr: 0x001bb084
>    (001 at 0xfff005f8) status: 0x9000 len: 0004 addr: 0x001bb0a4
>    (002 at 0xfff00600) status: 0x1000 len: 0001 addr: 0x001bb0c4
>    (003 at 0xfff00608) status: 0x3000 len: 0001 addr: 0x001bb0e4
>     SMC1_PRAM_TBPTR            0x20         2     05f0
>
>     --> hardware pointer hangs at 0x5f0 because R-Bit not set, but
>         at 0x5f8
>
> Inside uart.c, there are the following output routines:
>
>    rs_8xx_put_char()
>    rs_8xx_write()
>    rs_8xx_send_xchar()
>    my_console_write()
>
> I think there must be a synchronization accessing the
> TX BD table. I suggest the patch attached.
>
>
> Best Regards
> Steffen
> --
>
>
> --------------------------------------------------------------
>
> Steffen Rumler
> ICN CP D NT SW 7
> Siemens AG
> Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
> D-81359 Munich                 Phone: +49 89 722-44061
> Germany                        Fax  : +49 89 722-36703
>
> --------------------------------------------------------------
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
