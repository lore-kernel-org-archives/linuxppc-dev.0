Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 19273683D6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 00:30:08 +1000 (EST)
In-Reply-To: <011901c5c49a$9aa01fc0$3f13180a@utsfd.cs.fujitsu.co.jp>
References: <011901c5c49a$9aa01fc0$3f13180a@utsfd.cs.fujitsu.co.jp>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4D122DC0-BFB6-469B-8569-AE04AE5DD7FC@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Thu, 29 Sep 2005 09:30:15 -0500
To: sun <sun.zhitai@jp.fujitsu.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: fix-up GIANFAR driver timer bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The reported issue no longer exists in the latest version of the  
driver, which should be in linus' tree soon (it's in the netdev  
tree).  However, it may have crept into the PHY Layer, so I will  
investigate.  Thank you for reporting this!

Andy

On Sep 28, 2005, at 21:07, sun wrote:

> Repeat executing a command series like the attached descript will  
> cause
> system hanging or kernel panic shown below on a GIANFAR used system.
> The attached patch is for fix the above issue.
> The issue and the solution have been confirmed on
> MPC8560ADS and MPC85555CDS evaluation boards.
>
> ----------
> -sh-3.00# ./net_setting.sh
> eth1 setting start
> ###set ip-address
>
> ###net Trying to free free IRQ103
> down
>
> ###set MAC address
>
> ###net up
> kernel BUG in cascade at kernel/timer.c:419!
> Oops: Exception in kernel mode, sig: 5 [#1]
> NIP: C0029090 LR: C00290A0 SP: CCD69B20 REGS: ccd69a70 TRAP:  
> 0700    Not tainted
> MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = cde58080[170] 'ifconfig' THREAD: ccd68000
> Last syscall: 54
> GPR00: 00000001 CCD69B20 CDE58080 C0311DD4 C031269C FFFBD700  
> C0311F4C C0311E94
> GPR08: FFFBD869 00003B60 00000169 00003B5F FFFBD700 1010A204  
> 00000000 00000000
> GPR16: 00000000 1001C094 00000000 00000000 C07D2400 FFFF8914  
> C03092C0 C0310000
> GPR24: C0310000 C0310000 C0280000 C0311DD4 00000017 C0311DD4  
> C0312694 C031269C
> NIP [c0029090] cascade+0x40/0x78
> LR [c00290a0] cascade+0x50/0x78
> Call trace:
> [c002923c] run_timer_softirq+0x174/0x1d8
> [c0024b4c] __do_softirq+0x80/0xf4
> [c0024c18] do_softirq+0x58/0x60
> [c0003930] timer_interrupt+0xa0/0x208
> [c0002598] ret_from_except+0x0/0x18
> [c001f694] release_console_sem+0xc4/0x234
> [c001f95c] vprintk+0x158/0x1c0
> [c001fa14] printk+0x50/0x60
> [c014d91c] get_phy_info+0xcc/0xe4
> [c014b30c] gfar_enet_open+0x2ec/0x390
> [c01a7630] dev_open+0xb0/0xd8
> [c01a8dc4] dev_change_flags+0x6c/0x144
> [c01e6eec] devinet_ioctl+0x618/0x764
> [c01e8250] inet_ioctl+0x10c/0x120
> [c019dbcc] sock_ioctl+0x1ac/0x288
> Kernel panic - not syncing: Aiee, killing interrupt handler!
> <0>Rebooting in 1 seconds..U-Boot 1.1.2 (Aug 19 2005 - 09:55:23)
>
>
> <fixIFCONFIGpanic.patch>
> <net_setting.sh>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
