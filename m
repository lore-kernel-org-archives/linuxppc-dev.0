Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F0606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oAzzQFfH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFKdS6Pv5z2xPb;
	Thu, 29 Oct 2026 08:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793220536;
	cv=none; b=ZDMPEyMQEqiQq9EafeQiLkdwHigiXhW+BJgDUmlX2FrPEatYW/RGcRpLhck4fD2sWWnTWfVuczS3Q7St3zfuPzQBsBYbLygMkyZ4I2ANStD0GZjh9+eqju4XFfROh36u0SEjvdB6egYAsNHwQpdPHD35tiBJILOVq6uYvb98MxIZw8WKR3C3ERQY206d04+y3VpdQ0sll5aXS1jshP3ctL5o1slFJLeGxzgKenfSBtM0VnuoKlO9h+SfoXtWMPIYqCdpBPKzB78agby70Aq0JxsRSrnx/YIZ0dHkL71R+XSqKsAEnj37a6fGR+AH6ofIfMIVGeoMSqC6xaqGvFBfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793220536; c=relaxed/relaxed;
	bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G49DOc76udCDojnLePlWWjAqOJmRadMv+zeTXCxPXaXS26hMBUJFtahJ1/EEACDWh9nY1eAE3ldOn7LBUHJ7pq9DdcrELBb9UcKpfyDt+hbLYazgXHjhasOgfct57qCmynrJWeU99ZZRan9Ek/+C6cLWBHj+oGx5c1TKueFLMtMr45ZuDXQzF/UYOLxLNMH+N96bvXmd4wZ5Lcmm0ntxImsDWOmIBfiK8HAQQtX164Erb0PPdc9xSCLiUxnlsvdrPVVCIwRuIrbk/tPp/PREQqKRHD3hShimDmkuWKIndP+kyIM6kB5jDFaA/XcPtNaRkgcAHNXDraskZrXOqFbVOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oAzzQFfH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oAzzQFfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFKGG51tKz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 07:48:54 +1100 (AEDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-4b28d9537bcso61297b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793220531; x=1793825331; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
        b=oAzzQFfHStDJzQR86IDQbzwWg1/b7HQEFe747RyAWtmCRZ7/mK8vW8qCy8P4+FMxH4
         lZKAebnuL9NV2DRGDkEpaIy6CXazp1mMjNJqrxRCWvNWLUqdYMNGGe6ZILYNXWWLrnIr
         HIE1VgMWwSA2tXXyAXkKWiV8kaIQu2gda2HCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220531; x=1793825331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH2WnjXWwsl9S26zTcVnDiXysm6ntQCEcJClsDwXCEM=;
        b=UB04f+X1VY17Cvd4GJ/fgHrrP2kCdKDbsJk5Ruvm+y+2r31lC6AkoazjDWXzZ4Uwr9
         UH/o44NmcK6U9NXDuMZudHt8JObjT8EnCDMjCK8cE1j9HkWo5hmKB8IoCQ1zWz/4fKaJ
         zmVUZUidmQcsFLVX9NsBNrGix8E+ASs2lTkKk9Uruc2d03aJNpsm29ubRG6oPGwH/OT7
         f5mliVJ/IA7tP36N5N+cU+212JHV/3ekxaKali33l29wDwFoAfdKJw8BbgacckK+Izj6
         KoydX5or0H8tbUNOZvHPh8gauguYcd/6cs7fYgGUWtanT3SbwGpn7+oEhFY+C1PtoIuz
         f8Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzTzyM9aVG43l9Iz6SihuHsADBfJoxVU7ry6gW7KV0u0FYvFTl2yqJruUr4U4Ib7zPPdrisW6pWlNH5vDk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIZ5w4iL+M2BzTN6bqzcclNRrtLtyxYTB0b+GJn4WxPKk8ZGNgC
	TfhfsuCf9dElTOsed698rgjrsD2pNr4EYPE6LMTUYd6+5TzQktFs8krOCJHNEthEHg==
X-Gm-Gg: AYBFou0Jt+ZCDzqQdPe/X6g3bQmi87G1XL9fZykcxRf0yIuR6WNvr0YxEj9IDtO+pQn
	zyd3khIQFAUNJFyCTrIDbKuLbtNtrBN6AzyAYTPLCjSKgeCZavmJTEFZKDrSHaauNnmcvzlZU/J
	slFUyWF6rCSdTaD2Xu7l37kNu/pYcBgpX3+GoZGLE/Ry4NOdlqR4lqIKdcHxG51oR9NECwzMqnp
	vE7ZyTMJJu0IrqWFZO0YdBITzOyisu/8FPSIw5NmkuoLsJAgeNFN9P3T40oNnY7evUERnNop29Z
	ZKM+JbWPzccZw0uk8qATCsz32KOdLYBJeLdqg68gr/LOvhA4W9uIZZwsMyS2blxuRRjOsOOxb3G
	MjMa1xMuRaNPAmE2SDaojnZU2o4r/IBfOymmpIf7cI8U2FOgFg8Pgy0rXAs7+VAP1CGrVC4tAS6
	xYwgkZpsyosCgM6YbkbK0a9BQWrBGnkxi52g3rKlcVYqO4n+BddTg789TXmJl/jb6jMYPDKfhFp
	93mMmV2kAuCxZ/Yf1gLYPYCAy+czQ+fI5EHxUph4/zXe+kcimxjYAMdR2WM+GADYz394DfONzps
	xHAD1fPNJ/n3K7o6mlrqRWRfVp6vbGi4hqS3CDfmK5GWgBJLW52mVx6i3PuCg8xkUJpqzNrBAiI
	k4bpHRkKISwILc04aazrcMWFOdgUVy+IsZxaEQnA=
X-Received: by 2002:a05:6808:bca:b0:4b8:4703:db97 with SMTP id 5614622812f47-563efb4d666mr411105b6e.32.1793220530793;
        Wed, 28 Oct 2026 13:48:50 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2281137b6e.2.2026.10.28.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:50 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v7 2/5] serial: serialize asynchronous write wakeups with the port lock
Date: Wed, 28 Oct 2026 14:48:45 -0600
Message-ID: <20261028204847.3471382-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com> <20261027-submit-serial-8250-dma-cancel-v1-v7-2-985a023ba4b4@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

A few issues in this patch across the serial drivers:

1. Recursive self-deadlock on ltq_port->lock in drivers/tty/serial/lantiq.c:

> @@ -239,7 +239,8 @@ lqasc_tx_int(int irq, void *_port)
>  	spin_lock_irqsave(&ltq_port->lock, flags);
>  	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
>  	spin_unlock_irqrestore(&ltq_port->lock, flags);
> -	lqasc_start_tx(port);
> +	scoped_guard(uart_port_lock_irqsave, port)
> +		lqasc_start_tx(port);
>  	return IRQ_HANDLED;
>  }

Inside lqasc_start_tx():

	spin_lock_irqsave(&ltq_port->lock, flags);
	uart_port_tx(port, ch,
		lqasc_tx_ready(port),
		writeb(ch, port->membase + LTQ_ASC_TBUF));
	spin_unlock_irqrestore(&ltq_port->lock, flags);

uart_port_tx() invokes uart_write_wakeup(port) while ltq_port->lock is still
held (nested inside port->lock). If anything in the wakeup path or printk()
invokes lqasc_console_write() (which takes spin_lock_irqsave(&ltq_port->lock,
flags) at line 612), the CPU will immediately self-deadlock on ltq_port->lock.
ltq_port->lock should not be held across uart_write_wakeup(port).

2. Missed unlocked callers in drivers/tty/serial/dz.c, drivers/tty/serial/zs.c,
and drivers/tty/serial/jsm/jsm_cls.c:

The commit description states:
"Ensure every driver caller of uart_write_wakeup(), directly or through
uart_port_tx*() and uart_handle_cts_change(), holds the port lock first."

However:
- In drivers/tty/serial/dz.c: dz_transmit_chars() (lines 266-288) only locks
  &dport->port around dz_stop_tx(), calling uart_fifo_get(&dport->port, &tmp)
  at line 267 and uart_write_wakeup(&dport->port) at line 281 without holding
  dport->port.lock.
- In drivers/tty/serial/zs.c: zs_transmit_chars() (line 641) only acquires
  &scc->zlock, so zs_raw_transmit_chars() calls uart_fifo_get(&zport->port, &ch)
  (line 621) and uart_write_wakeup(&zport->port) (line 630) without holding
  zport->port.lock. In addition, zs_status_handle() (lines 673-680) drops
  &scc->zlock and calls uart_handle_cts_change(uport, ...) and
  uart_handle_dcd_change(uport, ...) with no lock held at all, which triggers
  lockdep_assert_held_once(&uport->lock) in serial_core.c.
- In drivers/tty/serial/jsm/jsm_cls.c: while jsm_neo.c wrapped
  neo_parse_modem() in scoped_guard(uart_port_lock_irqsave, &ch->uart_port),
  cls_parse_isr() in jsm_cls.c (line 585) still calls cls_parse_modem() ->
  uart_handle_dcd_change(&ch->uart_port, ...) without holding ch->uart_port.lock.

Also, in Patch 3/5, adding lockdep_assert_held_once(&port->lock); to
uart_write_wakeup() alongside uart_xmit_block() / uart_xmit_unblock() would
help catch any unlocked callers automatically.

Thanks,
Raul

