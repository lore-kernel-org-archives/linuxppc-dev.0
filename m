Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 919B5DE581
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:29:34 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <47DEE6CF.7040801@freescale.com>
References: <20080317175208.GA17844@localhost.localdomain>
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>
	<47DEE6CF.7040801@freescale.com>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 23:29:32 +0100
Message-Id: <1205792972.7589.70.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 16:46 -0500, Timur Tabi wrote:
> Joakim Tjernlund wrote:
> 
> > Trying to add fixed-link support for ucc_geth as this is broken too. I
> > noticed that ifconfig eth1 up follwed by ifconfig eth1 down hangs
> > my board once I got the ucc_geth driver to recognize fixed-link.
> > Does it work for you?
> 
> A long time ago there was a bug where "ifconfig eth1 down" would cause a kernel
> panic if eth0 was also up.  The root cause was a bug in rheap.c.  However, this
> code was fixed a year ago.  Could it be a similar bug?

BTW, I get this on the console:
BUG: soft lockup - CPU#0 stuck for 61s! [ifconfig:263]
NIP: c013649c LR: c0136490 CTR: c0015a34
REGS: c78a9cf0 TRAP: 0901   Not tainted  (2.6.25-rc5)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24022448  XER: 00000000
TASK = c7822430[263] 'ifconfig' THREAD: c78a8000
GPR00: 00000000 c78a9da0 c7822430 00000000 00000000 00000006 00000000 02400000 
GPR08: 00009032 c9062210 c02a0000 00000000 0000000c 
NIP [c013649c] ugeth_disable+0x13c/0x18c
LR [c0136490] ugeth_disable+0x130/0x18c
Call Trace:
[c78a9dc0] [c0136c8c] ucc_geth_stop+0x24/0xa0
[c78a9de0] [c01393e8] ucc_geth_close+0x9c/0xd8
[c78a9e00] [c0166f54] dev_close+0xac/0xb0
[c78a9e10] [c0169a7c] dev_change_flags+0x98/0x1c4
[c78a9e30] [c01b4a78] devinet_ioctl+0x668/0x79c
[c78a9eb0] [c01b6a94] inet_ioctl+0xb4/0xc4
[c78a9ec0] [c015a7a4] sock_ioctl+0x174/0x240
[c78a9ee0] [c0072efc] vfs_ioctl+0x88/0x9c
[c78a9ef0] [c0072fc8] do_vfs_ioctl+0xb8/0x400
[c78a9f10] [c0073350] sys_ioctl+0x40/0x74
[c78a9f40] [c000f2b0] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff65760
    LR = 0xffeae5c
Instruction dump:
91490000 81630000 806b0000 4bedf571 38a0000c 38c00000 7c641b78 38600005 
4bedd70d 813e0008 7c0004ac 80090000 <0c000000> 4c00012c 740b2000 4182ffe

Which appear to be the last IN_BE call in ugeth_disable:

     7d4:	48 00 00 01 	bl      7d4 <ugeth_disable+0x12c>
     7d8:	81 3e 00 08 	lwz     r9,8(r30)
	DEF_MMIO_OUT(name, u##size, __stringify(insn)" %1,0,%2")

DEF_MMIO_IN_BE(in_8,     8, lbz);
DEF_MMIO_IN_BE(in_be16, 16, lhz);
DEF_MMIO_IN_BE(in_be32, 32, lwz);
     7dc:	7c 00 04 ac 	sync    
     7e0:	80 09 00 00 	lwz     r0,0(r9)
---> 7e4:	0c 00 00 00 	twi     0,r0,0
     7e8:	4c 00 01 2c 	isync
     7ec:	74 0b 20 00 	andis.  r11,r0,8192
     7f0:	41 82 ff ec 	beq+    7dc <ugeth_disable+0x134>
