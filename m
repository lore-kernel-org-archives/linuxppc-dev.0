Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75845606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GTY8/AlO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBdLW1TXMz2yGT;
	Sat, 24 Oct 2026 22:43:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792824058;
	cv=none; b=QIeuczTrBzh8vcFk9hubp8AXFN0uWowg9tnA94YXgReG/z2fcK2F2mBNRDQmoh1wbvIFzfYctlEMthuTMtppjcVSkqMF+wjJC+lgvgy8yqKkX089Ws0NsThhz/CE8UIeV4i7rU9it4u8KV3dGDKNFT6x0Ma2zBzUk7ELY7CuQNdU03qY6nan0WVX6kSM0jVODha8JfDo7minXO/WebQpY81bLNUjIerVoXPjrNFkAnCMi3jFqC5v7E0D7Z0JfrXoFK+/9qkFnWOQ9WbvT7ilSfjqD388AHosYxb6lspQ0kEK5Rp1+5vcf95L7j/HcMenT+CCMx9FTSii2QICex3fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792824058; c=relaxed/relaxed;
	bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FpG3TwUJ/NyNJwsSWw5f52BvWXT5FKqRS07oswAszvUkXdGHWnUnAX/16olwcN8TYCZ2gv3MrBgg4bC30EoBmwUtvEMONiK5177raqdSs1YjOeuwzkJzbyWZ9Zoy63xGJKty+MCJs8LkmGdKRtCxZifpEURStktp217xKdCgJnGJDckEQNFzWutLSXqRtxsFz85xsOLbViyTEcsBngu00Im7WPNJ1IaY0tqiaiy0iQ2h95opV1g+AKrChzPoLPsmRSNsRm+HVlHWIjaD0k93K/4yHOgvWWuDhOlD2bi5jN6WA8aHAzHoljB+pX1c80yXUEPw77w0mvM8vBm10R2iQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GTY8/AlO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GTY8/AlO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBVdd4HCxz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 17:40:52 +1100 (AEDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-504ae5941faso852795b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824049; x=1793428849; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
        b=GTY8/AlOXTeiGvsWZ0QS6q4yGw/t/V5wiTmlYWczrN+xm9YC/w220UZ/pJF1SvYT//
         1OIuEZ5vDkiXOtVEHx4YkhwE3tFVkkZJwrkycKjN6Stx7u84PD4znIZvNfZI9qGs0iha
         bS55LUnBCsY4n8jJVpjTVanUDUoDiKsOo7nZP6/YPxf20sk5EUuW/LuKQfdglhiC/DAO
         1RJA5ui0u1eX8iH7DHTqi0rktpVUuCR5mrMVq7nnszzzp+N0CRSDU6M39r0bTG8YbjK5
         Wks9HuFOrwIfv1Kse5Lci5v34r1i0tJX1yK7ta4nAc+9kRc37XaE8b0Vt3bYau3ai/va
         NU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824049; x=1793428849;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=edz22Fq6n7hqO7w64D56fVejxYtfF3v+LcW93z688tQ=;
        b=T9s+LnNkrvUGJGRXJzf6O/ExKsVQo+bgRhcdKbpKbRs4AYjiMf1mstFM2ws4Qg6vQI
         siYoiCoMdjgzU/a4P8jGClxTDuh9OGcK7+OdpDuuEDe73MMrGcM+XxuBLn8y9/CpAjWQ
         CoEXemJkX7uBXaii2d5yDwDeJ1d0OvAIo3SQ5/PAK5ucF+rRjW6OXZP4Ngu9tPu6h+b+
         VHzdsWMDDr2njy2o29VEcImaIblnnbTyicLCGuSSn1sAZn1EidSEqF1VK26mfuNP9at1
         89eOLbBPdVBXY79T5oOgQ83z/5vZY9tfjLvhKX0YvZdQRJpJdM/Zjw5oHrRerhZHpOOL
         ZzeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlrLyksM+rw+TE7V47p7Vkv3nBNubym06teHwWNanJQlixdXpmLeMtZq9z1opuMSjLTVD3saO4ie+irr8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIgG2KBopc80r1DiuYJILXwLGjUzYQ1anAfmGtnQ7AQ0/HRNqmy
	NBMzQQhHGBi92QyBtSIcNPOfVKJUbk/aA1b7xot6fJ0zikT/Lmd2CC8i
X-Gm-Gg: AYBFou0/mLXUyCtSYjFmlKlpjp7Q3oowuMz/7wClf50TWK/KTx3TM1wCtDFALfGa63/
	wr+7Ary/YdYX5SS228r790WIhRgvAyqQI/hBLnR6VpmSrYflUMPCUdTy7LOoX05ShgL0twsbXDJ
	6yc6nsOGI88pXOrU2/x8mQ4yDR3juRgxGyJs3Oiqbx+twhu33PS4N2kSXk7OptbRRLuGRy/pDm4
	HBM0M0LwLvkpScHAaAlordlnYojGmwVNbEGRFUOc6DQQrS+gqwBN7Urlujm+iynt8A17PrVijPZ
	XdIzurlDVuvR1ih179ajgy5IX4X0dNaa+5qlE/XMrB9F06LoNJ/ynyRU4bM88yU/9re5GlVj6SV
	mPGiPMSTeFaKT97jNvcDJI7jGB3nd0/amZh9+MGwIu5BUAauK6bNoRUQn/ly6ei2QEX3NloasrR
	AThC+qR1rK+19KpqnbfF9oumOxYMVJosb8ROzp4n9WyE1EX97Z9nvi9Y/yDdiWgRdkGPNGrfo7q
	FLTIdYRXdxwuL018r5zRxOi40YlcegG8oAbmtzFCdWQ6Q6zcUvg4v7uW03V3KhYxwSx0m/1A7VL
	6mP0PmWd8Rn4JUz+ngKxfBqy0xzNSTLbhQ+Z3COKRd176E0A8QDE6YNVHAPWZ3ye7k9rt3+NCtz
	HYgaiiEGBzI8h09y0UbhVNEsA7t6QGlZx0PtVksW8jwss4C56WXKm7VwZDn1///5naoIIqfLTS6
	0PXg==
X-Received: by 2002:a05:6808:1798:b0:525:184c:7952 with SMTP id 5614622812f47-55c0026231bmr837705b6e.16.1792824048956;
        Fri, 23 Oct 2026 23:40:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm864633b6e.9.2026.10.23.23.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:40:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Sat, 24 Oct 2026 00:40:39 -0600
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WS3WobQQyFX8Xsdbcdaf6kXPU9Si80M1K8JXZS2
 zEtIe9erdOL2FBIYVnQovMdHa1epqMeFj1Od5uX6aDn5bg87r3InzZT38r+XudleD1hwAIBYT4
 +t91ymleZPMyEOcxjJ3OXfdeH+Qxzw0BGSYk7TI55Oqgtvy4W376/1c74of20cteOJked28EJ2
 /WTNxz055d/OeS/UO959nFPb+Q3SH/c+XB3GwBKRlWxclAS46YRoFgJNFCptFQZRx0XlJz61lP
 ebWIJqZlIFOgIibkOBQMXYiOQlBOIZWnXqspjBI5mLWbFnNQ9h1dEVM37oZVknOq1ioLkUGBQ6
 iFnKanX4ism06YDKvdCtTHbjddoLfmQYmBUgAm7FUmt5jwid9OeEyHGa1UKRO4EgrV5NvEkGKK
 7gKf0vIbAtRa6UaVctFWjEHrLIwepoROTlpFXglQLrUu6ViHVIkCBNZsi+xYws2uj/4oiaj4H5
 ZBvVIlKdoVatOx7rHUEzwQWKIYehqbCjAX7tB7QdjmeHg+/Lyd7hsvP//h1+hNm9dEasWEM8ev
 9TpaHz345F/gZ3wPxA0B0oC9YJYNGYrgFxvfA+AFgdOCoZKypJ454C0z/C0xr5JrZr5miv98DX
 19f/wCQKuFMBAQAAA==
X-Change-ID: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve canceled transmit and receive storage until DMA and its completion
callbacks have retired. Serial-core write backpressure protects a flushed
TX FIFO while normal transfers continue to DMA directly from that FIFO.

The series separates OMAP's locked completion processing and serializes
asynchronous write wakeups with the port lock before adding the serial-core
reservation helpers and applying them to 8250 TX. Flushing
empties the logical queue immediately. While the old transfer owns its
storage, write_room() reports zero and write-ready notifications wait for
retirement. Failed termination retains the reservation until normal
completion, without advancing the reset FIFO. DMA retirement releases the
reservation independently of port readiness. Serial core keeps writes and
wakeups gated during shutdown until successful startup or resume.

RX delivers paused data before the PIO fallback and retires callbacks in
process context. Track FIFO access separately from buffer retirement so
PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
released the FIFO. On failure, retain the requested interrupt enables in
the existing IER shadow and mask receive interrupts in hardware until DMA
has stopped. Recovery then leaves RX on PIO until reopen. Shutdown excludes
new retirement work before releasing the channels.

Based on tty-next with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], transmit-PM shutdown fix [4], serport
write-wakeup deferral [5], DesignWare BUSY-safe fractional-divisor
programming [6], and Intel MID RX DMA timeout locking [7]. The serport fix
is needed before serializing the remaining write-wakeup callers with the
port lock.

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com
[5] https://lore.kernel.org/r/20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com
[6] https://lore.kernel.org/r/20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Add the posted serport write-wakeup deferral as a prerequisite for the
  caller-locking preparation.
- Add a preparatory patch serializing asynchronous write-wakeup callers
  with the port lock, including indirect CTS and transmit-helper calls.
  Keep sleeping register accesses outside the lock and defer SCCNXP
  notifications until its controller lock is released.
- Use the separately posted DesignWare BUSY-safe fractional-divisor fix
  and Intel MID RX DMA timeout locking fix as prerequisites, leaving five
  patches in this series.
- Separate serial-core write readiness from DMA storage reservations. Record
  retirement during startup and shutdown while keeping writes and wakeups
  gated until the port is ready.
- Wake deferred writers after successful startup or resume, including when
  reopening with a retained FIFO, and restart any retained queued output.
- Keep the write-ready notification pending while retained output is at or
  above the normal wakeup threshold, until TX completion drains it.
- Publish resume readiness under the TX restart lock without releasing a
  reservation that may belong to a newly flushed transfer.
- Release 8250's TX reservation after shutdown has stopped DMA and unmapped
  the source; serial core retains control of write readiness.
- Link to v4: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com

Changes in v4:
- Retain flushed TX reservations through shutdown and failed resume. Release
  them after successful resume, or when allocating a new FIFO on reopen,
  so retirement cannot wake writers into a closing port.
- Treat RX flush as complete once the channel is inactive, and clear the
  shutdown guard before startup configures the UART and tests interrupts.
- Check completion after a failed pause so a transfer that finished before
  its callback acquired the port lock is delivered and retired normally.
- Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
  discovery, writing DLF and DLL/DLH only after confirming DLAB.
- Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com

Changes in v3:
- Defer write-ready wakeups while flushed TX storage is reserved, and
  serialize the flush wakeup with the reservation under the port lock.
- Suppress ordinary TX starts during the reservation while preserving
  high-priority flow-control characters, which use separate storage.
- Separate RX FIFO access from callback retirement, allowing PIO and the
  DesignWare empty-FIFO timeout workaround after a successful pause and
  termination while keeping the receive buffer reserved.
- Use the existing IER shadow for requested enables and a shared register
  writer to keep receive interrupts masked throughout DMA error recovery,
  including termios, RS485, modem-status and overrun-backoff updates.
- Preserve the timeout-enable bit across stop_rx(), exclude late shutdown
  interrupts from PIO, and avoid FIFO resets during RX DMA recovery.
- Preserve the completion-path LSR read after stop_rx(), while gating DMA
  resubmission on the receive interrupt enable.
- Pack the cancellation flags after moving all their accesses under the
  port lock, including the recovery worker's snapshot and initialization.
- Apply the early-return, shared-helper and line-wrapping cleanups.
- Link to v2: https://patch.msgid.link/20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com

Changes in v2:
- Add serial-core helpers to reserve flushed transmit storage until DMA
  retirement. Apply write backpressure during that interval and keep normal
  TX using the FIFO directly, replacing the private transmit buffer in v1.
- Document the flush callback's reservation, writer backpressure and
  retirement requirements, including release before shutdown returns.
- Split the OMAP completion refactor into a preparatory patch and move
  the RZ/N1 preparation-order and shutdown PM fixes to independent
  submissions, keeping four patches in this series.
- Take runtime PM references around worker UART accesses, and leave normal
  RX retirement to release ownership without reading LSR or restarting DMA.
- Synchronize the queued TX ranges before preparing the descriptor and
  return the mapping to CPU ownership before releasing the reservation.
- Keep the TX transfer length separate from FIFO cancellation, so a failed
  termination can account completion without advancing the reset FIFO.
- Exclude late RX flush work during shutdown, including Intel MID DMA
  timeout interrupts which are independent of UART_IER.
- Accept DMA_IN_PROGRESS after successful pause, and recover from failed
  pause, termination or DMA_ERROR before handing the receiver to PIO.
- Preserve stop_rx() and shutdown across recovery, and retain the
  DesignWare empty-FIFO timeout workaround when receiving through PIO.
- Apply the requested guard spacing and container_of() formatting.
- Link to v1: https://patch.msgid.link/20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com

---
James Hilliard (5):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: serialize asynchronous write wakeups with the port lock
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer

 drivers/tty/serial/21285.c          |   2 +
 drivers/tty/serial/8250/8250.h      |  59 +++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 284 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 +++-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++--
 drivers/tty/serial/atmel_serial.c   |   2 +
 drivers/tty/serial/clps711x.c       |   6 +-
 drivers/tty/serial/cpm_uart.c       |   2 +
 drivers/tty/serial/fsl_lpuart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c    |   3 +-
 drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
 drivers/tty/serial/lantiq.c         |   3 +-
 drivers/tty/serial/ma35d1_serial.c  |   6 +-
 drivers/tty/serial/max3100.c        |   6 +-
 drivers/tty/serial/max310x.c        |   9 +-
 drivers/tty/serial/mux.c            |  13 +-
 drivers/tty/serial/mvebu-uart.c     |   2 +
 drivers/tty/serial/mxs-auart.c      |   2 +
 drivers/tty/serial/sb1250-duart.c   |  10 +-
 drivers/tty/serial/sccnxp.c         |  45 ++++--
 drivers/tty/serial/serial_core.c    | 100 +++++++++++--
 drivers/tty/serial/ucc_uart.c       |   6 +-
 include/linux/serial_core.h         |  18 ++-
 25 files changed, 532 insertions(+), 155 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
prerequisite-patch-id: 2876a1809e5fe29b8825950a32796aef1d885054
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


