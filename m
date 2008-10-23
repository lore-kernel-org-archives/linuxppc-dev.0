Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7542DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 13:43:01 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m9N2g1LC026864
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 13:42:01 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9N2gw3R289260
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 13:42:58 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9N2gv3t023506
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 13:42:58 +1100
Date: Thu, 23 Oct 2008 13:42:47 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Satya <satyakiran@gmail.com>
Subject: Re: hugetlbfs for ppc440 - kernel BUG
Message-ID: <20081023024247.GA25947@yookeroo.seuss>
References: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
	<1224622063.7654.265.camel@pasglop>
	<acbcf3840810211546s1d72dac0kabcf1285358efbdf@mail.gmail.com>
	<acbcf3840810211550q34dac858je6c114a924067d65@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acbcf3840810211550q34dac858je6c114a924067d65@mail.gmail.com>
Cc: kazutomo@mcs.anl.gov, edi@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2008 at 03:50:30PM -0700, Satya wrote:
> On Tue, Oct 21, 2008 at 3:46 PM, Satya <satyakiran@gmail.com> wrote:
> 
> > Ben,
> > Look here: http://www-unix.mcs.anl.gov/zeptoos/hugepages/
> >
> > thanks,
> > ./satya
> >
> >
> > On Tue, Oct 21, 2008 at 1:47 PM, Benjamin Herrenschmidt <
> > benh@kernel.crashing.org> wrote:
> >
> >> On Tue, 2007-07-10 at 13:38 -0500, Satya wrote:
> >> > hello,
> >> > I am trying to implement hugetlbfs on the IBM Bluegene/L IO node
> >> > (ppc440) and I have a big problem as well as a few questions to ask
> >> > the group. I patched a 2.6.21.6 linux kernel (manually) with Edi
> >> > Shmueli's hugetlbfs implementation (found here:
> >> > http://patchwork.ozlabs.org/linuxppc/patch?id=8427) for this. I did
> >> > have to make slight changes (described at the end) to make it work.
> >> > My test program is a shortened version of a sys v shared memory
> >> > example described in Documentation/vm/hugetlbpage.txt
> >>
> >> Hi !
> >>
> >> The patchwork link unfortunately didn't survive the transition to
> >> patchwork 2.
> >>
> >> Do you know what's the status of Hugetlb support for 44x ? Is there any
> >> plan to release that for upstream inclusion ?
> >>
> >> Cheers,
> >> Ben.
> >>
> >>
> >>
> 
> whoops, sorry for top-posting. Here is a patch that worked at that time:
> http://www-unix.mcs.anl.gov/zeptoos/hugepages/hugetlbpage_44x.patch
> 
> I didn't follow up after this to get it merged upstream. Also I don't know
> if hugetlb core has changed to deal with PTEs in high memory.

Ok, had a look at this.  It's had some tweaks since I last looked at
the bluegene hugepage/440 patch.  It still has the rather ugly
approach of storing the hugepage PTEs always at the bottom level, and
duplicating them umpteen times (including pointing multiple PMDs at a
single PTE page when the hugepage size exceeds the area mapped by a
PMD).  It also has the most serious bug I remember from the old
version - the DIRTY and ACCESSED handling is completely bogus, because
it doesn't keep the copies of the bits in the many copies of the PTEs
in sync.  Between the TLB miss rewrite that's happened in the meantime
and my patch to handle these from hugetlb_fault() it's at least now
easier to fix this bug.  Also the patch is arch/ppc based.

I'll try to sort this out in the near future.  I guess the only big
question is whether its important to support hugepage sizes < 2M.  For
hugepage sizes >=2M (16M and 256M) we can just make PMD pointers into
hugepage pointers with the addition of a suitable size field, as we do
for 40x.  For page sizes <2M things get more complicated because we
need some sort of second level hugepage tables (which may or may not
be distinct from the ordinary second level tables).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
