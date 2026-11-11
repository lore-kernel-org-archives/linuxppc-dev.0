Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E71606A32D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LndH6WA3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyYF6gskz3bl1;
	Thu, 12 Nov 2026 09:16:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435409;
	cv=none; b=Keax6KiLIgOWp0pw20d0feuXAgYwONCMlenfl16fYGz7x8W9QF/77JQSkz/w/pCO0f2Roe2paLp/eWBGXbeNVuKKLotpvtwo7YESWRHIfO9achvuBoa8Qdom+VpywmEtHgEbbsp5gnwk4w7/+zFR6p3bJNjXYcJJldD8g37N88TXcWzk6fvINDVaMgoTzVF1H6UofGWk5Q1Bpye/Otfv2hcBp9aQHxyPeVCj54+XLT3GmcoIbZTGsqFMLVifIplpqrMhFWDlqkTCHUvmfEnbomHtCpPAwu0WQAihhvoYiG7Rb9WSFNKRUnEJm+mQwJA0pDdRcdsDMh+Bl4P3Qy/39w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435409; c=relaxed/relaxed;
	bh=UmU/L3mtytG/sNB91QgHVjOGgDMAszTw4KUZIgC7r8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJuVlYt5poueXfiv931RYFiWgGaBgNrAdBA2fvuIiVTojmdEAu1KwHhhQWse6rCFOAA9FIyF8Y+XV7tWB83S3SZ+htb1o0Swtji8syTHbKK7gXvpBxcWlG9ZRIq1dCMpHs2eCgdPIz9DhjHUWQb8bReE+KCfquBu11amVXE/0Eybw0hGi/KKSximP4bKL01qn5fwHoULDltMyPq/2OgkpAlwoLwGz21HfTcC+8Wv+mSMjjXUNt5ZKS/mLE1Ywz0Yg/VN95kkGrwPDdTn7EFVyIcjwkLSjFevoVMDUpySetn8JdxZr8E+cO7zpMwhjWjVVmyFsjEXdnfH4LBWckHU0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LndH6WA3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LndH6WA3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyYB42Rgz3bgw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:16:46 +1100 (AEDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-4d198f1a591so2352597b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435404; x=1795040204; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmU/L3mtytG/sNB91QgHVjOGgDMAszTw4KUZIgC7r8Y=;
        b=LndH6WA3jyfP+lzfb49h/Oo6zOoJHILZdyyEX34xIFp6C0S9qg7R865Cfl7SDBYHEO
         fNl5GNU7jni1s0NOfYmZQD8QYcJvH4ABArzgkoC4GJV2g7j2/7zt9EbuWvRG4gmODnsW
         9VflGzjhIRoyLIvPrACPkP608+mwZhptn58FqB006sp9A97AT9cXJXFSB6S84glNjLDU
         S08NjS+vYzjA8SB1eGkrLKMU/RHbqCP1YfyeTaGJcxkub57NdAGMwLRmGwOp4fPPP+mS
         uxAuJ7UFVxqYhOYH/Fr8aCvZGQW3GAbDQt4XrfjoI2uOgSk/3YlSX50yiOrpYGIBDfY2
         dx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435404; x=1795040204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmU/L3mtytG/sNB91QgHVjOGgDMAszTw4KUZIgC7r8Y=;
        b=g2wVC07RgIx0HEwxZ3ySd0ZhIc5lCIm4OQmOvIMGU5Rf/vYM2m4+yVor3Dspj3VLKK
         NSuAQ0tkYIqgodjmnWqtic+z6iTPA1XVnAUZ4fQGkkKzXY0PCKJE/QEYSY4C8JJ+yiZ7
         xUM6E141PjBwichn2QfECF/F6xpkwUlGzbhziMDpU0v3YzWqI+DMHs40BiWoEGnlxD3R
         qt5J4DHc3YY55xwr+zUU+j9jRbgVK3NqTKOSmTlA2wNUh7yn8pPxscjIVE47/mTpIN3i
         oR2Rf1XWeNImnE+NHH2zl3bqp5NrawaPe2pcRn0l+qjaBX8ioxxqDlODX4NU0BPLMXJz
         mYVw==
X-Forwarded-Encrypted: i=1; AL+hErFY5QwDlh9pRs+GlJsciEBjmo/zrctYT7VjC+kG6gEqF2LBTDliGkQVx2AzoNoxv+o4hhDaFomnOCmW4Vs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Oy9YU/PsblyzXITVkAiblNYYtA3CKs1oEljlUKlqfqS/1WirX
	kR3C4W8PMKUaZkcsGuLMkv7oFkIVeW0h1Pp5fIhl6EsI0Zfzzzxo/Taq
X-Gm-Gg: AYBFou35p+Z8DsxmmB/TCQqUWRnkJ2GGlCF/FgjwFc9lfesyuu2A1PFxCzFWE9aJL3J
	GO1gk07TcbpjH7Sv5gWQcatN1E3Nw/Gqe3la13kG34nCU4qTChP8oNfGI+VFeMb9HURQbzaLFhl
	ghxRmnzMpipnv/zwjhswLH/3KP3K6/Uj6GSmdKJB5jsqR+KH0/FPPsALHEpp5/+TIV1YuP9v896
	6i8+bh0mMxtEsueQauxucTzvG/6T5GDSezZNoB19vUmaDF+HUBC3OggcMXnjMxyEVCiH0owVUD6
	iDJt37MPvyof3KA6PRn/21klqXy+12v45De2ZxS9FaPGlRpoXzqe/6MQxQfqqWzRtrx1RkeVF+Q
	7M58Kmk++GnocbpNv7BCbbmehQ6XeyjyZ1AzzoBPI7S6djbzV5RvobMdwtkhOxQv8rnVkbcYkiI
	2HpcMZOvlteYCbALyYNaSqXzm2UDUyHbdtsdbIksFKU9RGDgsLSg2YMjBuWVspJwWuF4QATUD3K
	Jht6OS0NpD6cS5Pd6aU6+SLhYv0scsoThKDg06145hgtdUX4IHCLKF03MZGGursgz/rwbNaWNN+
	brjexbsl/lVmY7/38gZbwSV1jh9XJxM31myur4QBpf/4Ig1tDcoB2kzgqMBzXDYqlA3i91jfwfS
	ixBdqokzIVsd2sCe0SKsuqBkh3waqc7rgsh9hY+C/aFdgSt0OjcuC0bo3eAP1pFRmbqavOjvTr6
	2dbg17rnP6FpA9o6DshNpfSHy0ZjJY724vEBMfof4ZJOCg1PwWDXM=
X-Received: by 2002:a05:6808:c1a6:b0:4f4:3f10:830d with SMTP id 5614622812f47-56b98620adcmr3356129b6e.53.1794435403619;
        Wed, 11 Nov 2026 14:16:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:32 -0700
Subject: [PATCH v12 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-7-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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
finished while its completion interrupt is still pending. Initially retain
the transfer and retry pause and status in the worker. Mask receive
interrupts to prevent a timeout storm and keep callbacks from copying or
resubmitting this worker-owned transfer. Back off retries from 1 ms,
allowing completion and shutdown to wake the worker immediately.

After one second of unsuccessful pause retries, stop the transfer with
dmaengine_terminate_sync() outside the port lock. An indefinite wait could
otherwise leave a request/response peer waiting for data that is stuck in
a partial DMA buffer. Report that recovery discards the pending payload:
without a stable residue it cannot safely be copied. Keep rx_running,
rx_pause_pending and rx_terminating set until termination has stopped DMA
and drained its callbacks. Then restore receive handling and allow another
DMA descriptor, without latching a permanent PIO fallback for a pause
timeout. This trades the stalled transfer's data for continued reception.

If synchronous termination fails, retain ownership and retry with a delay
that doubles from 1 ms to one second. Report the first failure and ongoing
failures every five seconds for this recovery. Completion and shutdown
wake the retry wait; shutdown takes over final channel retirement. A
permanent termination failure still leaves RX masked and its storage
reserved: the pause retry budget does not guarantee recovery from a
provider that cannot stop. Each flush starts with a fresh retry budget.

RX DMA admission already requires cmd_pause. A provider whose hardware
cannot pause must advertise that correctly. If pause nevertheless returns
-ENOSYS or -EOPNOTSUPP for an incomplete transfer, enter synchronous
recovery immediately. Unsupported pause, DMA_ERROR and asynchronous
termination failure retain the error fallback to PIO until reopen.

Keep the requested enables in the existing IER shadow and filter hardware
writes during pause retries and recovery, including termios, RS485 and
overrun-backoff changes. Apply the current enables after retirement so
stop_rx() and shutdown remain effective. Hold a runtime PM reference
around worker register accesses.

Abort the DesignWare idle sequence when RX cannot be stopped. Allow the
empty-FIFO timeout workaround once DMA has released the FIFO, including
while callbacks retire. Exclude FIFO resets during RX DMA recovery.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Suggested-by: Raul E Rangel <rrangel@chromium.org>
Link: https://lore.kernel.org/r/20261109162135.906262-1-rrangel@chromium.org/
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  47 ++++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 261 ++++++++++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_dw.c   |  28 ++--
 drivers/tty/serial/8250/8250_port.c |  36 +++--
 5 files changed, 313 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1e739aceff39..5b0836e984f1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -11,6 +11,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 #include "../serial_mctrl_gpio.h"
@@ -23,6 +24,10 @@ struct uart_8250_dma {
 	/* Completion processing with the port lock held. */
 	void (*tx_complete)(struct uart_8250_port *p);
 	struct work_struct tx_flush_work;
+	struct work_struct rx_flush_work;
+	wait_queue_head_t rx_pause_wait;
+	/* Written under the port lock; sampled locklessly by the wait condition. */
+	bool rx_pause_wakeup;
 	struct uart_8250_port *port;
 
 	/* Filter function */
@@ -55,11 +60,16 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running;
 	unsigned char		tx_err;
+	/* RX DMA may access the FIFO; independent of callback retirement. */
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
 	bool			shutting_down:1;
 	bool			tx_terminating:1;
 	bool			tx_flushed:1;
+	bool			rx_terminating:1;
+	/* Keep RX masked until the pending flush is retired. */
+	bool			rx_pause_pending:1;
+	bool			rx_err:1;
 };
 
 struct old_serial_port {
@@ -148,6 +158,30 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
 	up->port.serial_out(&up->port, offset, value);
 }
 
+static inline bool serial8250_rx_dma_running(struct uart_8250_port *up)
+{
+	return up->dma && up->dma->rx_running;
+}
+
+static inline bool serial8250_rx_dma_recovering(struct uart_8250_port *up)
+{
+	return up->dma &&
+	       (up->dma->rx_pause_pending ||
+		((up->dma->rx_err || up->dma->rx_running) && up->dma->rx_terminating));
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
@@ -221,7 +255,7 @@ static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -233,7 +267,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 	return true;
 }
 
@@ -417,7 +451,7 @@ extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
-extern void serial8250_rx_dma_flush(struct uart_8250_port *);
+int serial8250_rx_dma_flush(struct uart_8250_port *p);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
 
@@ -473,7 +507,12 @@ static inline int serial8250_rx_dma(struct uart_8250_port *p)
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
index 739a8238e4de..b1f2998e7735 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 2013 Intel Corporation
  */
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_reg.h>
@@ -84,53 +87,211 @@ void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
 
-static void __dma_rx_complete(struct uart_8250_port *p)
+static void serial8250_rx_dma_copy(struct uart_8250_port *p,
+				   const struct dma_tx_state *state)
 {
-	struct uart_8250_dma	*dma = p->dma;
-	struct tty_port		*tty_port = &p->port.state->port;
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
+	struct uart_8250_dma *dma = p->dma;
+	struct tty_port *tty_port = &p->port.state->port;
+	size_t count = dma->rx_size - state->residue;
 
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
+		if (ret == -ENOSYS || ret == -EOPNOTSUPP)
+			goto recover;
+		/*
+		 * Hardware may be idle before the provider publishes completion.
+		 * Leave the descriptor alive and retry outside interrupt context;
+		 * copying its buffer is not safe until it stops.
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
+
+	guard(uart_port_lock_irqsave)(&p->port);
 
-	uart_port_lock_irqsave(&p->port, &flags);
 	if (dma->shutting_down)
-		goto out;
-	if (dma->rx_running)
-		__dma_rx_complete(p);
+		return;
+	if (serial8250_rx_dma_recovering(p)) {
+		/* Let the worker observe completion without waiting for its timeout. */
+		WRITE_ONCE(dma->rx_pause_wakeup, true);
+		wake_up(&dma->rx_pause_wait);
+		return;
+	}
+	if (dma->rx_terminating)
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
 
-	/*
-	 * Cannot be combined with the previous check because __dma_rx_complete()
-	 * changes dma->rx_running.
-	 */
-	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
-		p->dma->rx_dma(p);
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+	/* Preserve LSR read side effects when stop_rx() has disabled resubmission. */
+	if ((serial_lsr_in(p) & UART_LSR_DR) && (p->ier & UART_IER_RDI))
+		dma->rx_dma(p);
+}
+
+static int serial8250_rx_dma_terminate(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start = ktime_get();
+	ktime_t last_report = start;
+	bool warned = false;
+	int ret;
+
+	for (;;) {
+		scoped_guard(uart_port_lock_irqsave, &p->port) {
+			/* Let shutdown take over without waiting for the retry delay. */
+			if (dma->shutting_down)
+				return -ESHUTDOWN;
+			WRITE_ONCE(dma->rx_pause_wakeup, false);
+		}
+		ret = dmaengine_terminate_sync(dma->rxchan);
+		if (!ret)
+			return 0;
+
+		if (!warned || ktime_ms_delta(ktime_get(), last_report) >= 5 * MSEC_PER_SEC) {
+			dev_err(p->port.dev, "failed to stop RX DMA after %lld ms: %d\n",
+				ktime_ms_delta(ktime_get(), start), ret);
+			last_report = ktime_get();
+			warned = true;
+		}
+		/* Failed termination cannot release the buffer or the UART FIFO. */
+		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeup),
+				     ns_to_ktime(delay_us * NSEC_PER_USEC));
+		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+	}
+}
+
+static void serial8250_rx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, rx_flush_work);
+	struct uart_8250_port *p = dma->port;
+	unsigned int delay_us = 1 * USEC_PER_MSEC;
+	ktime_t start = ktime_get();
+	bool recover, retry, restore_rx, fallback;
+	bool timed_out = false;
+	int ret = 0;
+
+	guard(serial8250_rpm)(p);
+
+	for (;;) {
+		scoped_guard(uart_port_lock_irqsave, &p->port) {
+			/* Shutdown cancels this work and drains both DMA channels. */
+			if (dma->shutting_down)
+				return;
+			/* Serialize reset with completion and shutdown notifications. */
+			WRITE_ONCE(dma->rx_pause_wakeup, false);
+			retry = dma->rx_pause_pending && !dma->rx_terminating;
+			if (retry) {
+				ret = serial8250_rx_dma_try_flush(p);
+				retry = dma->rx_pause_pending && !dma->rx_terminating;
+				if (retry &&
+				    ktime_ms_delta(ktime_get(), start) >= 1 * MSEC_PER_SEC) {
+					dma->rx_terminating = true;
+					timed_out = true;
+					retry = false;
+				}
+			}
+			recover = dma->rx_err || (dma->rx_running && dma->rx_terminating);
+			fallback = dma->rx_err;
+		}
+		if (!retry)
+			break;
+		/* Notifications also cover completion or shutdown before sleeping. */
+		wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dma->rx_pause_wakeup),
+				     ns_to_ktime(delay_us * NSEC_PER_USEC));
+		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
+	}
+
+	if (timed_out)
+		dev_warn(p->port.dev, "RX DMA pause timed out: %d; discarding pending data\n", ret);
+
+	if (recover) {
+		if (serial8250_rx_dma_terminate(p))
+			return;
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
+	if (fallback)
+		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
@@ -240,6 +401,9 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down || dma->rx_running)
 		return 0;
+	/* A retiring transfer has released the FIFO, but not its buffer. */
+	if (dma->rx_err || dma->rx_terminating)
+		return -EIO;
 
 	serial8250_do_prepare_rx_dma(p);
 
@@ -260,16 +424,26 @@ int serial8250_rx_dma(struct uart_8250_port *p)
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
+	if (!serial8250_rx_dma_running(p))
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
 
@@ -366,10 +540,16 @@ int serial8250_request_dma(struct uart_8250_port *p)
 
 	dma->port = p;
 	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	INIT_WORK(&dma->rx_flush_work, serial8250_rx_dma_flush_work);
+	init_waitqueue_head(&dma->rx_pause_wait);
 
 	scoped_guard(uart_port_lock_irqsave, &p->port) {
 		dma->tx_terminating = false;
 		dma->tx_flushed = false;
+		dma->rx_terminating = false;
+		dma->rx_pause_pending = false;
+		WRITE_ONCE(dma->rx_pause_wakeup, false);
+		dma->rx_err = false;
 		dma->shutting_down = false;
 	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
@@ -393,10 +573,15 @@ void serial8250_release_dma(struct uart_8250_port *p)
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
index 9cbe076463e0..2f6681910351 100644
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
+	if ((quirks & DW_UART_QUIRK_IS_DMA_FC) && rx_timeout &&
+	    serial8250_rx_dma_running(up) &&
+	    !up->dma->rx_terminating && !up->dma->rx_pause_pending) {
 		status = serial_lsr_in(up);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cfbd154bf5f9..49d6a0b19fb4 100644
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
@@ -2447,8 +2460,11 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Synchronize UART_IER access against the console.
 	 */
 	scoped_guard(uart_port_lock_irqsave, port) {
-		if (up->dma)
+		if (up->dma) {
 			up->dma->shutting_down = true;
+			WRITE_ONCE(up->dma->rx_pause_wakeup, true);
+			wake_up(&up->dma->rx_pause_wait);
+		}
 		up->ier = 0;
 		serial_port_out(port, UART_IER, 0);
 	}
@@ -2786,7 +2802,7 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_port_out(port, UART_IER, up->ier);
+	serial8250_out_IER(up, up->ier);
 }
 
 static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)

-- 
2.53.0


