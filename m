Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409VJt4Pb9zF24J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:13:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv/nvram: opal_nvram_write handle unknown
 OPAL errors
In-Reply-To: <20180326150233.23089-1-npiggin@gmail.com>
References: <20180326150233.23089-1-npiggin@gmail.com>
Date: Tue, 27 Mar 2018 23:13:00 +1100
Message-ID: <877epxk983.fsf@concordia.ellerman.id.au>
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

> opal_nvram_write currently just assumes success if it encounters an
> error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
> on other errors instead.

Does that ever happen with current skiboot?

Even if it doesn't I think I'm inclined to tag this for stable.

cheers

> diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
> index 9db4398ded5d..13bf625dc3e8 100644
> --- a/arch/powerpc/platforms/powernv/opal-nvram.c
> +++ b/arch/powerpc/platforms/powernv/opal-nvram.c
> @@ -59,6 +59,8 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
>  		if (rc == OPAL_BUSY_EVENT)
>  			opal_poll_events(NULL);
>  	}
> +	if (rc)
> +		return -EIO;
>  	*index += count;
>  	return count;
>  }
> -- 
> 2.16.1
