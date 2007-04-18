Return-Path: <benh@kernel.crashing.org>
Subject: Re: Fix breakage caused by tlb flush batch changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070418061948.GA29312@localhost.localdomain>
References: <20070418061948.GA29312@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 17:39:52 +1000
Message-Id: <1176881992.7639.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-18 at 16:19 +1000, David Gibson wrote:
> BenH's commit a741e67969577163a4cfc78d7fd2753219087ef1 in powerpc.git,
> although (AFAICT) only intended to affect ppc64, also has side-effects
> which break 44x.  I think 40x, 8xx and Freescale Book E are also
> affected, though I haven't tested them.
> 
> The problem lies in unconditionally removing flush_tlb_pending() from
> the versions of flush_tlb_mm(), flush_tlb_range() and
> flush_tlb_kernel_range() used on ppc64 - which are also used the
> embedded platforms mentioned above.
> 
> The patch below restores the necessary flushes and fixes the breakage
> for 44x.  They should also fix any breakage for the other platforms,
> but again I haven't tested those.

Damn, do these things use a batch at all ? If not, they should defkine
the whole set a functions separately rather than ifdef's like that...
flush_tlb_pending is a bad name for that.

Ben.
