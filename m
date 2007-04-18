Return-Path: <dgibson@ozlabs.org>
Date: Wed, 18 Apr 2007 18:04:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fix breakage caused by tlb flush batch changes
Message-ID: <20070418080416.GA31443@localhost.localdomain>
References: <20070418061948.GA29312@localhost.localdomain>
	<1176881992.7639.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176881992.7639.2.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2007 at 05:39:52PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2007-04-18 at 16:19 +1000, David Gibson wrote:
> > BenH's commit a741e67969577163a4cfc78d7fd2753219087ef1 in powerpc.git,
> > although (AFAICT) only intended to affect ppc64, also has side-effects
> > which break 44x.  I think 40x, 8xx and Freescale Book E are also
> > affected, though I haven't tested them.
> > 
> > The problem lies in unconditionally removing flush_tlb_pending() from
> > the versions of flush_tlb_mm(), flush_tlb_range() and
> > flush_tlb_kernel_range() used on ppc64 - which are also used the
> > embedded platforms mentioned above.
> > 
> > The patch below restores the necessary flushes and fixes the breakage
> > for 44x.  They should also fix any breakage for the other platforms,
> > but again I haven't tested those.
> 
> Damn, do these things use a batch at all ? If not, they should defkine
> the whole set a functions separately rather than ifdef's like that...
> flush_tlb_pending is a bad name for that.

No they don't and yes they should.  I was planning to do such a
redefinition along with other cleanups related to splitting the MMU
related .h files up by CPU/MMU family.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
