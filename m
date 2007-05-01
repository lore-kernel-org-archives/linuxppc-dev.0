Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE8BCDDF26
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 07:32:19 +1000 (EST)
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705011453380.4771@mtfhpc.demon.co.uk>
References: <20070430145414.88fda272.akpm@linux-foundation.org>
	<20070430.150407.07642146.davem@davemloft.net>
	<1177977619.24962.6.camel@localhost.localdomain>
	<20070430.173806.112621225.davem@davemloft.net>
	<Pine.LNX.4.61.0705010223040.3556@mtfhpc.demon.co.uk>
	<1177985136.24962.8.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705011453380.4771@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Wed, 02 May 2007 07:31:50 +1000
Message-Id: <1178055110.13263.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org,
	andrea@suse.de, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I have attached a patch (so pine does not mangle it) for linux-2.6.20.9.
> Is this what you had in mind?
> 
> For linux-2.6.21, more work will be needed as it has more code calling 
> ptep_set_access_flags.

I'm not 100% sure we need the 'update' argument... we can remove the
whole old_entry, pte_same, etc... and just have pte_set_access_flags()
read the old PTE and decide wether something needs to be changed or not.

Ben.
