Message-ID: <3B4F412F.99A14D9E@comdev.cc>
Date: Fri, 13 Jul 2001 11:42:55 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mmu problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok, I'm working on porting this to a custom 8260 board.
For a while I thought I was having problems with the network
layer, because the machine would lock up after I logged in
via telnet and attempted to execute a command.

So I slowly paired things down, and got it to lock up at the console.
I found that if I logged in to the console and did a number of
ls -laR &
(about 5 running simultaneously) thinks lock up.

Sometimes I get a nice register dump, sometimes things just freeze.
The stack trace when I get a dump is always in some type of memory
management page.  (Example below).

I suspect there's something about the MMU that's not being configured
properly, but I don't really know where to start.

Help?

(8260, PPCBoot 0.9, linux 2.4.4, serial console on SMC2, ether on FCC3 )

--Adam

Oops: Exception in kernel mode, sig: 4
NIP: C0005F80 XER: 00000000 LR: C000CF9C SP: C3417D30 REGS: c3417c80
TRAP: 0700 MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3416000[22] 'ls' Last syscall: 6
last math c3416000 last altivec 00000000
GPR00: C0023B74 C3417D30 C3416000 C3400000 00000080 00000081 C33FF000
68616E67
GPR08: 65640000 50726F66 C027B060 00000084 44442482 1004BE90 00000001
7FFFF9D0
GPR16: 3002A570 3002A2B8 7FFFF8C0 7FFFF8C4 00009032 02000000 C3687BA0
C3F6E6DC
GPR24: C000BE90 00000133 C3687C40 C368AEA0 C351FA60 C0271AE0 00000119
C0247FE4
Call backtrace:
C0271AE0 C0023B74 C001F81C C001F99C C000C020 C0003DC4 3000D02C
300050DC 30011058 30003AA4 300039D4 30013544

choice bits from System.map:

c0003db4 T ret_from_fork
c0003dbc T ret_from_intercept
c0003dc4 T ret_from_except
c0003dec T do_bottom_half_ret
c0003e20 T do_signal_ret

c000be1c t m8260_mask_and_ack
c000be78 T m8260_get_irq
c000be90 T do_page_fault
c000c218 T bad_page_fault
c000c270 T va_to_pte
c000c2dc T va_to_phys
c000c328 T print_8xx_pte

c001f674 t do_anonymous_page
c001f79c t do_no_page
c001f928 T handle_mm_fault
c001fa54 T __pmd_alloc
c001fab0 T pte_alloc

c00238a8 t nopage_sequential_readahead
c0023a4c T filemap_nopage
c0023f88 T filemap_sync

c0155440 B sysctl_tcp_mem
c015544c B unix_socket_table
c0155850 A _end




--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
