Return-Path: <mikey@neuling.org>
To: John Rose <johnrose@austin.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: force 4k update_flash block and list sizes 
In-reply-to: <1162943615.13499.15.camel@sinatra.austin.ibm.com> 
References: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
Date: Wed, 08 Nov 2006 13:06:22 +1100
Message-ID: <20286.1162951582@neuling.org>
Sender: mikey@neuling.org
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +
> +	if (flash_block_cache) {
> +		rc = kmem_cache_destroy(flash_block_cache);
> +		if (rc)
> +			printk(KERN_WARNING "%s: cache memory leak\n",
> +					__FUNCTION__);
> +	}

kmem_cache_destroy doesn't return anything.  Hence we get:

arch/powerpc/kernel/rtas_flash.c: In function 'rtas_flash_cleanup':
arch/powerpc/kernel/rtas_flash.c:835: error: void value not ignored as it ought to be

Mikey
