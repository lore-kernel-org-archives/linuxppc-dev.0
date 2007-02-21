Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070221002922.GG10231@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1172000736.22940.48.camel@localhost.localdomain>
	<1172001107.18571.127.camel@localhost.localdomain>
	<20070221002922.GG10231@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 11:40:57 +1100
Message-Id: <1172018457.18571.176.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2007-02-21 at 11:29 +1100, David Gibson wrote:
> On Wed, Feb 21, 2007 at 06:51:47AM +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2007-02-20 at 13:45 -0600, Adam Litke wrote:
> > > Your patch drops the pgoff check that prepare_hugepage_range used to
> > > check.  The misaligned_offset test in libhugetlbfs identified the
> > > problem.  The following patch (applied on top of yours) makes the
> > > problem go away.  I am not necessarily suggesting it's the correct
> > > fix... just concisely describing the problem.
> > 
> > Ok, I'll fold that into the patch. Ultimately, when I finally do the
> > generic changes, prepare_hugepage_range() will be going away. I will
> > either pass pgoff along to slice_g_u_a for it to validate the pgoff, or
> > I will let f_ops->mmap() be responsible of checking it. For SPEs, I do
> > the pgoff check there. Any reason tht wouldn't work for huge pages ?
> 
> Err... there was.  The trouble was the prepare() or
> get_unmapped_area() which could open new slices happens before the
> ->mmap() call, so we could have already converted segments,
> irreversibly, then have the mmap fail because of a bad alignment.  Now
> that slice conversions can go both ways, that might not be a
> significant problem any more.

Ok. I'll start working on the generic g_u_a changes and will try to make
sure I get that right there. In the meantime, Adam's patch is good.

Ben.
