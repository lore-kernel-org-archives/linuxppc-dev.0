From: Arun Dharankar <ADharankar@attbi.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Questions regarding serial console on MPC8260ADS under Linux
Date: Sat, 12 Apr 2003 19:44:37 -0400
References: <200304121926.37104.ADharankar@ATTBI.Com>
In-Reply-To: <200304121926.37104.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304121944.37688.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also, for item (3) below, the BDI shows the DPRAM contents as:

   f0000040 : 00d000f0 30300020 00000000 2ff79c75  ....00. ..../..u
   f0000050 : 00d0f5ef 07615f3f 00000000 4eebe672  .....a_?....N..r
   f0000060 : 00f096f0 edc4fcff 0020e9ab dcbbdf3b  ......... .....

Which are the same as when PPCBoot is executing.


And, Linux works fine - console login, telnet over FCC all are ok.

Best regards,
-Arun.



On Saturday 12 April 2003 07:26 pm, Arun Dharankar wrote:
> Hello...
>
> 1. After making sure that the stty/termio settings on the console port
>     have "brkint", I tried sending a break (kermit, minicom and reverse
>     telnet on BDI). The break does not seem to generate SIGINT.
>
>     What could I be missing, or doing wrong? Or is my understanding
>     incorrect of the brkint termio flag?
>
>
> 2. I would like to use the SAK/sysrq on the serial console. One thing
>     seems to be missing is ASYNC_SAK flag in the ser_info_t->flags.
>     So, I added it in the 8260_io/uart.c:startup(...). Also, made sure
>     that /proc/sys/kernel/sysrq has "1" in it. With this much, I tried
> sending a break on the console followed by "t" (and other SAK feature
> keys). No luck.
>
>     Could this be related to (1) above? What about the missing flag
>     ASYNC_SAK in the ser_info_t info struct?
>
>
> 3. During Linux kernel bootup, ppc_md.progress(...) is called in a number
>     of places. This is before the serial console is initialized. On the
>     8260 configuration, the ppc_md.progress(...) is NULL. Has this been
>     been fixed by anyone for the 8260 configuration?
>
>     On the board I use, PPCBoot is the bootloader/monitor. So, I copied
>     over the serial_putc()/serial_puts() routines to uart.c (ofcourse, the
>     modified to use the same DPRAM settings/addresses as used by
>     PPCBoot.
>
>     With BDI, I can see that this ppc_md.progress()-->serial_puts()-->
>     serial_putc() is called. But,
>      volatile cbd_t tbdf = (cbd_t *)&im->im_dprambase[up->smc_tbase];
>     Seems to cause an exception in machine_init() the first time it is
>     called.  Also, up does point to 0xf0000040 (in IMAP/IMMR).
>
>     My guess is that this is do with the address translations which are
>     not setup at this instance during startup. I am not sure how to fix
>     this - if this is the case.  How do I get this to work?
>
>
> Best regards,
> -Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
