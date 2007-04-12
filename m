Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/8] bootwrapper: help for 64 bit cpus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a965688ebce046ac66fe18168e0d24e1@kernel.crashing.org>
References: <boot-4-04.miltonm@bga.com>
	<a965688ebce046ac66fe18168e0d24e1@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 18:49:49 +1000
Message-Id: <1176367789.5764.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 09:43 +0200, Segher Boessenkool wrote:
> > +	/* We are in 64-bit mode.  This program must run in 32 bit
> > +	 * mode.  Assume we are actually running somewhere in the
> > +	 * low 32 bits of the address space, so we can just turn
> > +	 * off MSR[SF] which is bit 0.
> > +	 */
> > +	.machine push
> > +	.machine "ppc64"
> > +	rldicl	r0,r0,0,1
> > +	sync
> > +	mtmsrd	r0
> > +	isync
> > +	.machine pop
> 
> I'm not sure this actually works on all CPUs --
> aren't you supposed to use rfid for this?

Not for 32/64 bits switches afaik... as long as your PC is known to
fit in 32 bits, you don't generate an implicit branch.

Ben.
