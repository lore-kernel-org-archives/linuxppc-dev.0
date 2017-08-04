Return-Path: <srs0=ktdi=7g=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqLk26xKzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:38:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNqLk1LBQz8sy1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:38:06 +1000 (AEST)
Message-ID: <1501810658.2664.60.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: sjitindarsingh@gmail.com, Paul Mackerras <paulus@samba.org>,
 ben@codiert.org, Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard
 <anton@ozlabs.org>, stable@vger.kernel.org#3.12+
Date: Fri, 04 Aug 2017 11:37:38 +1000
In-Reply-To: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 14:54 +0530, Hari Bathini wrote:
> As linux,memory-limit node is set and also later used by the kernel,
> avoid endian conversions for this property.
> 
> Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
> Cc: stable@vger.kernel.org # 3.12+
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 613f79f..723df83 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -3180,9 +3180,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
>  	 * Fill in some infos for use by the kernel later on
>  	 */
>  	if (prom_memory_limit) {
> -		__be64 val = cpu_to_be64(prom_memory_limit);
>  		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
> -			     &val, sizeof(val));
> +			     &prom_memory_limit, sizeof(prom_memory_limit));
>  	}
>  #ifdef CONFIG_PPC64
>  	if (prom_iommu_off)

NACK. The device-tree is big endian by convention.

Ben.
