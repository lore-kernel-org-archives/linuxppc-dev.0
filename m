Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC3606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDdENs6O
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxNk5Pkjz2xjM;
	Wed, 04 Nov 2026 05:07:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729222;
	cv=none; b=j+LCZuY2AkpnBFCoq8zaZ4gU7lHS2BSG8Tr67X4SpQ2o6LtABk3V3OuGcVrq1NhcA/0ZAUctcxlu4wNyOgjDNPXfOYUI+V+80HK25ZHQr2yPqZWZSIk15COA/PvhU/SSShcmMuaBFKc/8LOWoFu1NE0fC7d0S8IVja6GA1QpgSmntbMFQMl+cO7zo70iBxCCpeqCv5R0zM8b/WoQS82CpdfM2C/zGkc/6GSPXzL+8cvb7QVg6tuzssD5EXUZ/BwCfzLQZP5fgUWiROj3lQVKePWNrFbKqbag/sOqOaQG7so1qS9RQ0GBo875L2PRXC7n959ENxgi9ue0uEcjj/NznA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729222; c=relaxed/relaxed;
	bh=w5lVWBJjRjA2krxM/KTY4SL80JsSZ9imdxqcG/GS5Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArwQ+drA8TXf5C/bislCICZBcMTyOl1dyICi90iBK7Q9a6/3xcYfkfuX/Zipx9av/9f26SsrnbNPnD7ZHc3Wgk5tGSmIEoFytPDeQX/7ZTtxkL2MqZu/vkqDhorcSTrgetGQ9khs21UNoVRXQToSR/+lCa8/ilZ7vjh9ZOP3dhOS6WVFb6PqalRxtVtWmnIP26FpVsz3jDXOsYsKeSiSw+34RQbjMQFpOylKbFzfATO7ttPNF4xFpBYIweATKnkUGnLbxGmRfYDtiaGIa3Nu3pqeZiAxg1NRErJWwaxTCP3IY+X1hIHJgfa2TU3P9t75Y/FdDb9vDmf/CxUGl5KdQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDdENs6O; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDdENs6O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxNh28fLz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:06:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793729221; x=1825265221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bfpjoi+2x7WliPDN0Q0PNRLL9EnvniyukWyol0qacZo=;
  b=EDdENs6OVuJr1T2cCF0cPHO1+tt9VgjwNDcFshWljssRye2qrjdsVZPo
   IKavNxOjFIAU1cOsLvrnCWM8hX/POUGHuiK9sW7HwneZu+ELMD1TDneOz
   NYizWMPbi9p2mu4LMXdhPE/wCmz0h6VFTe0vCCUi/wMxmJDn+JlzNcdlS
   sk4M8A+DDS8bELPDolQ/KYo3NzIjv9V1XwUSqwwvTcMN5KvAM6T00JRLu
   ghrWRQwEN2cQqbrSLLD6tEkqa7yu//KJHzv7jWNZZrxmaiYvM+MJevQDh
   WOqMKvCxhn5B4IL80jKaJoBpZNXyA/cE/8aa07Ap1c8qZrMgJCdGd6I9D
   A==;
X-CSE-ConnectionGUID: 7KGiX6duRHy39eeootzgmQ==
X-CSE-MsgGUID: BWT3rmM1T0mR1zgawrDo7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2497319"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2497319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:06:57 -0800
X-CSE-ConnectionGUID: 0DUEqvTGSyWP84YdvsRCVw==
X-CSE-MsgGUID: pmuQBEc9QCOEV5T43CA1cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6503533"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:06:50 -0800
Date: Tue, 3 Nov 2026 20:06:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Message-ID: <auoit0AkmVeCvXqk@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
 <auoa8OWBxqaQuKRq@ashevche-desk.local>
 <CADvTj4rL23q6eO8vjVe9vL1g6B8aoZqsbnThi2QJqkj=9e59sw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4rL23q6eO8vjVe9vL1g6B8aoZqsbnThi2QJqkj=9e59sw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 10:54:38AM -0700, James Hilliard wrote:
> On Tue, Nov 3, 2026 at 10:34 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Nov 02, 2026 at 04:14:34PM -0700, James Hilliard wrote:

...

> > > +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> > > +{
> > > +     struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
> > > +     struct uart_8250_port *p = dma->port;
> > > +     unsigned int delay_us = USEC_PER_MSEC;
> > > +     ktime_t start = ktime_get();
> > > +     bool recover, retry, restore_rx;
> > > +     bool warned = false;
> > > +     int ret;
> > > +
> > > +     guard(serial8250_rpm)(p);
> > > +
> > > +     for (;;) {
> > > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > +                     /* Shutdown cancels this work and drains both DMA channels. */
> > > +                     if (dma->shutting_down)
> > > +                             return;
> > > +                     /* Serialize reset with completion and shutdown notifications. */
> > > +                     WRITE_ONCE(dma->rx_pause_wakeup, false);
> > > +                     retry = dma->rx_pause_pending && !dma->rx_terminating;
> > > +                     if (retry) {
> > > +                             ret = serial8250_rx_dma_try_flush(p);
> > > +                             retry = dma->rx_pause_pending && !dma->rx_terminating;
> > > +                     }
> > > +                     recover = dma->rx_err;
> > > +             }
> > > +             if (!retry)
> > > +                     break;
> > > +             if (!warned && ktime_ms_delta(ktime_get(), start) >= MSEC_PER_SEC) {
> > > +                     dev_warn_ratelimited(p->port.dev,
> > > +                                          "RX DMA pause stalled: %d; retaining transfer and retrying\n",
> > > +                                          ret);
> >
> > _ratelimited() is a slop of AI without understanding the code. It makes nonsense
> > in combination with warned.
> 
> The two controls have different scopes. warned is local to one invocation
> of the flush worker and prevents repeated warning attempts while that
> flush remains stalled. A later flush starts with warned cleared again.
> 
> The rate limit applies across worker invocations and UART ports. It limits
> messages from separate stalls, rather than repeated retries of the same
> stall.

How? The whole _ratelimited() is nonsense here.

> > > +                     warned = true;
> >
> > Altogether NIH _once().
> 
> dev_warn_once() uses a static flag at the call site, shared by all ports.
> After the first warning, subsequent stalls would remain silent even after
> recovery or reopening the port, including stalls on another UART.
> 
> The intended behavior here is at most one warning attempt per prolonged
> stall, while keeping later incidents diagnosable and limiting their
> aggregate logging rate.

Yes, so what the point to use _ratelimited()?

> > > +             }
> > > +             /* Notifications also cover completion or shutdown before sleeping. */
> > > +             wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeup),
> > > +                                  ns_to_ktime(delay_us * NSEC_PER_USEC));
> > > +             delay_us = min(delay_us * 2, USEC_PER_SEC);
> > > +     }
> > > +
> > > +     if (recover) {
> > > +             ret = dmaengine_terminate_sync(dma->rxchan);
> > > +             if (ret) {
> > > +                     /* Retain ownership and keep RX masked if DMA cannot be stopped. */
> > > +                     dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
> > > +                     return;
> > > +             }
> > > +     } else {
> > > +             dmaengine_synchronize(dma->rxchan);
> > > +     }
> > > +
> > > +     scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > +             restore_rx = recover || dma->rx_pause_pending;
> > > +             dma->rx_pause_pending = false;
> > > +             dma->rx_terminating = false;
> > > +             dma->rx_running = 0;
> > > +             if (dma->shutting_down)
> > > +                     return;
> > > +
> > > +             if (!restore_rx)
> > > +                     return;
> > > +
> > > +             /* Apply the current enables, including any intervening stop_rx(). */
> > > +             serial8250_out_IER(p, p->ier);
> > > +     }
> > > +     if (recover)
> > > +             dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
> > >  }

-- 
With Best Regards,
Andy Shevchenko



