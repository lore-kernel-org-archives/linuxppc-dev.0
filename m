Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6F606A31F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gS81Ta7D
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzPv16r5z30Sv;
	Fri, 30 Oct 2026 09:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793312867;
	cv=none; b=ouNZwIArLYewxImzk0TY9JBEs9+TItnbY2uORyfm9eDbnrbHY4a/enZ8AnyMZmmXp49iatYxBT50HsWSRFTP9f25Yrfxym/Wg7RH9YdKRd6U3zd2vqiip9UC/ku2aCVfh/rrobLxZU5i898RhwRvHecIG2mBClYWshWdvVO/z4OAaYRCQyIUkuM3jtKLJHkJZNOIwkyKLSiZiUZ/DX4Srrl2H1sCmfM6htDH0wPXsf5aH6t9OHBghJGecOKHsl4yMy5YIWKgfs9Wgo4BIhH6ewkTHuZJZsnbxaiWc3OTQaBeaILbyRQU+tzTFpwxUeB2KHZYxP10yum7emkBU+mMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793312867; c=relaxed/relaxed;
	bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcOXED+n9zgdKQJVhGDwe8f72ez/Ym46DeavoYvAbMySIENTObgztnrDkq9j1AC6k8PLXf+3Q7HFsUKtJEyyKu5bPccIhKTE8NMlPrcY32Pv2yzoFFKs7J0C/z4GYr4VfgLTirByJLr5tXIa657xU1fEPUEoqLqe1ortjIjPA398wR12mMd+op2tmlz8mE43qN+WRYT2kN0O4u5gBz7X4S8HvRDeGE9vvCCwSw9RUAdLlysT9COU6D0meuHH544cpgporTaFiOsthWPMNEnlQCpvk0RtiYPutFJtfELMD1c9TR+XbzvO0A41w4FzfMhbBRmPfvM76FkWmWiI7wSmww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gS81Ta7D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gS81Ta7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFzPs6Ns4z2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 09:27:45 +1100 (AEDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-823e4047037so103665a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793312863; x=1793917663; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
        b=gS81Ta7DUV/Owak11YB44bPIN1ROxBAfJAaTP//5KTGrJ9VAGJbQ/Ub2Uh3EoJPQqG
         3Ajwt6qM/SKSITnwi3UZYsiCDdVYllgJR4d8mcqxBaZ6rCvhFK+A4aEpDg5hTo+qzona
         yN8V1mBdN+WLsIU9MePa5BYooT5joOXUQ+2eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312863; x=1793917663;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
        b=ezWAgxC7yVmczOrfYStmkVQtpgwrNcDAvgEoAnzJj4n4YDBPnZ+ap2U6Dt4D102ETy
         LHNXxB3bGgI0xF3VK9pceaILWwRfoWix0tRd4GXQ/qJ70BrNmmIdk5FYtkb2xpob+zfz
         dDb26sgK8XOcylYbbkiZp4Fp4zu3/dcESfLIGT8XESZja49gwMD9i81NGRI6Y/zJWqQK
         PX7lAU6SynrEd43WDHa85JI2mNyos+kRkD7fyD+UJx+FvyOOg+OO4fi9eAo4/ObfN2SG
         S8esUt89KdDhdAxIpa4ho4fzVz/njppWefos052xQU8/KVCFLRbO8esFu9sm+8WLs0aM
         exWw==
X-Forwarded-Encrypted: i=1; AKwUvBxv3WDFG1tIq0q0nFNVJZZI9ZoyKtv/szarT/vl4LxheVWZkinplJITgUBwM6YjUw93zxfbNfVFAfNW9c4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI5VqYKQ2yHiOy4Srb19RCRhgid8CGVUsG4/xfMvz5nkVuw+d4/
	CTVKjoDe6atpO5SnIkM1iSr50FxJfsGOr4zHhUO5CKs1Kq9wmMieTPa/Vr5BLhIOzg==
X-Gm-Gg: AYBFou330K/CbNTidUwYA9uDUxWRKNrKWgi952K03DhGooOwy7YdT9kpkxOpDaibYi8
	RGnG2AdttQpzyRI+kS658CL2mMtRZF9kQR3GVPSCJoRUo4d0SmmfbUHvk/S5FVfrUpaN1hgaeh0
	lgLekDciknoyYPO+DDOsHw2BGPIQ2vGfYFAEbJIl5syCA9/mY8GzQsKInE/xrYicskjgTb3Wi4C
	NeGSc4pJG6FD3zFqNOKc4LnNfhrcFHuFGTpiUPPN0A6bMVZddaWen3m8zzWjY2960APjgQz3/GR
	Khxx44M36hZrHfAiDOYlQrEBbzuuQyhAcmEFCbBo1PZkzRJ5RV/3K7Xgp+h/oMe4mwcy25yjMdV
	6Z1L3v2UzZIqWHIhL4IRczGuNDBZLFORDiJjb2xrxmk5RQMQGUtjIO/oR/yNl+crjg7+A4XWEa3
	gWtiWefL+XaWOxqPsmk/ZBIQg70dzkjmrorp86Ikl9/MDT3mndaKHEgC+kYfJKVCjGwsz/gs7pE
	yL0VYrZuKbSxRBSMnejfqpoL/4e5aTJ5OSdyp2saLYX/YbGNbonod7wwQoPOzQ0SZujpA6bHXDD
	kusf8XPYhW6wtcAHis8iW3Y/yiIzBCA6q3jv0AiVP13MmMCw28sZI4k/jtzgXp4rcizsd/v8gRW
	zge0NYcacGa7mR+E=
X-Received: by 2002:a05:6830:25c6:b0:81f:827a:b1cf with SMTP id 46e09a7af769-85d3644f500mr541370a34.22.1793312863265;
        Thu, 29 Oct 2026 15:27:43 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b89asm718163a34.6.2026.10.29.15.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:27:41 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when termination fails
Date: Thu, 29 Oct 2026 16:27:34 -0600
Message-ID: <20261029222734.3086943-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:19 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > +	while (rx_ret || tx_ret) {
> > > +		dev_err_ratelimited(p->port.dev,
> > > > +				    "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > +				    rx_ret, tx_ret);
> > > > +		msleep(100);
> > > > +		if (rx_ret)
> > > > +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > +		if (tx_ret)
> > > > +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > +	}
> > >
> > > Huh?!
> > >
> > > This is unacceptable. Sleeping is okay, but value should really match the
> > > baudspeed and other parameters of the transfer.
> ...
> Regardless of the retry interval, shutdown cannot release the buffers
> until the provider establishes that DMA and its callbacks have stopped.

Agreed that if dmaengine_terminate_sync() fails, shutdown must not free
dma->rx_buf, unmap dma->tx_addr, or kfree(port->xmit_buf) while hardware
or a detached callback may still touch them.

However, because serial8250_release_dma() runs under port->mutex in
uart_shutdown(), uart_tty_port_shutdown(), and uart_suspend_port(), an
unbounded `while (rx_ret || tx_ret) { msleep(100); ... }` loop means that
if a DMA provider returns a persistent error from dmaengine_terminate_sync()
(-ENOSYS, -EINVAL, -ENODEV, -ENXIO, -ETIMEDOUT, or a wedged controller),
close(), hangup(), and system suspend will hang forever in
TASK_UNINTERRUPTIBLE while holding port->mutex (triggering hung_task_panic
after 120 seconds).

Would it make sense to satisfy both constraints (no UAF on buffers/callbacks,
and no infinite sleep in close()/suspend()) by quarantining/leaking only the
failed channel's resources instead of looping forever? Specifically:
1. Bound the retry loop in serial8250_terminate_dma() (or do not loop on
   non-transient errors, checking `if (dma->rxchan)` / `if (dma->txchan)`).
2. If rx_ret or tx_ret is still non-zero, warn once (`dev_err` / `WARN_ON_ONCE`)
   and intentionally quarantine/leak only the failed channel's resources:
   - If rx_ret != 0, leave dma->rxchan non-NULL, keep dma->shutting_down = true,
     and skip dma_free_coherent() / dma_release_channel(dma->rxchan).
   - If tx_ret != 0, leave dma->txchan non-NULL, keep dma->shutting_down = true
     and state->xmit_blocked = true, skip dma_unmap_single() /
     uart_xmit_unblock() / dma_release_channel(dma->txchan), and in
     serial_core.c:uart_free_xmit_buf(), skip `kfree(xmit_buf)` if
     `state->xmit_blocked` is still set.
3. For a subsequent port reopen after a quarantined failure:
   - Remove the redundant `up->dma->shutting_down = false;` in
     serial8250_do_startup() before serial8250_request_dma(up) (which already
     clears shutting_down under port->lock), and have serial8250_request_dma()
     return -EBUSY if `dma->rxchan || dma->txchan` is still non-NULL so
     reopen falls back cleanly to PIO (`up->dma = NULL`).
   - Guard the DMA completion callbacks (`__dma_tx_complete`, `dma_rx_complete`,
     `omap_8250_dma_tx_complete`, `__dma_rx_complete`) with `if (!dma || ...)`
     so a late callback after `up->dma = NULL` is ignored safely.

That way, neither hardware nor a detached callback can ever UAF rx_buf or
xmit_buf, while close(), system suspend, and subsequent PIO reopen all
complete cleanly without an unbounded msleep() loop.

Thanks,
Raul

