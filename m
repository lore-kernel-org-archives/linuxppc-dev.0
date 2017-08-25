Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdykq2lhLzDrVk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 20:56:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] powerpc/vas: Define copy/paste interfaces
In-Reply-To: <1503556688-15412-13-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-13-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 20:56:01 +1000
Message-ID: <87shgfuda6.fsf@concordia.ellerman.id.au>
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

Hi Suka,

A few more things ...

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
> new file mode 100644
> index 0000000..7783bb8
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/copy-paste.h
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2016 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +/*
> + * Macros taken from tools/testing/selftests/powerpc/context_switch/cp_abort.c
> + */

These are both out of date, they're changed in v3.0B.

> +#define PASTE(RA, RB, L, RC) \
> +	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) \
> +			  | (L) << (31-10) | (RC) << (31-31))

You should define PPC_PASTE() in ppc-opcode.h

We already have PPC_INST_PASTE, so use that.

L and RC are gone.

> +
> +#define COPY(RA, RB, L) \
> +	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) \
> +			  | (L) << (31-10))

Use PPC_COPY().

> +
> +#define CR0_FXM		"0x80"

I don't think a #define for this helps readability.

> +#define CR0_SHIFT	28
> +#define CR0_MASK	0xF

Not used.

> +/*
> + * Copy/paste instructions:
> + *
> + *	copy RA,RB,L
> + *		Copy contents of address (RA) + effective_address(RB)
> + *		to internal copy-buffer.
> + *
> + *		L == 1 indicates this is the first copy.
> + *
> + *		L == 0 indicates its a continuation of a prior first copy.
> + *
> + *	paste RA,RB,L
> + *		Paste contents of internal copy-buffer to the address
> + *		(RA) + effective_address(RB)
> + *
> + *		L == 0 indicates its a continuation of a prior paste. i.e.
> + *		don't wait for the completion or update status.
> + *
> + *		L == 1 indicates this is the last paste in the group (i.e.
> + *		wait for the group to complete and update status in CR0).
> + *
> + *	For Power9, the L bit must be 'true' in both copy and paste.
> + */
> +
> +static inline int vas_copy(void *crb, int offset, int first)
> +{
> +	WARN_ON_ONCE(!first);

Please change the API to not require unused parameters.

Same for offset.

> +
> +	__asm__ __volatile(stringify_in_c(COPY(%0, %1, %2))";"

I've never seen __volatile before.

Just use: asm volatile


> +		:
> +		: "b" (offset), "b" (crb), "i" (1)
> +		: "memory");
> +
> +	return 0;
> +}
> +
> +static inline int vas_paste(void *paste_address, int offset, int last)
> +{
> +	unsigned long long cr;

cr is 32-bits actually.

> +	WARN_ON_ONCE(!last);
> +
> +	cr = 0;
> +	__asm__ __volatile(stringify_in_c(PASTE(%1, %2, 1, 1))";"
> +		"mfocrf %0," CR0_FXM ";"
> +		: "=r" (cr)
> +		: "b" (paste_address), "b" (offset)
> +		: "memory");

You need cr0 in the clobbers.

> +
> +	return cr;

I think it would be more natural if you just returned CR0, so if you did
shift and mask with the CR0 constants you have above.


> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index 70762c3..73081b4 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -1040,6 +1041,57 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
>  }
>  EXPORT_SYMBOL_GPL(vas_tx_win_open);
>  
> +int vas_copy_crb(void *crb, int offset, bool first)
> +{
> +	if (!vas_initialized())
> +		return -1;
> +
> +	return vas_copy(crb, offset, first);
> +}
> +EXPORT_SYMBOL_GPL(vas_copy_crb);
> +
> +#define RMA_LSMP_REPORT_ENABLE PPC_BIT(53)
> +int vas_paste_crb(struct vas_window *txwin, int offset, bool last, bool re)
> +{
> +	int rc;
> +	uint64_t val;
> +	void *addr;
> +
> +	if (!vas_initialized())
> +		return -1;

This is in the fast path, or at least the runtime path. So I don't think
these checks are wanted, how would we have got this far if vas wasn't
initialised?



cheers
