Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNtK36FThzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 13:51:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: sjitindarsingh@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ben@codiert.org,
 Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
In-Reply-To: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
Date: Fri, 04 Aug 2017 13:51:50 +1000
Message-ID: <8760e4q9bd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

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

As Ben said, this is not OK. The flat device tree is a data
structure with a specified format[1], we don't violate the spec just to
avoid an endian swap.

Is there an actual bug you're trying to solve?

cheers


[1]: https://www.devicetree.org/

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
