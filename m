Return-Path: <pku.leo@gmail.com>
Received: from mail-qy0-f181.google.com (mail-qy0-f181.google.com
	[209.85.221.181]) by ozlabs.org (Postfix) with ESMTP id 6A97CB7D4E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 14:28:46 +1000 (EST)
Received: by qyk11 with SMTP id 11so206488qyk.13
	for <linuxppc-dev@ozlabs.org>; Wed, 05 May 2010 21:28:44 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <u2ted82fe3e1005050451q96498ce9jc9f5c0650e00ae2d@mail.gmail.com>
References: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
	<u2ted82fe3e1005050451q96498ce9jc9f5c0650e00ae2d@mail.gmail.com>
Date: Thu, 6 May 2010 12:28:44 +0800
Message-ID: <m2x2a27d3731005052128w3e9fe517ie3a068b352adb7f3@mail.gmail.com>
Subject: Re: Page fault on vmalloc'ed memory
From: Li Yang <leoli@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 5, 2010 at 7:51 PM, Timur Tabi <timur.tabi@gmail.com> wrote:
> On Wed, May 5, 2010 at 12:19 AM, Li Yang-R58472 <r58472@freescale.com> wr=
ote:
>> I got a weird page fault oops on vmalloc'ed area. =C2=A0Digging into the=
 powerpc do_page_fault(), I found there is no handling of address in kernel=
 space unlike the x86 counter part. =C2=A0Does any one know how we deal wit=
h the vmalloc'ed area on powerpc? =C2=A0Thanks a lot.
>
> Can you be more specific? =C2=A0Post the oops message, and tell us the
> specific x86 code that you think is missing.

I was doing some preliminary studying before posting it.

Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0xf938d040
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=3D2 P2020 DS
Modules linked in: e1000e(+)
NIP: f938d040 LR: f938d040 CTR: c026d894
REGS: ef94de30 TRAP: 0400   Not tainted  (2.6.32-00165-g9e2ec9e-dirty)
MSR: 00029000 <EE,ME,CE>  CR: 24000422  XER: 20000000
TASK =3D ef91b440[2276] 'insmod' THREAD: ef94c000 CPU: 0
GPR00: f938d040 ef94dee0 ef91b440 00000039 00021000 ffffffff c026e330 706f7=
261
GPR08: c066789c 00000000 00005b34 00000001 24000422 10018dd0 10096470 10077=
bd4
GPR16: 100b93fc 100925d4 100bb02c 00000000 00000000 100b9410 100c6808 10000=
bb4
GPR24: 10000bb8 10000bdc 001d2ec9 f938d000 00000000 c0660000 ef94c000 f9386=
e00
NIP [f938d040] e1000_init_module+0x40/0xb8 [e1000e]
LR [f938d040] e1000_init_module+0x40/0xb8 [e1000e]
Call Trace:
[ef94dee0] [f938d040] e1000_init_module+0x40/0xb8 [e1000e] (unreliable)
[ef94def0] [c0001db4] do_one_initcall+0x3c/0x1e0
[ef94df20] [c007db4c] sys_init_module+0xf8/0x21c
[ef94df40] [c0010318] ret_from_syscall+0x0/0x3c
Instruction dump:
3fe0f938 3bff6e00 3c60f938 90010014 38a54b70 7fe4fb78 38635700 4800006d
3c60f938 7fe4fb78 38635730 4800005d <3c80f938> 3ca0f938 3c60f938 38846e08
---[ end trace 047b8203944b6a38 ]---
Segmentation fault

The root cause of this oops might not be related with the vmalloc'ed
area processing in Instruction Storage Interrupt.  But x86 does have
the code for processing it while we don't.  Is it because we have
nothing to do with the vmalloc'ed ISI on PowerPC architecture?

In arch/x86/mm/fault.c:
        /*
         * We fault-in kernel-space virtual memory on-demand. The
         * 'reference' page table is init_mm.pgd.
         *
         * NOTE! We MUST NOT take any locks for this case. We may
         * be in an interrupt or a critical region, and should
         * only copy the information from the master page table,
         * nothing more.
         *
         * This verifies that the fault happens in kernel space
         * (error_code & 4) =3D=3D 0, and that the fault was not a
         * protection error (error_code & 9) =3D=3D 0.
         */
        if (unlikely(fault_in_kernel_space(address))) {
                if (!(error_code & (PF_RSVD | PF_USER | PF_PROT))) {
                        if (vmalloc_fault(address) >=3D 0)
                                return;

                        if (kmemcheck_fault(regs, address, error_code))
                                return;
                }

                /* Can handle a stale RO->RW TLB: */
                if (spurious_fault(error_code, address))
                        return;

                /* kprobes don't want to hook the spurious faults: */
                if (notify_page_fault(regs))
                        return;
                /*
                 * Don't take the mm semaphore here. If we fixup a prefetch
                 * fault we could otherwise deadlock:
                 */
                bad_area_nosemaphore(regs, error_code, address);

                return;
     }

In arch/powerpc/mm/fault.c, we do:

        /* On a kernel SLB miss we can only check for a valid exception ent=
ry */
        if (!user_mode(regs) && (address >=3D TASK_SIZE))
                return SIGSEGV;

- Leo
