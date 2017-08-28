Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xggmD5hxjzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 15:48:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 01/10] powerpc: Handle most loads and stores in
 instruction emulation code
In-Reply-To: <1503639722-19121-2-git-send-email-paulus@ozlabs.org>
References: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
 <1503639722-19121-2-git-send-email-paulus@ozlabs.org>
Date: Mon, 28 Aug 2017 15:48:09 +1000
Message-ID: <87h8wss0o6.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> diff --git a/arch/powerpc/lib/quad.S b/arch/powerpc/lib/quad.S
> new file mode 100644
> index 0000000..2cc77dc
> --- /dev/null
> +++ b/arch/powerpc/lib/quad.S
> @@ -0,0 +1,62 @@
> +/*
> + * Quadword loads and stores
> + * for use in instruction emulation.
> + *
> + * Copyright 2017 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/processor.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/ppc-opcode.h>
> +#include <asm/reg.h>
> +#include <asm/asm-offsets.h>
> +#include <linux/errno.h>
> +
> +/* do_lq(unsigned long ea, unsigned long *regs) */
> +_GLOBAL(do_lq)
> +1:	lq	r6, 0(r3)
> +	std	r6, 0(r4)
> +	std	r7, 8(r4)
> +	li	r3, 0
> +	blr
> +2:	li	r3, -EFAULT
> +	blr
> +	EX_TABLE(1b, 2b)
> +
> +/* do_stq(unsigned long ea, unsigned long val0, unsigned long val1) */
> +_GLOBAL(do_stq)
> +1:	stq	r4, 0(r3)
> +	li	r3, 0
> +	blr
> +2:	li	r3, -EFAULT
> +	blr
> +	EX_TABLE(1b, 2b)
> +
> +/* do_lqarx(unsigned long ea, unsigned long *regs) */
> +_GLOBAL(do_lqarx)
> +1:	lqarx	r6, 0, r3

Older binutils barf on this, so we'll need to use a macro to generate it.

> +	std	r6, 0(r4)
> +	std	r7, 8(r4)
> +	li	r3, 0
> +	blr
> +2:	li	r3, -EFAULT
> +	blr
> +	EX_TABLE(1b, 2b)
> +
> +/* do_stqcx(unsigned long ea, unsigned long val0, unsigned long val1,
> +	    unsigned int *crp) */
> +
> +_GLOBAL(do_stqcx)
> +1:	stqcx.	r4, 0, r3

This too.

eg:
  arch/powerpc/lib/quad.S:42: Error: Unrecognized opcode: `lqarx'
  arch/powerpc/lib/quad.S:55: Error: Unrecognized opcode: `stqcx.'

cheers
