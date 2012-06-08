Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4D3EB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 10:51:53 +1000 (EST)
Message-ID: <1339116697.24838.36.camel@pasglop>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 08 Jun 2012 10:51:37 +1000
In-Reply-To: <4FD0EA08.7040903@freescale.com>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <20120607030423.GA30053@drongo> <4FD0EA08.7040903@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, michael@ellerman.id.au,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 olof@lixom.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-07 at 12:51 -0500, Scott Wood wrote:
> 
> The assembler can't tell that you used r0 rather than 0, because
> that's
> handled by the preprocessor, but it seems like a bug (or at least lax
> error checking) that it accepts %r0 there, and that objdump decodes it
> as "dcbz r0,r3" rather than "dcbz 0,r3".

Well, this is the domain of bike shed painting :-) the syntax of the
instruction is:

	dcbz RA,RB

Now, of course, like other RA,RB pairs it has the semantic that

if RA = 0 then b <- 0
else           b <- (RA)
EA <- b + (RB)

If we were to be pendantic and our assembly could also enforce the use
of % for registers, I suppose it would make sense to require 0 rather
than %0 for those "RA" forms to make it absolutely clear that we are
talking about 0 and not r0 in this specific case, I agree, but in the
current shape of the asm, I don't think that's something to expect.

Cheers,
Ben.
