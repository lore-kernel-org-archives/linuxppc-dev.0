Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE6B4B719A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 19:18:43 +1000 (EST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE6E3DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 19:18:42 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5H9IYLF021631
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 14:48:34 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5H9IX7p3072066
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 14:48:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5H9IXOr017119
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 19:18:33 +1000
Message-ID: <4A38B4EA.20507@in.ibm.com>
Date: Wed, 17 Jun 2009 14:48:34 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix potential access to freed pages when
	using hugetlbfs
References: <20090616025419.A5581DDD1B@ozlabs.org>
In-Reply-To: <20090616025419.A5581DDD1B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> When using 64k page sizes, our PTE pages are split in two halves,
> the second half containing the "extension" used to keep track of
> individual 4k pages when not using HW 64k pages.
>
> However, our page tables used for hugetlb have a slightly different
> format and don't carry that "second half".
>
> Our code that batched PTEs to be invalidated unconditionally reads
> the "second half" (to put it into the batch), which means that when
> called to invalidate hugetlb PTEs, it will access unrelated memory.
>
> It breaks when CONFIG_DEBUG_PAGEALLOC is enabled.
>
> This fixes it by only accessing the second half when the _PAGE_COMBO
> bit is set in the first half, which indicates that we are dealing with
> a "combo" page which represents 16x4k subpages. Anything else shouldn't
> have this bit set and thus not require loading from the second half.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Thanks for the patch. The machine survived after two days of
testing with hugetlbfs tests.


Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
