Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B8ECB6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 16:39:45 +1000 (EST)
Message-ID: <1339051173.24838.10.camel@pasglop>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Thu, 07 Jun 2012 16:39:33 +1000
In-Reply-To: <4725.1339049104@neuling.org>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <1339017602.7150.174.camel@pasglop> <4725.1339049104@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: michael@ellerman.id.au, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 olof@lixom.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-07 at 16:05 +1000, Michael Neuling wrote:

> One problem with this is when we construct the instructions, like using
> anything from ppc-opcode.h.  eg. using PPC_POPCNTB would need to go from:
>     PPC_POPCNTB(r3,r3) 
> to:
>     PPC_POPCNTB(3,3) 
> Which is less readable IMHO.

Yes, I know. Not much to do about this, but it might still be worth it,
how much time wasted due to mixing up or with ori in asm somewhere ?

One option would be to #define R3 (or _r3) for use in those macros so
we still have something nicer than just "3"... oh well.

Cheers,
Ben.
