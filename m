Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3GJs53f9zDqRB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 16:50:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()
In-Reply-To: <1484104609-22129-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1484104609-22129-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Wed, 18 Jan 2017 16:49:58 +1100
Message-ID: <87wpdsapdl.fsf@concordia.ellerman.id.au>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> In __eeh_clear_pe_frozen_state(), we should pass the flag's value
> instead of its address to eeh_unfreeze_pe(). This doesn't introduce
> any problems, but the code is just wrong.

It means any caller that passes false, will be getting the wrong
behaviour. eg. I see at least one call in eeh_reset_device() which
passes false to eeh_clear_pe_frozen_state(), which is then passed to
__eeh_clear_pe_frozen_state().

But I guess you're saying that caller doesn't actually see a bug because
of this?

> This fixes the code by passing flag's value to eeh_unfreeze_pe().
>
> Cc: stable@vger.kernel.org #3.18+
> Fixes: 5cfb20b96f6 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index d88573b..fa15fa6 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -549,7 +549,7 @@ static void *__eeh_clear_pe_frozen_state(void *data, void *flag)

	bool *clear_sw_state = flag;

>  	int i, rc = 1;
>  
>  	for (i = 0; rc && i < 3; i++)
> -		rc = eeh_unfreeze_pe(pe, clear_sw_state);
> +		rc = eeh_unfreeze_pe(pe, *clear_sw_state);


I think it would be better to just do the dereference once:

	bool clear_sw_state = *(bool *)flag;
	int i, rc = 1;

	for (i = 0; rc && i < 3; i++)
		rc = eeh_unfreeze_pe(pe, clear_sw_state);


cheers
