Return-Path: <robert.richter@amd.com>
Date: Fri, 9 May 2008 17:07:59 +0200
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev]  [PATCH] Updated: Reworked Cell OProfile: SPU
	mutex lock fix
Message-ID: <20080509150759.GL24041@erda.amd.com>
References: <1209587712.7531.42.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1209587712.7531.42.camel@carll-linux-desktop>
Cc: linuxppc-dev@ozlabs.org,
	oprofile-list <oprofile-list@lists.sourceforge.net>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please see my comments below.

-Roberta

On 30.04.08 13:35:12, Carl Love wrote:

[...]

> -int spu_sync_stop(void)
> +void spu_sync_stop(void)
>  {
>  	unsigned long flags = 0;
> -	int ret = spu_switch_event_unregister(&spu_active);
> -	if (ret) {
> -		printk(KERN_ERR "SPU_PROF: "
> -			"%s, line %d: spu_switch_event_unregister returned %d\n",
> -			__FUNCTION__, __LINE__, ret);
> -		goto out;
> -	}
> +
> +	/* Ignoring the return value from the unregister
> +	 * call.  A failed return value simply says there
> +	 * was no registered event.  Hence there will not
> +	 * be any calls to process a switch event that
> +	 * could cause a problem.
> +	 */
> +	spu_switch_event_unregister(&spu_active);

Better to use this here, to show the return value is ignored:

       (void)spu_switch_event_unregister(...)

>  
>  	spin_lock_irqsave(&cache_lock, flags);
> -	ret = release_cached_info(RELEASE_ALL);
> +	release_cached_info(RELEASE_ALL);

Dito.

>  	spin_unlock_irqrestore(&cache_lock, flags);
> -out:
>  	pr_debug("spu_sync_stop -- done.\n");
> -	return ret;
> +	return;
>  }
>  
>  
> Index: Cell_kernel_4_15_2008/arch/powerpc/oprofile/op_model_cell.c
> ===================================================================
> --- Cell_kernel_4_15_2008.orig/arch/powerpc/oprofile/op_model_cell.c
> +++ Cell_kernel_4_15_2008/arch/powerpc/oprofile/op_model_cell.c
> @@ -1191,15 +1191,15 @@ static int cell_sync_start(void)
>  	if (spu_cycle_reset)
>  		return spu_sync_start();
>  	else
> -		return DO_GENERIC_SYNC;
> +		return 0;
>  }
>  
> -static int cell_sync_stop(void)
> +static void cell_sync_stop(void)
>  {
>  	if (spu_cycle_reset)
> -		return spu_sync_stop();
> -	else
> -		return 1;
> +		spu_sync_stop();

Same here.

> +
> +	return;
>  }
>  
>  struct op_powerpc_model op_model_cell = {

[...]

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
