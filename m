Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9240CDDE31
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 10:48:45 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m850mEI1010187
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 10:48:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m850mhSH235776
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 10:48:43 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m850mh7O015898
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 10:48:43 +1000
Date: Thu, 4 Sep 2008 16:22:50 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
Message-ID: <20080904062250.GF14704@yookeroo.seuss>
References: <20080902050510.GB12965@yookeroo.seuss>
	<48BD73FB.1050601@linux.vnet.ibm.com>
	<20080903002029.GC9681@yookeroo.seuss>
	<48BF0D6F.2010602@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BF0D6F.2010602@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 05:19:27PM -0500, Jon Tollefson wrote:
> David Gibson wrote:
> > On Tue, Sep 02, 2008 at 12:12:27PM -0500, Jon Tollefson wrote:
> >   
> >> David Gibson wrote:
> >>     
> >>> When BenH and I were looking at the new code for handling 16G pages,
> >>> we noticed a small bug.  It doesn't actually break anything user
> >>> visible, but it's certainly not the way things are supposed to be.
> >>> The 16G patches didn't update the huge_pte_offset() and
> >>> huge_pte_alloc() functions, which means that the hugepte tables for
> >>> 16G pages will be allocated much further down the page table tree than
> >>> they should be - allocating several levels of page table with a single
> >>> entry in them along the way.
> >>>
> >>> The patch below is supposed to fix this, cleaning up the existing
> >>> handling of 64k vs 16M pages while its at it.  However, it needs some
> >>> testing.
> >>>
> >>> I've checked that it doesn't break existing 16M support, either with
> >>> 4k or 64k base pages.  I haven't figured out how to test with 64k
> >>> pages yet, at least until the multisize support goes into
> >>> libhugetlbfs.  For 16G pages, I just don't have access to a machine
> >>> with enough memory to test.  Jon, presumably you must have found such
> >>> a machine when you did the 16G page support in the first place.  Do
> >>> you still have access, and can you test this patch?
> >>>   
> >>>       
> >> I do have access to a machine to test it.  I applied the patch to -rc4
> >> and used a pseries_defconfig.  I boot with
> >> default_hugepagesz=16G... in order to test huge page sizes other then
> >> 16M at this point.
> >>
> >> Running the libhugetlbfs test suite it gets as far as   Readback (64):  
> >> PASS
> >> before it hits the following program check.
> >>     
> >
> > Ah, yes, oops, forgot to fix up the pagetable freeing path in line
> > with the other changes.  Try the revised version below.
> >   
> I have run through the tests twice now with this new patch using a 4k
> base page size(and 16G huge page size) and there are no program checks
> or spin lock issues.  So looking good.
> 
> I will run it next a couple of times with 64K base pages.

Ok, and I've now run it with 64k hugepage size, so assuming this last
test of yours goes ok, I'll push the patch out.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
