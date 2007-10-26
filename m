Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D885DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 11:46:52 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20071024194640.GB19691@waste.org>
References: <20071024194640.GB19691@waste.org>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 11:46:42 +1000
Message-Id: <1193363202.7018.36.camel@pasglop>
Mime-Version: 1.0
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-24 at 14:46 -0500, Matt Mackall wrote:
> 
> My first suspicion was a dcache/icache coherency issue in
> copy_to_user_page, so I added flush_dcache_icache_page(page) here to
> no avail. On closer inspection, it looks like both icache and dcache
> are already being flushed by flush_icache_user_range().
> 
> Adding printk(".") (or any printk) in this function here fixes things
> (serial console at 115k), while printk("") and udelay(100) do not.
> Which still suggests an icache bug..?
> 
> Any suggestions?

I think you're hitting a known bug of 44x support. Those CPUs have a
crazy virtually tagged icache and the kernel doesn't deal with it at all
(pretty much...). We just are lucky things generally work :-)

That means among other things that flush_icache_* will not work because
they kmap pages and use that mapping. The only way to flush icache user
pages with 44x is to actually flush with the user virtual address
(meaning you have to be in the current context, and you probably need to
have a TLB entry there... yuck)... or just blow the whole icache away.

Try sticking an iccci in there and let me know if that helps.

Ben
