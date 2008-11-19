Return-Path: <sonny@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D17D7DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 04:04:48 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAJH4Ugs005142
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 12:04:30 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAJH4dqJ098394
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 12:04:40 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAJH4KOa006806
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 12:04:21 -0500
Date: Wed, 19 Nov 2008 11:04:38 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20081119170438.GA16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
	<20081117072613.GO16240@us.ibm.com>
	<18723.37096.243151.673526@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18723.37096.243151.673526@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 19, 2008 at 03:07:04PM +1100, Paul Mackerras wrote:
> Sonny Rao writes:
> 
> > -	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
> > -			       size, vma->vm_page_prot))
> > +	/* check for the case of a small BSR device and map one 4k page for it*/
> > +	if (dev->bsr_len < PAGE_SIZE && size == PAGE_SIZE)
> > +		ret = remap_4k_pfn(vma, vma->vm_start, dev->bsr_addr >> 12,
> > +				   vma->vm_page_prot);
> 
> I think we should be checking that dev->bsr_len == 4096 here.
> 
> Paul.

Well, dev->bsr_len could be 4096 or 8192

-- 
Sonny Rao, LTC OzLabs, BML team
