Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 1F40068802
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 00:50:26 +1100 (EST)
Message-ID: <1133534967.43905ef73521a@webmail.televes.com:443>
Date: Fri,  2 Dec 2005 15:49:27 +0100
From: Alex BASTOS <alebas@televes.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <1133520697.4390273987a6a@webmail.televes.com:443>
	<4390223C.8060103@ru.mvista.com>
	<1133531801.4390529995cfa@webmail.televes.com:443>
In-Reply-To: <1133531801.4390529995cfa@webmail.televes.com:443>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitally,

Finally, more clever informacion from log_buf.
(...and sorry about previos uncomplete information)

<5>Linux version 2.6.15-rc2 (alebas@xxxx) (gcc version 3.3.2) #1 PREEMPT Fri Dec
2 12:22:09 CET 2005
<6>Televes xxxxxx
<4>arch/ppc/syslib/m82xx_pci.c: The PCI bus is 66666666 Mhz.
<4>Waiting 1 second after deasserting RST...
<4>Machine check in kernel mode.
<4>Caused by (from SRR1=41030): Transfer error ack signal
<4>Oops: machine check, sig: 7 [#1]
<4>PREEMPT
<4>NIP: C001150C LR: C0011530 SP: C01D1EA0 REGS: c01d1df0 TRAP: 0200    Not
tainted
<4>MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>TASK = c01a2ff8[0] 'swapper' THREAD: c01d0000
<4>Last syscall: 0
<6>GPR00: 000000FF C01D1EA0 C01A2FF8 00000000 00000008 F0010906 00000001
C01D1ED8
<6>GPR08: 00000001 00000002 00000800 F0010904 24008028 FFFFFFFF 03FFE000
00000000
<6>GPR16: 00000001 00000001 FFFFFFFF 007FFF00 03FF8CE8 00000000 00000003
03BCB578
<6>GPR24: 00000000 00000000 00000001 0000000E 00000008 C01D1ED8 C01EC2DC
C01FC000
<4>NIP [c001150c] indirect_read_config+0xe8/0x11c
<4>LR [c0011530] indirect_read_config+0x10c/0x11c
<4>Call trace:
<4> [c00c8fb4] pci_bus_read_config_byte+0x60/0xa8
<4> [c000a784] early_read_config_byte+0x30/0x44
<4> [c01dc04c] pciauto_bus_scan+0xac/0x298
<4> [c01dba00] pq2_find_bridges+0x184/0x1b0
<4> [c01db1a0] m8260_setup_arch+0x30/0x80
<4> [c01d8c2c] setup_arch+0x110/0x18c
<4> [c01d2544] start_kernel+0x34/0x1bc
<4> [000032bc] 0x32bc
<4>Oops: kernel access of bad area, sig: 11 [#2]
<4>PREEMPT
<4>NIP: C001196C LR: C0012940 SP: C01D1C70 REGS: c01d1bc0 TRAP: 0300    Not
tainted
<4>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>DAR: 00000000, DSISR: 20000000
<4>TASK = c01a2ff8[0] 'swapper' THREAD: c01d0000
<4>Last syscall: 0
<6>GPR00: 00010005 C01D1C70 C01A2FF8 C01A2FF8 00000000 00000001 C01ED8E0
00000000
<6>GPR08: 00000000 00000001 00000078 C01D0000 00000000 FFFFFFFF 03FFE000
00000000
<6>GPR16: 00000001 00000001 FFFFFFFF 007FFF00 03FF8CE8 00000000 00000003
C01F0000
<6>GPR24: C01F0000 00000000 00000001 0000000E C01EB09C 00000000 C01EDD20
C01A2FF8
<4>NIP [c001196c] dequeue_task+0x0/0x78
<4>LR [c0012940] scheduler_tick+0x244/0x3b0
<4>Call trace:
<4> [c002284c] update_process_times+0xa4/0x168
<4> [c0005bb4] timer_interrupt+0x90/0x25c
<4> [c0004a7c] ret_from_except+0x0/0x14
<4> [c0004d9c] die+0xa0/0xc4
<4> [c0004a30] ret_from_except_full+0x0/0x4c
<4> [c001150c] indirect_read_config+0xe8/0x11c
<4> [c00c8fb4] pci_bus_read_config_byte+0x60/0xa8
<4> [c000a784] early_read_config_byte+0x30/0x44
<4> [c01dc04c] pciauto_bus_scan+0xac/0x298
<4> [c01dba00] pq2_find_bridges+0x184/0x1b0
<4> [c01db1a0] m8260_setup_arch+0x30/0x80
<4> [c01d8c2c] setup_arch+0x110/0x18c
<4> [c01d2544] start_kernel+0x34/0x1bc
<4> [000032bc] 0x32bc
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!
<4> <0>Rebooting in 180 seconds..

The Tranfer Error makes not many sense for me, as _TEA is pulled-up.
Maybe the oops after that is caused by the bad call return point?

Thanks,

Alex BASTOS
