Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 176DFB6FCC
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 17:17:32 +1000 (EST)
Message-ID: <1339226228.24838.74.camel@pasglop>
Subject: Re: [PATCH 10/15] powerpc: fixes for instructions not using correct
 register naming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sat, 09 Jun 2012 17:17:08 +1000
In-Reply-To: <m2boktnfh9.fsf@linux-m68k.org>
References: <1339155365.316308.981577666228.qpush@ale>
 <20120608113605.91B88D43B2F__24549.446340143$1339156128$gmane$org@localhost.localdomain>
 <m2sje6t2y5.fsf@igel.home> <1339195362.24838.50.camel@pasglop>
 <m2boktnfh9.fsf@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-06-09 at 08:53 +0200, Andreas Schwab wrote:
> 
> > The macro system we use cannot do that (it will prefix with REG_),
> since
> > both arguments are registers we must use R0 in this case.
> 
> So define a ___PPC_RA0 macro that doesn't do that.

But then we lose the checking for other instructions :-) Unless we start
being nasty and defining a different macro form for RA which can be 0...

I'd rather not go there unless we absolutely have to...

What would be nice also would be if we had a gas option to enforce the
use of % for register names. We'd probably have to struggle a little bit
with gcc inline asm in a case or two though.

Cheers,
Ben.
