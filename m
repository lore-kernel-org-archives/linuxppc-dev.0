Return-Path: <agl@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A89667B84
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 02:08:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7VG8DFN019587
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:08:13 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7VG8C6T195892
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:08:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7VG8Bup009707
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:08:11 -0400
Subject: Re: [PATCH] fix NUMA interleaving for huge pages (was RE: libnuma
	interleaving oddness)
From: Adam Litke <agl@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20060831160052.GB23990@us.ibm.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com> <200608300919.13125.ak@suse.de>
	<20060830072948.GE5195@us.ibm.com>
	<Pine.LNX.4.64.0608301401290.4217@schroedinger.engr.sgi.com>
	<20060831060036.GA18661@us.ibm.com> <20060831160052.GB23990@us.ibm.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:08:05 -0500
Message-Id: <1157040485.7185.10004.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, lnxninja@us.ibm.com,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-31 at 09:00 -0700, Nishanth Aravamudan wrote:
> Since vma->vm_pgoff is in units of smallpages, VMAs for huge pages have
> the lower HPAGE_SHIFT - PAGE_SHIFT bits always cleared, which results in
> badd offsets to the interleave functions. Take this difference from
> small pages into account when calculating the offset. This does add a
> 0-bit shift into the small-page path (via alloc_page_vma()), but I think
> that is negligible. Also add a BUG_ON to prevent the offset from growing
> due to a negative right-shift, which probably shouldn't be allowed
> anyways.
> 
> Tested on an 8-memory node ppc64 NUMA box and got the interleaving I
> expected.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Adam Litke <agl@us.ibm.com>

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
