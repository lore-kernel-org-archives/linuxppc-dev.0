Return-Path: <linuxppc-dev+bounces-26198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F3C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:49:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkmb4cS0z30Cj;
	Sun, 30 Aug 2026 17:49:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076191;
	cv=none; b=dFudx7aHjAebz+sgv2S1ergnSHJneGtgd6CZv1QMNfYaWTtWJebBgHo5beTgqk2xLzCddRPRkLoHqSjcVTjvwiJE8kSSFZuN/OGf7sqHKTqSkUVVO2zj3FK0mnEAu/0KWYFcZDFAvU1XYgdVH9NCtSvAiTiaD2nCvNqGo2z89j+AFXA18cOnZAjKmqzMQxjOFKNozv+A1zuusQC83PPQuf1Oifrt41I3BubzPapxPYFgpuueugCD2fSSwN1a9IfwZ3fQFliCNkxiT8whETXAVpDNqZi78alHe4w6tB8iirViROfearkokVLHhRf5gttVr9cTUpvJyrXLW1hCUdY/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076191; c=relaxed/relaxed;
	bh=4NrSsuZV29xVILt7z5sekPgPcSUlhKVhvtPvsz1aJgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfFTYM9jH63TvRGdyYiFRyiFBHPIR/NssFirQcEBC0yUG9u5Lvbgm0eG3AEkINvZlUKKxf4RZzfzSss9vSyEpBsruI+JnYeX2LwcqwLhcB1FhJWd3v9ZqMNx7V6nS1T244f5PRM1Km3MDutQfsJxtmC11d/9E/febWYwOUpeK2GoT/MzZztCzUElUvQ/xJh44C22UTdnPMhpVW0kvTgAPAlY9JYjsmnmQrvZV5a66eKESrDuoLo38oGCoJogRBPFm6xAjmtVhuq5ZVJj0JAODYvwVhEQPC5nH5ikGwyRQFyB4q0irw3Ci0oOfNPwUqf9l5w+SO7ISjesfZYHoJS6gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVy5RuRD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVy5RuRD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkmZ4Ttdz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:49:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C79244020;
	Sun, 30 Aug 2026 07:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B737E1F000E9;
	Sun, 30 Aug 2026 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076188;
	bh=4NrSsuZV29xVILt7z5sekPgPcSUlhKVhvtPvsz1aJgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YVy5RuRDJhrAG9c9gOgOtGUONheY/iIyUzWDRWv4Ew/lBNFR2qwEW4yd4oaDrr5n/
	 ONEHQvjB4UNd/jUu/xSPGX5HSptOA+Zv8L1WrwK96G/KfXj9zRlAahVclZBId1k47T
	 lu7s+qxucogiX331Q7G5Mq8iYxh9JFuYhsgXOPuxWpwL255qmpQN50FiRZ9z1L0G9r
	 iTxxgTzu2cJEZ/3s+yUxOfX7guIl1bnaVpdBuj+JvDPJaCr+E4v/9r8CEkMKbHt/yn
	 9i1BIw3vxI6BOUmb6freBYrww0vm7Zks6+Nh0UGsIZ4XbBivpp0GYRrQecwsn5cYVb
	 zGErJk3Yo/SKg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:38 +0300
Subject: [PATCH 2/3] serial: core: replace get_zeroed_page() with kzalloc()
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
Message-Id: <20260830-tty-v1-2-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
In-Reply-To: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
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
 drivers/tty/serial/serial_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..f12ce7d190fe 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
 	unsigned long flags;
-	unsigned long page;
+	unsigned char *buf;
 
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
@@ -283,7 +283,7 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	char *xmit_buf;
 
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


