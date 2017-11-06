Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVncw3nq2zDrKv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 20:41:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com
Cc: boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH v5 06/10] powerpc/opal: Rework the opal-async interface
In-Reply-To: <20171103024146.17086-7-cyrilbur@gmail.com>
References: <20171103024146.17086-1-cyrilbur@gmail.com>
 <20171103024146.17086-7-cyrilbur@gmail.com>
Date: Mon, 06 Nov 2017 20:41:18 +1100
Message-ID: <87h8u7bv7l.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
> index c43421ab2d2f..fbae8a37ce2c 100644
> --- a/arch/powerpc/platforms/powernv/opal-async.c
> +++ b/arch/powerpc/platforms/powernv/opal-async.c
> @@ -23,40 +23,45 @@
>  #include <asm/machdep.h>
>  #include <asm/opal.h>
>  
> -#define N_ASYNC_COMPLETIONS	64
> +enum opal_async_token_state {
> +	ASYNC_TOKEN_UNALLOCATED = 0,
> +	ASYNC_TOKEN_ALLOCATED,
> +	ASYNC_TOKEN_COMPLETED
> +};
> +
> +struct opal_async_token {
> +	enum opal_async_token_state state;
> +	struct opal_msg response;
> +};
>  
> -static DECLARE_BITMAP(opal_async_complete_map, N_ASYNC_COMPLETIONS) = {~0UL};
> -static DECLARE_BITMAP(opal_async_token_map, N_ASYNC_COMPLETIONS);
>  static DECLARE_WAIT_QUEUE_HEAD(opal_async_wait);
>  static DEFINE_SPINLOCK(opal_async_comp_lock);
>  static struct semaphore opal_async_sem;
> -static struct opal_msg *opal_async_responses;
>  static unsigned int opal_max_async_tokens;
> +static struct opal_async_token *opal_async_tokens;
>  
>  static int __opal_async_get_token(void)
>  {
>  	unsigned long flags;
> -	int token;
> +	int token = -EBUSY;
>  
>  	spin_lock_irqsave(&opal_async_comp_lock, flags);
> -	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
> -	if (token >= opal_max_async_tokens) {
> -		token = -EBUSY;
> -		goto out;
> +	for (token = 0; token < opal_max_async_tokens; token++) {
> +		if (opal_async_tokens[token].state == ASYNC_TOKEN_UNALLOCATED) {
> +			opal_async_tokens[token].state = ASYNC_TOKEN_ALLOCATED;
> +			goto out;
> +		}
>  	}
> -
> -	if (__test_and_set_bit(token, opal_async_token_map)) {
> -		token = -EBUSY;
> -		goto out;
> -	}
> -
> -	__clear_bit(token, opal_async_complete_map);
> -
>  out:
>  	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
>  	return token;
>  }

Resulting in:

 static int __opal_async_get_token(void)
 {
 	unsigned long flags;
+	int token = -EBUSY;
 
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	for (token = 0; token < opal_max_async_tokens; token++) {
+		if (opal_async_tokens[token].state == ASYNC_TOKEN_UNALLOCATED) {
+			opal_async_tokens[token].state = ASYNC_TOKEN_ALLOCATED;
+			goto out;
+		}
 	}
 out:
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 	return token;
 }

So when no unallocated token is found we return opal_max_async_tokens :(

I changed it to:

static int __opal_async_get_token(void)
{
	unsigned long flags;
	int i, token = -EBUSY;

	spin_lock_irqsave(&opal_async_comp_lock, flags);

	for (i = 0; i < opal_max_async_tokens; i++) {
		if (opal_async_tokens[i].state == ASYNC_TOKEN_UNALLOCATED) {
			opal_async_tokens[i].state = ASYNC_TOKEN_ALLOCATED;
			token = i;
			break;
		}
	}

	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
	return token;
}


>  
> +/*
> + * Note: If the returned token is used in an opal call and opal returns
> + * OPAL_ASYNC_COMPLETION you MUST opal_async_wait_response() before
                                     ^
                                     call


cheers
