Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66C261A0681
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 20:17:32 +1100 (AEDT)
Message-ID: <1445159851.4271.1.camel@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: run eeb tests only on POWER8
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org
Date: Sun, 18 Oct 2015 20:17:31 +1100
In-Reply-To: <1445106671-5028-1-git-send-email-kda@linux-powerpc.org>
References: <1445106671-5028-1-git-send-email-kda@linux-powerpc.org>
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

On Sat, 2015-10-17 at 21:31 +0300, Denis Kirjanov wrote:

> Event Based Branches currenly available on POWER8.
> so we can skip them on other CPUs.

Thanks for the patch, but ..

> I've found that at least one test loops forever
> on 970MP (cycles_with_freeze_test).

Ooo interesting. The harness should kill it after a timeout.

> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> index d7a72ce..a252637 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> @@ -319,6 +319,19 @@ void ebb_global_disable(void)
>  	mb();
>  }
>  
> +#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF)
> +bool ebb_is_supported(void)
> +{
> +	unsigned long pvr;
> +
> +	__asm__ __volatile__("mfpvr %0" : "=b"(pvr));
> +	/* EBB requires at least POWER8 */
> +	if (PVR_VER(pvr) >= 0x004D)
> +		return true;
> +
> +	return false;
> +}

The right way to do this is not to look at the PVR but instead look at
AT_HWCAP2, and see if it contains PPC_FEATURE2_EBB.

You can see an example in tm-syscall.c

Can you please respin with that change?

cheers
