Return-Path: <stuart@quadrics.com>
Received: from quadbrsmgw.quadrics.com (quadmail.quadrics.com
	[194.202.174.130]) by ozlabs.org (Postfix) with ESMTP id 05651DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 05:26:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id BD854356BC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 17:25:20 +0000 (GMT)
Received: from quadbrsmgw.quadrics.com ([127.0.0.1])
	by localhost (quadbrsmgw.quadrics.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id ogJ4FsB+D5WW for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 17:25:08 +0000 (GMT)
Received: from exch01.quadrics.com (owa.quadrics.com [194.202.174.9])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id 1E659356BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 17:21:12 +0000 (GMT)
Message-ID: <472B5BBC.9020607@quadrics.com>
Date: Fri, 02 Nov 2007 17:17:48 +0000
From: Stuart Hodgson <stuart@quadrics.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: GDB bdi2000 and mpc85xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am attempting to get Kernel debugging working on our mpc8541 based 
board via a BDI2000. The various components in use are

kernel - 2.6.19.2
BDI firmware - 1.08
U-Boot - 1.2.0
ppc_85xx-gdb - from eldk4.1 (6.3.0.0-1.21_3rh)


Kernel is configured with `-g` in CFLAGS and not with CONFIG_BDI_SWITCH, 
from the information I have read around the subject this seem to be 
correct. I also have `MMU  XLAT`, and `PTBASE 0xF0` set in by BDI 
configuration file. The default value for XLAT of `0xc0000000` matches 
the kernel our kernel config.

Steps that I done so far

1. Power on BDI
2. Power on the board
3. BDI> reset run
4. Enter u-boot environment to stop linux booting immediately.
5. BDI> HALT
6. BDI> BREAK HARD
7. BDI> BI 0xc025a51c   (this is the address of start_kernel for my build)
8. BDI> GO
9. From U-boot prompt `bootm`, kernel is copied from flash and loading 
begins
10. Kernel does not halt at start_kernel and continues to the login

If I attempt to break at an address later in the boot sequence, such as 
qmx19_ata_input_data (this is the area that I am trying to investigate) 
I get

- TARGET: core #0 has entered debug mode

So from here I attempt to connect to the BDI from gdb

linux> cd ~/linux-2.6.19.2
linux> ppc_85xx-gdb vmlimux

"
GNU gdb Red Hat Linux (6.3.0.0-1.21_3rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux".
The target architecture is set automatically (currently powerpc:603)
"

I noticed here that the last line does not match the e500 core I am 
using, but there does not seem to a change if I change this using `set 
architecture powerpc:e500`


(gdb) tar rem <bdi_ip>:2001
Remote debugging using <bdi_ip>:2001
0x00000000 in ?? ()


What I don't understand here is why 0x00000000 is shown as the address, 
further on the BDI the following error is shown then the connection is made

"
*** MMU: address translation for 0x00000000 failed
*** MMU: address translation for 0xFFFFFFFC failed
*** MMU: address translation for 0x00000000 failed
*** MMU: address translation for 0xFFFFFFFC failed
"

If I then clear the breakpoint from the BDI

BDI> CI

I can then from gdb set breakpoints

(gdb) b qmx19_ata_input_data
Breakpoint 1 at 0xc014ecb4: file drivers/ide/ppc/qmx19-ide.c, line 139.
(gdb) c
Continuing.

And all seems well with resolving the symbol names and and source files. 
When the breakpoint is hit next

"
Program received signal SIGTRAP, Trace/breakpoint trap.
0x00000000 in ?? ()
(gdb) where
#0  0x00000000 in ?? ()
#1  0x00000000 in ?? ()
"

But as expected I can not do any debugging since the address's are not 
being resolved by GDB/BDI. Trying to single step now results in gdb showing

(gdb) s
Cannot find bounds of current function

and BDI showing
*** MMU: address translation for 0x00000000 failed
*** MMU: address translation for 0xFFFFFFFC failed

So my problem would seem to be with address translation. If I ask the 
BDI to translate the address for me it seems fine though

BDI> PHYS 0xc014ecb4
PHYS = 0x0_0014ecb4


So in summary is seem to me that there is a problem with the address 
translation to from BDI GDB, most likely the result of a missing 
configuration parameter or setting. I should also add that there there 
is not an inherent problem with the build of Linux as it boots fine and 
is operational but I would like to step though our CF card driver when 
the kernel is loading.

I have seen a couple of similar questions asked regarding the mpc85xx 
series but not any answers that have shed any light, by all accounts the 
steps I have done would seem to just work for other people, such as the 
BDI manual.

Does anyone have some insights into this.

thanks

Stuart Hodgson
