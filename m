Date: Wed, 26 May 2004 19:20:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Nei A. Chiaradia" <nei.chiaradia@cyclades.com>,
	Edson Seabra <edson.seabra@cyclades.com>
Subject: Re: Help with crash on MPC855T with 2.2.14
Message-ID: <20040526222027.GD9198@logos.cnet>
References: <20040526220954.GE8234@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040526220954.GE8234@logos.cnet>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Forgot to mention that same processor (on a similar but not exactly the
same hardware) running v2.4 is not-crashable with the same test.

On Wed, May 26, 2004 at 07:09:54PM -0300, Marcelo Tosatti wrote:
>
> Hi PPC fellows,
>
> We are facing a crash on high load on our TS console servers (2.2.14 based).
>
> The test used to reproduce the crash involves running SSH connection attemps in a loop
> from a fast host. After one or two hours of testing, the crash happens. Its still
> possible to ping the box and it answers to typed keys, but thats all. The kernel is looping
> in page fault handling code as following, which has been observed from a BDI2000 and gdb:
>
> (gdb) cont
> Continuing.
>
> (locked here, so I type "ctrl+c" on the gdb session).
>
> Program received signal SIGSTOP, Stopped (signal).
> local_flush_tlb_page (vma=0xce678200, vmaddr=2147481140) at init.c:549
> 549             asm volatile ("tlbia" : : );
> (gdb) bt
> #0  local_flush_tlb_page (vma=0xce678200, vmaddr=2147481140) at init.c:549
> #1  0xc0019368 in handle_mm_fault (tsk=0xce95e000, vma=0xce678200,
>     address=2147481140, write_access=33554432) at memory.c:918
> Cannot access memory at address 0xce95fca0
> (gdb) cont
> Continuing.
>
> And it keeps receiving faults from this address (7FFFF634 in this example,
> sometimes also 7FFFF630), which are part of the process last VMA. Forever.
>
> # cat /proc/1/maps
>
> 30023000-30026000 rwxp 00013000 01:00 249        /lib/ld-2.1.3.so
> 30026000-30027000 rwxp 00000000 00:00 0
> 7fffe000-80000000 rwxp fffff000 00:00 0
>
> The "error_code" passed to "do_page_fault" under such endless loop
> is either 0xE (14) or 0x82000000 (2181038080).
>
> handle_mm_fault trace for such "unsuccessful pte bringup":
>
> #0  handle_mm_fault (tsk=0xce70c000, vma=0xce6188c0, address=2147481140,
>     write_access=33554432) at memory.c:901
>
> 903             if (!pte_present(entry)) {
> 909             entry = pte_mkyoung(entry);
> 910             set_pte(pte, entry);
> 911             flush_tlb_page(vma, address);
> 912             if (write_access) {
> 913                     if (!pte_write(entry))
> 303             pte_val(pte) |= _PAGE_DIRTY;
> 304             if (pte_val(pte) & _PAGE_RW)
> 305                     pte_val(pte) |= _PAGE_HWWRITE;
> 918                     flush_tlb_page(vma, address);
> 916                     entry = pte_mkdirty(entry);
> 917                     set_pte(pte, entry);
> 918                     flush_tlb_page(vma, address);
> 921             return 1;
>
> I should try to figure out why is it faulting. Maybe the pte
> is not being correctly setup.
>
> Any hints are welcome.
>
> /proc/cpuinfo
> processor       : 0
> cpu             : 8xx
> clock           : 48MHz
> clock           : 48MHz
> bus clock       : 48MHz
> revision        : 0.0
> bogomips        : 47.82
> zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/124087 (0%)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
