Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5413EDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 23:33:22 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4CWmQd028446
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:32:48 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4CXID9196564
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:33:18 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4CXIxu018354
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 07:33:18 -0500
Date: Thu, 4 Dec 2008 07:33:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors v2
Message-ID: <20081204073314.2ee5d809@zod.rchland.ibm.com>
In-Reply-To: <20081204061341.C45CBDDDF6@ozlabs.org>
References: <20081204061341.C45CBDDDF6@ozlabs.org>
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

On Thu, 04 Dec 2008 17:12:59 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
> these processors. The result is that update_mmu_cache() would flush
> the cache for all pages mapped to userspace which is totally
> unnecessary on those processors since we already handle flushing
> on execute in the page fault path.
> 
> This should provide a nice speed up ;-)

Did you test it this time?  If so, how and what were the results?

josh
