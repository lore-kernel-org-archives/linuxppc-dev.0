Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 4EDAFDDFF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 03:47:21 +1100 (EST)
Subject: kernel panic after upgrading to 2.6.22
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF9B97E7E0.352B883F-ONC12573CA.0058283E-C12573CA.005AFC5C@abengoa.com>
Date: Tue, 8 Jan 2008 17:33:22 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello everybody!

I have upgraded from 2.6.15 to 2.6.22 with a mpc866 processor.  I haven=
't
got any idea what is happening in the system, but I got a kernel panic.=
 The
direction of the kernel panic points to the "get_index( )" call into
"prio_tree_insert( )".
I don't think the problem is caused by the uart cpm, but it's also a
possibility.

Here is the console message:

Linux version 2.6.22.14-ELinOS-453 (sermb@pt-330039) (gcc version 3.4.4=

(ELinOS 4.2 3.4.4-38 2007-11-23)) #93 PREEMPT Tue Jan 8 16:8

Zone PFN ranges:

  DMA             0 ->    32768

  Normal      32768 ->    32768

early_node_map[1] active PFN ranges

    0:        0 ->    32768

Built 1 zonelists.  Total pages: 32512

Kernel command line:

PID hash table entries: 512 (order: 9, 2048 bytes)

Decrementer Frequency =3D 375000000/60

cpm_uart: console: compat mode

CPM uart[-]:init portdesc

CPM uart[0]:allocbuf

CPM uart[0]:initbd

CPM uart[0]:init_smc

CPM uart[0]:set_termios

Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)

Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)

Memory: 125824k available (1424k kernel code, 288k data, 2192k init, 0k=

highmem)

Mount-cache hash table entries: 512

NET: Registered protocol family 16

NET: Registered protocol family 2

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 4096 (order: 3, 32768 bytes)

TCP bind hash table entries: 4096 (order: 2, 16384 bytes)

TCP: Hash tables configured (established 4096 bind 4096)

TCP reno registered

JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.

io scheduler noop registered (default)

io scheduler anticipatory registered

Serial: CPM driver $Revision: 0.02 $

cpm_uart: WARNING: no UART devices found on platform bus!

cpm_uart: the driver will guess configuration, but this mode is no long=
er
supported.

CPM uart[0]:config_port

CPM uart[0]:request port

CPM uart[0]:uart_type

ttyCPM0 at MMIO 0xff000a80 (irq =3D 20) is a CPM UART

CPM uart[1]:config_port

CPM uart[1]:request port

CPM uart[1]:allocbuf

CPM uart[1]:initbd

CPM uart[1]:init_smc

CPM uart[1]:uart_type

ttyCPM1 at MMIO 0xff000a90 (irq =3D 19) is a CPM UART

TCP cubic registered

NET: Registered protocol family 1

Freeing unused kernel memory: 2192k init

CPM uart[0]:startup

CPM uart[0]:set_termios

Oops: kernel access of bad area, sig: 11 [#1]

                                             PREEMPT

NIP: c00c9cdc LR: c00c9f2c CTR: 00000000

REGS: c0529cd0 TRAP: 0300   Not tainted  (2.6.22.14-ELinOS-453)

MSR: 00009032 <EE,ME,IR,DR>  CR: 35093059  XER: a0007a00

DAR: ff801005, DSISR: c0000000

TASK =3D c0524ae0[1] 'init' THREAD: c0528000

GPR00: c00c9f2c c0529d80 c0524ae0 ff800fff c03be29c c0529d98 c0529d9c
c03be278

GPR08: 00000000 00000000 c03be278 00000000 35093059 00000008 30027ff0
10001c3c

GPR16: 0ffd8000 00000129 00000000 c7c84578 00000000 c7c8458c 35093053
95053053

GPR24: 00000000 c03be278 c03be29c c7c8458c c03be29c c03be278 c03be56c
c03be320

Call Trace:

[c0529d80] [c03be2cc]  (unreliable)

[c0529d90] [c00c9f2c]

[c0529dd0] [c0047b3c]

[c0529df0] [c004e1a8]

[c0529e50] [c004f234]

[c0529e70] [c004f324]

[c0529eb0] [c004f720]

[c0529f10] [c000633c]

[c0529f40] [c0002a80]

Instruction dump:

7c8803a6 4e800021 38000001 7c030378 80010014 38210010 7c0803a6 4e800020=


7c0802a6 9421fff0 3944ffdc 90010014 <a0030006> 2f800000 419e0048 812a00=
44

Kernel panic - not syncing: Attempted to kill init!

Rebooting in 180 seconds..


Does anyone know what the problem could be?

Ra=FAl Moreno=
