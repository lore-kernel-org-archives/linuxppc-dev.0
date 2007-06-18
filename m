Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 839BEDDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 00:08:45 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <46730D5B.300@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <891b0e086ebe9ebf85355f893f5dafa9@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 23/33] powerpc: Localize mmu_off 
Date: Mon, 18 Jun 2007 09:08:56 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jun 16 08:06:19 EST 2007, Geoff Levand wrote:
> This just removes the dependency __mmu_off has on the symbol
> __after_prom_start.  I found the current code inconvenient when I
> wanted to put some debugging code between the call to __mmu_off
> and the branch to __after_prom_start.

You are entering this code with the mmu on?

My first thought was that is unexpected, but aparently Apple machines 
do that, so its supported for the master -- not the slaves.

> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
> ---
>  arch/powerpc/kernel/head_64.S |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -1695,9 +1695,11 @@ _GLOBAL(__start_initialization_multiplat
>  2:
>
>         /* Switch off MMU if not already */
> -       LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
> +       LOAD_REG_IMMEDIATE(r4, __mmu_off_return - KERNELBASE)
>         add     r4,r4,r30
>         bl      .__mmu_off
> +__mmu_off_return:
> +
>         b       .__after_prom_start
>
>  _STATIC(__boot_from_prom)
>
> -- 

That seems like a long label.

I could stand a 1: there (ie a local numeric label).

Hmm... how about always going directly there:

-       bl      .__mmu_off
-       b       .__after_prom_start
+       mtlr    r4
+       b       .__mmu_off


So that there is no space to add code that is skipped if the mmu was on?

milton
