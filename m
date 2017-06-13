Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn4ls1YjyzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 19:51:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/14] powerpc/64s: interrupt replay balance the return
 branch predictor
In-Reply-To: <20170611235835.7400-7-npiggin@gmail.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-7-npiggin@gmail.com>
Date: Tue, 13 Jun 2017 19:51:19 +1000
Message-ID: <8737b4i5bc.fsf@concordia.ellerman.id.au>
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

> The __replay_interrupt code is branched to with bl, but the caller is
> returned to directly with rfid from the interrupt.
>
> Instead return to a return stub that returns to the caller with blr,
> which should do better with the return predictor.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a04ee0d7f88e..d55201625ea3 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1586,7 +1586,7 @@ _GLOBAL(__replay_interrupt)
>  	 * we don't give a damn about, so we don't bother storing them.
>  	 */
>  	mfmsr	r12
> -	mflr	r11
> +	LOAD_REG_ADDR(r11, __replay_interrupt_return)

Can you make it a local label, to make it clear nothing outside the file
returns to there, and to not clutter the symbol map?

cheers
