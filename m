Return-Path: <axboe@kernel.dk>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 10DA2DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 22:00:22 +1100 (EST)
Date: Wed, 19 Nov 2008 11:58:33 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-ID: <20081119105833.GZ26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
	<20081119203922.0412c041.sfr@canb.auug.org.au>
	<20081119094300.GW26308@kernel.dk>
	<20081119213304.d2d21042.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081119213304.d2d21042.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 19 2008, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Wed, 19 Nov 2008 10:43:00 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
> >
> > On Wed, Nov 19 2008, Stephen Rothwell wrote:
> > > 
> > > Unable to handle kernel paging request for data at address 0x00000000
> > > Faulting instruction address: 0xc000000000503030
> > > cpu 0x0: Vector: 300 (Data Access) at [c00000000ffffa40]
> > >     pc: c000000000503030: ._spin_lock_irqsave+0x40/0x110
> > >     lr: c0000000002571f8: .blk_rq_timed_out_timer+0x48/0x190
> > >     sp: c00000000ffffcc0
> > >    msr: 8000000000009032
> > >    dar: 0
> > >  dsisr: 40000000
> > >   current = 0xc000000022d31040
> > >   paca    = 0xc000000000897300
> > >     pid   = 3399, comm = ckbcomp
> > > enter ? for help
> > > [c00000000ffffd50] c0000000002571f8 .blk_rq_timed_out_timer+0x48/0x190
> > > [c00000000ffffe00] c00000000006c2f4 .run_timer_softirq+0x1c4/0x2a0
> > > [c00000000ffffed0] c000000000065298 .__do_softirq+0xe8/0x1f0
> > > [c00000000fffff90] c000000000029224 .call_do_softirq+0x14/0x24
> > > [c000000022ad3c80] c00000000000d420 .do_softirq+0xf0/0x140
> > > [c000000022ad3d20] c0000000000654a4 .irq_exit+0x74/0x90
> > > [c000000022ad3da0] c000000000025844 .timer_interrupt+0x134/0x150
> > > [c000000022ad3e30] c000000000003700 decrementer_common+0x100/0x180
> > > --- Exception: 901 (Decrementer) at 000000000ff52440
> > 
> > That's even more weird, how could 'data' passed in to the timer ever be
> > 0? It's setup like this:
> 
> 'data' above is generic, not a variable name. The 0 is probably the

;-) I'm aware of that, I meant the 'timer' data argument. But you are
right, it's probably q->queue_lock being NULL here or we would have
oopsed earlier. There's no code line.

> address of the spinlock (though I need to check more to be sure) as it
> crashed inside _spin_lock_irqsave.

Do you know what device this might be? It still makes no sense, if the
timer was added, we went through the normal IO paths and we would have
crashed on NULL ->queue_lock much earlier.

-- 
Jens Axboe
