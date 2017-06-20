Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wskTv3GD6zDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 09:25:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KNNYXG066441
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:25:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7an7dsv8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:25:21 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 17:25:19 -0600
Date: Tue, 20 Jun 2017 16:25:07 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC v2 02/12] powerpc: Free up four 64K PTE bits in 64K backed
 hpte pages.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
 <ff6fe458-6539-e237-4556-41872385815a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff6fe458-6539-e237-4556-41872385815a@linux.vnet.ibm.com>
Message-Id: <20170620232507.GG17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 04:21:45PM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:22 AM, Ram Pai wrote:
> > Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> > in the 64K backed hpte pages. This along with the earlier
> > patch will entirely free up the four bits from 64K PTE.
> > 
> > This patch does the following change to 64K PTE that is
> > backed by 64K hpte.
> > 
> > H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> >         of the pte.
> > H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> >         second part of the pte.
> > 
> > since bit 7 is now freed up, we move H_PAGE_BUSY from bit 9
> > to bit 7. Trying to minimize gaps so that contiguous bits
> > can be allocated if needed in the future.
> > 
> > The second part of the PTE will hold
> > (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> 
> I still dont understand how we freed up the 5th bit which is
> used in the 5th patch. Was that bit never used for any thing
> on 64K page size (64K and 4K mappings) ?

yes. it was not used. So I gladly used it :-)


RP
