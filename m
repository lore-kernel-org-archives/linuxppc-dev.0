Message-ID: <757A9CB222EBD5118D2300D0B7828DE10BE1D62B@az33exm32.corp.mot.com>
From: Swarthout Ed-RA8734 <Ed.Swarthout@freescale.com>
To: "'Tameen Khan'" <tameen@cisco.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: RE: Kgdb on Motorola 8451 ppc board
Date: Mon, 5 Jul 2004 21:39:02 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tameen asked:

> Any pointers to where I can get info to get kgdb working for this cross
> arch debugging will be helpful..

Three things to look at:

1. You can tell gdb to show everything going over the serial port with:

(gdb) set debug remote 1

but I get similar messages when nothing is even attached to the serial port.

2. Are you seeing "kgdb init" in the console logs?
That message should come from kgdb_map_scc() in gen550_kgdb.c
What serial port are you using for kgdb?

3. Is the gdb stub actually in a position to do a serial port read?  It will only be listening as a result of a trap or if "gdb" is passed on the kernel cmdline.  (See setup_arch() in setup.c)

Disclaimer: I haven't actually tried kgdb on this board and I'm on vacation for two weeks...

Ed dot Swarthout at Freescale dot com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
