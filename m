Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B714ADDF6D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 00:34:06 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBADTEXc001831
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 08:29:14 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBADXxFq164976
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 08:34:01 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBAEY8jg006577
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:34:08 -0500
Date: Wed, 10 Dec 2008 08:31:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/2] powerpc: 44x doesn't need G set everywhere
Message-ID: <20081210083143.62b869f4@zod.rchland.ibm.com>
In-Reply-To: <20081210055139.A7FFCDDF65@ozlabs.org>
References: <20081210055139.A7FFCDDF65@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008 16:50:50 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> After discussing with chip designers, it appears that it's not
> necessary to set G everywhere on 440 cores. The various core
> errata related to prefetch should be sorted out by firmware by
> disabling icache prefetching in CCR0. We add the workaround to
> the kernel however just in case oooold firmwares don't do it.
> 
> This is valid for -all- 4xx core variants. Later ones hard wire
> the absence of prefetch but it doesn't harm to clear the bits
> in CCR0 (they should already be cleared anyway).
> 
> We still leave G=1 on the linear mapping for now, we need to
> stop over-mapping RAM to be able to remove it.

Hm.  Over-mapping it has the nice advantage that we use as few pinned
TLB entries as possible.  For 440x6 cores with more than 256 MiB of
DRAM, you could theoretically use a single 1GiB TLB entry to map all
kernel DRAM.

Do you think the trade-offs of allowing speculative accesses are worth
the increased TLB pressure?  Large base pages will help with that in
some workloads, but others are still going to be TLB constrained.

I know, I'm probably paranoid.  But changing things like this around
without some kind of benchmark data or testcase to make sure we aren't
making it worse gives me the heebee-geebees.

josh
