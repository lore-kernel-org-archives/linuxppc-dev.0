Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kmRq20sdzF3Nb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 13:30:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xive: Remove (almost) unused macros
In-Reply-To: <20180511080313.29815-1-ruscur@russell.cc>
References: <20180511080313.29815-1-ruscur@russell.cc>
Date: Mon, 14 May 2018 13:30:30 +1000
Message-ID: <877eo6rk15.fsf@concordia.ellerman.id.au>
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

Russell Currey <ruscur@russell.cc> writes:
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index b48454be5b98..3b471c0193ca 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -341,7 +341,7 @@ static void xive_native_update_pending(struct xive_cpu *xc)
>  	 * of the hypervisor interrupt (if any)
>  	 */
>  	cppr = ack & 0xff;
> -	he = GETFIELD(TM_QW3_NSR_HE, (ack >> 8));
> +	he = ((ack >> 8) & TM_QW3_NSR_HE) >> (ffs(TM_QW3_NSR_HE) - 1);

Using the #defines and ffs() here doesn't make the code any more
readable or maintainable.

We can just write:

	he = ack >> 14;

Or if we want to be more explicit about it being the top two bits of the
2nd byte:

	he = (ack >> 8) >> 6;


cheers
