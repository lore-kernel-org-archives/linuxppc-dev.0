Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77697606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PtgZ+U9a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJn8F1hYXz2xSS;
	Tue, 03 Nov 2026 22:55:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793706941;
	cv=none; b=AHzqAKbU8mIfbng+hOSf853V54v7+ChdBPJfKG7h+y9QiYBZtfReiAqGkfR8LghOxNd5c/hvWD6HTHW7sN405mBfzCV0+dLaF0azPJNJe73EJWroOo0Tq/qbARpGPcwQyNpGI8g0ua5f+W6oS20wkra92fyTOrcdikKw151K9SEY/OjawMbTBl4i2m+uk4UKEA7OydkMVSgI34PBfBUKDtc4vfqmsHBdHCyxKEe9zGQXsmQHcbmX/oPgouHTJb9l484wVWm3flAGdLUnnF/g9DcoO4gnUIwQqRLYPsibVqD8LzUvHO52Wk6mfloHRFsJdA12XssRUKP2jpdVP08sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793706941; c=relaxed/relaxed;
	bh=HCorhxQxJT3W15/Ol75aTGcFGkkBMt7oxlNw+Tltp1E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XkLx8kvyrbVfQo2MI0k6KqUourmnd/YALL+i+6XVGbHZR7O3IcFd/hKlCcXHGmHnAVsxdFd9yLWL3Jl1SaolTmXN1S5M85ObWLkWe9fZ2Ht9AK9qrLQzh9T9E3I5C500IoNxpajhsW+lpupQ1xUdoGR8ALqx+eVe104OEHmOW3XsRG0usH8VO/1K/hpPP/VJd1lu21eKOMGhPYJGZO9uK+KkfevdPD75qNlhnen8kn8HVYiDILX30gxRXgz529uNsZ6qzlkzsDrH8bF+1Rowa2bTPykq+SFJoibNaDJj1VlQozvnUfqJKj9v7TDGOaUaozhAEAr7ZMvU0qgE82vSbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PtgZ+U9a; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PtgZ+U9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJn8B2xcrz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 22:55:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706938; x=1825242938;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NRlGTsFdID6TOhr7uHXdva//9pjtlPak/4evBt26tjw=;
  b=PtgZ+U9afL5wT+CCBuBR78Gpo2s7jkmZ9SKg4B2mg5xAuv+Xm8N25u8i
   fVYZ3u4fjQ8G3QX9EmvpdO6qmktU9O4urJkKv8zekgvrthDf9KHCiuJkh
   QZMhg2j2Qg3hKIgLQvDHLs2Gjkiuhxlg5HimjuBoE05sro4lMpPdnK3aA
   iy5QpZ4Sv4v9EyhcXI+g+EAOyD5MpWhQ7rwZFn+0C2NeuUCenwEKyZFj9
   wzLHJmcGNGV2QH7KawSD58rwDz3y1q+L4AGRQptaI3rjHtYhiiLN7oxuL
   C5PX4Qy8B3iBxFPOBv0AE8q03P/DQesa99mgzgKLI6OZXecMA6qbNydk6
   w==;
X-CSE-ConnectionGUID: L/0YgxdCSyqoT8mKk5/mLg==
X-CSE-MsgGUID: Oz9IJwwUSEGAyiMhGce2yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2454754"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2454754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:55:34 -0800
X-CSE-ConnectionGUID: UXG0LlmJSGON8WP14xs+zg==
X-CSE-MsgGUID: /usHt9haTsq5iys1QJ0A4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6265075"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:55:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Nov 2026 13:55:20 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
    Peter Ujfalusi <peter.ujfalusi@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
Message-ID: <a95c92c6-afe3-52e3-c320-6d7ccd357965@linux.intel.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026, James Hilliard wrote:

> Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
> completion callback calling it without rx_dma_lock. Shutdown and runtime
> suspend flush RX under rx_dma_lock but without the port lock, allowing
> these paths to overlap the callback's buffer accounting and flip-buffer
> insertion. RX submission and UART interrupt handling also require the
> port lock.
> 
> Take rx_dma_lock inside the port lock in the completion callback. Hold
> the port lock around the shutdown and runtime-suspend flushes, matching
> the existing interrupt-path lock order. Assert both locks in the common
> completion helper and the port lock at the flush entry point.
> 
> Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index b6f108d34854..322403cec2de 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
>  	guard(serial8250_rpm)(up);
>  
>  	flush_work(&priv->qos_work);
> -	if (up->dma)
> +	if (up->dma) {
> +		guard(uart_port_lock_irq)(port);
>  		omap_8250_rx_dma_flush(up);
> +	}
>  
>  	serial_out(up, UART_OMAP_WER, 0);
>  	if (priv->habit & UART_HAS_EFR2)
> @@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
>  #ifdef CONFIG_SERIAL_8250_DMA
>  static int omap_8250_rx_dma(struct uart_8250_port *p);
>  
> -/* Must be called while priv->rx_dma_lock is held */
> +/* Must be called with the port lock and priv->rx_dma_lock held. */

Nit, following kerneldoc's style, this would start with Context: (you 
don't need to make it full kerneldoc but it is useful to follow the kernel 
doc style where possible).

>  static void __dma_rx_do_complete(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma    *dma = p->dma;
> @@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  	int			ret;
>  	u32			reg;
>  
> +	lockdep_assert_held_once(&p->port.lock);
> +	lockdep_assert_held_once(&priv->rx_dma_lock);
> +
>  	if (!dma->rx_running)
>  		goto out;
>  
> @@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
>  	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
>  		return;
>  
> -	__dma_rx_do_complete(p);
> +	scoped_guard(spinlock, &priv->rx_dma_lock)
> +		__dma_rx_do_complete(p);
>  	if (priv->throttled)
>  		return;
>  
> @@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
>  	unsigned long		flags;
>  	int ret;
>  
> +	lockdep_assert_held_once(&p->port.lock);
> +
>  	spin_lock_irqsave(&priv->rx_dma_lock, flags);
>  
>  	if (!dma->rx_running) {
> @@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
>  		}
>  	}
>  
> -	if (up && up->dma && up->dma->rxchan)
> +	if (up && up->dma && up->dma->rxchan) {
> +		guard(uart_port_lock_irqsave)(&up->port);
>  		omap_8250_rx_dma_flush(up);
> +	}
>  
>  	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	schedule_work(&priv->qos_work);
> 
> 

-- 
 i.


