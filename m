Return-Path: <linuxppc-dev+bounces-26197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960C6C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:49:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkmY1MkFz306N;
	Sun, 30 Aug 2026 17:49:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076189;
	cv=none; b=oBhFOcYxBLFENkApWLfIixhwygsKEq7fOhe6hodtlAPPyv8HpDeLwei4Ryt9qeArLJSXrbA/KPIzrVzu31QsxvnvwxilBBBISh73LMhuEttKc4usIdk5ycYX77v2DCVAF3AS8vsMgAS1tQMhzea7AViaAEbWVNFCywm64uye2kCfftuSYnky28qoqtIe2QI1+5YDXLfucaMC35HIYRbdt0TmlpkHAhQxUQdzz/rucRftNrDHGgC9YIchXYlAaTCQD8JkX5qtguum4PImKNhxxMRlfE+8zEJIdcxm+LR0cMhHWxWhInpFeeMdOkjhIONbQiTHKKLpcX3lXagyQNWytg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076189; c=relaxed/relaxed;
	bh=HuAQFZwiOZzqNfEaGbCIrZqTUyDwkDp9iUPeNuXnT0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNkHBFpJdhGrmCuWzBvqbMk57awjZ8fucHi9513mEk0ZzOI7FctJZ9evuaB0JGIZJIHTIZZqFwMLG+oLK8KcAlXSlFwO0+sblXEq2+J/lEirA2qjIeqRRVZqMTo7PWMljYpPOhoIuVBIa8C5fjFd+nkxwosX4h28Z0SzXclecRF+5rLYUTdgFN/Vu/PaQjD6bu2Sfwp2NOoM6QBIRbBSEt9FjMhPC/iZx86oUgBRmU84W/g/vZpOURwxhG1GdOn1JnchUeUGeCRP2jhBkdCD0mwvIUzqjHIdHExWp+n2MezLeGvd5zLknunbjI7cZVO2AoMewg3xOxojPyszu2aMZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOx4HGWj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOx4HGWj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkmW46RKz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:49:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5533543C8C;
	Sun, 30 Aug 2026 07:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE331F00A3D;
	Sun, 30 Aug 2026 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076185;
	bh=HuAQFZwiOZzqNfEaGbCIrZqTUyDwkDp9iUPeNuXnT0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NOx4HGWjxeuC3f34ZH/BvB1br+XJ+CJKR4IxRAwWAEqdxRYw7/ImwrMEVKFpf/Kg0
	 AJode0vDl1kcX4QqspysvvD+TJYk5aQ2GZl/ZwmXIH4gkQNWcny+xwYp37F7E40tsE
	 VZnpJUN/K56Pg2Z5AJJx004ORINtZRaC3nH+H0rGRd9gCkSx3EjnUeeYv0XriMDcT/
	 RGLuYELGfmmQBecnLFSat3U2/DheEczEzej8qj+W0u8KIizfDBNepX9Si2yzIuTW/+
	 bDbogz42uOCEB8zkoZB2xUXKnSPldxToGvEjFNMuL23yN7HZJdMzAwcACVYjzLamXF
	 XManrSAy5lqLA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:37 +0300
Subject: [PATCH 1/3] tty: port: replace get_zeroed_page() with kzalloc()
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
Message-Id: <20260830-tty-v1-1-0cbe6170649b@kernel.org>
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
index 54359310e293..44122921fc45 100644
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


