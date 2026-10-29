Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EF606A901
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kakw6tbK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmdv6Dr8z30RN;
	Fri, 30 Oct 2026 01:22:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793283747;
	cv=none; b=Vzqqylu+RdRyiM0/SZmbZeXZQV2JIN128U9v4TgoApVqUfexd+oc3TlR1RyKzSjLoRbmL5NkHQASARjemN8IFhgKJTsYrkVznHKGCPa5NDe+HF6zF2jHCDAIbJt8LHWE20XeVwcJyq3u/nTcopN/NhwwmbR52V2IeJ801NUGVAPVNxhLXPhB1bykSVj53e0+sQPIy4EFDqo0ql1U8Q8HHRwn3ARgIFCeWrfK6khWx/MIhAgguzL0WVLpfnCarNUJs8VxozMw1ncsFkTWw75ESkEznK/3/HaSZ+PGQOKsHDls+V/sQvdC0tUrmh549va381ZWjF9WyZCjxTPiHzqdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793283747; c=relaxed/relaxed;
	bh=EgkPHMHLTM0OJa/gTROG+9KF0iCc6Eu3UkCLei8s4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCWc9nuhx+Tf5/A3mAxBU4VT9W9ZaDHRnu7lTw5n4Pe9WTQm9s2HKCNhcGfxErULKTaDx7lPHt/PmRq/IM681Puy2rJmWHYpo+TzCrThY9IAc+W9rDMYLpb34VnmKXZ7/rSYLglvFui4ZSav/Hl9b991YkxE91YY5+3q3EA2ORgoNNjMA1JSeCdy4X2xxWjMdb33QjL5KX8p0s9Uvn5WQ1txH9GAXHjfV3EuFq10o05QTxTmZQ1enKUJoYIjngxOx+TOutc+Fx6ZFRzRpasyZ4PV2zJ/YLmz8IGW9M5dPQNFAumFaXWDnq3633qPiSQnz8nGtAHOYKVCQD+24uh7mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kakw6tbK; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kakw6tbK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFmdt414dz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:22:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283747; x=1824819747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MgJL8MuqM9l4uyQAiqFvrF6SdMQF/UIm279xyhJToOY=;
  b=kakw6tbKItWyzXuuMap1b7lC0HFk5dWrt/VcqAWVcGJgbwMUpiK7HjYI
   5O2XInOldHw9UQeU4+WH4/pLehwdA06w1kqPR9rW+tJjfJSDYeKuLgg+G
   edBT2CzKsPg4N9Gd46q+eY9X49usiebXaJih6IlhiiZ+Ctl3iaThg5Q0I
   cd0OmC1cV9kv9ucl85F7VHCc0zk5xme4RyjdDN1Hyk+d2lwR+44lqmAeA
   r3zD2lPOPh5YE6C+aEkryiwkMQQvMErjo76vKnPWqfzA0H2MZBOQ/i11c
   jDEhjI2iVmxJ0LFQxMF++A3QAF0oOGRpQe22tEhKlzdVVUi3VymvqLjxK
   g==;
X-CSE-ConnectionGUID: CYX0llOGQteQT/JBIKIYAg==
X-CSE-MsgGUID: ab3CNNPsQwuHI598DVvU7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1925629"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1925629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:22:24 -0700
X-CSE-ConnectionGUID: yr/uZ8XsRG2FWMf2URIasA==
X-CSE-MsgGUID: egHmc43mSROKoKZDsLbkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5261220"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:22:16 -0700
Date: Thu, 29 Oct 2026 16:22:15 +0200
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
	Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Message-ID: <auNWl_thBnE8JqBE@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:37:01AM -0600, James Hilliard wrote:
> The generic RX timeout path pauses a transfer, copies its data and
> terminates it asynchronously. Clearing rx_running at that point lets a
> new receive reuse the buffer and cookie while the old callback has not
> yet run. Inspecting the new cookie cannot distinguish that callback from
> the completion of a new transfer.
> 
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Keep FIFO access separate from callback retirement: after a
> successful pause and termination, clear rx_running while rx_terminating
> prevents another descriptor from reusing the buffer. Deliver the paused
> data before allowing the interrupt handler to drain the FIFO through PIO.
> Normal retirement only releases ownership and leaves subsequent receive
> handling to the UART interrupt.
> 
> Preserve the normal completion-path LSR read and gate DMA resubmission on
> the receive interrupt enable, so stop_rx() prevents another transfer while
> the status read retains its existing side effects.
> 
> Reject new flush work and PIO receive handling during shutdown, including
> late Intel MID DMA timeouts. Stop and drain retirement work before freeing
> the channels and buffer. Once RX has stopped, allow the idle flush used by
> DesignWare LCR recovery during shutdown. Clear the shutdown guard before
> startup configures the UART and tests its interrupts.
> 
> Check pause failures before accessing the buffer. A successful pause is
> the quiescence guarantee, even when a provider still reports IN_PROGRESS.
> Also accept DMA_COMPLETE after a failed pause: completion can stop the
> channel before its callback acquires the port lock, leaving nothing for
> the provider to pause. Retire that completed transfer normally.
> 
> A failed pause with an incomplete cookie is ambiguous: hardware may have
> finished while its completion interrupt is still pending. Canceling that
> descriptor can discard the entire completed receive buffer and switch
> permanently to PIO. Retain the transfer and retry pause and status in the
> worker, with receive interrupts masked to prevent a timeout interrupt
> storm. The worker copies only after a successful pause or reported
> completion, then terminates and drains the old callback before reuse.
> The pending-pause guard keeps callbacks from copying or resubmitting the
> transfer concurrently. Retries sleep outside the port lock and stop when
> shutdown takes over. A provider which never pauses or completes retains
> RX ownership until an error or shutdown; a timeout alone cannot establish
> that discarding the buffer is safe.
> 
> On DMA_ERROR or termination failure, let the worker stop DMA before
> handing the FIFO to PIO. Keep the requested enables in the existing IER
> shadow and filter hardware writes during pause retries and recovery,
> including termios, RS485 and overrun-backoff changes. Apply the current
> enables after retirement so stop_rx() and shutdown remain effective.
> Hold a runtime PM reference around worker register accesses and keep RX
> on PIO until reopen after a confirmed error.
> 
> Abort the DesignWare idle sequence when RX cannot be stopped. Allow
> the empty-FIFO timeout workaround once DMA has released the FIFO, including
> while callbacks retire. Exclude FIFO resets during RX DMA recovery. If the
> provider still cannot terminate the channel in process context, retain
> its buffer and leave receive interrupts masked.
> 
> For OMAP, publish the shutdown gate under the port lock before the final
> RX flush and interrupt masking. Take the RX DMA lock inside the port lock
> in the completion callback, and serialize the runtime-suspend flush with
> the same order. Drain the UART IRQ before releasing DMA state so an
> in-flight handler cannot retain up->dma across its release.

Can this patch be split to smaller logically isolated (to some extent) pieces?

...

> +++ b/drivers/tty/serial/8250/8250_dma.c

>  #include <linux/tty_flip.h>
>  #include <linux/serial_reg.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/delay.h>

When adding a new header to an unsorted block, try to squeeze it the way that
you get the longest ordered chain (yes, interleaved with some unsorted
elements, but still).

>  #include "8250.h"

-- 
With Best Regards,
Andy Shevchenko



