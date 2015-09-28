Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AE9C1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 02:41:32 +1000 (AEST)
Message-ID: <1443458480.32298.173.camel@freescale.com>
Subject: Re: [PATCH 00/31] powerpc/mm: Update page table format for book3s 64
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 28 Sep 2015 11:41:20 -0500
In-Reply-To: <87zj07gn06.fsf@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442872135.19102.184.camel@freescale.com>
 <877fnj3q6m.fsf@linux.vnet.ibm.com>
 <1442905053.19102.228.camel@freescale.com>
 <87zj07gn06.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-28 at 10:26 +0530, Aneesh Kumar K.V wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
> > On Tue, 2015-09-22 at 12:18 +0530, Aneesh Kumar K.V wrote:
> > > Scott Wood <scottwood@freescale.com> writes:
> > > 
> > > > On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
> > > > > Hi All,
> > > > > 
> > > > > This patch series attempt to update book3s 64 linux page table 
> > > > > format to
> > > > > make it more flexible. Our current pte format is very restrictive 
> > > > > and we
> > > > > overload multiple pte bits. This is due to the non-availability of 
> > > > > free 
> > > > > bits
> > > > > in pte_t. We use pte_t to track the validity of 4K subpages. This 
> > > > > patch
> > > > > series free up pte_t of 11 bits by moving 4K subpage tracking to the
> > > > > lower half of PTE page. The pte format is updated such that we have 
> > > > > a
> > > > > better method for identifying a pte entry at pmd level. This will 
> > > > > also 
> > > > > enable
> > > > > us to implement hugetlb migration(not yet done in this series). 
> > > > > 
> > > > > Before making the changes to the pte format, I am splitting the
> > > > > pte header definition such that we now have the below layout for 
> > > > > headers
> > > > > 
> > > > > book3s
> > > > >    32
> > > > >      hash.h pgtable.h 
> > > > >    64
> > > > >      hash.h  pgtable.h hash-4k.h hash-64k.h
> > > > > booke
> > > > >   32
> > > > >      pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
> > > > >   64
> > > > >     pgtable-4k.h  pgtable-64k.h  pgtable.h
> > > > 
> > > > 40x and 8xx are not booke.  Is there a better name that can be used 
> > > > for 
> > > > this 
> > > > directory?  Maybe "nohash", similar to arch/powerpc/mm/tlb_nohash.c?
> > > > 
> > > 
> > > I looked at Documentation/powerpc/cpu_families.txt to name the headers.
> > > It lists then below booke.
> > 
> > It lists 40x as booke (there was some question about that when 
> > cpu_families.txt was added...  I guess you could call it "proto-booke", 
> > though it doesn't use CONFIG_BOOKE in Linux), but 8xx is in its own 
> > category.
> > 
> > In any case, "nohash" is the term used elsewhere.
> 
> How about using swtlb ? (nohash always confused me, It would be nice to
> be explict and us software tlb ?)

I'd prefer nohash.  Besides being existing practice (what's confusing about 
it?), e6500 is nohash but has a partial hw tlb, and 603 is considered hash 
despite having a software-loaded tlb.

-Scott
