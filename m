Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400vcX5rYTzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:41:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 03/14] powerpc/64s: allocate lppacas individually
In-Reply-To: <20180213150824.27689-4-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-4-npiggin@gmail.com>
Date: Tue, 13 Mar 2018 23:41:46 +1100
Message-ID: <87woygf8qd.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
> index eeb13429d685..3fe126796975 100644
> --- a/arch/powerpc/platforms/pseries/kexec.c
> +++ b/arch/powerpc/platforms/pseries/kexec.c
> @@ -23,7 +23,12 @@
>  
>  void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
>  {
> -	/* Don't risk a hypervisor call if we're crashing */
> +	/*
> +	 * Don't risk a hypervisor call if we're crashing
> +	 * XXX: Why? The hypervisor is not crashing. It might be better
> +	 * to at least attempt unregister to avoid the hypervisor stepping
> +	 * on our memory.
> +	 */

Because every extra line of code we run in the crashed kernel is another
opportunity to screw up and not make it into the kdump kernel.

For example the hcalls we do to unregister the VPA might trigger hcall
tracing which runs a bunch of code and might trip up on something. We
could modify those hcalls to not be traced, but then we can't trace them
in normal operation.

And the hypervisor might continue to write to the VPA, but that's OK
because it's the VPA of the crashing kernel, the kdump kernel runs in a
separate reserved memory region.

Possibly we could fix the hcall tracing issues etc, but this code has
not given us any problems for quite a while (~13 years) - ie. there
seems to be no issue with re-registering the VPAs etc. in the kdump
kernel.

cheers
