Return-Path: <linuxppc-dev+bounces-26267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B12EC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMZ82W26z2yr1;
	Mon, 31 Aug 2026 18:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164880;
	cv=none; b=W7Rex0Kpt6oQv41PBBA4nl/wWIsxAkP14lvJrYECsGTwEn8isngIuJByCkZVcX2RFGdTSK4d43LI6vLf83m4AhHhzoKL7VlCtcHqpUGz/DpkfVRUBb9vv99UQ0Yvj3SZP7RVCpahurvc/S905bY74jZPWT5AORXm6BUcP3++DMZyaLdTJ3d37I106hx+r8ZH4c0mg0WN0gSRiVUSzkR9cOJIwL70Ok3D+M8CEBjZlkQrmY4ddSn6hBnTiIuxJMMdYQvKHkT0u8qpUEA46ZGnPxS04D6w/4WWxF824/TP7laDmtnV8gVH6D6+8HJWR2Rt5f8XrEptaw2rzdOIsMquZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164880; c=relaxed/relaxed;
	bh=zXWRkm+Wfn8w+zGyJ3glKrxRz07Jsyoil0yx8XutPKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+KnAYKz/eJZYYqL2RJKk9ZTjNSwgWd96I2vhEiJ00LfntVlGdPcSx5EoFXZjw7l7Xvikqx9cxWuOA0fydc3uwizBBARNBpg+YitqLZ9q9Ei6TpYZ7/XjyHTtnVBsxdzS6zhdAjO3aWM/E359XwE+UXRkjbq0NzKFt91gYe9tIvM4aDWR2ItgKWDmFuY0Z8lHaRI0qLHCvtslVMOTSvb6yLGOugkghS5UGx6tcYZyHzRe52i43lo7dhgpqzTQVTh83min3LHT307UFHJeLoVhTWGB30zNsKu4YupslS0ii/5XOXVIi2wcKl9hIeGRuF7+RZAxAQfZ/o0vdpU0PL7Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvmsrp/R; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvmsrp/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMZ73Ff1z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:27:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 013574018E;
	Mon, 31 Aug 2026 08:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8111F000E9;
	Mon, 31 Aug 2026 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164876;
	bh=zXWRkm+Wfn8w+zGyJ3glKrxRz07Jsyoil0yx8XutPKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cvmsrp/RtsT8dP5IEl7OA8SYmLdkon9cbY+CdI3SnhrNz8UxoqcNjnhM5aotPogw4
	 x4c0BbG5Ah8Z8fMQNLKQiJxzhGHFydk2zAfy2XqnTxF6ygIl60OpHepenBw6uX3pmg
	 voJMeFM1p2LkEqQReCFbLYObygRjiTAzotVUaTB9ltvG+XqcTuyedptECBFyTMNr7q
	 Xq2w1mD+t7r6dqp6u4lYZFv5f17A0mkIhqLyu8LRSr03mCO4VD+9g0kP4cO4pyhIoN
	 wMCcswUTo6dNqAMzYtlixVmfmnCwbtaZ56fFzT1x9MSGFbs1VQF8qI0ymt89kjktav
	 LFx1T/R8nImZw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 31 Aug 2026 11:27:44 +0300
Subject: [PATCH v2 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-tty-v2-2-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
In-Reply-To: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

uart_alloc_xmit_buf() allocates the transmit buffer of a serial port. The
buffer only backs the port's kfifo, the data being sent is copied in and
out of it.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, make the local variable holding the buffer a pointer to get
rid of the casts.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/serial/serial_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484b..a72fe14f76771 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
 	unsigned long flags;
-	unsigned long page;
+	u8 *buf;
 
 	/*
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	uport = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
-		state->port.xmit_buf = (unsigned char *)page;
+		state->port.xmit_buf = buf;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
 				PAGE_SIZE);
 		uart_port_unlock_deref(uport, flags);
 	} else {
 		uart_port_unlock_deref(uport, flags);
 		/*
-		 * Do not free() the page under the port lock, see
+		 * Do not free() the buffer under the port lock, see
 		 * uart_free_xmit_buf().
 		 */
-		free_page(page);
+		kfree(buf);
 	}
 
 	return 0;
@@ -280,10 +280,10 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
 	unsigned long flags;
-	char *xmit_buf;
+	u8 *xmit_buf;
 
 	/*
-	 * Do not free() the transmit buffer page under the port lock since
+	 * Do not free() the transmit buffer under the port lock since
 	 * this can create various circular locking scenarios. For instance,
 	 * console driver may need to allocate/free a debug object, which
 	 * can end up in printk() recursion.
@@ -294,7 +294,7 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	INIT_KFIFO(port->xmit_fifo);
 	uart_port_unlock_deref(uport, flags);
 
-	free_page((unsigned long)xmit_buf);
+	kfree(xmit_buf);
 }
 
 /*

-- 
2.53.0


