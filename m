Return-Path: <linuxppc-dev+bounces-26266-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D507C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:28:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMZ56bZlz2yhP;
	Mon, 31 Aug 2026 18:27:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164877;
	cv=none; b=T+mA6B0zaAscWmmW0koXScw4a428mWY/qh30bl9j0Ppq77WinFj6mDDiJRwgBjiIEHYTQW3avlm7c0qfYINliIGqNWBU8xSiHarm8WMF3O39dlA1Ffxsfjci4ri0Cuhp73anLxeSbHCDTuUhWWJg6QLrp+XHin7PQTX17w8mriY3DiNP99l7+atiD0czhqUlDY0nmx+DQRFoJhOk4/mAd4mq0mgIFL0npoaI4jgUCfRK7CFheIxFKf1BtdPFaI6QzKjAcfAouL7JjRtd/QAZlPMqxMCVr4qRSC6cHjTPcPxg07cfMfjufpCc38eDySY4AG9skdiUqa2in5ld7+mfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164877; c=relaxed/relaxed;
	bh=Y4bH+/WtPEyRU+oBNZLJOMfju4/GbiOfv2EYcWlAxs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjK9uskbYR/TwccT43UdMK2CmK7wOp3llH6rXStG0QEQLSBEO1dX1HTFsFvjNSLWaPfd8Xb8vXvLWLX52zeMvrX6S0OqzRQuCQxddeN2iRRqTXfYnccihUUhtguqC/hyIgZXdjzPGPQoo1FkdEc/rqPjVHQXUL1oMXwJ09aRUFt27Q9laipnEJ7bXEj5K8L+heHFC9Xcd7HbfPdNpHD0138kZ/6QOD0yPic8r0sQq4BLW6VeEtz/sE+WsbSySrZJcJvYjresW9w38Uv36+KHSwkxTAk2dJ1/ILIJV8x5BLwmLVDF7Pw9XRw1N8JoEYaZVBgnAK32r2P3wKkLxTEy+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBOjheqg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBOjheqg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMZ51Nhdz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:27:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DEF2344505;
	Mon, 31 Aug 2026 08:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396651F00A3D;
	Mon, 31 Aug 2026 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164873;
	bh=Y4bH+/WtPEyRU+oBNZLJOMfju4/GbiOfv2EYcWlAxs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PBOjheqgZU2//8wt0aikBUBXJMoEdiXNgcruw0QaK+0mHSMz2A20L9Y+wS1TTqm2a
	 cB8k9NDiAwOE3FQpU0Wtkxhy3pX5eP8uV5RGROxVtznX4ozJ+fAOLG5A4gsGTtqEKV
	 2UX8sigBGUWxIVY2UXRFD645QP2a5kYSEjZbVx+BMbo4LUxTUoPDxH2heA4H95HwVw
	 TCUE9QXm/lvmvJMvNdEvR4thgz5vc19pAXHDblSxIDmsO3hr4ILc8mb/dhEX4njQst
	 xfZu6qdT+dVUxHz88Xxdx6uh7GVre1GhlxHhvGcHq48YCNkqtgmkg4M8cHiIDZDg7j
	 ujirBHwtexgYw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 31 Aug 2026 11:27:43 +0300
Subject: [PATCH v2 1/3] tty: port: replace get_zeroed_page() with kzalloc()
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
Message-Id: <20260831-tty-v2-1-88cd58c3c640@kernel.org>
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

tty_port_alloc_xmit_buf() allocates the transmit buffer of a tty port. The
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

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/tty_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 54359310e293c..44122921fc45b 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -240,13 +240,13 @@ EXPORT_SYMBOL_GPL(tty_port_unregister_device);
 
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
-	/* We may sleep in get_zeroed_page() */
+	/* We may sleep in kzalloc() */
 	guard(mutex)(&port->buf_mutex);
 
 	if (port->xmit_buf)
 		return 0;
 
-	port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
+	port->xmit_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (port->xmit_buf == NULL)
 		return -ENOMEM;
 
@@ -259,7 +259,7 @@ EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
 	guard(mutex)(&port->buf_mutex);
-	free_page((unsigned long)port->xmit_buf);
+	kfree(port->xmit_buf);
 	port->xmit_buf = NULL;
 	INIT_KFIFO(port->xmit_fifo);
 }
@@ -288,7 +288,7 @@ static void tty_port_destructor(struct kref *kref)
 	/* check if last port ref was dropped before tty release */
 	if (WARN_ON(port->itty))
 		return;
-	free_page((unsigned long)port->xmit_buf);
+	kfree(port->xmit_buf);
 	tty_port_destroy(port);
 	if (port->ops && port->ops->destruct)
 		port->ops->destruct(port);

-- 
2.53.0


