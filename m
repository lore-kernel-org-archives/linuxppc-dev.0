Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Sep 2007 11:04:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Message-ID: <20070905010405.GA17189@localhost.localdomain>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<46DD500B.4020207@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46DD500B.4020207@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 01:31:07PM +0100, Matt Sealey wrote:
> 
> Gabriel Paubert wrote:
> > On Tue, Sep 04, 2007 at 12:09:22PM +0100, Matt Sealey wrote:
> >> Hi guys,
> >>
> >> The Solaris PPC code drop included most of these functions for 32-bit ops on
> >> 32-bit PPC architectures but the 64-bit operations are not present. What I
> >> a not clear on is the operation of lwarx and stwcx. and if they will work if
> >> you are doing operations on two words at a time.
> > 
> > No. There is a single reservation for a single word.
> 
> This is what I gathered from the programming environments manual at least.
> 
> > the 64 bit operations inside a spinlock on PPC32, and then select the
> > number /location of spinlock(s) based on your needs, from one global
> > per machine to one per 64 bit variable if you find excessive contention.
> 
> Okay that makes sense, but it would have to be a super global big lock,
> I don't think the code is there in ZFS to give every 64-bit variable it's
> own dedicated spinlock (kind of an overhaul) and I'm trying to be fast..

These aren't the only two options.  You could use a hashed array of
locks, based on the address where you're doing the atomic operation.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
