Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 339B567A70
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2005 05:19:41 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j2OIJa0Q175882
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2005 18:19:36 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j2OIJZdS217444
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2005 19:19:35 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j2OIJZVc029238
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2005 19:19:35 +0100
In-Reply-To: <1111645464.5569.15.camel@gaston>
References: <1111645464.5569.15.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 24 Mar 2005 19:20:43 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> While experimenting with framebuffer access performances, we noticed a
> very significant improvement in write access to it when not setting
> the "guarded" bit on the MMU mappings. This bit basically says that
> reads and writes won't have side effects (it allows speculation).

Unless the data is already in cache.

> It appears that it also disables write combining.

When the page is also cache-inhibited, it indeed does.


Btw, did you ever get to fix the problem with mapping the last page
of physical address space via /dev/mem ?


Segher
