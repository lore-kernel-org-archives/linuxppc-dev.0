Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B1BB367B5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 08:13:45 +1000 (EST)
Date: Tue, 1 Aug 2006 15:13:42 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Karol Lewandowski <kl@jasmine.eu.org>
Subject: Re: [BUG] ibm_emac: kernel panic with CONFIG_SLOB=y
Message-ID: <20060801221342.GA13171@gate.ebshome.net>
References: <20060801204011.GB1754@riddly.domek.prywatny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060801204011.GB1754@riddly.domek.prywatny>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 01, 2006 at 10:40:11PM +0200, Karol Lewandowski wrote:
> Hi,
> 
> I'm getting reproductible kernel panic when I use smaller SLOB
> allocator (instead of SLAB).  This is reproductible but very randomly
> -- sometimes it happens during bootup, sometimes few minutes later.
> 
> Hardware is custom board with IBM405EP (very close to Bubingna, just
> no RTC):
> 
> # cat /proc/cpuinfo
> processor	: 0
> cpu		: 405EP
> clock		: 200MHz
> revision	: 9.80 (pvr 5121 0950)
> bogomips	: 199.47
> machine		: MagicBox
> plb bus clock	: 100MHz
> pci bus clock	: 25MHz
> 
> Enabling SLAB instead of SLOB fixes this, so I assume this is driver
> issue.

This is probably the same issue  I had with SLAB debugging.

In short, those allocators aren't compatible with non-coherent cache 
archs (like 4xx), because driver assumes at least L1 cache line 
alignment for all allocated memory.

For more info, you can read this post:

http://ozlabs.org/pipermail/linuxppc-embedded/2006-February/022087.html

-- 
Eugene
