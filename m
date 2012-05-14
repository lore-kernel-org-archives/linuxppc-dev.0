Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AFF8B6FAA
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2012 06:50:00 +1000 (EST)
Message-ID: <1337028587.6727.19.camel@pasglop>
Subject: Re: [Patch][hw-breakpoint] Use generic hw-breakpoint interfaces for
 new PPC ptrace flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
Date: Tue, 15 May 2012 06:49:47 +1000
In-Reply-To: <20120514102438.GA31573@in.ibm.com>
References: <20120511084338.GA31696@in.ibm.com>
 <1336956822.6727.4.camel@pasglop> <20120514102438.GA31573@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-05-14 at 15:54 +0530, K.Prasad wrote:
> On Mon, May 14, 2012 at 10:53:42AM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2012-05-11 at 14:13 +0530, K.Prasad wrote:
> > 
> > > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > > +	int ret, len = 0;
> > > +	struct thread_struct *thread = &(child->thread);
> > > +	struct perf_event *bp;
> > > +	struct perf_event_attr attr;
> > > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> > 
> > "ret" is unused in that function, causing a warning which breaks the
> > build since we have -Werror. I'm fixing that locally but be more careful
> > next time please.
> > 
> > Ben.
> 
> Sorry about that warning, I clearly missed that. I guess you
> do a custom build with -Werror flag enabled, unlike what the normal
> Makefile does?

The normal Makefile has -Werror enabled on arch/powerpc, you are
probably using an older compiler that didn't warn on unused variables by
default.

Ben.
