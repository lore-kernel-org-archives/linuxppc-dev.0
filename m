Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWT5N5bT1zDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 23:19:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/18] powerpc/vas: Export HVWC to debugfs
In-Reply-To: <1507343298-27496-12-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1507343298-27496-12-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Tue, 07 Nov 2017 23:19:48 +1100
Message-ID: <871sla46xn.fsf@concordia.ellerman.id.au>
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
> index 23c13a7..088ce56 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -145,24 +145,42 @@ static void unmap_paste_region(struct vas_window *window)
>  }
>  
>  /*
> - * Unmap the MMIO regions for a window.
> + * Unmap the MMIO regions for a window. Hold the vas_mutex so we don't
> + * unmap when the window's debugfs dir is in use. This serializes close
> + * of a window even on another VAS instance but since its not a critical
> + * path, just minimize the time we hold the mutex for now. We can add
> + * a per-instance mutex later if necessary.
>   */
>  static void unmap_winctx_mmio_bars(struct vas_window *window)
>  {
>  	int len;
> +	void *uwc_map;
> +	void *hvwc_map;
>  	u64 busaddr_start;
>  
> +	mutex_lock(&vas_mutex);
> +
>  	if (window->hvwc_map) {
> -		get_hvwc_mmio_bar(window, &busaddr_start, &len);
> -		unmap_region(window->hvwc_map, busaddr_start, len);
> +		hvwc_map = window->hvwc_map;
>  		window->hvwc_map = NULL;
>  	}
>  
>  	if (window->uwc_map) {
> -		get_uwc_mmio_bar(window, &busaddr_start, &len);
> -		unmap_region(window->uwc_map, busaddr_start, len);
> +		uwc_map = window->uwc_map;
>  		window->uwc_map = NULL;
>  	}
> +
> +	mutex_unlock(&vas_mutex);
> +
> +	if (hvwc_map) {
> +		get_hvwc_mmio_bar(window, &busaddr_start, &len);
> +		unmap_region(hvwc_map, busaddr_start, len);
> +	}
> +
> +	if (uwc_map) {
> +		get_uwc_mmio_bar(window, &busaddr_start, &len);
> +		unmap_region(uwc_map, busaddr_start, len);
> +	}

arch/powerpc/platforms/powernv/vas-window.c: In function 'unmap_winctx_mmio_bars':
arch/powerpc/platforms/powernv/vas-window.c:137:2: error: 'uwc_map' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  iounmap(addr);
  ^
arch/powerpc/platforms/powernv/vas-window.c:168:8: note: 'uwc_map' was declared here
  void *uwc_map;
        ^
arch/powerpc/platforms/powernv/vas-window.c:137:2: error: 'hvwc_map' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  iounmap(addr);
  ^
arch/powerpc/platforms/powernv/vas-window.c:169:8: note: 'hvwc_map' was declared here
  void *hvwc_map;
        ^
cc1: all warnings being treated as errors


cheers
