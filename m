Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97EA02C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 15:00:57 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 16 Aug 2012 01:00:54 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 95EC26E8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 01:00:52 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7G50pwg068742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 01:00:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7G50T6w031219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 02:00:30 -0300
Date: Thu, 16 Aug 2012 10:30:30 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120816050030.GA12060@in.ibm.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
 <1345066913.11751.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345066913.11751.4.camel@pasglop>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 Oleg Nesterov <oleg@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 16, 2012 at 07:41:53AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-08-15 at 18:59 +0200, Oleg Nesterov wrote:
> > On 07/26, Ananth N Mavinakayanahalli wrote:
> > >
> > > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > >
> > > This is the port of uprobes to powerpc. Usage is similar to x86.
> > 
> > I am just curious why this series was ignored by powerpc maintainers...
> 
> Because it arrived too late for the previous merge window considering my
> limited bandwidth for reviewing things and that nobody else seems to
> have reviewed it :-)
> 
> It's still on track for the next one, and I'm hoping to dedicate most of
> next week going through patches & doing a powerpc -next.

Thanks Ben!

> > Of course I can not review this code, I know nothing about powerpc,
> > but the patches look simple/straightforward.
> > 
> > Paul, Benjamin?
> > 
> > Just one question... Shouldn't arch_uprobe_pre_xol() forbid to probe
> > UPROBE_SWBP_INSN (at least) ?
> > 
> > (I assume that emulate_step() can't handle this case but of course I
> >  do not understand arch/powerpc/lib/sstep.c)
> > 
> > Note that uprobe_pre_sstep_notifier() sets utask->state = UTASK_BP_HIT
> > without any checks. This doesn't look right if it was UTASK_SSTEP...
> > 
> > But again, I do not know what powepc will actually do if we try to
> > single-step over UPROBE_SWBP_INSN.
> 
> Ananth ?

set_swbp() will return -EEXIST to install_breakpoint if we are trying to
put a breakpoint on UPROBE_SWBP_INSN. So, the arch agnostic code itself
takes care of this case... or am I missing something?

However, I see that we need a powerpc specific is_swbp_insn()
implementation since we will have to take care of all the trap variants.

I will need to update the patches based on changes being made by Oleg
and Sebastien for the single-step issues. Will incorporate the powerpc
specific is_swbp_insn() change along with the changes required for the
single-step part and send out the next version.

Ananth
