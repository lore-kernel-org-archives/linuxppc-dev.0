Return-Path: <linuxppc-dev+bounces-26480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404EC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 09:16:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbDV65tymz2yDr;
	Thu, 03 Sep 2026 19:15:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788426958;
	cv=none; b=XG09KIV4ahvRBAvv05d3HszubkuuGQEfwLASJdlAgd0T13yZiyDfBmrEC9nuIbIFuM1r7jw1ZVRueU/8JP16syMZfQS95siapGhIjRtKzOfgC+LJBohWB+ULTxekI8cePHpsi720XjImXmXyYZyyhsnhPxDwrAexIc7KyFj2AoFlZdhvVA2bihjdbvk29PLRjuOnELSI8g002Y8lwkKjjB5iHflOkWOUYhNPB0B6z46eMbMWfmFYIGO6esVeB78yhR8emqwrzbfIsAElEvcg3eH551fjB92OyYdW4nVPeiqUH5sRj5ZGBxqP2e6mjPinq8rYLhjHXdorPJTzUEDUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788426958; c=relaxed/relaxed;
	bh=2a8yIQ3NE86fziYRRmM1NyoVwXAqG0dHOhexSSfbtW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llhs/+Cnw3IbLtmNHfRJzo+6VcKfmDVtE/j/mrwWYIwOWwBm2xMqmrBdaPsJZEYD6wQljN3quMV3LzHEAPdid7yJLALcpePCApiRDgEkOxgI40lOQHNXMhzptgtPDWRLgMr98CWWJPLA8QBOM6xJgqqtEDksIB1rnYoSWZw0Q6bGls9m7pb+wCZbYc2XAH+PGA2C8hZrKbsu8YBOhTJ7PVrW/1Vy/I5hA5IXACpEgkybr6Xkr9RIx8RTIdiMTcY2BKb6HJhxpLGdEjQluW8SBVTdv80kwzMzKzDxze2v5MXlEc3wshvoB0ZTdo25m57+jdIQGXNyjwIXML6lB8tOwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0zsCHKQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0zsCHKQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbDV55PXmz2y2X
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 19:15:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C994D404DB;
	Thu,  3 Sep 2026 09:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCB61F000E9;
	Thu,  3 Sep 2026 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426953;
	bh=2a8yIQ3NE86fziYRRmM1NyoVwXAqG0dHOhexSSfbtW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0zsCHKQLk4p8gAn3X8j4oy3KYslGMK/guDz3UOJRR2N9We0sVvbpFK/tqFZEs6hS
	 QGZTNx4CYKtVtsv0C4c6LK+370dmf6vuYWyChytDHcZjngcrLBJRbI1EPFabmoqMSA
	 qZY2m0BNqpRVODEnXYlMUDe3XKdhPYn1UADPoG0K7Kp5YbWUwTwJMx998EnYZp5x+E
	 7GFc412nEoX9MMCL8ZxJywrQM0nTSpoDEGJ7jQOSeDwqfeL2JHMR5tpX8WtDYELqbb
	 7IrVKjbr8LEORFSJMs8oYP5mXCSNx/j4l/PbFzx/kbmKrHsqq6Xbb9o6tQoUAyn5GT
	 6o2UQOGFJA4eA==
Date: Thu, 3 Sep 2026 12:15:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <apk6wr2S1IOQp_Kf@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <apVmYXlqsVr_p4Oc@kernel.org>
 <7adfefaa-91c5-4bf4-ff98-5dfbba0eac96@outbound.gmail.com>
 <apcKQBRCFeF-usK7@kernel.org>
 <2d7b127d-6079-40c0-2020-dc7767b2396b@outbound.gmail.com>
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
In-Reply-To: <2d7b127d-6079-40c0-2020-dc7767b2396b@outbound.gmail.com>

On Wed, Sep 02, 2026 at 01:40:21PM +0200, Eli Billauer wrote:
> On 01/09/2026 19:24, Mike Rapoport wrote:
> > On Tue, Sep 01, 2026 at 10:42:47AM +0200, Eli Billauer wrote:
> > > On 31/08/2026 13:32, Mike Rapoport wrote:
> > > > For large sizes kmalloc falls back to page allocator anyway.
> > > > 
> > > > And the doc is out of date unfortunately.
> > > I think it would be a good idea to update the doc first, and by doing so
> > > officially change the API. After getting this change approved, it's indeed
> > > safe to rely on kmalloc() even for larger memory allocations.
> > The documentation always lags behind the code and "official" API is what
> > include/linux/slab.h says :)
> 
> This is what I found in slab.h:
> 
>  *
>  * kmalloc is the normal method of allocating memory
>  * for objects smaller than page size in the kernel.
>  *

Citing vbabka:

that sentence doesn't exclude >PAGE_SIZE allocations :)
 
> Regards,
>    Eli
> 

-- 
Sincerely yours,
Mike.

