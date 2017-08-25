Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdxXt2ZkzzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 20:02:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/12] powerpc/vas: Define vas_win_close() interface
In-Reply-To: <1503556688-15412-11-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-11-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 20:02:20 +1000
Message-ID: <87valct177.fsf@concordia.ellerman.id.au>
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

Hi Suka,

More comments :)

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index 2dd4b63..24288dd 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -879,11 +887,92 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
>  }
>  EXPORT_SYMBOL_GPL(vas_rx_win_open);
>  
> -/* stub for now */
> +static void poll_window_busy_state(struct vas_window *window)
> +{
> +	int busy;
> +	uint64_t val;
> +
> +retry:
> +	/*
> +	 * Poll Window Busy flag
> +	 */
> +	val = read_hvwc_reg(window, VREG(WIN_STATUS));
> +	busy = GET_FIELD(VAS_WIN_BUSY, val);
> +	if (busy) {
> +		val = 0;
> +		schedule_timeout(2000);

What's 2000?

That's in jiffies, so it's not a fixed amount of time.

But on a typical config that will be 20 _seconds_ ?!

But you haven't set the task state, so AFAIK it will just return
instantly.

And if there's a software/hardware bug and it never stops being busy,
then we have a softlockup. The other option would be print a big fat
warning and just not free the window. But maybe that doesn't work for
other reasons.

> +		goto retry;
> +	}
> +}
> +
> +static void poll_window_castout(struct vas_window *window)
> +{
> +	int cached;
> +	uint64_t val;
> +
> +	/* Cast window context out of the cache */
> +retry:
> +	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
> +	cached = GET_FIELD(VAS_WIN_CACHE_STATUS, val);
> +	if (cached) {
> +		val = 0ULL;
> +		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
> +		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
> +		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);

Sigh, I still don't like that macro :)

or:
		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), 1ull << 63);

> +
> +		schedule_timeout(2000);
> +		goto retry;
> +	}
> +}
> +
> +/*
> + * Close a window.
> + *
> + * See Section 1.12.1 of VAS workbook v1.05 for details on closing window:
> + *	- Disable new paste operations (unmap paste address)
> + *	- Poll for the "Window Busy" bit to be cleared
> + *	- Clear the Open/Enable bit for the Window.
> + *	- Poll for return of window Credits (implies FIFO empty for Rx win?)
> + *	- Unpin and cast window context out of cache
> + *
> + * Besides the hardware, kernel has some bookkeeping of course.
> + */
>  int vas_win_close(struct vas_window *window)
>  {
> -	return -1;
> +	uint64_t val;
> +
> +	if (!window)
> +		return 0;
> +
> +	if (!window->tx_win && atomic_read(&window->num_txwins) != 0) {
> +		pr_devel("VAS: Attempting to close an active Rx window!\n");
> +		WARN_ON_ONCE(1);
> +		return -EAGAIN;

EAGAIN means "if you do the same thing again it might work".

I don't think that's right here. The window is not in a state where it
can be freed, the caller needs to do something to fix that.

EBUSY would probably be more appropriate.


cheers
