Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C9327B6FBD
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 08:43:07 +1000 (EST)
Message-ID: <1339195362.24838.50.camel@pasglop>
Subject: Re: [PATCH 10/15] powerpc: fixes for instructions not using correct
 register naming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sat, 09 Jun 2012 08:42:42 +1000
In-Reply-To: <m2sje6t2y5.fsf@igel.home>
References: <1339155365.316308.981577666228.qpush@ale>
 <20120608113605.91B88D43B2F__24549.446340143$1339156128$gmane$org@localhost.localdomain>
 <m2sje6t2y5.fsf@igel.home>
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

On Fri, 2012-06-08 at 14:15 +0200, Andreas Schwab wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> >  	/* Invalidate all TLBs */
> > -	PPC_TLBILX_ALL(0,0)
> > +	PPC_TLBILX_ALL(R0,R0)
> 
> The first argument is (RA|0), so 0 is zero, not r0.

The macro system we use cannot do that (it will prefix with REG_), since
both arguments are registers we must use R0 in this case.

Cheers,
Ben.
