Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54B9E1A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 06:28:18 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B8FF140293
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 06:28:16 +1000 (AEST)
Message-ID: <1433967236.2477.146.camel@freescale.com>
Subject: Re: question on FSL_EMB perf
From: Scott Wood <scottwood@freescale.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Date: Wed, 10 Jun 2015 15:13:56 -0500
In-Reply-To: <1433964454.1495.58.camel@twins>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
 <1433963830.2477.136.camel@freescale.com> <1433964454.1495.58.camel@twins>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 21:27 +0200, Peter Zijlstra wrote:
> On Wed, 2015-06-10 at 14:17 -0500, Scott Wood wrote:
> > On Wed, 2015-06-10 at 13:41 +0200, Peter Zijlstra wrote:
> > > Hi Mike, Ben,
> > > 
> > > I just noticed:
> > > 
> > > arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS_NMI if PPC64
> > > 
> > > But can't ppc32 have FSL_EMB perf?
> > 
> > Yes, but it doesn't use NMIs.  ppc64 has lazy interrupt disabling 
> > which functions as a pseudo-NMI.
> 
> I know. But you can get the same nesting nonsense as with actual real
> NMIs.

What sort of "nesting nonsense" would we get on ppc32?  I wasn't 
trying to say that the pseudo-NMIs didn't count -- I was pointing out 
that we don't even have that on ppc32.

> And seeing how you select HAVE_PERF_EVENT_NMI for PPC64, I figure you
> ought to select it too for whatever fsl-emb is.

Why?

> # git grep nmi_enter arch/powerpc/
> arch/powerpc/perf/core-book3s.c:                nmi_enter();
> arch/powerpc/perf/core-fsl-emb.c:               nmi_enter();

nmi_enter() only gets called when perf_intr_is_nmi() returns non-zero, 
which only happens on ppc64.

-Scott
