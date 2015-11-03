Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E13661A0A70
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:18:38 +1100 (AEDT)
Message-ID: <1446542318.23081.7.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 0/7] Remove 4k subpage tracking with hash 64K config
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Nov 2015 20:18:38 +1100
In-Reply-To: <87r3k7u0tf.fsf@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20151029030029.GA31681@fergus.ozlabs.ibm.com>
 <87r3k7u0tf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-03 at 10:38 +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> > On Wed, Oct 21, 2015 at 01:42:26AM +0530, Aneesh Kumar K.V wrote:
> > > Hi,
> > > 
> > > This patch series is on top of the series posted at 
> > > 
> > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135299.html
> > > "[PATCH V4 00/31] powerpc/mm: Update page table format for book3s 64". In this
> > > series we remove 4k subpage tracking with 64K config. Instead we do a hash
> > > table lookup to get the slot information of 4k hash ptes. This also allow us
> > > to remove real_pte_t. Side effect of the change is that a specific 4k slot
> > > lookup can result in multiple H_READ hcalls. But that should only impact
> > > when we are using 4K subpages which should be rare.
> > > 
> > > NOTE: I only tested this on systemsim. Wanted to get this out to get early
> > > feedback.
> > 
> > I tried this on a quad G5 and it seems to work just fine.  On a kernel
> > compile test there was very little difference in speed - I measured
> > about 0.4% slowdown but that may not be statistically significant.
> > This was with 64k pages configured and THP enabled.
> > 
> 
> I also ran mmtest configs/config-global-dhp__pagealloc-performance
> config with changes including this series. (ie, the changes tested
> include two patch series, one which change the pte format and this
> series). I am attaching the results below. I removed the pagealloc
> performance numbers from that because it was giving me all 00 which I
> assume is due to systemtap script issue.
> 
> We don't see any performance impact with the series and some of the
> performance change is withing the variance of test run as indicated by
> the numbers below. We do find less page fault and in some case better
> autonuma numbers 

Thanks for running those numbers.

For the record, it looks like you're running those on a bare metal Tuleta
system? What chip rev etc. is it. And how much memory does the system have
(that's probably somewhere below but just for easy reference).

I'll have to see if the boot failure I got on my G5 was actually related to
this or just something spurious.

cheers
