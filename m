Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93CEFDDFB0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 00:06:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5JE6Xxi023901
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:06:33 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5JE6R2H193844
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:06:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5JE6Qjf006027
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:06:27 -0400
Date: Thu, 19 Jun 2008 10:04:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080619100405.61da19fa@zod.rchland.ibm.com>
In-Reply-To: <1213145431.25745.42.camel@pasglop>
References: <1213145431.25745.42.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 11 Jun 2008 10:50:31 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

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

I've looked this over quite a bit and can't find anything wrong with
it.  As soon as I get my boards set back up next week, I will try it
out on a few and see if I can find a good stress test as well.

If you could add the comments that Kumar suggested and send out an
updated patch, I'm inclined to get this into 2.6.27, but we should do
that soon if that is our target.

josh
