Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69C7D1A072A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 13:40:39 +1100 (AEDT)
Message-ID: <1427856038.4256.7.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fix memory corruption by
 pnv_alloc_idle_core_states
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jan Stancek <jstancek@redhat.com>
Date: Wed, 01 Apr 2015 13:40:38 +1100
In-Reply-To: <67174f780b3615749546d5a6d5bfba4c4f26a855.1427818011.git.jstancek@redhat.com>
References: <67174f780b3615749546d5a6d5bfba4c4f26a855.1427818011.git.jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, sbest@redhat.com,
 paulus@samba.org, shreyas@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 18:11 +0200, Jan Stancek wrote:
> Space allocated for paca is based off nr_cpu_ids,
> but pnv_alloc_idle_core_states() iterates paca with
> cpu_nr_cores()*threads_per_core, which is using NR_CPUS.
> 
> This causes pnv_alloc_idle_core_states() to write over memory,
> which is outside of paca array and may later lead to various panics.
> 
> Fixes: 7cba160ad789 (powernv/cpuidle: Redesign idle states management)
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thanks. I'll send that to Linus in the next day or two and mark it for stable
as well.

cheers
