Message-ID: <3E8D3545.57A6903F@bmrtech.com>
Date: Fri, 04 Apr 2003 15:33:25 +0800
From: Jikun Sun <jack.sun@bmrtech.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux crash when big application executing on PPC405GP board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Board: CSB272 IBM PPC405GP
Linux kernel version: 2.4.17
Linux kernel can boot nfs root filesystem on the board. Shell works
correctly.
However the system will oops when execute big applications, such as
copying a file which is larger than 2MBytes.
The following is ksymoops:

The size of vmlinux.srec is 2.076Mbytes.
root@192.9.200.145:/# cp vmlinux.srec  vmlinux.srec.bak

Oops: kernel access of bad area, sig: 11
NIP: C002CA74 XER: 00000000 LR: C002CA50 SP: C017BDA0 REGS: c017bce0
TRAP: 0800
Using defaults from ksymoops -t elf32-little -a unknown
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0179ff0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C01D26D0 C017BDA0 C0179FF0 00000001 00009030 00000006 C02C9015
FFFFFC18
GPR08: C1FD2240 38300D0A C02D3640 42333846 42000022 10021A24 00000000
00000030
GPR16: 00000000 00000000 00000000 00000001 00001032 0017BEA0 00000000
C0002BCC
GPR24: C0003F78 C01A0000 00000010 C0180000 00000020 C01D26C8 C017BDA8
C01D26C0
Call backtrace:
C0016750 C00EBDB0 C00D7930 C00D7CD4 C0003EC8 C0003FB4 C0002BCC
C0021F90 C00044E0 C0004508 C000240C C018C794 C0002318
Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c002ca74 <kmalloc+e0/1b0>   <=====
Trace; c0016750 <get_fast_time+1c/2c>
Trace; c00ebdb0 <alloc_skb+124/204>
Trace; c00d7930 <ppc405_rx_fill+50/134>
Trace; c00d7cd4 <ppc405_eth_rxeob+d4/108>
Trace; c0003ec8 <ppc_irq_dispatch_handler+1b0/260>
Trace; c0003fb4 <do_IRQ+3c/c0>
Trace; c0002bcc <ret_from_intercept+0/8>
Trace; c0021f90 <check_pgt_cache+20/30>
Trace; c00044e0 <idled+50/68>
Trace; c0004508 <cpu_idle+10/24>
Trace; c000240c <rest_init+30/40>
Trace; c018c794 <start_kernel+150/164>
Trace; c0002318 <start_here+48/a0>

Hope for helps


Jikun Sun


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
