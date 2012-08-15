Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C5EA2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 07:42:29 +1000 (EST)
Message-ID: <1345066913.11751.4.camel@pasglop>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 16 Aug 2012 07:41:53 +1000
In-Reply-To: <20120815165931.GA10059@redhat.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-08-15 at 18:59 +0200, Oleg Nesterov wrote:
> On 07/26, Ananth N Mavinakayanahalli wrote:
> >
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >
> > This is the port of uprobes to powerpc. Usage is similar to x86.
> 
> I am just curious why this series was ignored by powerpc maintainers...

Because it arrived too late for the previous merge window considering my
limited bandwidth for reviewing things and that nobody else seems to
have reviewed it :-)

It's still on track for the next one, and I'm hoping to dedicate most of
next week going through patches & doing a powerpc -next.

> Of course I can not review this code, I know nothing about powerpc,
> but the patches look simple/straightforward.
> 
> Paul, Benjamin?
> 
> Just one question... Shouldn't arch_uprobe_pre_xol() forbid to probe
> UPROBE_SWBP_INSN (at least) ?
> 
> (I assume that emulate_step() can't handle this case but of course I
>  do not understand arch/powerpc/lib/sstep.c)
> 
> Note that uprobe_pre_sstep_notifier() sets utask->state = UTASK_BP_HIT
> without any checks. This doesn't look right if it was UTASK_SSTEP...
> 
> But again, I do not know what powepc will actually do if we try to
> single-step over UPROBE_SWBP_INSN.

Ananth ?

Cheers,
Ben.
