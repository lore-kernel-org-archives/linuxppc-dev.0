Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19C8267AB6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Mar 2005 09:27:21 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
References: <1111645464.5569.15.camel@gaston>
	<6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 09:26:52 +1100
Message-Id: <1111789613.5569.69.camel@gaston>
Mime-Version: 1.0
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

On Thu, 2005-03-24 at 19:20 +0100, Segher Boessenkool wrote:
> > While experimenting with framebuffer access performances, we noticed a
> > very significant improvement in write access to it when not setting
> > the "guarded" bit on the MMU mappings. This bit basically says that
> > reads and writes won't have side effects (it allows speculation).
> 
> Unless the data is already in cache.
> 
> > It appears that it also disables write combining.
> 
> When the page is also cache-inhibited, it indeed does.
> 
> 
> Btw, did you ever get to fix the problem with mapping the last page
> of physical address space via /dev/mem ?

I don't think so, but I'll have to double check.

Ben.
