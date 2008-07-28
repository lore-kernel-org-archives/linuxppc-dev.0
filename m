Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CEB7DDF77
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:18:34 +1000 (EST)
Date: Sun, 27 Jul 2008 20:17:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: gigantci pages patches
Message-Id: <20080727201735.0b141250.akpm@linux-foundation.org>
In-Reply-To: <20080728010757.GF11318@yookeroo.seuss>
References: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
	<20080722033417.GD14888@yookeroo.seuss>
	<4886418C.9050704@linux.vnet.ibm.com>
	<20080728010757.GF11318@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: npiggin@suse.de, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jon Tollefson <kniht@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 11:07:57 +1000 David Gibson <dwg@au1.ibm.com> wrote:

> On Tue, Jul 22, 2008 at 03:22:36PM -0500, Jon Tollefson wrote:
> > David Gibson wrote:
> > > On Fri, Jul 11, 2008 at 05:45:15PM +1000, Stephen Rothwell wrote:
> > >   
> > >> Hi all,
> > >>
> > >> Could people take one last look at these patches and if there are no
> > >> issues, please send Ack-bys to Andrew who will push them to Linus for
> > >> 2.6.27.
> > >>
> > >> [PATCH 1/6 v2] allow arch specific function for allocating gigantic pages
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18437
> > >> Patch: [PATCH 2/6 v2] powerpc: function for allocating gigantic pages
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18438
> > >> Patch: [PATCH 3/6 v2] powerpc: scan device tree and save gigantic page locations
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18439
> > >> Patch: [PATCH 4/6 v2] powerpc: define page support for 16G pages
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18440
> > >> Patch: [PATCH 5/6 v2] check for overflow
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18441
> > >> Patch: [PATCH 6/6] powerpc: support multiple huge page sizes
> > >> http://patchwork.ozlabs.org/linuxppc/patch?&id=18442
> > >>     
> > >
> > > Sorry, I should have looked at these properly when they went past in
> > > May, but obviously I missed them.
> > >
> > > They mostly look ok.  I'm a bit confused on 2/6 though - it seems the
> > > new powerpc alloc_bootmem_huge_page() function is specific to the 16G
> > > gigantic pages.  But can't that function also get called for the
> > > normal 16M hugepages depending on how the hugepage pool is
> > > initialized.
> > >
> > > Or am I missing something (wouldn't surprise me given my brain's
> > > sluggishness today)?
> > >   
> > The alloc_bootmem_huge_page() function is only called for pages >=
> > MAX_ORDER.  The 16M pages are always allocated within the generic
> > hugetlbfs code with alloc_pages_node().
> 
> Ah, ok.  Well, in that case:
> 
> Acked-by: David Gibson <dwg@au1.ibm.com>
> 
> for the series

OK.  Although I'm no longer sure what patches "for the series" refers to.

I am currently retaining

powerpc-implement-pte_special.patch
powerpc-implement-pte_special-update.patch
powerpc-lockless-get_user_pages.patch

and frankly I'm unsure what the status is.  I have a note that benh had
concerns about powerpc-lockless-get_user_pages.patch, but iirc they
were waffly and vague ;)

So I'm thinking I'll stick these patches onto my send-to-ben list.
