Date: Thu, 12 Oct 2000 15:33:17 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board 
In-Reply-To: <Pine.HPX.4.10.10010121155380.16113-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0010121527430.10161-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Gabriel Paubert wrote:
> Could you try my kernel and patches on ftp://vlab1.iram.es/pub/linux-2.4 ?

When I try the zImage-2.4.0-test7 on my MVME2303 i have the following
error message :
pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).
....

I have patched the test10 kernet with your patch but I have the following
compile error :
ppc_ksyms.c:289: `int_control' undeclared here (not in a function)
ppc_ksyms.c:289: initializer element is not constant
ppc_ksyms.c:289: (near initialization for `__ksymtab_int_control.value')

In fact after a search in .c and .h file I only have this :
./arch/ppc/kernel/apus_setup.c: int_control.int_sti = __no_use_sti;
./arch/ppc/kernel/apus_setup.c: int_control.int_cli = __no_use_cli;
./arch/ppc/kernel/apus_setup.c: int_control.int_save_flags =
__no_use_save_flags;
./arch/ppc/kernel/apus_setup.c: int_control.int_restore_flags =
__no_use_restore_flags;
./arch/ppc/kernel/pmac_pic.c:   int_control.int_set_lost =
__no_use_set_lost;
./arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(int_control);

./include/asm-ppc/hw_irq.h:struct int_control_struct
./include/asm-ppc/hw_irq.h:extern struct int_control_struct int_control;

So I'll try your patch on a test5 kernel from ftp.kernel.org to see if the
problem continue.

O+ xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
