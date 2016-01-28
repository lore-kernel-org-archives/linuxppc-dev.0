Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BC211A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 15:27:00 +1100 (AEDT)
Message-ID: <1453955219.4108.6.camel@ellerman.id.au>
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 amodra@gmail.com, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Thu, 28 Jan 2016 15:26:59 +1100
In-Reply-To: <20160127104400.GA32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <1453889967.10839.2.camel@ellerman.id.au> <20160127104400.GA32095@lst.de>
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

On Wed, 2016-01-27 at 11:44 +0100, Torsten Duwe wrote:
> On Wed, Jan 27, 2016 at 09:19:27PM +1100, Michael Ellerman wrote:
> > Hi Torsten,
> >
> > > +++ b/arch/powerpc/kernel/entry_64.S
> > > @@ -1206,7 +1206,12 @@ _GLOBAL(enter_prom)
> > >  #ifdef CONFIG_DYNAMIC_FTRACE
> > >  _GLOBAL(mcount)
> > >  _GLOBAL(_mcount)
> > > -	blr
> > > +	std	r0,LRSAVE(r1) /* gcc6 does this _after_ this call _only_ */
> > > +	mflr	r0
> > > +	mtctr	r0
> > > +	ld	r0,LRSAVE(r1)
> > > +	mtlr	r0
> > > +	bctr
> >
> > Can we use r11 instead? eg:
> >
> > _GLOBAL(_mcount)
> > 	mflr	r11
> > 	mtctr	r11
> > 	mtlr	r0
> > 	bctr
> >
> > Otherwise I worry the std/ld is going to cause a load-hit-store. And it's just
> > plain more instructions too.
> >
> > I don't quite grok the gcc code enough to tell if that's always safe, GCC does
> > use r11 sometimes, but I don't think it ever expects it to survive across
> > _mcount()?
>
> I used r11 in that area once, and it crashed, but I don't recall the deatils.
> We'll see. The performance shouldn't be critical, as the code is only used
> during boot-up. With DYNAMIC_FTRACE, The calls will be replaced by
> 0x600000^W PPC_INST_NOP :)

True.

That raises an interesting question, how does it work *without* DYNAMIC_FTRACE?

It looks like you haven't updated that version of _mcount at all? Or maybe I'm
missing an #ifdef somewhere?

_GLOBAL_TOC(_mcount)
	/* Taken from output of objdump from lib64/glibc */
	mflr	r3
	ld	r11, 0(r1)
	stdu	r1, -112(r1)
	std	r3, 128(r1)
	ld	r4, 16(r11)

	subi	r3, r3, MCOUNT_INSN_SIZE
	LOAD_REG_ADDR(r5,ftrace_trace_function)
	ld	r5,0(r5)
	ld	r5,0(r5)
	mtctr	r5
	bctrl
	nop

It doesn't look like that will work right with the -mprofile-kernel ABI. And
indeed it doesn't boot.

So we'll need to work that out. I guess the minimum would be to disable
-mprofile-kernel if DYNAMIC_FTRACE is disabled.

Frankly I think we'd be happy to *only* support DYNAMIC_FTRACE, but the generic
code doesn't let us do that at the moment.

> > > index 44d4d8e..080c525 100644
> > > --- a/arch/powerpc/kernel/ftrace.c
> > > +++ b/arch/powerpc/kernel/ftrace.c
> > > @@ -306,11 +306,19 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> > >  	 * The load offset is different depending on the ABI. For simplicity
> > >  	 * just mask it out when doing the compare.
> > >  	 */
> > > +#ifndef CC_USING_MPROFILE_KERNEL
> > >  	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
> > > -		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
> > > +		pr_err("Unexpected call sequence at %p: %x %x\n",
> > > +		ip, op[0], op[1]);
> > >  		return -EINVAL;
> > >  	}
> > > -
> > > +#else
> > > +	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
> > > +	if (op[0] != 0x60000000) {
> >
> > That is "PPC_INST_NOP".
> >

> > > +		pr_err("Unexpected call at %p: %x\n", ip, op[0]);
> > > +		return -EINVAL;
> > > +	}
> > > +#endif
> >
> > Can you please break that out into a static inline, with separate versions for
> > the two cases.
> >
> > We should aim for no #ifdefs inside functions.
>
> Points taken.

Thanks.

> Does this set _work_ for you now? That'd be great to hear.

Sort of, see previous comments.

But it's better than the previous version which didn't boot :)

Also ftracetest fails at step 8:

  ...
  [8] ftrace - function graph filters with stack tracer
  Unable to handle kernel paging request for data at address 0xd0000000033d7f70
  Faulting instruction address: 0xc0000000001b16ec
  Oops: Kernel access of bad area, sig: 11 [#1]
  SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: virtio_balloon fuse autofs4 virtio_net virtio_pci virtio_ring virtio
  CPU: 15 PID: 0 Comm: swapper/15 Not tainted 4.5.0-rc1-00009-g325e167adf2b #4
  task: c0000001fefe0400 ti: c0000001fff74000 task.ti: c0000001fb0e0000
  NIP: c0000000001b16ec LR: c000000000048abc CTR: d0000000032d0424
  REGS: c0000001fff77aa0 TRAP: 0300   Not tainted  (4.5.0-rc1-00009-g325e167adf2b)
  MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002422  XER: 20000000
  CFAR: c0000000004ebbf0 DAR: d0000000033d7f70 DSISR: 40000000 SOFTE: 0
  GPR00: c000000000009f84 c0000001fff77d20 d0000000032d9fb0 c000000000118d70
  GPR04: d0000000032d0420 0000000000000000 0000000000000000 00000001ff170000
  GPR08: 0000000000000000 d0000000033d9fb0 c0000001f36f2c00 d0000000032d1898
  GPR12: c000000000118d70 c00000000fe03c00 c0000001fb0e0000 c000000000d6d3c8
  GPR16: c000000000d59c28 c0000001fb0e0000 0000000000000001 0000000000000008
  GPR20: c0000001fb0e0080 0000000000000001 0000000000000002 0000000000000019
  GPR24: c0000001f36f2c00 0000000000000000 0000000000000000 0000000000000000
  GPR28: 0000000000000000 d0000000032d0420 c000000000118d70 c0000001f3570680
  NIP [c0000000001b16ec] ftrace_graph_is_dead+0xc/0x20
  LR [c000000000048abc] prepare_ftrace_return+0x2c/0x150
  Call Trace:
  [c0000001fff77d20] [0000000000000002] 0x2 (unreliable)
  [c0000001fff77d70] [c000000000009f84] ftrace_graph_caller+0x34/0x74
  [c0000001fff77de0] [c000000000118d70] handle_irq_event_percpu+0x90/0x2b0
  [c0000001fff77ea0] [c000000000118ffc] handle_irq_event+0x6c/0xd0
  [c0000001fff77ed0] [c00000000011e280] handle_fasteoi_irq+0xf0/0x2a0
  [c0000001fff77f00] [c000000000117f40] generic_handle_irq+0x50/0x80
  [c0000001fff77f20] [c000000000011228] __do_irq+0x98/0x1d0
  [c0000001fff77f90] [c000000000024074] call_do_irq+0x14/0x24
  [c0000001fb0e3a20] [c0000000000113f8] do_IRQ+0x98/0x140
  [c0000001fb0e3a60] [c0000000000025d0] hardware_interrupt_common+0x150/0x180
  --- interrupt: 501 at plpar_hcall_norets+0x1c/0x28
      LR = check_and_cede_processor+0x38/0x50
  [c0000001fb0e3d50] [c0000000008008c4] check_and_cede_processor+0x24/0x50 (unreliable)
  [c0000001fb0e3db0] [c000000000800aec] shared_cede_loop+0x6c/0x180
  [c0000001fb0e3df0] [c0000000007fdca4] cpuidle_enter_state+0x174/0x400
  [c0000001fb0e3e50] [c000000000104550] call_cpuidle+0x50/0xa0
  [c0000001fb0e3e70] [c000000000104b58] cpu_startup_entry+0x338/0x440
  [c0000001fb0e3f30] [c00000000004090c] start_secondary+0x35c/0x3a0
  [c0000001fb0e3f90] [c000000000008b6c] start_secondary_prolog+0x10/0x14
  Instruction dump:
  60000000 4bfe6c79 60000000 e8610020 38210030 e8010010 7c0803a6 4bffff30
  60420000 3c4c00ca 3842ff20 3d220010 <8869dfc0> 4e800020 60000000 60000000
  ---[ end trace 129c2895cb584df3 ]---

  Kernel panic - not syncing: Fatal exception in interrupt


That doesn't happen without your series applied, though that doesn't 100% mean
it's your bug. I haven't had time to dig any deeper.

> Stay tuned for v7...

Thanks.

cheers
