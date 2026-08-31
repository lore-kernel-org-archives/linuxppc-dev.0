Return-Path: <linuxppc-dev+bounces-26269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2E0C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:29:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMbJ3j4Cz2yDm;
	Mon, 31 Aug 2026 18:29:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164940;
	cv=none; b=XkFLBZf/uoB5Iopz+JvAEsu7HDIYF8rgPV0UxyrYhv3TW+ZEEAHE/AI0dXh4z5rT+Xt2Z6K5k+lfxm2CY5f6cPlwavQNUMwysau+S1ky7qcPPAHaBoT4bWLA8fy4LBxA15T+UGh861cZHXQCNnjyOQ3psxmB01CHOuUiOJr75NnEoSo5mEnTVK5k1nAr+rX+m7Xx+lZW8V0pNO1AiEqi+uQNtyEKhZP5apO44nyaHAvhQ9DV4xpEt9Crt3DfNlS6JOA11QbT9eAKo51BT/ZYZJKh6A85NC1BfIX1AgI3EB+2mUkNhSey2d3+4s4v8SEBlJog7rYn/pGUc+faJig6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164940; c=relaxed/relaxed;
	bh=VQpc8lTOdX3xSHi8EiRB4f2hLx8t85VdxKOuNWE2LD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmcMVWAGnxnLpDAdb3RSo6ZAWoQwV+LzI7RJyL9o7Wxvt4gTzlcixfE7PY58j1u59q1JEQFrKPhmBVGXAxpoVlsrVKHrAS0nt8qQ+vVnvkHddbHy1BFMrIDvhesnrWwwb5KZavEefycbzqyZU/JimgxVWRzD3OYvnyt0cjKO3L2z0EY5CffkVS9Im4go1YAhsvpICmaZqz3dVzhOW1Fi7t8yNKoIucIzqL82dFn8LvsGQOYPft/asafuIHyi6wQjziT2dL8HQAsvL9FRn6fENzccNyAg1cJVcvBkr2eQNr/IpLkhsytDY9sP0fSwKU9GmZKfoYTD5OaQi1MsD9yTeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4ZAcMaG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4ZAcMaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMbG585zz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:28:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4EE5B4383A;
	Mon, 31 Aug 2026 08:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240B1F000E9;
	Mon, 31 Aug 2026 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164936;
	bh=VQpc8lTOdX3xSHi8EiRB4f2hLx8t85VdxKOuNWE2LD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4ZAcMaGmhWkbt0Rh1OPbj1YlvacnstiEn1h6FFml6IuFq+3UCfM+lcx8aLY2H5Sb
	 aTcviB67lh56jpthcbuARnaiLX4X0zEJ5iPxkrisAndSC28M/yhEdVLGlUkt0diRxO
	 9bduFdfWk+hI7CWNkelr83aVU9pAyG0ntG7S56uds6uH8gbohovzZGzBTSkSIocm39
	 gnGlVJEZbg6CRfoOomrsStasSuqGXnXNNxknZttY9AdVDI4XPTmJ93LIezloeltrna
	 rqfo0Swu4IbyUCEIkpSb0iea7aqu2MJDVQwQFkcSN19DRtkiVxfkbBz7lauGqWknXo
	 5oualX6cx/Q9g==
Date: Mon, 31 Aug 2026 11:28:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
Message-ID: <apU7QSOV22VJL3ay@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-2-0cbe6170649b@kernel.org>
 <602bdc5f-e9fa-4ed5-a009-03af860d31a6@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602bdc5f-e9fa-4ed5-a009-03af860d31a6@kernel.org>

On Mon, Aug 31, 2026 at 05:02:54AM +0200, Jiri Slaby wrote:
> On 30. 08. 26, 9:49, Mike Rapoport (Microsoft) wrote:
> > uart_alloc_xmit_buf() allocates the transmit buffer of a serial port. The
> > buffer only backs the port's kfifo, the data being sent is copied in and
> > out of it.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > While on it, make the local variable holding the buffer a pointer to get
> > rid of the casts.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Assisted-by: copilot:claude-opus
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   drivers/tty/serial/serial_core.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 95774b0f1484..f12ce7d190fe 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
> >   	struct uart_state *state = container_of(port, struct uart_state, port);
> >   	struct uart_port *uport;
> >   	unsigned long flags;
> > -	unsigned long page;
> 
> 1:
> 
> > +	unsigned char *buf;
> >   	/*
> >   	 * Initialise and allocate the transmit and temporary
> >   	 * buffer.
> >   	 */
> > -	page = get_zeroed_page(GFP_KERNEL);
> > -	if (!page)
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buf)
> >   		return -ENOMEM;
> >   	uport = uart_port_ref_lock(state, &flags);
> >   	if (!state->port.xmit_buf) {
> > -		state->port.xmit_buf = (unsigned char *)page;
> > +		state->port.xmit_buf = buf;
> 
> xmit_buf is u8 *. This uchar was omitted when I was changing the type back
> then. Could you use the right type at 1b now?

Sure, I also made this change in uart_free_xmit_buf().
 
> thanks,
> -- 
> js
> suse labs

-- 
Sincerely yours,
Mike.

