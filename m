Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt7bq142zzF1t1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 23:17:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: boot: add strrchr function
In-Reply-To: <20180301152654.29275-1-robh@kernel.org>
References: <20180301152654.29275-1-robh@kernel.org>
Date: Fri, 02 Mar 2018 23:17:41 +1100
Message-ID: <87h8pywu1m.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:

> libfdt gained a new dependency on strrchr, so copy the implementation
> from lib/string.c. Most of the string functions are in assembly, but
> stdio.c already has strnlen, so add strrchr there.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. This is a dependency for dtc/libfdt sync with upstream.

Yeah seems fine. At some point we should try and duplicate less code in
boot, but now is not that time.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
> index a701261b1781..98042eff7b26 100644
> --- a/arch/powerpc/boot/stdio.c
> +++ b/arch/powerpc/boot/stdio.c
> @@ -21,6 +21,16 @@ size_t strnlen(const char * s, size_t count)
>  	return sc - s;
>  }
>  
> +char *strrchr(const char *s, int c)
> +{
> +	const char *last = NULL;
> +	do {
> +		if (*s == (char)c)
> +			last = s;
> +	} while (*s++);
> +	return (char *)last;
> +}
> +
>  #ifdef __powerpc64__
>  
>  # define do_div(n, base) ({						\
> -- 
> 2.14.1
