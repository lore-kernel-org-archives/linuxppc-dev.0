Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23C991A0311
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 14:51:09 +1100 (AEDT)
Date: Fri, 4 Mar 2016 21:50:54 -0600
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, scottwood@freescale.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20160305035054.GA5277@home.buserror.net>
References: <807dbc9449077e36752c649c09ae1c0d70e45254.1442876807.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <807dbc9449077e36752c649c09ae1c0d70e45254.1442876807.git.christophe.leroy@c-s.fr>
Subject: Re: [4/9] powerpc: inline ip_fast_csum()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 04:34:25PM +0200, Christophe Leroy wrote:
> @@ -137,6 +130,45 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
>  #endif
>  }
>  
> +/*
> + * This is a version of ip_compute_csum() optimized for IP headers,
> + * which always checksum on 4 octet boundaries.  ihl is the number
> + * of 32-bit words and is always >= 5.
> + */
> +static inline __wsum ip_fast_csum_nofold(const void *iph, unsigned int ihl)
> +{
> +	u32 *ptr = (u32 *)iph + 1;

const?

> +#ifdef __powerpc64__
> +	unsigned int i;
> +	u64 s = *(__force u32 *)iph;

const?
Why __force?

> +	s += (s >> 32);
> +	return (__force __wsum)s;
> +
> +#else
> +	__wsum sum, tmp;
> +
> +	asm("mtctr %3;"
> +	    "addc %0,%4,%5;"
> +	    "1:lwzu %1, 4(%2);"
> +	    "adde %0,%0,%1;"
> +	    "bdnz 1b;"
> +	    "addze %0,%0;"
> +	    : "=r"(sum), "=r"(tmp), "+b"(ptr)
> +	    : "r"(ihl - 2), "r"(*(u32 *)iph), "r"(*ptr)
> +	    : "ctr", "xer", "memory");

Space between " and (
Space after :
const in cast

I've fixed these up while applying.

-Scott
