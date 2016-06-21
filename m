Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYZNh5sw7zDrqC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:23:48 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id l125so513606ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:23:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466414623.27324.2.camel@ellerman.id.au>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
 <1466116390.24271.27.camel@kernel.crashing.org>
 <1466127964.12899.5.camel@ellerman.id.au>
 <87eg7u8li9.fsf@skywalker.in.ibm.com>
 <1466414623.27324.2.camel@ellerman.id.au>
Date: Tue, 21 Jun 2016 07:23:46 +0300
Message-ID: <CAOJe8K3JANhLmwdg5Z_o=mfybYG+kv1q2o7cy0eUN57fUyQ_Vg@mail.gmail.com>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> How about this? Denis does this work?
>
> cheers
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S
> b/arch/powerpc/kernel/exceptions-64s.S
> index 4c9440629128..8bcc1b457115 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1399,11 +1399,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
>  	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
>
>  	mtlr	r10
> -BEGIN_MMU_FTR_SECTION
> -	b	2f
> -END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
>  	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> +BEGIN_MMU_FTR_SECTION
>  	beq-	2f
> +FTR_SECTION_ELSE
> +	b	2f
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
>
>  .machine	push
>  .machine	"power4"
>

Yeah, it works. Thanks

>
