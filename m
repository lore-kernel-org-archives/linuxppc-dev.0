Return-Path: <agl@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0B4067B64
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 04:13:11 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UID6tv030021
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:13:06 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7UID6po280858
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:13:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7UID6tA032111
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:13:06 -0400
Subject: Re: libnuma interleaving oddness
From: Adam Litke <agl@us.ibm.com>
To: Tim Pepper <tpepper@gmail.com>
In-Reply-To: <eada2a070608301101j205b2711va5c287dbf8aab492@mail.gmail.com>
References: <20060829231545.GY5195@us.ibm.com>
	<200608300919.13125.ak@suse.de> <20060830072948.GE5195@us.ibm.com>
	<200608300932.23746.ak@suse.de>
	<eada2a070608301101j205b2711va5c287dbf8aab492@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 13:13:05 -0500
Message-Id: <1156961585.7185.8680.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Nishanth Aravamudan <nacc@us.ibm.com>,
	Andi Kleen <ak@suse.de>, linuxppc-dev@ozlabs.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-30 at 11:01 -0700, Tim Pepper wrote:
> On 8/30/06, Andi Kleen <ak@suse.de> wrote:
> > Then it's probably some new problem in hugetlbfs.
> 
> It's something subtle though, because I _am_ able to get interleaving
> on hugetlbfs with a slightly simplified test case (see previous email)
> compared to Nish's.
> 
> > Does it work with shmfs?
> 
> Haven't tried shmfs, but the following correctly does the expected
> interleaving with hugepages (although not hugetlbfs backed):
>      shmid = shmget( 0, NR_HUGE_PAGES, IPC_CREAT | SHM_HUGETLB | 0666 );
>      shmat_addr = shmat( shmid, NULL, 0 );
>      ...
>      numa_interleave_memory( shmat_addr, SHM_SIZE, &nm );
> I'd expect it works fine with non-huge pages, shmfs.

Actually, the above call will yield hugetlbfs backed huge pages.  The
kernel just prepares the hugetlbfs file for you.  See
hugetlb_zero_setup().

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
