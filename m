Return-Path: <apw@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BAE967B6D
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 07:08:02 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6OL7wIP017626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:07:58 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6OL7wdK293750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 15:07:58 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6OL7vVF001483
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 15:07:57 -0600
Date: Mon, 24 Jul 2006 17:07:40 -0400
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: mpic discovery on JS20
Message-ID: <20060724210740.GA7139@kvasir.watson.ibm.com>
References: <20060720231601.GA24736@kvasir.watson.ibm.com>
	<1153726896.12748.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1153726896.12748.0.camel@localhost.localdomain>
From: Amos Waterland <apw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2006 at 05:41:36PM +1000, Michael Ellerman wrote:
> On Thu, 2006-07-20 at 19:16 -0400, Amos Waterland wrote:
> > Current Linus and Paulus trees do this on JS20 blades with SLOF:
> > 
> >  Failed to locate the MPIC interrupt controller
> >  PID hash table entries: 4096 (order: 12, 32768 bytes)
> >  Maple: Found RTC at IO 0x1070
> >  cpu 0x0: Vector: 700 (Program Check) at [c00000007ef83ab0]
> >      pc: c00000000002e0c8: .mpic_request_ipis+0x34/0xc8
> >      lr: c00000000036b484: .smp_mpic_probe+0x3c/0x58
> >      sp: c00000007ef83d30
> >     msr: 9000000000029032
> >    current = 0xc00000000194d610
> >    paca    = 0xc00000000038f180
> >      pid   = 1, comm = swapper
> >  kernel BUG in mpic_request_ipis at arch/powerpc/sysdev/mpic.c:1132!
> 
> Does this help?

Yes, it does to some degree.  Current paulus tree with your patch applied:

 Built 1 zonelists.  Total pages: 524288
 Kernel command line: 
 mpic: Setting up MPIC " MPIC     " version <unknown> at f8040000, max 28 CPUs
 mpic: ISU size: 516, shift: 10, mask: 3ff
 Badness in mpic_init at arch/powerpc/sysdev/mpic.c:875
 Call Trace:
 [C0000000004D3880] [C00000000000EEB8] .show_stack+0x68/0x1b0 (unreliable)
 [C0000000004D3920] [C00000000001D558] .program_check_exception+0x1cc/0x598
 [C0000000004D39F0] [C0000000000044EC] program_check_common+0xec/0x100
 --- Exception: 700 at .mpic_init+0x5c/0x784
     LR = .maple_init_IRQ+0x204/0x290
 [C0000000004D3CE0] [C0000000004D3DB0] init_thread_union+0x3db0/0x4000 
 [C0000000004D3DB0] [C00000000036C130] .maple_init_IRQ+0x204/0x290
 [C0000000004D3E80] [C000000000361A88] .init_IRQ+0x34/0x48
 [C0000000004D3EF0] [C00000000035B6E0] .start_kernel+0x154/0x2b8
 [C0000000004D3F90] [C0000000000084FC] .start_here_common+0x50/0x54
 mpic: Initializing for 251 sources
 mpic: Setting up HT PICs workarounds for U3/U4
 mpic:   - HT:01.0 [0xb8] vendor 1022 device 7450 has 4 irqs
 mpic:   - HT:02.0 [0xb8] vendor 1022 device 7450 has 4 irqs
 mpic:   - HT:03.0 [0xf0] vendor 1022 device 7460 has 24 irqs
 PID hash table entries: 4096 (order: 12, 32768 bytes)
 Maple: Found RTC at IO 0x1070
 cpu 0x0: Vector: 0  at [c00000007ef83940]
     pc: c0000000000216bc: .smp_call_function+0x18c/0x1e4
     lr: c0000000000216bc: .smp_call_function+0x18c/0x1e4
     sp: c00000007ef83ab0
    msr: 9000000000009032
   current = 0xc00000000194d610
   paca    = 0xc00000000038c180
     pid   = 1, comm = swapper

The warning is this:

         WARN_ON(mpic->num_sources > MPIC_VEC_IPI_0);
