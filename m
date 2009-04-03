Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id ED768DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 11:45:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc ptrace block-step
In-Reply-To: Benjamin Herrenschmidt's message of  Thursday,
	2 April 2009 16:26:56 +1100 <1238650016.17330.193.camel@pasglop>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1238650016.17330.193.camel@pasglop>
Message-Id: <20090403004450.F2166FC3AB@magilla.sf.frob.com>
Date: Thu,  2 Apr 2009 17:44:50 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The patch only implements it for "server/classic" processors, not BookE,
> thus it should probably only advertise it for these :-)
>
> Though it wouldn't be too hard to implement it for BookE using DBCR0:BRT
> (Branch Taken debug event) though it might need some careful fixups such
> as the one we have for single step regarding hitting exception entry
> code.

In that case, this code seems fairly mysterious:

> > +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> > +		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
> > +		regs->msr |= MSR_DE;

That doesn't already do whatever it is you described?

Can we assume now that you or someone else who knows what all that means
will take this up?


Thanks,
Roland
