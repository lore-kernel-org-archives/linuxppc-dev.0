Return-Path: <olof@lixom.net>
Date: Mon, 19 Feb 2007 14:15:20 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
Message-ID: <20070219201520.GA6776@lixom.net>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<20070219153315.GA5036@lixom.net>
	<1171913963.18571.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171913963.18571.33.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 06:39:23AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-02-19 at 09:33 -0600, Olof Johansson wrote:
> > On Mon, Feb 19, 2007 at 05:43:38PM +1100, Benjamin Herrenschmidt wrote:
> > > powerpc: Introduce address space "slices"
> > > 
> > > This patch provide some infrastructure that will allow proper creation
> > > of special VMAs with different page sizes on powerpc.
> > > 
> > > The basic issue is to be able to do what hugetlbfs does but with
> > > different page sizes for some other special filesystems, more
> > > specifically, my need is:
> > > 
> > >  - hugetlbfs should still work of course :-)
> > > 
> > >  - SPE local store mappings using 64K pages on a 4K base page size
> > > kernel on Cell
> > 
> > Why? What is the reason they can't use 4K pages?
> 
> Reduce TLB/ERAT trashing. SPE MMUs are fairly small, and in setups where
> an SPE maps all the others, we take a performance hit due to trashing
> with 4K pages.
>
> However, going to full 64K base page size has other
> drawbacks, especially in setups with little main memory.

Right. I was mostly wondering what the underlying reason for the
requirement was.


Thanks,

-Olof
