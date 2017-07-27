Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ2pD3ksmzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 16:56:52 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id m88so7873606iod.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 23:56:52 -0700 (PDT)
Message-ID: <1501138604.14223.1.camel@gmail.com>
Subject: Re: KVM guests freeze under upstream kernel
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, joserz@linux.vnet.ibm.com, Paul
 Mackerras <paulus@ozlabs.org>
Cc: oohall@gmail.com, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Jul 2017 16:56:44 +1000
In-Reply-To: <87d18mfu56.fsf@concordia.ellerman.id.au>
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca>
 <20170720052159.GB8602@fergus.ozlabs.ibm.com>
 <20170721011818.GC13187@pacoca> <20170726131848.GA13783@pacoca>
 <87d18mfu56.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 13:14 +1000, Michael Ellerman wrote:
> joserz@linux.vnet.ibm.com writes:
> > On Thu, Jul 20, 2017 at 10:18:18PM -0300, joserz@linux.vnet.ibm.com
> >  wrote:
> > > On Thu, Jul 20, 2017 at 03:21:59PM +1000, Paul Mackerras wrote:
> > > > 
> > > > Did you check the host kernel logs for any oops messages?
> > > 
> > > dmesg was clean but after sometime waiting (I forgot QEMU running
> > > in
> > > another terminal) I got the oops below (after rebooting the host
> > > I 
> > > couldn't reproduce it again).
> > > 
> > > Another test that I did was:
> > > Compile with transparent huge pages disabled: KVM works fine
> > > Compile with transparent huge pages enabled: doesn't work
> > >   + disabling it in /sys/kernel/mm/transparent_hugepage: doesn't
> > > work
> > > 
> > > Just out of my own curiosity I made this small change:
> > > 
> > > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > b/arch/powerpc/include
> > > index c0737c8..f94a3b6 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > > @@ -80,7 +80,7 @@
> > >  
> > >   #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software
> > > dirty
> > >   tracking 
> > >    #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special
> > > page */
> > >    -#define _PAGE_DEVMAP           _RPAGE_SW1 /* software:
> > > ZONE_DEVICE page */
> > >    +#define _PAGE_DEVMAP           _RPAGE_RSV3
> > >     #define __HAVE_ARCH_PTE_DEVMAP
> > > 
> > > and it works. I chose _RPAGE_RSV3 because it uses the same value
> > > that
> > > x86 uses (0x0400000000000000UL) but I don't if it could have any
> > > side
> > > effect
> > > 
> > 
> > Does this change make any sense to you people?
> 
> No :)
> 
> I think it's just hiding the bug somehow. Presumably we have some
> code
> somewhere that is getting confused by _RPAGE_SW1 being set, or
> setting
> that bit incorrectly.

kernel BUG at /scratch/surajjs/linux/arch/powerpc/include/asm/book3s/64/radix.h:260!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=2048 
NUMA 
PowerNV
Modules linked in:
CPU: 3 PID: 2050 Comm: qemu-system-ppc Not tainted 4.13.0-rc2-00001-g2f3013c-dirty #1
task: c000000f1ebc0000 task.stack: c000000f1ec00000
NIP: c000000000070fd4 LR: c0000000000e2120 CTR: c0000000000e20d0
REGS: c000000f1ec036b0 TRAP: 0700   Not tainted  (4.13.0-rc2-00001-g2f3013c-dirty)
MSR: 900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
  CR: 22244824  XER: 00000000
CFAR: c000000000070e74 SOFTE: 1 
GPR00: 0000000000000009 c000000f1ec03930 c000000001067400 0000000019cf0a05 
GPR04: c000000000000000 050acf190f000080 0000000000000005 0000000000000800 
GPR08: 0000000000000015 8000000f19cf0a05 c000000f1eb64368 0000000000000009 
GPR12: 0000000000000009 c00000000fd80f00 c000000f1eca7a30 4000000000000000 
GPR16: 5f9fffffffff1780 4000000000002000 00007fff5fff0000 00007fff879700a6 
GPR20: 8000000000000108 c00000000110bce0 0000000000000f61 c0000000000e20d0 
GPR24: 000000000000ffff c000000f1c7a6008 00007fff6f600000 00007fff5fff0000 
GPR28: c000000f19fd0000 000000000da00000 0000000000000000 c000000f1ec03990 
NIP [c000000000070fd4] __find_linux_pte_or_hugepte+0x1d4/0x350
LR [c0000000000e2120] kvm_unmap_radix+0x50/0x1d0
Call Trace:
[c000000f1ec03930] [c0000000000b2554] mark_page_dirty+0x34/0xa0 (unreliable)
[c000000f1ec03970] [c0000000000e2120] kvm_unmap_radix+0x50/0x1d0
[c000000f1ec039c0] [c0000000000dbea0] kvm_handle_hva_range+0x100/0x170
[c000000f1ec03a30] [c0000000000df43c] kvm_unmap_hva_range_hv+0x6c/0x80
[c000000f1ec03a70] [c0000000000c7588] kvm_unmap_hva_range+0x48/0x60
[c000000f1ec03ab0] [c0000000000bb77c] kvm_mmu_notifier_invalidate_range_start+0x8c/0x130
[c000000f1ec03b10] [c000000000316f10] __mmu_notifier_invalidate_range_start+0xa0/0xf0
[c000000f1ec03b60] [c0000000002e95f0] change_protection+0x840/0xe20
[c000000f1ec03cb0] [c000000000313050] change_prot_numa+0x50/0xd0
[c000000f1ec03d00] [c000000000143f24] task_numa_work+0x2b4/0x3b0
[c000000f1ec03dc0] [c000000000128738] task_work_run+0xf8/0x160
[c000000f1ec03e00] [c00000000001db94] do_notify_resume+0xe4/0xf0
[c000000f1ec03e30] [c00000000000b744] ret_from_except_lite+0x70/0x74
Instruction dump:
419e00ec 60000000 78a70022 54a9403e 50a9c00e 54e3403e 50a9c42e 50e3c00e 
50e3c42e 792907c6 7d291b78 55270528 <0b070000> 3ce04000 3c804000 78e707c6 
---[ end trace aecf406c356566bb ]---


The bug on added was:

arch/powerpc/include/asm/book3s/64/radix.h:260:
258 static inline int radix__pmd_trans_huge(pmd_t pmd)
259 {
260         BUG_ON(pmd_val(pmd) & _PAGE_DEVMAP);
261         return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
262 }

> 
> cheers
