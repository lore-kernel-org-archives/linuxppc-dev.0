To: "Joshua Horvath" <Josh_Horvath-AJH051@email.mot.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Abatron BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Nov 2001 09:55:07 CST."
             <3BE2C1DB.8B975906@labs.mot.com>
Date: Fri, 02 Nov 2001 22:03:32 +0100
Message-Id: <20011102210337.9620F10CDB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joshua,

in message <3BE2C1DB.8B975906@labs.mot.com> you wrote:
>
> Since we haven't had a problem bringing the kernel up on our boards, 1) isn't
> (currently) a big deal.  What we really need is to be able to debug loadable
> modules, which from what I've gathered is only possible with kgdb.  Is this
> assumption correct?

No, this is wrong. Of course you can debug loadable modules with  the
BDI2000  as  well. You just have to manually load the symbol table in
GDB, for instance:

On the target: load the module:

	# insmod -m ./buzzer
	Sections:       Size      Address   Align
	.this           00000060  cf007000  2**2
	.text           000005a4  cf007060  2**2
	.rodata         00000128  cf007604  2**2
	.data           00000048  cf00772c  2**2
	.sdata          00000018  cf007774  2**2
	.kstrtab        000000ed  cf00778c  2**0
	.sbss           00000020  cf00787c  2**2
	.bss            00000000  cf00789c  2**0
	.plt            000000a0  cf0078a0  2**4
	__ksymtab       00000060  cf007940  2**2
	__archdata      00000000  cf0079a0  2**4

	Symbols:
	00000000 a buzzer.c
	cf007000 d __this_module
	cf007000 D __insmod_buzzer_O/tmp/buzzer_M3B276319_V132100
	cf007060 T buzzer_init
	cf007060 T __insmod_buzzer_S.text_L1444
	cf007060 t .text        <<============================================
	cf007170 t buzzer_open
	cf0071d8 t buzzer_release
	cf007218 t buzzer_read
	cf007220 t buzzer_write
	cf007284 t buzzer_ioctl
	...

In GDB:

	^C
	Program received signal SIGSTOP, Stopped (signal).
	0xc0003cdc in idled ()
	(gdb) add-symbol-file ../driver/buzzer 0xcf007060
	add symbol table from file "../driver/buzzer" at
		.text_addr = 0xcf007060
	(y or n) y
	Reading symbols from ../driver/buzzer...done.
	(gdb) b buzzer_op
	buzzer_open  buzzer_ops
	(gdb) b buzzer_open
	Breakpoint 2 at 0xcf007170: file buzzer.c, line 236.
	(gdb) b buzzer_ioctl
	Breakpoint 3 at 0xcf0072a0: file buzzer.c, line 316.
	(gdb) c
	Continuing.
	...
	Breakpoint 2, buzzer_open (inode=0xc0f28610, file=0xc01463c0) at buzzer.c:236
	236             if (!immr) {
	...


> We can flash our boards, download code, etc. and as I said, we've got the
> kernel running successfully.  So other than point 2) above, is there anything
> else I've missed that would provide a compelling reason to purchase these
> units?

You can debug device drivers (both statically linked  and  loaded  as
modules)  and  other  kernel  code.  The  BDI2000 works with many CPU
types. The price is (IMHO) fair, the quality good (3  years  warranry
on  the  hardware!),  and  I  know  no  other tool vendor with better
response.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you believe that feeling bad or worrying long enough will change a
past or future event, then you are residing on another planet with  a
different reality system.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
