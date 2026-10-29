Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FD606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yj4a78Wk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFbgC6bDzz30gC;
	Thu, 29 Oct 2026 18:37:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793259479;
	cv=none; b=KETpvR5sxfy/rAIteskdFrOKOT2FtiRREO/Ax58dpRBXysygJ9Z4yQEaNT0Fgz8bcTZNfiMemBz2PqC66KoxUudNHv4jVXkvpo9oxqv/kNQWEKGXSbpiNwjQ+hVdROJQPKPq5/Cw/DPGE4aMGm6CxFD8orhoHvUGmouWfozs/Lh82iZWCf1LxO2/rulF/L95L7wGdntWbyWbZerg/9rP88dNZ2/BFZOKh6SnPn1nojhiHCoaivCvyU29AHJr9lE7i7FEy9X4H0A2M+e0qajOPdSI3Ow0CjUgnpF3wITAtYGnxAaS4vCJFTfYf/kPS2xh3f1e2W36pavw2s/gcrsFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793259479; c=relaxed/relaxed;
	bh=f4A3fsginImgL7nHh+bUVI4tTAdAQ7Dw1/UUiyq8gIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNg6ViIRsJUme1ASv97d0dQAY1n7Mn/S+z+jGDV43bdH/oxd+e/0sRHXwOCCrHKnGp4acDEKUX9ej+/tdWfOcZVLDTWSskBWesZT/oJgKfdwODFQzzm4Tvy7d1ISLHsoNM0Za+YV3sqBKOPeNJhXoNwd9osDAdBPRKU9SkXqtLHhuVq0GKRP43V9w5QWGnyGn5K39lYF6aCD/UeMmIOyMuy4HClbr5fWhlb21MGXy8Ih8gk2Y/3T2dM+Ehy/+7NiGCtkuzNKT8RN1RN5GN7PobVGC5LfoES+/2FI0PfnQJkh2/Fe6/k10eAFdSIaiNmGnfmGObmpjckcxVBrfh3ElA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yj4a78Wk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yj4a78Wk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFbg65C8Lz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 18:37:54 +1100 (AEDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-4f48d91ba7dso1015064b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259472; x=1793864272; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4A3fsginImgL7nHh+bUVI4tTAdAQ7Dw1/UUiyq8gIc=;
        b=Yj4a78Wk9ac/kmx0/iEDSAQ3zaojiSizHuMXZMOIE5CfwTlQV+mkgUeIKEMNZ/k3Go
         hGhtp2j4Oazq+1CKIDwjqM6fbN0HMGQgWv5XUHiGyAOOTLtuW7wAZ4hHc5QAn1WhJ7Or
         y63Ud1NqtjaSrpHsOAq7Ru/3k8PhqBtBPteztULCukntHI+0caWpr8sEfRTMDgDOaOui
         HC2WtFKccphVYD33Z5x1U9JjEm+6oQm5GGm9OlRvbIQw8sv/Upfjh5s98b1d4OFjbdXg
         8thWQfiS5EQunz7zRQGW3uD55YZUldI8b5TLpXk/r3JJdQ85kAfcTd+jWvZB6OaqLUeT
         /9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259472; x=1793864272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4A3fsginImgL7nHh+bUVI4tTAdAQ7Dw1/UUiyq8gIc=;
        b=RnZDAAsY2Mxc570jTSTUg5uqMyYMOftVPelUQpbe6A+/8SFFem28Rau3uXEVVUOncM
         Ddlx9ayx49Cds8v8OXlxW7XNF4wElT8Om5DqFwWzG9b+yYPO6UucW6Kht47zZoM3mY5m
         zgKob9BwKRsAB7u1THOdz57p6vHaVmGzfCOv/0EQigOow+kzN6EHXyyaHww/FaYSe6Rl
         /SfLOSs1zpnA/twvNfnwJSRrRujLUB/eL3/ci78qK/crLPyqkAHXtRLV7PLk1YjHUCte
         jG068YPpwkiMVxkk81p0yJCpgLScaOGOYUCopMvtH4wqoPGWSydmRCDFV7pfuKDq0nnG
         4fow==
X-Forwarded-Encrypted: i=1; AKwUvBx7bNYB9YB8nQpU7mXqORbjWJNC7VvQLFNIV2vu7Pa18MTdnfuSRt41kDnHmU1Fe0ISlhTt6fOdBFxXS98=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJibL49dXyX74O1DQ218IucfKAO9jejlMvR8DOBVLqmwmewFkso
	Q18z5DoALP5IoqqJ2HW4+VXAk2iXrZbSt2Y/wS9gaVyzbLXA90AIL45w
X-Gm-Gg: AYBFou3vWzeDTcpSAYgRYc7xIpvjp9bfuYM2pjjo6JwxYi1sO6UJO/AdYvsKHpPr9q3
	6HV1R1LwBMFBTuwn4y/KCKzIn+i7ceMVDCBRND85e86+YLOAc9zpJX8bcq+1uRaAFAFS0VydrGf
	7KzVD3RVgC4lOIRUSIvwnIsz9ptuDnqBdNBb9XCYd3Z0Fgus1+LWv0bBfd9GqTlFL5V4vMc1Z5g
	ZQTDdHyfdws/+UcbM+jBPDalNxwVAG6l61WWBuZgl2rQ/IxS7Ymn8qi7aZ375P+Y06liGIswPQ6
	zRsDuaCJUZqU/tXZpc/RqHlDJjTfqgcq41V1zNlNmBDWNCLq04mdQ7Z280N8k0deXOaKY1Md4H3
	EwmS+ZZQ87eIRge9DKBaLQgV9QZkZaHSpv55A4M7oHHnqPkfmOTV9tph1CIrcSkGq9VkxJpq+tC
	jgjL1XOdvTPQD1uf+GhznegiXriHIWOrjrZKK9K+tuYvYtwnc4ZwREmBW2qSP36RNsxb9v6xfOC
	/nVCkZC9muKjWqiYu2NR8jCe+8ZGZd2CrFZL6ZQXlmgwwSNJTXtDYYaSbiePp2HeJ0UAQMmG6yW
	3nY5Uf5QvfzuFDLclogascGInEQp8NuIT0mhlKNyGEgxjndOKXmrm4MjAZFBXFgKzlKOTGWBd8K
	oGQXH5hnCGWV3+OkBZcQkrYuwym00Dm7VlKBL6xbCVXG9aJ0xos6WnX4sPq1YfRNc5ZkyVIVI7D
	rJCTZKhq5ehv4nwaQqqYnSoJ+IVdaPqfnOXg7LMdm7NMU6qe2eU+zH
X-Received: by 2002:a05:6808:c215:b0:55c:925:9d5c with SMTP id 5614622812f47-56384987f0bmr3136241b6e.55.1793259472002;
        Thu, 29 Oct 2026 00:37:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c3638604sm3321976b6e.1.2026.10.29.00.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:37:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 01:37:01 -0600
Subject: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before reusing
 the receive buffer
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
Message-Id: <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
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

The generic RX timeout path pauses a transfer, copies its data and
terminates it asynchronously. Clearing rx_running at that point lets a
new receive reuse the buffer and cookie while the old callback has not
yet run. Inspecting the new cookie cannot distinguish that callback from
the completion of a new transfer.

Reserve the receive buffer until a worker has drained the canceled
callbacks. Keep FIFO access separate from callback retirement: after a
successful pause and termination, clear rx_running while rx_terminating
prevents another descriptor from reusing the buffer. Deliver the paused
data before allowing the interrupt handler to drain the FIFO through PIO.
Normal retirement only releases ownership and leaves subsequent receive
handling to the UART interrupt.

Preserve the normal completion-path LSR read and gate DMA resubmission on
the receive interrupt enable, so stop_rx() prevents another transfer while
the status read retains its existing side effects.

Reject new flush work and PIO receive handling during shutdown, including
late Intel MID DMA timeouts. Stop and drain retirement work before freeing
the channels and buffer. Once RX has stopped, allow the idle flush used by
DesignWare LCR recovery during shutdown. Clear the shutdown guard before
startup configures the UART and tests its interrupts.

Check pause failures before accessing the buffer. A successful pause is
the quiescence guarantee, even when a provider still reports IN_PROGRESS.
Also accept DMA_COMPLETE after a failed pause: completion can stop the
channel before its callback acquires the port lock, leaving nothing for
the provider to pause. Retire that completed transfer normally.

A failed pause with an incomplete cookie is ambiguous: hardware may have
finished while its completion interrupt is still pending. Canceling that
descriptor can discard the entire completed receive buffer and switch
permanently to PIO. Retain the transfer and retry pause and status in the
worker, with receive interrupts masked to prevent a timeout interrupt
storm. The worker copies only after a successful pause or reported
completion, then terminates and drains the old callback before reuse.
The pending-pause guard keeps callbacks from copying or resubmitting the
transfer concurrently. Retries sleep outside the port lock and stop when
shutdown takes over. A provider which never pauses or completes retains
RX ownership until an error or shutdown; a timeout alone cannot establish
that discarding the buffer is safe.

On DMA_ERROR or termination failure, let the worker stop DMA before
handing the FIFO to PIO. Keep the requested enables in the existing IER
shadow and filter hardware writes during pause retries and recovery,
including termios, RS485 and overrun-backoff changes. Apply the current
enables after retirement so stop_rx() and shutdown remain effective.
Hold a runtime PM reference around worker register accesses and keep RX
on PIO until reopen after a confirmed error.

Abort the DesignWare idle sequence when RX cannot be stopped. Allow
the empty-FIFO timeout workaround once DMA has released the FIFO, including
while callbacks retire. Exclude FIFO resets during RX DMA recovery. If the
provider still cannot terminate the channel in process context, retain
its buffer and leave receive interrupts masked.

For OMAP, publish the shutdown gate under the port lock before the final
RX flush and interrupt masking. Take the RX DMA lock inside the port lock
in the completion callback, and serialize the runtime-suspend flush with
the same order. Drain the UART IRQ before releasing DMA state so an
in-flight handler cannot retain up->dma across its release.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  42 +++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 197 +++++++++++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_dw.c   |  28 +++--
 drivers/tty/serial/8250/8250_omap.c |  28 +++--
 drivers/tty/serial/8250/8250_port.c |  31 ++++--
 6 files changed, 262 insertions(+), 66 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 9f01fa36fa3c..d51a0aa0aae8 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -23,6 +23,7 @@ struct uart_8250_dma {
 	/* Completion processing with the port lock held. */
 	void (*tx_complete)(struct uart_8250_port *p);
 	struct work_struct tx_flush_work;
+	struct work_struct rx_flush_work;
 	struct uart_8250_port *port;
 
 	/* Filter function */
@@ -55,11 +56,16 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running;
 	unsigned char		tx_err;
+	/* RX DMA may access the FIFO; independent of callback retirement. */
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
 	bool			shutting_down:1;
 	bool			tx_terminating:1;
 	bool			tx_flushed:1;
+	bool			rx_terminating:1;
+	/* Retry pause without discarding a completion awaiting its DMA IRQ. */
+	bool			rx_pause_pending:1;
+	bool			rx_err:1;
 };
 
 struct old_serial_port {
@@ -148,6 +154,29 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+static inline bool serial8250_rx_dma_running(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_running;
+}
+
+static inline bool serial8250_rx_dma_recovering(struct uart_8250_port *up)
+{
+	return up->dma && (up->dma->rx_pause_pending ||
+			   (up->dma->rx_err && up->dma->rx_terminating));
+}
+
+/* Keep the desired enables in up->ier while RX DMA recovery masks hardware. */
+static inline void serial8250_out_IER(struct uart_8250_port *up, u8 ier)
+{
+	lockdep_assert_held_once(&up->port.lock);
+
+	if (up->dma && up->dma->shutting_down)
+		ier = 0;
+	else if (serial8250_rx_dma_recovering(up))
+		ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE);
+	serial_out(up, UART_IER, ier);
+}
+
 /**
  *	serial_lsr_in - Read LSR register and preserve flags across reads
  *	@up:	uart 8250 port
@@ -221,7 +250,7 @@ static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -233,7 +262,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -417,7 +446,7 @@ extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
-extern void serial8250_rx_dma_flush(struct uart_8250_port *);
+int serial8250_rx_dma_flush(struct uart_8250_port *p);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
 
@@ -473,7 +502,12 @@ static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
-static inline void serial8250_rx_dma_flush(struct uart_8250_port *p) { }
+
+static inline int serial8250_rx_dma_flush(struct uart_8250_port *p)
+{
+	return 0;
+}
+
 static inline int serial8250_request_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..ca06288038ed 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -738,7 +738,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 
 	guard(uart_port_lock_irqsave)(&up->port);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int __serial8250_register_8250_port(struct uart_8250_port *uart,
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 344f0dd24b41..f980b4faf6a3 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -8,6 +8,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_reg.h>
 #include <linux/dma-mapping.h>
+#include <linux/delay.h>
 
 #include "8250.h"
 
@@ -86,53 +87,153 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
 
-static void __dma_rx_complete(struct uart_8250_port *p)
+static void serial8250_rx_dma_copy(struct uart_8250_port *p,
+				   const struct dma_tx_state *state)
 {
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tty_port = &p->port.state->port;
-	struct dma_tx_state	state;
-	enum dma_status		dma_status;
-	int			count;
-
-	/*
-	 * New DMA Rx can be started during the completion handler before it
-	 * could acquire port's lock and it might still be ongoing. Don't to
-	 * anything in such case.
-	 */
-	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	if (dma_status == DMA_IN_PROGRESS)
-		return;
-
-	count = dma->rx_size - state.residue;
+	size_t			count = dma->rx_size - state->residue;
 
 	if (tty_insert_flip_string(tty_port, dma->rx_buf, count) != count)
 		p->port.icount.buf_overrun++;
 	p->port.icount.rx += count;
-	dma->rx_running = 0;
 
 	tty_flip_buffer_push(tty_port);
 }
 
+static void serial8250_rx_dma_recover(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	/* Keep PIO and new descriptors out until the worker stops the channel. */
+	dma->rx_err = true;
+	dma->rx_terminating = true;
+	serial8250_out_IER(p, p->ier);
+}
+
+/* Try to obtain a stable residue before retiring the current descriptor. */
+static int serial8250_rx_dma_try_flush(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	struct dma_tx_state state;
+	enum dma_status status;
+	int ret;
+
+	lockdep_assert_held_once(&p->port.lock);
+
+	ret = dmaengine_pause(dma->rxchan);
+	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	if (status == DMA_ERROR) {
+		ret = -EIO;
+		goto recover;
+	}
+	if (ret && status != DMA_COMPLETE) {
+		/*
+		 * Hardware may be idle before the provider publishes completion.
+		 * Leave the descriptor alive and retry outside interrupt context;
+		 * neither copying its buffer nor canceling it is safe yet.
+		 */
+		dma->rx_pause_pending = true;
+		serial8250_out_IER(p, p->ier);
+		return ret;
+	}
+	/* Some providers still report IN_PROGRESS after a successful pause. */
+	serial8250_rx_dma_copy(p, &state);
+	dma->rx_terminating = true;
+	ret = dmaengine_terminate_async(dma->rxchan);
+	if (ret)
+		goto recover;
+
+	/* DMA released the FIFO; retain the buffer until callbacks retire. */
+	dma->rx_running = 0;
+	return 0;
+
+recover:
+	serial8250_rx_dma_recover(p);
+	return ret;
+}
+
 static void dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
 	struct uart_8250_dma *dma = p->dma;
-	unsigned long flags;
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	uart_port_lock_irqsave(&p->port, &flags);
-	if (dma->shutting_down)
-		goto out;
-	if (dma->rx_running)
-		__dma_rx_complete(p);
+	guard(uart_port_lock_irqsave)(&p->port);
 
-	/*
-	 * Cannot be combined with the previous check because __dma_rx_complete()
-	 * changes dma->rx_running.
-	 */
-	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
-		p->dma->rx_dma(p);
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+	if (dma->shutting_down || dma->rx_terminating || dma->rx_pause_pending)
+		return;
+	if (dma->rx_running) {
+		status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+		if (status == DMA_ERROR) {
+			serial8250_rx_dma_recover(p);
+			schedule_work(&dma->rx_flush_work);
+			return;
+		}
+		if (status != DMA_COMPLETE)
+			return;
+		serial8250_rx_dma_copy(p, &state);
+		dma->rx_running = 0;
+	}
+
+	/* Preserve LSR read side effects when stop_rx() has disabled resubmission. */
+	if ((serial_lsr_in(p) & UART_LSR_DR) && (p->ier & UART_IER_RDI))
+		dma->rx_dma(p);
+}
+
+static void serial8250_rx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
+	struct uart_8250_port *p = dma->port;
+	bool recover, retry, restore_rx;
+	int ret;
+
+	guard(serial8250_rpm)(p);
+
+	for (;;) {
+		scoped_guard(uart_port_lock_irqsave, &p->port) {
+			/* Shutdown cancels this work and drains both DMA channels. */
+			if (dma->shutting_down)
+				return;
+			if (dma->rx_pause_pending && !dma->rx_terminating)
+				serial8250_rx_dma_try_flush(p);
+			retry = dma->rx_pause_pending && !dma->rx_terminating;
+			recover = dma->rx_err;
+		}
+		if (!retry)
+			break;
+		/* Let the DMA IRQ publish completion or a pending pause settle. */
+		usleep_range(1000, 2000);
+	}
+
+	if (recover) {
+		ret = dmaengine_terminate_sync(dma->rxchan);
+		if (ret) {
+			/* Retain ownership and keep RX masked if DMA cannot be stopped. */
+			dev_err(p->port.dev, "failed to stop RX DMA: %d\n", ret);
+			return;
+		}
+	} else {
+		dmaengine_synchronize(dma->rxchan);
+	}
+
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		restore_rx = recover || dma->rx_pause_pending;
+		dma->rx_pause_pending = false;
+		dma->rx_terminating = false;
+		dma->rx_running = 0;
+		if (dma->shutting_down)
+			return;
+
+		if (!restore_rx)
+			return;
+
+		/* Apply the current enables, including any intervening stop_rx(). */
+		serial8250_out_IER(p, p->ier);
+	}
+	if (recover)
+		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
@@ -242,6 +343,9 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down || dma->rx_running)
 		return 0;
+	/* A retiring transfer has released the FIFO, but not its buffer. */
+	if (dma->rx_err || dma->rx_terminating)
+		return -EIO;
 
 	serial8250_do_prepare_rx_dma(p);
 
@@ -262,16 +366,26 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 	return 0;
 }
 
-void serial8250_rx_dma_flush(struct uart_8250_port *p)
+int serial8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	int ret;
 
-	if (!dma || !dma->rxchan || !dma->rx_running)
-		return;
+	lockdep_assert_held_once(&p->port.lock);
 
-	dmaengine_pause(dma->rxchan);
-	__dma_rx_complete(p);
-	dmaengine_terminate_async(dma->rxchan);
+	if (!dma || !dma->rx_running)
+		return 0;
+	/* A late interrupt must not hand a still-active receiver to PIO. */
+	if (dma->shutting_down)
+		return -ESHUTDOWN;
+	if (dma->rx_terminating)
+		return -EIO;
+	if (dma->rx_pause_pending)
+		return -EAGAIN;
+
+	ret = serial8250_rx_dma_try_flush(p);
+	schedule_work(&dma->rx_flush_work);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -368,10 +482,14 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->port = p;
 	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	INIT_WORK(&dma->rx_flush_work, serial8250_rx_dma_flush_work);
 
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->tx_terminating = false;
 		dma->tx_flushed = false;
+		dma->rx_terminating = false;
+		dma->rx_pause_pending = false;
+		dma->rx_err = false;
 		dma->shutting_down = false;
 	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
@@ -395,10 +513,15 @@ void serial8250_release_dma(struct uart_8250_port *p)
 		return;
 
 	cancel_work_sync(&dma->tx_flush_work);
+	cancel_work_sync(&dma->rx_flush_work);
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
-	dma->rx_running = 0;
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->rx_running = 0;
+		dma->rx_terminating = false;
+		dma->rx_pause_pending = false;
+	}
 	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size,
 			  dma->rx_buf, dma->rx_addr);
 	dma_release_channel(dma->rxchan);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..050a1c23d9f0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -112,7 +112,7 @@ static void dw8250_idle_exit(struct uart_port *p)
 	if (up->capabilities & UART_CAP_FIFO)
 		serial_port_out(p, UART_FCR, up->fcr);
 	serial_port_out(p, UART_MCR, up->mcr);
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 
 	/* DMA Rx is restarted by IRQ handler as needed. */
 	if (up->dma)
@@ -134,6 +134,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int retries;
+	int ret;
 	u32 lsr;
 
 	lockdep_assert_held_once(&p->lock);
@@ -147,7 +148,12 @@ static int dw8250_idle_enter(struct uart_port *p)
 	serial_port_out(p, UART_IER, 0);
 
 	if (up->dma) {
-		serial8250_rx_dma_flush(up);
+		ret = serial8250_rx_dma_flush(up);
+		if (ret) {
+			serial8250_out_IER(up, up->ier);
+			d->in_idle = 0;
+			return ret;
+		}
 		if (serial8250_tx_dma_running(up))
 			serial8250_tx_dma_pause(up);
 	}
@@ -390,9 +396,9 @@ static void dw8250_quirk_ier_kick(struct uart_port *p)
 	if (!(lsr & UART_LSR_THRE))
 		return;
 
-	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial8250_out_IER(up, up->ier | UART_IER_THRI);
 	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
-	serial_port_out(p, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static int dw8250_handle_irq(struct uart_port *p)
@@ -429,6 +435,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	d->no_int_count = 0;
 
+	if (up->dma && up->dma->shutting_down)
+		return 1;
+
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
 	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
@@ -436,10 +445,11 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * read.  If we don't do this then the "RX TIMEOUT" interrupt will
 	 * fire forever.
 	 *
-	 * This problem has only been observed so far when not in DMA mode
-	 * so we limit the workaround only to non-DMA mode.
+	 * Only read the FIFO when DMA no longer owns it, including PIO fallback
+	 * after a DMA error.
 	 */
-	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_timeout) {
+	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) &&
+	    !serial8250_rx_dma_running(up) && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		/*
@@ -454,7 +464,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
-	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
+	if (quirks & DW_UART_QUIRK_IS_DMA_FC && rx_timeout &&
+	    serial8250_rx_dma_running(up) && !up->dma->rx_terminating &&
+	    !up->dma->rx_pause_pending) {
 		status = serial_lsr_in(up);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 13507409a5b6..9211ccda316a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
-		omap_8250_rx_dma_flush(up);
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -780,13 +778,16 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	/* Synchronize UART_IER access against the console. */
 	scoped_guard(uart_port_lock_irq, port) {
-		if (up->dma)
+		if (up->dma) {
 			up->dma->shutting_down = true;
+			omap_8250_rx_dma_flush(up);
+		}
 		up->ier = 0;
 		serial_out(up, UART_IER, 0);
 	}
 
-	disable_irq_nosync(port->irq);
+	/* An in-flight handler may still be using up->dma. */
+	disable_irq(port->irq);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -898,7 +899,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Must be called with the port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +912,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +981,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1000,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1329,6 +1336,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	uart_port_lock(port);
 
+	if (up->dma->shutting_down) {
+		uart_port_unlock(port);
+		return IRQ_HANDLED;
+	}
+
 	status = serial_port_in(port, UART_LSR);
 
 	if ((iir & 0x3f) != UART_IIR_THRI) {
@@ -1818,8 +1830,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cfbd154bf5f9..51ecaacf9097 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1306,7 +1306,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 /**
@@ -1332,7 +1332,8 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_and_reinit_fifos(p);
+		if (!serial8250_rx_dma_recovering(p))
+			serial8250_clear_and_reinit_fifos(p);
 
 		if (toggle_ier) {
 			/*
@@ -1346,7 +1347,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 			lockdep_assert_held_once(&p->port.lock);
 
 			p->ier |= UART_IER_RLSI | UART_IER_RDI;
-			serial_port_out(&p->port, UART_IER, p->ier);
+			serial8250_out_IER(p, p->ier);
 		}
 	}
 }
@@ -1600,7 +1601,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	mctrl_gpio_disable_ms_no_sync(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1619,7 +1620,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	up->ier |= UART_IER_MSI;
 
 	guard(serial8250_rpm)(up);
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
@@ -1816,8 +1817,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 		fallthrough;
 	case UART_IIR_RLSI:
 	case UART_IIR_RX_TIMEOUT:
-		serial8250_rx_dma_flush(up);
-		return true;
+		return !serial8250_rx_dma_flush(up);
 	}
 	return up->dma->rx_dma(up);
 }
@@ -1837,15 +1837,22 @@ void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 
 	lockdep_assert_held_once(&port->lock);
 
+	if (up->dma && up->dma->shutting_down)
+		return;
+
 	status = serial_lsr_in(up);
 
 	/*
 	 * Recover from no-data-ready and FIFO error condition to avoid getting
 	 * stuck in the ISR.
 	 */
-	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE) &&
+	    !serial8250_rx_dma_running(up))
 		serial8250_clear_and_reinit_fifos(up);
 
+	if (serial8250_rx_dma_recovering(up))
+		skip_rx = true;
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
@@ -2345,6 +2352,12 @@ int serial8250_do_startup(struct uart_port *port)
 
 	guard(serial8250_rpm)(up);
 
+	/* The previous shutdown has drained DMA and its callbacks. */
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (up->dma)
+			up->dma->shutting_down = false;
+	}
+
 	serial8250_startup_special(port);
 
 	/*
@@ -2786,7 +2799,7 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)

-- 
2.53.0


