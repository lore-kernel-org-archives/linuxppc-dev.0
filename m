Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB87667D2E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 21:19:44 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA8AJYxT412670
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 10:19:34 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA8AMdec2662642
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 11:22:39 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA8AJYeP008967
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 11:19:34 +0100
In-Reply-To: <aday7qngiuf.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 8 Nov 2006 11:22:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Roland Dreier wrote on 07.11.2006 20:25:12:

>  > -   *mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
>  > +   *mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
>  > +      (physaddr & (~PAGE_MASK));
>
> I'm confused -- shouldn't ioremap() do the right thing even if
> physaddr isn't page-aligned?  Why is this needed?
>
>  - R.

ioremap maps 4k pages on 4k kernels and on 64k pages on 64k kernels. So far
the theory.

This is true for memory.

For mapped PCI or ebus registers things are a bit different.
Some PCI adapters expect that every other 4k page is a new area with
different meaning starts
(some PCI adapters are definetly ehca and mellanox here). The consequence
is you have to map
only 4k instead of 64k, otherwise you'd map 15 other "access areas" are
also mapped.

On POWER the ebus memory is mapped by H_ENTER.
The hypervisor checks for 4k page size on H_ENTER, reason see above.

The nopage handler now does seperate 4k H_ENTERs even for 64k pages in the
ebus area,
therefore we have to register a 64k page on a 64k boundary, and the nopage
triggers the right H_ENTER
as soon as we access the page at the right offset.

We plan to change that as soon as the base kernel can handle mixed
pagesizes in a more official way.

Christop R.
