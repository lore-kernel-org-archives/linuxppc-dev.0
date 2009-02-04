Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B49BDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 16:14:16 +1100 (EST)
Date: Tue, 3 Feb 2009 21:13:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
Message-Id: <20090203211329.d6190a08.akpm@linux-foundation.org>
In-Reply-To: <1233712248.16867.131.camel@pasglop>
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eli Cohen <eli@mellanox.co.il>, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 04 Feb 2009 12:50:48 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2009-02-03 at 17:08 -0800, Roland Dreier wrote:
> > Forwarding Eli's patch below, since PowerPC guys may have missed it.  I
> > guess the question for Ben et al is whether there is any issue with
> > exporting HPAGE_SHIFT for modules (can be EXPORT_SYMBOL_GPL if you feel
> > it's an internal detail).  It would probably make sense to roll this
> > change into the mlx4 change that Eli alludes to below and merge through
> > my tree (with ppc maintainer acks of course), rather than splitting this
> > patch out and introducing cross-tree dependencies (and also separating
> > the rationale for the change from the change itself).
> > 
> > Thanks,
> >   Roland
> > 
> > 
> > Drivers may want to take advantage of the large pages used for memory obtained
> > from hugetlbfs. One example is mlx4_ib which can use much less MTT entries (in
> > the order of HPAGE_SIZE / PAGE_SIZE) when registering such memory, thus scale
> > significantly better when registering larger memory regions. Other drivers
> > could also benefit from this.
> 
> Except that we support multiple large page sizes nowadays ... I think
> the size can be specified per mountpoint of hugetlbfs no ? Thus things
> like mellanox would have to query the page size used for a given
> mapping.
> 
> Do the generic hugetlbfs code provides such an API ? If not, we may need
> to add one.
> 

I think it's something like

	huge_page_size(page_hstate(page))
