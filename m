Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27F606A328
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G9Kvp7IE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBsXM3YgZz2xnh;
	Sun, 25 Oct 2026 07:52:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792875155;
	cv=none; b=X6lHELOpTzDmgoNT5Kf2kW6Rmjov0SLs+OzgZLnQVeW7dGGiydKmnvFyOVqNN1jCo2BR5GbOZspcTbZtOELhoRfuH/B2MQkJuKV58y1EfGcu8i0iU0q4d8DulPZsE4xDxXx862EDy8cGiRom+j0kO68U7X9CRB01LSzxtk3nbESbFDa8XXZHSgwLwPtp00VJfOnwZJd5TGbAlWeKz2Z1xjlyhRsV6zClqWKIdc/TlwoBnpCMuAvRozblv+joHC+4p8k1G71MMzL5rE9e0mygA0cWhnHcJrzbAAurz/Lq8KT3mpMcOkHaXDOrUyoAEBG+hAqv2y4WBdm1s/tiVtxLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792875155; c=relaxed/relaxed;
	bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQaB7OsJ6V/Uts+MsOTPi2VGT4yA1nemM0ZpchmPzw3dMVz+kWD12z2Ybw3rxgZ8DIerEcZdTRmkAsoO2SSjYle7XXyxrRBpYjn0wsgyMy1uOrmSWj3LJfC8Ia3X1tc17S41IqskCOi+jgXNZq03YofPvK8Ox7W+MeBKvbp8isfBW4VWdYCw7bUH6MfvEZKW4B5uWxjK1Da+VcFKmDgBHQFcry7TAKajmB0T/AbEAQ9aZ+J7Rx5Eezl+xsD3+YiqmfDP0XjrEGZPsIQi9FXVxiVOdmXZknF/aevsQ/eU+vj3awY4buGbqW2FNhmTpF61FiHAXDhiXML9wnhuSUfogQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G9Kvp7IE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G9Kvp7IE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBsXL3RGZz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 07:52:34 +1100 (AEDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-82109f51565so807664a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875151; x=1793479951; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
        b=G9Kvp7IEoqucnjRHl+kF76FeGcbV5onTvsqgd8RAtRYO5uFj0Rf5dPtusFdLj3hXDN
         NdSjT1GfFpQVGjFph0spuNPt/qvslmbPCho8srTsMcf5aBVm1ObJISdiaQkiHMLpfAO0
         B5qollkMhqNTP+cdom57+AhTHEzoMmJ+G5fyU1BgK1b22lCxf2IomXeGvj4pu0e6Nn1A
         lJfz/ajzikDbsP5WGOQe3w9nG1mN+gtAU7F27Ct0Pjb50MsI7cWKILOm/ee19/D4zw2G
         3ukeuZYE+Pe4t5Ap8PNtsJE8qSyCqB1QuIIFVAPChS9kTJyXyyefNNpzK2CFE1cNZIQB
         8Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875151; x=1793479951;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q5g+37LHyIr/5ZHcnQ2k9bfTXYcAaVphq0sZK3Ck0qI=;
        b=BMRTxQVsZk/sX6339LTmmPjPQADPXq/NerEM57j2JpXwEDKs4KbZVXHgdhFB9FmRwV
         I/1zz7v54DmnHgjemsiIpyDH29cw2YYAhjHqmxnQ9jqosIqFqU6vOdGYHNiyYWIfjJ1t
         vw0iw+rOTd7iHxYyRHaRkH9VZMSBLpdiMhiLWn/eBBjiOrdT7xOG8Q+JwMrJezJ4cH+p
         ZKpLI5s7f8vr66aFBtP60ZXojpMxORtK1Tu2hqvbvw7p/SI5D+tQMkNVGkrXjrGAqpv5
         u0ncSb7oBN32ZzuvGYJ/9++PdPC0HovfENukRf5DKkaGDRIWhrXqNpWP4GWkv85drudz
         kyzw==
X-Forwarded-Encrypted: i=1; AKwUvBwc3CQ8RWjHVhnfops4B+MLODyeWqhsbHXZJOuT5sOTyLICjVKPXyBlv616WdIOvWPQxNvo/d9xWe5f2WQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJvZTnUI8//w/FhT+2CN8PYydIozjib50Pjg1OAGaXpBXt4uQN0
	gxrGfwHwvhqMhmuvBMHQrbdyzU/QN9SXQ3eFrV/6Xw+54R9JzpOEqzrA
X-Gm-Gg: AYBFou2TP4MG5fCOypghK2AMeZoF9U/z+dm9d9+pnL96Jdk9ReYXNkPvjFgFUlj78kp
	moK4LSFfPFdVmvw7UHlsmZm3n/fb32zxaOFk2EmfCasSiz8IfhVpsIxfLMSHpuacX+z6UbZLhru
	AsE9b+5C1+gWE4B9p3rDk6SVVVZObzVQiq6MQmQbmv+4Gb0MDte7044OqX4qhD69w9ngFYCRukJ
	1hE9tBwDhMh/mQgmwSBvys2+KKgjiTaSoZL5w2xfxweba1aA9evqEnCGAfrwRvLiMH8bjkbjKQo
	xEkvBGTdwE6MmYlQeo7hDYcJvrDm33L0r2TJ77nKkOxQd+TRgEoxquYnL7JSSrM+CcKuU3c0/fa
	ozm/MhR+dM+7VamNhb2k5QRLZGvllWHNkNCLdqUET8/ZY+sWrdQneoaH1GPkEZBEosBea6Rxi2k
	X/Xr8RMVO/G3Qe+qsmzloudi5sBSVmGOXV5qObX1WNZzv2jXDkwJwOVxjWDhiD2wqBiW3/px3bt
	s9ETGsAHoictqYOsd9938aRcYp42q7cnAVfdtYZ+s0qhWsYausiiEu4eveH+KilYlNZZV88hIMe
	tOf246jFBHkNtnQQIUgiGoO24Dd2/zdR28CuMZ6rjaTX7gwWwLYIemBU2mHiSxLOH4sTzymE8Es
	c6US/KZ0MGE3bV3rWQI2lOGYcZKGzh5709u96MUq3795Siu8wd7FdtmE1hPPVH+ct7Bs1Omgmqx
	ajBg==
X-Received: by 2002:a05:6808:1923:b0:4d6:90f3:74b2 with SMTP id 5614622812f47-55c003b61e2mr1752748b6e.50.1792875151379;
        Sat, 24 Oct 2026 13:52:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm1986785b6e.7.2026.10.24.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:52:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 0/5] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Sat, 24 Oct 2026 14:52:25 -0600
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WT3W7bMAyFXyXw9byJFCWRvdp7DLvQD7l4aNotS
 YMNRd99dLqLJMCADDAM0OD5jg5Fv04H3S96mB42r9NeT8theX7yIn/YTH1bn77pvAyvJwyYISD
 Mh5e2W47zKquPM2MK89jVudenro/zCeaGgY1JWTpMjvmxV1t+nS2+fH2vnfFd+3Hlrh2tHnRue
 yds10/esNefn/7lkP9CvefFj3t8J79D+vPOD/ewAWAyLopFgnI1aRoBsuXAA5VzoyI4yjij6rF
 vPeXDJuZAzWqNFToCiZShYOBCbAyVEkG1VNu1qsgYQaJZi0kxkbrn8IqZi3k/tEwmVK5VHGoKG
 QZTDynVTL1kHzGbNh1QpGcuTcRuvEZr5IesBsYZhLFbrtRKSiNKN+2JGDFeqygwuxNULM2zVU+
 CIboLeErPawhSSuYbFaWsrRiH0FsaKdQSOgtrHmkl1GKh9UrXqh4H1x5GogHNlGJORTxdgtKte
 krzmfoYb7w4J9GkFi35HEsZwTOBBY7BYUpZBDP2aV2g7XI4Pu9/n1f2BOfLv387/QmzmvqNimE
 M8fO3XV0eP/rmnOEnvATiHUB0oA9YawKNLHALjJfAeAcwOnAUNlHqJBFvgfS/QFojlyQ+eY7+v
 gWmSyDdAUwO9OtCySzof9Ql8O3t7Q/SXrY/VQQAAA==
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
[6] https://lore.kernel.org/r/20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v6:
- Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Serialize CLPS711x TX servicing and interrupt-enable state with the
  port lock. Use non-waiting IRQ disable in stop_tx(), skip queued TX
  interrupts after stopping, and drain the handler outside the lock
  during shutdown.
- Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe
  alongside their interrupt-handler locking, preserving the caller's
  interrupt state when releasing the port lock.
- Report RX DMA recovery after releasing the port lock, keeping the
  state changes and interrupt-enable restoration serialized.
- Link to v5: https://patch.msgid.link/20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com

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
 drivers/tty/serial/8250/8250_dma.c  | 286 +++++++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_dw.c   |  27 +++-
 drivers/tty/serial/8250/8250_omap.c |  38 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++--
 drivers/tty/serial/atmel_serial.c   |  12 +-
 drivers/tty/serial/clps711x.c       |  23 ++-
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
 drivers/tty/serial/sb1250-duart.c   |  14 +-
 drivers/tty/serial/sccnxp.c         |  45 ++++--
 drivers/tty/serial/serial_core.c    | 100 +++++++++++--
 drivers/tty/serial/ucc_uart.c       |   6 +-
 include/linux/serial_core.h         |  18 ++-
 25 files changed, 551 insertions(+), 169 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 4456eb7f800cb5d50a70c898e6d5a452a7f0bca4
prerequisite-patch-id: c3d8ac0d54d1bfe43657964c517cfa4c7fde11af
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


