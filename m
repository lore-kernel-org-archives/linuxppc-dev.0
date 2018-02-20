Return-Path: <cyrilbur@gmail.com>
Received: from mail-io0-x22c.google.com (mail-io0-x22c.google.com
 [IPv6:2607:f8b0:4001:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlrQb2ZZYzF0d8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 17:32:55 +1100 (AEDT)
Received: by mail-io0-x22c.google.com with SMTP id l12so8023043ioc.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 22:32:55 -0800 (PST)
Message-ID: <1519108367.6563.24.camel@gmail.com>
Subject: Re: [RFC PATCH 05/12] [WIP] powerpc/tm: Reclaim/recheckpoint on
 entry/exit
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 17:32:47 +1100
In-Reply-To: <1519104300.5655.2.camel@neuling.org>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-6-cyrilbur@gmail.com>
 <1519095033.7360.52.camel@neuling.org> <1519098854.6563.15.camel@gmail.com>
 <1519104300.5655.2.camel@neuling.org>
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

On Tue, 2018-02-20 at 16:25 +1100, Michael Neuling wrote:
> > > > @@ -1055,6 +1082,8 @@ void restore_tm_state(struct pt_regs *regs)
> > > >  	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
> > > >  	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
> > > >  
> > > > +	tm_recheckpoint(&current->thread);
> > > > +
> > > 
> > > So why do we do tm_recheckpoint at all? Shouldn't most of the tm_blah code go
> > > away in process.c after all this?
> > > 
> > 
> > I'm not sure I follow, we need to recheckpoint because we're going back
> > to userspace? Or would you rather calling the tm.S code directly from
> > the exception return path?
> 
> Yeah, I was thinking the point of this series was.  We do tm_reclaim right on
> entry and tm_recheckpoint right on exit.  
> 

Yeah that's the ultimate goal, considering I haven't been attacked or
offered more drugs I feel like what I've done isn't crazy. Your
feedback is great, thanks.

> The bits in between (ie. the tm_blah() calls process.c) would mostly go away.
> 
> 
> > Yes, I hope we'll be able to have a fairly big cleanup commit of tm_
> > code in process.c at the end of this series.
> 
> Yep, agreed.
> 
> Mikey
