Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdwxd5BqyzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 19:35:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/12] powerpc/vas: Define helpers to alloc/free windows
In-Reply-To: <1503556688-15412-7-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-7-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 19:35:16 +1000
Message-ID: <878ti8uh0r.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index 3a50d6a..9c12919 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -490,6 +490,76 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
>  	return 0;
>  }
>  
> +DEFINE_SPINLOCK(vas_ida_lock);

static.

> +
> +void vas_release_window_id(struct ida *ida, int winid)

static.

> +{
> +	spin_lock(&vas_ida_lock);
> +	ida_remove(ida, winid);
> +	spin_unlock(&vas_ida_lock);
> +}
> +
> +int vas_assign_window_id(struct ida *ida)

static.

> +{
> +	int rc, winid;
> +
> +	rc = ida_pre_get(ida, GFP_KERNEL);
> +	if (!rc)
> +		return -EAGAIN;
> +
> +	spin_lock(&vas_ida_lock);
> +	rc = ida_get_new_above(ida, 0, &winid);

If you're passing 0 you can just use ida_get_new().

Or did you actually want to exclude 0? In which case you should pass 1.

> +	spin_unlock(&vas_ida_lock);
> +
> +	if (rc)
> +		return rc;

You're supposed to handle EAGAIN I thought.

> +
> +	if (winid > VAS_WINDOWS_PER_CHIP) {
> +		pr_err("VAS: Too many (%d) open windows\n", winid);
> +		vas_release_window_id(ida, winid);
> +		return -EAGAIN;
> +	}
> +
> +	return winid;
> +}
> +
> +void vas_window_free(struct vas_window *window)

static.

> +{
> +	int winid = window->winid;
> +	struct vas_instance *vinst = window->vinst;
> +
> +	unmap_winctx_mmio_bars(window);
> +	kfree(window);
> +
> +	vas_release_window_id(&vinst->ida, winid);
> +}
> +
> +struct vas_window *vas_window_alloc(struct vas_instance *vinst)
> +{
> +	int winid;
> +	struct vas_window *window;
> +
> +	winid = vas_assign_window_id(&vinst->ida);
> +	if (winid < 0)
> +		return ERR_PTR(winid);
> +
> +	window = kzalloc(sizeof(*window), GFP_KERNEL);
> +	if (!window)
> +		return ERR_PTR(-ENOMEM);

You leak an id here.

The error handling would be easier in here if the caller did the alloc,
or if you split alloc and init, and alloc just did the kzalloc().

One of the callers even prints "unable to allocate memory" if this
function fails, but that's not accurate, there's several failure modes.

> +
> +	window->vinst = vinst;
> +	window->winid = winid;
> +
> +	if (map_winctx_mmio_bars(window))
> +		goto out_free;
> +
> +	return window;
> +
> +out_free:
> +	kfree(window);

Leak an id here.

> +	return ERR_PTR(-ENOMEM);
> +}
> +
>  /* stub for now */
>  int vas_win_close(struct vas_window *window)
>  {
> -- 
> 2.7.4
