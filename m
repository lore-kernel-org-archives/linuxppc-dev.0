Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC4Sm6qGRzDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:53:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Fix the message in facility unavailable exception
In-Reply-To: <60df3f67-f217-378a-2244-319d265c0f1c@gmail.com>
References: <60df3f67-f217-378a-2244-319d265c0f1c@gmail.com>
Date: Mon, 07 Nov 2016 18:53:43 +1100
Message-ID: <87d1i7n2t4.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> I ran into this during some testing on qemu. The current
> facility_strings[] are correct when the trap address is
> 0xf80 (hypervisor facility unavailable). When the trap
> address is 0xf60, IC (Interruption Cause) a.k.a status
> in the code is undefined for values 0 and 1.

OK. But how did you generate an exception with an undefined status code?

> This patch
> adds a check to prevent printing the wrong information
> and helps better direct debugging effort.
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index d26605d..da0f634 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1520,8 +1520,14 @@ void facility_unavailable_exception(struct pt_regs *regs)
>  	}
>  
>  	if ((status < ARRAY_SIZE(facility_strings)) &&
> -	    facility_strings[status])
> -		facility = facility_strings[status];
> +	    facility_strings[status]) {
> +		if (!hv && status < 2) {
> +			pr_warn("Unexpected facility unavailable exception "
> +				"interruption cause %d\n", status);

Please don't add un-ratelimited printks() in this function, otherwise if
they're user triggerable (which some are) it gives the user a way to
scrub the kernel log.

> +			facility = "Unknown";
> +		} else
> +			facility = facility_strings[status];
> +	}

I think we should instead tighten the condition on that top-level if, and
have an else clause for all cases that uses "Unknown". eg.

	if ((hv || status >= 2) &&
            (status < ARRAY_SIZE(facility_strings)) &&
	    facility_strings[status])
        {
		facility = facility_strings[status];
        } else {
		facility = "Unknown";
        }

And then if you want to we can also print the hex status value in the
existing printk().

cheers
