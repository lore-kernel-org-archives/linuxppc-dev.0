Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPlsy69nlzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:03:34 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Fix IBM_ARCH_VEC_NRCORES_OFFSET value
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1465339861.3263.24.camel@kernel.crashing.org>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5757FB81.7040905@redhat.com>
Date: Wed, 8 Jun 2016 13:03:29 +0200
MIME-Version: 1.0
In-Reply-To: <1465339861.3263.24.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.06.2016 00:51, Benjamin Herrenschmidt wrote:
> Commit 7cc851039d643a2ee7df4d18177150f2c3a484f5
> "powerpc/pseries: Add POWER8NVL support to ibm,client-architecture-support call"
> introduced a regression by adding fields to the beginning of the
> ibm_architecture_vec structure without updating IBM_ARCH_VEC_NRCORES_OFFSET.
> 
> This causes the kernel to print a warning at boot and to fail to adjust
> the number of cores based on the number of threads before doing the CAS
> call to firmware.
> 
> This is quite a fragile piece of code sadly, we should try to find a way
> to avoid that hard coded offset at some point, but for now this fixes it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index ccd2037..6ee4b72 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -719,7 +719,7 @@ unsigned char ibm_architecture_vec[] = {
>  	 * must match by the macro below. Update the definition if
>  	 * the structure layout changes.
>  	 */
> -#define IBM_ARCH_VEC_NRCORES_OFFSET	125
> +#define IBM_ARCH_VEC_NRCORES_OFFSET	133
>  	W(NR_CPUS),			/* number of cores supported */
>  	0,
>  	0,

Yes, that should be the right offset now!

Please also add "Cc: stable@vger.kernel.org # v4.0+" to the patch since
the commit 7cc851039d64 did have that as well.

And sorry for breaking this!

Reviewed-by: Thomas Huth <thuth@redhat.com>
