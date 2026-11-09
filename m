Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C58606A333
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUiQm2vD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNG6Y3NNsz2yDs;
	Mon, 09 Nov 2026 14:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794196277;
	cv=none; b=O6rPNlkF7ZrcXHchiivM7VcWNi5qLGQhI9Va0zLoF4hRbl9PzUIIO/UGIx1lHk+szTWl8rmdIMV7669XiAb0HbPkWOXKNFEPH5ftBDOMYP4Q/e4QJoNgRFzXBvnU5YQvbW2aw7B/iW4yvl3zTML8m9ZDiTONvvv+zDsQO57+V8FL0XLnmBZRw0TwHevODGEjSWU9rIzmdzUTcd8kp+koEdhiqwtnyuKF9MIc1S2r989A0K7OxC77/e3dlptmg9v0RzR9qrbcbQ5lnjRkyw9HewgpLCaFwFLVEJgYA+rJBEpOe8DcF2kR4kJF6/zJBB4A5o/p6cxKUlnGfqza+AcdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794196277; c=relaxed/relaxed;
	bh=y3HC3NlDohogGoQG3iyBoABNjpQ8d2suUgv9O6n6PBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=euQo6W0W1e47dYi/AeCQKE1vx8/wXO4rGrTczJSYa1v0AdAKntgWOOrBiPFgm124dhPJh59eQABTxcR2qNCXrU0oJwC7ymBaVy1g0Lt6Ugf9LxJ/aZO0FX3PJv/aYBlpMn2PGAKjIep74exuDasYs979TZwkkFM9QKvRtHio9TRa9mbw9A5fuSsqbVHJsZLGpZ6icVrXoK40dBfuG8YrA10MEIhJUmuJHOOVlC6od+DNFw70cNo9rbLg1xmb8FlRKPdBSCcIh+ntjWv3lmP8aMORGy7DoVRJynrPg1Qagfc5SaMXGsz6LHHwHNkbFoBH+lQfvbZ2UTsesgOkXcpFuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUiQm2vD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUiQm2vD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNG6W0qQWz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 14:51:14 +1100 (AEDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-846566246e8so420057a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794196271; x=1794801071; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y3HC3NlDohogGoQG3iyBoABNjpQ8d2suUgv9O6n6PBk=;
        b=QUiQm2vDnADYrHzzFUvSz3iz5VqR2/tNJajfC+frtJFZY0gNrVEzmJmDLxQwaMOD2r
         DQxKDxu+Tz4zcuzFlERRX2uwQzIfX2aJk/NwVS6YAZCc6iThDQAx2f2BpLWKHoZvnS0n
         58hGx7ZP0Uavwhx24GYQ6bHxcy/ESpJZCCAS1ZWpI20m6v3lM4OAYQifg9eAm8ifQskk
         WcNvs5CcT3XXeWaEHNoAx+YuYqGRvNDN+Z4o8IhU6agBEWeiEDkjtE5wLbZStlIVYBkV
         4luGfguKz4LSLnY5yq0BKSI4+TG0ac+1Z57WMGFfNB0fJknO+5oCm6a28zrEcxIIjQIV
         J25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196271; x=1794801071;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3HC3NlDohogGoQG3iyBoABNjpQ8d2suUgv9O6n6PBk=;
        b=RizORsvMBg+AZOJ1BHTg+QdDKI5jNs3fXUqfOkI8x8OgwwhmqH7jQh+GSE0PwOB3Qa
         QkZg1RYvNI0yFzkO15/OtbuI9Lgy2VDQFLec6/nLGehYulYuFwsfye4tiTb6MA31cFic
         IKcgdDMtC5YXR8MYPt9XO6zufG+XYWnoe+EcrRDi/fY+Deyi3BpH32f8qZk7DJ/eW43n
         HpQqvpDKUN+qTTypaGc6LqrqSpDg+JyM674huW+BL8TFsEbajc5e1P7RVC61mm8Dj5vh
         jIyHmhINM60VM4WrBgnjYV++5eTgyAwKKBLCLDbn882qvOWdKIBCwOE+VSUZWFbIGtlI
         9uDQ==
X-Forwarded-Encrypted: i=1; AL+hErHRTiz4yhV2Dk1Iv1ZSKG0dpXLqd3yWgkOi2wzEIS9DJqO+NBUvKBhzVxnx568iOPhXSDBTVVfMYtVmRoI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+8rgZywF4qy6b6loK9ybqvLrebguzhMx3CVWfaygBI209JzD/7
	Pi12nYdLaM/sSq9IrH2E95E5+cA25vuKrekvXhzsOYNo7/A8dCIKKe3l
X-Gm-Gg: AYBFou1h7Z5rfijl6D1qvHuu6lSamzhuQF0Y+TQTzKVas0+KYp9r9ap25D3evXYLUAo
	qFP+IBIQwfpPK8tF07yZ6kfBCbMUpw57xboNE00Rf7WqIeMgBSG3WRU0By+HuFCkALmtP6NVDOz
	WyU7ZgNQFJH4M8VJax8WQq1Ohn5XBPayxCSRTNBMlv18VQPkX3XRVWWj4ssl3xdUQmfrsBYVZN6
	PgUgkh6VOo+U9lqBTcpFXJyDCqabcTBs61J/GMF0A6jeuSJam/7Nh3yvC+KU1iAevh49SVQdtlp
	tCqFiq0e/TS8rIRCdw2aQJGoGEJYSmgcFjaoKDdsimH2goYs6KXCWGCEpVR1xzgQO4Vo5/L9C6i
	3tmiCki0xlldCOIhDrJjG+P4bgO02JWnS7BC6g1SpfPWMGoRP76Rl7nEbCEDn5otNkkiBzUJbgU
	ijTU1iyx7hZJ+fVI0sGJuOzLd8TNIQARDfqfMhajdMkMAODUsUJxgdkXq0zktB+ipmkE4BoHm1T
	mdP+h3UmcedykCrJo+IP49yijy6fePNhV8E7q03qx/tb5nf6+WSgrnbD9TFfpFevRBGEXBx/t4V
	Shq1L6aKXVqHSfchlm3PttGyGJW8IB+BxL5kEoESoFeXYH0+2OdQcPC01/4qZpcYF9cMtCfaQBe
	qQUJm39suFM079PhVo4M9DjjJL9sVpAHQuxX6nEC/9omaCLCopX7UKANjMpJf7JtmtO//e5c0N4
	9PY7VsHsXbzXOfIlg5fKRKaOycRowhTlq9afvL4J7vwYmS+3RZhRsl
X-Received: by 2002:a05:6830:6415:b0:807:3423:e50a with SMTP id 46e09a7af769-85f5087a5d6mr1689845a34.15.1794196270614;
        Sun, 08 Nov 2026 19:51:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fad32cdsm2800428a34.6.2026.11.08.19.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:51:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v10 0/8] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Sun, 08 Nov 2026 20:50:09 -0700
Message-Id: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XT227bMAwA0F8p8jxvInUj+7T/GPZASWTjoWm3J
 A02FP330emApR4GpIBhQIZ0eBH9vDnoftbD5vbmebPX03yYHx98AeHDzaZv5eFOp3n4hw0GLBA
 QpsNT283HaTkn9xNhDtPYydTloev9dIKpYSCjpMQdNs5836vNP88xvnx9XbvxTftxcZcdTQ46t
 b0L2+WTb9jrj0//jRD+qL7pyRM+vtKvSn/ceXa3N6UgaR2pl4a50wAyiClrFAwDgZBFtGo6U3L
 sWy/z9iaWkJqJRIGOkJjrUDAAKNgIJOUEYlna21OVxwgczVrMijlp5TB8RUTVfD+0koxTfXuKg
 uRQYFDqIWcpqdfiPSbTpgMq90K1Mdsq1mgteZJiYFSACbsVSa3mPCJ3054TIca3p1Ig8kggWJv
 XJl4JhuhRwKv0eg2Bay20ilU8QRvcMHpynhpiNUugycslVkKnUlzFGuRYqREhDOmEI8qQliBXM
 kOrxTIV7LzKkEpmzWrRsvex1hG8JrBAMfQwNBVm9GObZYK28+H4uP91HtoTnC//+vH0J0xq6jf
 KhjHEz3c7me8/+uSc8RNegngFiA56g1UyaCSGNRgvwXgFGB0c3i7W1BNHXIPpvWBaSq6ZfZop+
 nsN5kswXQFmB/26kAsx0vgnw/JesDhYLBafArBcyhqsl2C9AqxLhpTFG9T8/0hrkC5BvgIkB6O
 NXJrEjDrWIP8FXbwC5CVDyNxF/F4SXYIvLy+/AXNZJZ2bBQAA
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
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,T_SPF_HELO_TEMPERROR,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve canceled transmit and receive storage until DMA and its completion
callbacks have retired. Serial-core write backpressure protects a flushed
TX FIFO while normal transfers continue to DMA directly from that FIFO.

The preparatory patches separate OMAP's locked TX completion processing,
serialize asynchronous write wakeups, and fix OMAP RX locking and shutdown
ordering. Serial-core reservation helpers then protect 8250 TX storage.
Flushing empties the logical queue immediately. While the old transfer owns
its storage, write_room() reports zero and write-ready notifications wait for
retirement. Failed termination retains the reservation until normal
completion, without advancing the reset FIFO. DMA retirement releases the
reservation independently of port readiness. Serial core keeps writes and
write-ready notifications gated during shutdown until successful startup
or resume. Flushes still notify threads waiting for the logical FIFO to
empty, independently of whether its storage can be reused.

RX delivers paused data before the PIO fallback and retires callbacks in
process context. Track FIFO access separately from buffer retirement so
PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
released the FIFO. Retry ambiguous pause failures until a successful pause
or reported completion makes the buffer stable. Keep receive interrupts
masked meanwhile, preserving the requested enables in the IER shadow.
Back off pause retries from 1 ms to one second, with completion and shutdown
waking the worker immediately. Report each prolonged stall once per flush,
independently of other ports, while retaining the transfer. Reset the retry
delay when the pending flush finishes.
Confirmed DMA errors use synchronous recovery and leave RX on PIO until
reopen. Shutdown excludes new retirement work before releasing the channels.

Final shutdown retains both channels and their storage until synchronous
termination succeeds. Retry failed channels outside the port lock, starting
with a 1 ms sleep and doubling it up to one second to limit sustained
retries. Report the initial error, ongoing failures at five-second
intervals tracked separately for each teardown, and recovery once both
channels have stopped and drained. A permanently failed DMA engine blocks
teardown while retaining its storage and callback state.

DMA providers must supply the callback-drain guarantee of
dmaengine_synchronize() before retirement releases storage. The related
provider synchronization fixes are tracked separately and must precede
these consumer changes on affected controllers.

Based on tty-next at 6628e7d4c6b2 with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], transmit-PM shutdown fix [4], serport
write-wakeup deferral v2 [5], DesignWare BUSY-safe fractional-divisor
programming [6], and Intel MID RX DMA timeout locking [7]. The serport fix
is needed before serializing the remaining write-wakeup callers with the
port lock.

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com
[5] https://lore.kernel.org/r/20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com
[6] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v10:
- Rebase onto tty-next at 6628e7d4c6b2, retaining the latest posted versions
  of the prerequisites.
- Warn once per stalled RX flush without a shared rate limit, so concurrent
  stalls on different ports and later stalls on the same port are reported.
- Remove OMAP shutdown notifications for the unused generic RX pause worker.
- Use consistent TX cancellation predicates and the shared RX-running helper,
  simplify condition formatting, and describe OMAP locking with Context:.
- Spell retry intervals as explicit multiples of the time-unit constants.
- Use the public bitmap header for SCCNXP wakeup iteration and leave the
  unrelated event-handler iterator type unchanged.
- Share and document the low-water write-wakeup check used by serial-core
  readiness and generic 8250/OMAP TX DMA completion.
- Explain why ambiguous pause failures retain the transfer instead of using
  timeout-triggered PIO recovery, distinguishing data preservation from
  termination safety and documenting the possible indefinite RX stall.
- Track final-termination progress reporting separately for each teardown,
  reporting ongoing failures at five-second intervals without a shared
  rate limiter. Keep the initial failure and recovery reports
  unconditional.
- Collect Raul's Reviewed-by tags for the first six patches.
- Link to v9: https://patch.msgid.link/20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com

Changes in v9:
- Back off pending RX pause retries from 1 ms to one second, wake the worker
  on completion and shutdown, and report prolonged stalls once per flush
  through a rate-limited warning. Reset the delay for each new flush.
- Lock ST ASC startup's transmit servicing and RX interrupt enable after
  requesting the IRQ, covering write wakeups from an empty FIFO as well.
- Wake logical-FIFO drain waiters after a flush even while TX storage is
  reserved or the port is not ready, keeping line-discipline write-ready
  callbacks deferred until writes are allowed.
- Use plain port locking where interrupt context or an enclosing IRQ-saving
  lock already supplies the required exclusion, retaining IRQ-saving locks
  in workers, tasklets and mixed-context callers.
- Separate OMAP RX completion/flush locking and shutdown IRQ draining into
  two preparatory fixes, with their own rationale and Fixes tags.
- Place the new delay header before the existing include block.
- Back off failed final DMA termination retries from 1 ms to a one-second
  cap. Report the initial failure, rate-limit ongoing failures with elapsed
  time and current RX/TX errors, and report successful recovery.
- Link to v8: https://patch.msgid.link/20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com

Changes in v8:
- Retain RX transfers after ambiguous pause failures and retry in the worker
  until pause succeeds or completion is reported, preserving delayed data
  while masking RX interrupts and allowing shutdown to take over.
- Retain both DMA channels and their storage during final shutdown until
  synchronous termination succeeds, retrying failures outside the port lock.
- Update the serport write-wakeup prerequisite to the posted v2.
- Cover DZ transmit servicing, DECstation ZS TX/modem handling and
  JSM Classic modem notifications with the port lock.
- Defer ZS console-triggered TX restart to a worker, preserving the
  port-before-SCC lock order and draining work during teardown.
- Release Lantiq's private hardware lock before write-wakeup callbacks.
- Assert the port-lock contract in uart_write_wakeup().
- Retain the tx_running guard in generic and OMAP TX callbacks.
- Publish OMAP's shutdown gate before the final RX flush, serialize
  RX completion and runtime-suspend flushes with port and RX DMA locks,
  and drain its UART interrupt before releasing DMA state.
- Link to v7: https://patch.msgid.link/20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com

Changes in v7:
- Rebase onto tty-next at 6b4b543fa187.
- Use v4 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Use an unsigned long bitmap and for_each_set_bit() for SCCNXP
  deferred write wakeups, with unsigned port indices.
- Narrow SB1250 modem-status locking to shared-state updates and
  avoid taking the port lock for RX-only interrupts. Keep TX FIFO
  consumption and interrupt masking serialized with writers.
- Link to v6: https://lore.kernel.org/r/20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com

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

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacky Huang <ychuang3@nuvoton.com>
To: Shan-Chun Hung <schung@nuvoton.com>
To: Pali Rohár <pali@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Timur Tabi <timur@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Tony Lindgren <tony@atomide.com>
To: Raul E Rangel <rrangel@chromium.org>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org

---
James Hilliard (8):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: serialize asynchronous write wakeups with the port lock
      serial: 8250_omap: serialize RX DMA completion and flushing
      serial: 8250_omap: quiesce DMA IRQ handling before shutdown
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer
      serial: 8250: retain DMA resources when termination fails

 drivers/tty/serial/21285.c          |   2 +
 drivers/tty/serial/8250/8250.h      |  66 +++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 406 +++++++++++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_dw.c   |  28 ++-
 drivers/tty/serial/8250/8250_omap.c |  69 ++++--
 drivers/tty/serial/8250/8250_port.c |  36 +++-
 drivers/tty/serial/atmel_serial.c   |  12 +-
 drivers/tty/serial/clps711x.c       |  23 +-
 drivers/tty/serial/cpm_uart.c       |   2 +
 drivers/tty/serial/dz.c             |   9 +-
 drivers/tty/serial/fsl_lpuart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c    |   6 +-
 drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
 drivers/tty/serial/lantiq.c         |  12 +-
 drivers/tty/serial/ma35d1_serial.c  |   6 +-
 drivers/tty/serial/max3100.c        |   6 +-
 drivers/tty/serial/max310x.c        |   9 +-
 drivers/tty/serial/mux.c            |  13 +-
 drivers/tty/serial/mvebu-uart.c     |   2 +
 drivers/tty/serial/mxs-auart.c      |   2 +
 drivers/tty/serial/sb1250-duart.c   |  25 ++-
 drivers/tty/serial/sccnxp.c         |  43 +++-
 drivers/tty/serial/serial_core.c    | 104 ++++++++-
 drivers/tty/serial/st-asc.c         |   2 +
 drivers/tty/serial/ucc_uart.c       |   6 +-
 drivers/tty/serial/zs.c             |  94 ++++++---
 drivers/tty/serial/zs.h             |   3 +
 include/linux/serial_core.h         |  34 ++-
 29 files changed, 810 insertions(+), 223 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 76506fd9b234c7268227ff41e4d0989e82a1a433
prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


