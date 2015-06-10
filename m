Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B73B1A0E0A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 05:27:44 +1000 (AEST)
Message-ID: <1433964454.1495.58.camel@twins>
Subject: Re: question on FSL_EMB perf
From: Peter Zijlstra <peterz@infradead.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Wed, 10 Jun 2015 21:27:34 +0200
In-Reply-To: <1433963830.2477.136.camel@freescale.com>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
 <1433963830.2477.136.camel@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 14:17 -0500, Scott Wood wrote:
> On Wed, 2015-06-10 at 13:41 +0200, Peter Zijlstra wrote:
> > Hi Mike, Ben,
> >=20
> > I just noticed:
> >=20
> > arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS_NMI if PPC64
> >=20
> > But can't ppc32 have FSL_EMB perf?
>=20
> Yes, but it doesn't use NMIs.  ppc64 has lazy interrupt disabling=20
> which functions as a pseudo-NMI.

I know. But you can get the same nesting nonsense as with actual real
NMIs.

And seeing how you select HAVE_PERF_EVENT_NMI for PPC64, I figure you
ought to select it too for whatever fsl-emb is.

# git grep nmi_enter arch/powerpc/
arch/powerpc/perf/core-book3s.c:                nmi_enter();
arch/powerpc/perf/core-fsl-emb.c:               nmi_enter();
