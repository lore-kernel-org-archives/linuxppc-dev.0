Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 98109DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 04:43:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 11:40:04 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com><20080131161527.GT14201@localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Nathan Lynch" <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> I was going to test HEAD of powerpc.git to see if it is still there.

Still there. Also used GDB on the vmlinux image to get source and
dissasembly of the ooops:
Unable to handle kernel paging request for data at address 0x48024000
Faulting instruction address: 0xc000f0a0
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT Innovative Systems ApMax
Modules linked in: drv_wd(P) drv_scc devcom drv_pcir tipc drv_ss7
drv_auxcpu drv_leds(P) drv_ethsw proc_sysinfo(P) i2c_8266(P)
NIP: c000f0a0 LR: c0011fec CTR: 00000080
REGS: eebe9b70 TRAP: 0300   Tainted: P         (2.6.24-test)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24004442  XER: 00000000
DAR: 48024000, DSISR: 20000000
TASK =3D eeba9780[2554] 'armd_crash' THREAD: eebe8000
GPR00: eea44d00 eebe9c20 eeba9780 48024000 00000080 37a56181 48024000
00000000
GPR08: 37a56181 eea44d00 00000000 c2000000 44004422 10100f38 ef336600
bfffffff
GPR16: eeff0300 00000030 eea44d00 00000000 eebe9cdc 00000011 eebe9cd8
eebca480
GPR24: eea44d00 37a56181 48024000 eebad580 eebad580 37a56181 48024000
c26f4ac0
NIP [c000f0a0] __flush_dcache_icache+0x14/0x40
LR [c0011fec] update_mmu_cache+0x74/0x114
Call Trace:
[eebe9c20] [eebe8000] 0xeebe8000 (unreliable)
[eebe9c40] [c005cfd0] handle_mm_fault+0x630/0xbc0
[eebe9c80] [c005d954] get_user_pages+0x3f4/0x4fc
[eebe9cd0] [c00aa730] elf_core_dump+0x9a4/0xc5c
[eebe9d60] [c0077954] do_coredump+0x6e0/0x748
[eebe9e50] [c002a520] get_signal_to_deliver+0x40c/0x45c
[eebe9e80] [c0008cec] do_signal+0x50/0x294
[eebe9f40] [c000fc9c] do_user_signal+0x74/0xc4
--- Exception: 300 at 0x10044efc
    LR =3D 0x10044ec0
Instruction dump:
4d820020 7c8903a6 7c001bac 38630020 4200fff8 7c0004ac 4e800020 60000000
54630026 38800080 7c8903a6 7c661b78 <7c00186c> 38630020 4200fff8
7c0004ac
---[ end trace 37755b0fb9e79677 ]---
note: armd_crash[2554] exited with preempt_count 2

backtrace using gdb on vmlinux image:

0xc00aa730 is in elf_core_dump (fs/binfmt_elf.c:1762).
1757
1758                    for (addr =3D vma->vm_start; addr < end; addr =
+=3D
PAGE_SIZE) {
1759                            struct page *page;
1760                            struct vm_area_struct *vma;
1761
1762                            if (get_user_pages(current, current->mm,
addr, 1, 0, 1,
1763                                                    &page, &vma) =
<=3D
0) {
1764                                    DUMP_SEEK(PAGE_SIZE);
1765                            } else {
1766                                    if (page =3D=3D ZERO_PAGE(0)) {
(gdb) list *0xc005d954
0xc005d954 is in get_user_pages (mm/memory.c:1072).
1067                            cond_resched();
1068                            while (!(page =3D follow_page(vma, =
start,
foll_flags))) {
1069                                    int ret;
1070                                    ret =3D handle_mm_fault(mm, vma,
start,
1071                                                    foll_flags &
FOLL_WRITE);
1072                                    if (ret & VM_FAULT_ERROR) {
1073                                            if (ret & VM_FAULT_OOM)
1074                                                    return i ? i :
-ENOMEM;
1075                                            else if (ret &
VM_FAULT_SIGBUS)
1076                                                    return i ? i :
-EFAULT;
(gdb) list *0xc005cfd0
0xc005cfd0 is in handle_mm_fault (include/asm/thread_info.h:99).
94      {
95              register unsigned long sp asm("r1");
96
97              /* gcc4, at least, is smart enough to turn this into a
single
98               * rlwinm for ppc32 and clrrdi for ppc64 */
99              return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
100     }
101
102     #endif /* __ASSEMBLY__ */
103
(gdb)                   =20
(gdb) list *0xc0011fec
0xc0011fec is in update_mmu_cache (arch/powerpc/mm/mem.c:489).
484                     _tlbie(address, 0 /* 8xx doesn't care about PID
*/);
485     #endif
486                     if (!PageReserved(page)
487                         && !test_bit(PG_arch_1, &page->flags)) {
488                             if (vma->vm_mm =3D=3D =
current->active_mm) {
489                                     __flush_dcache_icache((void *)
address);
490                             } else
491                                     flush_dcache_icache_page(page);
492                             set_bit(PG_arch_1, &page->flags);
493                     }
(gdb) list *0xc000f0a0
No source file for address 0xc000f0a0.
(gdb) disassemble 0xc000f0a0
Dump of assembler code for function __flush_dcache_icache:
0xc000f08c <__flush_dcache_icache+0>:   dec    %esi
0xc000f08d <__flush_dcache_icache+1>:   addb   $0x20,(%eax)
0xc000f090 <__flush_dcache_icache+4>:   push   %esp
0xc000f091 <__flush_dcache_icache+5>:   arpl   %ax,(%eax)
0xc000f093 <__flush_dcache_icache+7>:   cmp    %al,%es:0x897c8000(%eax)
0xc000f09a <__flush_dcache_icache+14>:  add    0x781b667c(%esi),%esp
0xc000f0a0 <__flush_dcache_icache+20>:  jl     0xc000f0a2
<__flush_dcache_icache+22>
0xc000f0a2 <__flush_dcache_icache+22>:  sbb    %ch,0x63(%eax,%edi,1)
0xc000f0a6 <__flush_dcache_icache+26>:  add    %ah,(%eax)
0xc000f0a8 <__flush_dcache_icache+28>:  inc    %edx
0xc000f0a9 <__flush_dcache_icache+29>:  add    %bh,%bh
0xc000f0ab <__flush_dcache_icache+31>:  clc
0xc000f0ac <__flush_dcache_icache+32>:  jl     0xc000f0ae
<__flush_dcache_icache+34>
0xc000f0ae <__flush_dcache_icache+34>:  add    $0xac,%al
0xc000f0b0 <__flush_dcache_icache+36>:  jl     0xc000f03b
<flush_dcache_range+15>
0xc000f0b2 <__flush_dcache_icache+38>:  add    0xac37007c(%esi),%esp
0xc000f0b8 <__flush_dcache_icache+44>:  cmp    %al,%dh
0xc000f0ba <__flush_dcache_icache+46>:  add    %ah,(%eax)
0xc000f0bc <__flush_dcache_icache+48>:  inc    %edx
0xc000f0bd <__flush_dcache_icache+49>:  add    %bh,%bh
0xc000f0bf <__flush_dcache_icache+51>:  clc
0xc000f0c0 <__flush_dcache_icache+52>:  jl     0xc000f0c2
<__flush_dcache_icache+54>
0xc000f0c2 <__flush_dcache_icache+54>:  add    $0xac,%al
0xc000f0c4 <__flush_dcache_icache+56>:  dec    %esp
0xc000f0c5 <__flush_dcache_icache+57>:  add    %al,(%ecx)
0xc000f0c7 <__flush_dcache_icache+59>:  sub    $0x4e,%al
0xc000f0c9 <__flush_dcache_icache+61>:  addb   $0x20,(%eax)
End of assembler dump.
(gdb)                       =20
