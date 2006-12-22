Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26382DDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Dec 2006 11:31:39 +1100 (EST)
In-Reply-To: <20061221222303.GA6418@localhost.localdomain>
References: <20061221222303.GA6418@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E5477CAE-3FE8-4441-9225-570DD0679765@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Date: Fri, 22 Dec 2006 01:31:26 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	William Lee Irwin <wli@holomorphy.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	if (len > TASK_SIZE)
> +		return -ENOMEM;

Shouldn't that be addr+len instead?  The check looks incomplete
otherwise.  And you meant ">=" I guess?

> -		/* Paranoia, caller should have dealt with this */
> -		BUG_ON((addr + len) > 0x100000000UL);
> -

Any real reason to remove the paranoia check?  If it's trivially
always satisfied, the compiler will get rid of it for you :-)

Cheers,


Segher
