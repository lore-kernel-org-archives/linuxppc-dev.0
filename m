Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0E1DDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:24:23 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id lA74NfHo007785
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:23:41 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lA74RHQl244920
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:27:17 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA74NHv4023811
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 15:23:18 +1100
Date: Wed, 7 Nov 2007 09:31:19 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: problem in follow_hugetlb_page on ppc64 architecture with
	get_user_pages
Message-ID: <20071106223119.GC31367@localhost.localdomain>
References: <OF6FC435A0.F59C9AD9-ONC125738B.002A5195-C125738B.002A424A@de.ibm.com>
	<200711061606.04402.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200711061606.04402.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 04:06:04PM +0100, Hoang-Nam Nguyen wrote:
> Hello Roland!
> > We currently see this when testing Infiniband on ppc64 with ehca +
> > hugetlbfs.
> > From reading the code this should also be an issue on other architectures.
> > Roland, Adam, are you aware of anything in this area with mellanox
> > Infiniband cards or other usages with I/O adapters?
> Below is a testcase demonstrating this problem. You need to install
> libhugetlbfs.so and run it as below:
> HUGETLB_MORECORE=yes LD_PRELOAD=libhugetlbfs.so ./hugetlb_ibtest 100
> 
> This testcase does the following steps (high level desc):
> 1. malloc two buffers each of 100MB for send and recv
> 2. register them as memory regions
> 3. create queue pair QP
> 4. send data in send buffer using QP to itself (target is then recv buffer)
> 5. compare those buffers content
> 
> It runs fine without libhugetlbsf. If you call it with libhugetlbfs as
> above, step 5 will fail. If you do memset() of the buffers before step 2
> (register mr), then it runs without errors.
> It appears that hugetlb_cow() is called when first write access is performed
> after mrs have been registered. That means the testcase is seeing other pages
> than the ones registered to the adapter...
> 
> I was able reproduce this with mthca on 2.6.23/ppc64 and fc6/intel.

We should cut this down to the bare necessary and fold it into the
libhugetlbfs testsuite.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
