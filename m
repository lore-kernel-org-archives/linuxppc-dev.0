Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEABADE451
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:04:22 +1000 (EST)
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <352560B5-24A4-47B8-8A1F-5900957470FC@kernel.crashing.org>
References: <20080708055449.EDFDADDEF5@ozlabs.org>
	<352560B5-24A4-47B8-8A1F-5900957470FC@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 06:04:16 +1000
Message-Id: <1215633856.8970.374.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 10:31 -0500, Kumar Gala wrote:
> > v3. Relying on the generic code to fixup _PAGE_ACCESSED doesn't
> > work for exec faults because our cache coherency code in
> > do_page_fault() will never go all the way to the generic code
> > for these. We fix it up by always setting _PAGE_ACCESSED when
> > setting _PAGE_HWEXEC in there.
> > This version of the patch is rebased on top of -next
> 
> shouldn't you remove _PAGE_HWWRITE from 40x?  (I'm still seeing it
> in  
> pgtable-ppc32.h and head_40x.S)

I haven't updated 40x at all yet.

Ben.
