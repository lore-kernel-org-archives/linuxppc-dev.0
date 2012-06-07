Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
In-reply-to: <1339017602.7150.174.camel@pasglop>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <1339017602.7150.174.camel@pasglop>
Date: Thu, 07 Jun 2012 16:05:04 +1000
Message-ID: <4725.1339049104@neuling.org>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2012-06-06 at 18:40 +0200, Segher Boessenkool wrote:
> > > +err1;	dcbz	r0,r3
> > 
> > There is no such instruction, you probably meant "dcbz 0,r3"?
> 
> This reminds me... what would happen if we changed all our
> 
> #define	r0	0
> #define	r1	1
> 
> etc... to:
> 
> #define r0	%r0
> #define r1	%r1
> 
> ?
> 
> I'm thinking it might help catch that sort of nasties (and some of them
> can be really nasty, such as inverting mfspr/mtspr arguments, or vs ori,
> etc... ). I'm sure we'd have a problem with a few macros & inline
> constructs but nothing we can't fix..

One problem with this is when we construct the instructions, like using
anything from ppc-opcode.h.  eg. using PPC_POPCNTB would need to go from:
    PPC_POPCNTB(r3,r3) 
to:
    PPC_POPCNTB(3,3) 
Which is less readable IMHO.

Mikey
