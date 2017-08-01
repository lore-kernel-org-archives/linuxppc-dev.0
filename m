Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMWz81tRxzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 09:01:39 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u185so4421006pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 16:01:39 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5 2/2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <20170428055809.2675-2-matthew.brown.dev@gmail.com>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <20170428055809.2675-2-matthew.brown.dev@gmail.com>
Date: Wed, 02 Aug 2017 09:01:26 +1000
Message-ID: <878tj2sxix.fsf@linkitivity.dja.id.au>
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

Hi Matt,

> The raid6 Q syndrome check has been optimised using the vpermxor
> instruction.

Very much a nit, but normally we'd write the change that the patch makes
as a command: "Optimise the raid6 Q syndrome generation using the
vpermxor instruction" - see
https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html#describe-your-changes

> +static void noinline raid6_vpermxor$#_gen_syndrome_real(int disks, size_t bytes,
> +							void **ptrs)
> +{
> +	u8 **dptr = (u8 **)ptrs;
> +	u8 *p, *q;
> +	int d, z, z0;
> +	unative_t wp$$, wq$$, wd$$;
> +
> +	z0 = disks - 3;		/* Highest data disk */
> +	p = dptr[z0+1];		/* XOR parity */
> +	q = dptr[z0+2];		/* RS syndrome */
> +
> +	for (d = 0; d < bytes; d += NSIZE*$#) {
> +		wp$$ = wq$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE];
> +
> +		for (z = z0-1; z>=0; z--) {
> +			wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE];
> +			/* P syndrome */
> +			wp$$ = vec_xor(wp$$, wd$$);
> +
> +			/*Q syndrome */
> +			asm("vpermxor %0,%1,%2,%3":"=v"(wq$$):"v"(gf_high), "v"(gf_low), "v"(wq$$));

Initially I thought "why can't we break this over 2 lines?" and then I
remembered that the awk script can't handle that. A space between /* and
Q would be good though.

> +			wq$$ = vec_xor(wq$$, wd$$);

I generated some of the unrolled code and inspected it. It's non-trivial
to follow but that's justifiable, it's due to:
 - the complex maths
 - the unrolling process
 - consistency with the altivec code, which I think is worth keeping
I am not sure how you could make it any easier to read, so I don't think
that should block its acceptance into the kernel.

I am confident that this code works correctly and as described.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> -- 
> 2.9.3
