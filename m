Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0B541A028C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:46:18 +1100 (AEDT)
Message-ID: <1452667571.1272.4.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv: Remove support for p5ioc2
From: Russell Currey <ruscur@russell.cc>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 13 Jan 2016 17:46:11 +1100
In-Reply-To: <5695F123.4070602@au1.ibm.com>
References: <1452665431-7880-1-git-send-email-ruscur@russell.cc>
 <5695F123.4070602@au1.ibm.com>
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

On Wed, 2016-01-13 at 17:39 +1100, Andrew Donnellan wrote:
> On 13/01/16 17:10, Russell Currey wrote:
> > "p5ioc2 is used by approximately 2 machines in the world, and has never
> > ever been a supported configuration."
> > 
> > The code for p5ioc2 is essentially unused and complicates what is already
> > a very complicated codebase.  Its removal is essentially a "free win" in
> > the effort to simplify the powernv PCI code.
> > 
> > In addition, support for p5ioc2 has been dropped from skiboot.  There's no
> > reason to keep it around in the kernel.
> > 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> Doesn't apply cleanly on next, but that's minor.
Going to do a V2 to address your other comment, so I might as well fix the next
issue.
> 
> > @@ -117,11 +115,6 @@ struct pnv_phb {
> > 
> >   	union {
> >   		struct {
> > -			struct iommu_table iommu_table;
> > -			struct iommu_table_group table_group;
> > -		} p5ioc2;
> > -
> > -		struct {
> >   			/* Global bridge info */
> >   			unsigned int		total_pe;
> >   			unsigned int		reserved_pe;
> 
> Given this leaves struct ioda as the only member of the union, do we 
> want to get rid of the union?
> 
Probably.  I was going to leave that for future patches (which will be a proper
refactoring rather than a pure removal), but given it makes no difference I
should just get rid of it now.

Thanks for the review.
