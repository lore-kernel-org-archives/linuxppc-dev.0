Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id EBBF067CC4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 06:25:13 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
References: <200611052141.29030.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Nov 2006 11:25:12 -0800
In-Reply-To: <200611052141.29030.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's
	message of "Sun, 5 Nov 2006 21:41:28 +0100")
Message-ID: <aday7qngiuf.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > -	*mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
 > +	*mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
 > +		(physaddr & (~PAGE_MASK));

I'm confused -- shouldn't ioremap() do the right thing even if
physaddr isn't page-aligned?  Why is this needed?

 - R.
