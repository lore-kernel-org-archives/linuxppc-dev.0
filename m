Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMxQb4MB2zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 17:08:38 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9Q64mo6044995
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:08:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2du49xe4jk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:08:35 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 26 Oct 2017 00:08:34 -0600
Date: Wed, 25 Oct 2017 23:08:26 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 3/7] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
 <87o9p3kedg.fsf@concordia.ellerman.id.au>
 <871slu9ro4.fsf@linux.vnet.ibm.com>
 <20171023162934.GA5454@ram.oc3035372033.ibm.com>
 <87d15b1t6u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d15b1t6u.fsf@concordia.ellerman.id.au>
Message-Id: <20171026060826.GB5485@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 25, 2017 at 11:18:49AM +0200, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > On Mon, Oct 23, 2017 at 02:17:39PM +0530, Aneesh Kumar K.V wrote:
> >> Michael Ellerman <mpe@ellerman.id.au> writes:
> >> > Ram Pai <linuxram@us.ibm.com> writes:
> ...
> >> > Should be:
> >> > 	/*
> >> > 	 * Initialize all hidx entries to invalid value, the first time
> >> >          * the PTE is about to allocate a 4K HPTE.
> >> > 	 */
> >> >
> >> >> +	if (!(old_pte & H_PAGE_COMBO))
> >> >> +		rpte.hidx = ~0x0UL;
> >> >> +
> >> >
> >> > Paul had the idea that if we biased the slot number by 1, we could make
> >> > the "invalid" value be == 0.
> >> >
> >> > That would avoid needing to that above, and also mean the value is
> >> > correctly invalid from the get-go, which would be good IMO.
> >> >
> >> > I think now that you've added the slot accessors it would be pretty easy
> >> > to do.
> >> 
> >> That would be imply, we loose one slot in primary group, which means we
> >> will do extra work in some case because our primary now has only 7
> >> slots. And in case of pseries, the hypervisor will always return the
> >> least available slot, which implie we will do extra hcalls in case of an
> >> hpte insert to an empty group?
> >
> > No. that is not the idea.  The idea is that slot 'F' in the seconday
> > will continue to be a invalid slot, but will be represented as
> > offset-by-one in the PTE.  In other words, 0 will be repesented as 1,
> > 1 as 2....   and  n as (n+1)%32
> 
> Right.
> 
> > The idea seems feasible.  It has the advantage -- where 0 in the PTE
> > means invalid slot. But it can be confusing to the casual code-
> > reader. Will need to put in a big-huge comment to explain that.
> 
> This code is already confusing to *any* reader, so I don't think it's a
> worry. :)

I just got it coded and working.  But I see no advantage implementing
the shifted-value. The hidx in the secondary-part of the pte, still
needs to be initialzed to all-zeros. Because it could contain the value of
the hidx corresponding the 64k-backed hpte, which needs to be cleared.

I will send the patch anyway.  But we should not apply it
for I see no apparent gain.

RP

> 
> cheers

-- 
Ram Pai
