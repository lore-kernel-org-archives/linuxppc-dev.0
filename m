Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRc125JDLzDr4m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 16:17:42 +1100 (AEDT)
In-Reply-To: <20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anju@linux.vnet.ibm.com, paulus@samba.org, gpiccoli@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Fix IMC allocation routine
Message-Id: <3yRc122gtGz9t2m@ozlabs.org>
Date: Wed,  1 Nov 2017 16:17:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 19:41:33 UTC, "Guilherme G. Piccoli" wrote:
> When setting nr_cpus=1, we observed a crash in IMC code during boot
> due to a missing allocation: basically, IMC code is taking the number
> of threads into account in imc_mem_init() and if we manually set
> nr_cpus for a value that is not multiple of the number of threads per
> core, an integer division in that function will discard the decimal
> portion, leading IMC to not allocate one mem_info struct. This causes
> a NULL pointer dereference later, on is_core_imc_mem_inited().
> 
> This patch just rounds that division up, fixing the bug.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0b167f11085a34281349f395d20005

cheers
