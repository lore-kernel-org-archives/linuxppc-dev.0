Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E2A67A3F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 07:57:36 +1000 (EST)
Subject: Re: Collecting hypervisor call stats
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200606012014.20467.arnd.bergmann@de.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<20060531225813.GC7909@w-mikek2.ibm.com>
	<1149139576.28307.28.camel@localhost.localdomain>
	<200606012014.20467.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 07:57:23 +1000
Message-Id: <1149199043.16202.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-01 at 20:14 +0200, Arnd Bergmann wrote:
> On Thursday 01 June 2006 07:26, Benjamin Herrenschmidt wrote:
> > 
> > > We need to get a timestamp before and after the call.  mftb should do
> > > the trick.  Also, I'd prefer to have the code that stuffs the values
> > > into the array be C.  So, the decision is to have the assembly code
> > > call out to the C routine -OR- create wrappers for the assembly routines.
> > > I much prefer C wrappers to touching the assembly.
> > 
> > Argh... yet another use of mftb for which I'll need a cell specific
> > workaround 
> 
> I guess for statistics, we should rather avoid that overhead (and
> document the fact that we did on purpose).

Well.. if we can at one point "detect" the totally bogus value (the
timestamp going massively backward) and fix it up there, ok. Might be an
option.

> How fast is mftb really? Would that be significant compared to the
> time spent in a fast hcall?

Not sure, I would expect a few dozens cycles at least though... 

Ben.
