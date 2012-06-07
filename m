Return-Path: <michael@ellerman.id.au>
Message-ID: <1339049882.2215.10.camel@concordia>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Thu, 07 Jun 2012 16:18:02 +1000
In-Reply-To: <5626.1339049529@neuling.org>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <1339017602.7150.174.camel@pasglop> <4725.1339049104@neuling.org>
 <1339049235.2215.2.camel@concordia> <5626.1339049529@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, Anton Blanchard <anton@samba.org>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-07 at 16:12 +1000, Michael Neuling wrote:
> Michael Ellerman <michael@ellerman.id.au> wrote:
> 
> > On Thu, 2012-06-07 at 16:05 +1000, Michael Neuling wrote:
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > > On Wed, 2012-06-06 at 18:40 +0200, Segher Boessenkool wrote:
> > > > > > +err1;	dcbz	r0,r3
> > > > > 
> > > > > There is no such instruction, you probably meant "dcbz 0,r3"?
> > > > 
> > > > This reminds me... what would happen if we changed all our
> > > > 
> > > > #define	r0	0
> > > > #define	r1	1
> > > > 
> > > > etc... to:
> > > > 
> > > > #define r0	%r0
> > > > #define r1	%r1
> > > > 
> > > > ?
> > > > 
> > > > I'm thinking it might help catch that sort of nasties (and some of them
> > > > can be really nasty, such as inverting mfspr/mtspr arguments, or vs ori,
> > > > etc... ). I'm sure we'd have a problem with a few macros & inline
> > > > constructs but nothing we can't fix..
> > > 
> > > One problem with this is when we construct the instructions, like using
> > > anything from ppc-opcode.h.  eg. using PPC_POPCNTB would need to go from:
> > >     PPC_POPCNTB(r3,r3) 
> > > to:
> > >     PPC_POPCNTB(3,3) 
> > 
> > #define R(x)	x
> 
> #define R(x)	(x) 
> 
> > #define PPC_POPCNTB(R(3), R(3))
> 
> Maybe, looks pretty gross but you're the maintainer! :-)

No I am not!


I agree it's fairly gross. But I'll take gross and correct over ungross
and buggy.

cheers
