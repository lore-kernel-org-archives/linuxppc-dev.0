Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2nk23PqSzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 15:21:13 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so9601840pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 22:21:13 -0700 (PDT)
Date: Mon, 1 Aug 2016 15:21:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 08/11] powerpc: Add "mask_lvl" paramater to
 MASKABLE_* macros
Message-ID: <20160801152100.55b6c5f1@roar.ozlabs.ibm.com>
In-Reply-To: <1469991989-28409-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-9-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  1 Aug 2016 00:36:26 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Make it explicit the interrupt masking level supported
> by a gievn interrupt handler. Patch correspondingly
> extends the MASKABLE_* macros with an addition's parameter.
> "mask_lvl" parameter is passed to SOFTEN_TEST macro to decide
> on masking the interrupt.

Hey Madhavan,

It looks like this has worked quite nicely. I think you've
managed to avoid any additional instructions in fastpaths
if I'm reading correctly.

I will do a more comprehensive review, but I wanted to ask:


> @@ -426,79 +426,81 @@ label##_relon_hv:						\
>  #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
>  #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
>  
> -#define __SOFTEN_TEST(h, vec)						\
> +#define __SOFTEN_TEST(h, vec, mask_lvl)					\
>  	lbz	r10,PACASOFTIRQEN(r13);					\
> -	cmpwi	r10,IRQ_DISABLE_LEVEL_LINUX;				\
> +	andi.	r10,r10,mask_lvl;					\
>  	li	r10,SOFTEN_VALUE_##vec;					\
> -	bge	masked_##h##interrupt
> -#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
> +	bne	masked_##h##interrupt
> +#define _SOFTEN_TEST(h, vec, mask_lvl)	__SOFTEN_TEST(h, vec, mask_lvl)

We're talking about IRQ masking levels, but here it looks
like you're actually treating it as a mask.

I don't have a strong preference. Mask is more flexible, but
potentially constrained in how many interrupt types it can
cope with. That said, I doubt we'll need more than 8 mask bits
considering we've lived with one for years. So perhaps a mask
is a better choice. Ben, others, any preferences?

We should just use either "mask" or "level" everywhere, depending
on what we go with.

Thanks,
Nick
