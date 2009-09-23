Return-Path: <dgibson@ozlabs.org>
Date: Thu, 24 Sep 2009 09:22:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/44x: Fix xmon single step on PowerPC 44x
Message-ID: <20090923232258.GC4804@yookeroo.seuss>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
	<20090923135156.GH14261@zod.rchland.ibm.com>
	<1253741674.7103.327.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253741674.7103.327.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2009 at 07:34:34AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-09-23 at 09:51 -0400, Josh Boyer wrote:
[snip]
> > +static int do_step(struct pt_regs *regs)
> > +{
> > +	regs->msr |= MSR_DE;
> > +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> 
> I'm not sure about setting IDM... Won't that be a problem if you have
> an external debugger connected ?

Not in theory.  It should be possible to set both IDM and EDM
simultaneously.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
