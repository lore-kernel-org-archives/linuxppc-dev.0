Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71D84DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 16:20:16 +1000 (EST)
Message-Id: <0C753631-7D6C-4A31-82B1-2540C012BCDB@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1213145431.25745.42.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC/PATCH] powerpc: rework 4xx PTE access and TLB miss
Date: Wed, 11 Jun 2008 01:20:01 -0500
References: <1213145431.25745.42.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 10, 2008, at 7:50 PM, Benjamin Herrenschmidt wrote:

> This is some preliminary work to improve TLB management on SW loaded
> TLB powerpc platforms. This introduce support for non-atomic PTE
> operations in pgtable-ppc32.h and removes write back to the PTE from
> the TLB miss handlers. In addition, the DSI interrupt code no longer
> tries to fixup write permission, this is left to generic code, and
> _PAGE_HWWRITE is gone.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> This is a first step, plan is to do the same for FSL BookE, 405 and
> possibly 8xx too. From there, I want to rework a bit the execute
> permission handling to avoid multiple faults, add support for
> _PAGE_EXEC (no executable mappings), for prefaulting (especially
> for kmap) and proper SMP support for future SMP capable BookE
> platforms.

You really should add some comment about what you are doing with the  
44x watermark.  As I look at this I'm not clear what that change is  
about and I'm sure in the future someone looking at this will  
wondering why this commit changed those bits.

Otherwise this all looks good (other than my other nit picking comments)

- k
