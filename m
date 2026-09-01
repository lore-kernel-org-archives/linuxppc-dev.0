Return-Path: <linuxppc-dev+bounces-26362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECDEC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 08:37:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYzkv0lnxz2y2S;
	Tue, 01 Sep 2026 18:37:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788251863;
	cv=none; b=XvfF3hRZz8NeojXnLLbp+UzHABRPE6jWs1c6U6UXHUs0ZfNiAOjqWugBLe10aT7rxht6KoMoQ4utjAltzQqJCj/ezBcdLBMadvafh5ClYOSKmyg/uozvHqJrvtI53pLJGngXtwSTn/TT0TPl9hw0Kstixxb13wk8e0dToXmXxNuKt92krhWxFSAEYTJgDo5gbF21O70laeCf5t20aUQwGpNTXgqwWyixPRwJa9gRMmUTrNEkusyvL92S4nuk6pdg9x5OBfh+Pjj5SWAM7/7Du2dqNcPEosVsDm0zUyQYaMQIIY6F7OD3ZxI2Sxeowybnz0niCZCNzA2gFBtaSwn8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788251863; c=relaxed/relaxed;
	bh=tLMiVP+WYQH9c6fmi64EU174ERw2OHDZTVkQEU4Pesg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fraS2jWJZSWnFufeR3VINIL6l6alXrl9Erqilnv0Vg7k/RVnQzYWVl75WbjTenzVTBXwmTXdp/ZApUt0uTqv5lbLAXpAwYfWLxMfqf2T8ZN2rUNxGk8ky6ed7Oj0D/dL2AfDD4YYriGwgmEyCuNagkIM3diqQ13mo542otISD1dT5Mtv71gExDuSqj7bEzOZyw08oIFPQFrHIR6qww14kvlUbW+YJs0a8IsMYvUvUBH0NE5Oqkh2xlAm4zRt0HFUcuGxwzj53Ea+NplQk2++BRw7WQPPvIL7RAlsr+Y7EMbxPkoAQiS205iXE9NMULqaDovAoIsHXJbX9r5n7BDVSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c63VKeKS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c63VKeKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYzks6140z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 18:37:41 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so43738285e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788251857; x=1788856657; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLMiVP+WYQH9c6fmi64EU174ERw2OHDZTVkQEU4Pesg=;
        b=c63VKeKSDIDj2TkyTGzAnZ+po/a4MJUuJtbisFiHnvpfEOhS1Tsc3H6FDaaFX69i7L
         0LkAz85IBerrICB83tt6Fc9pIBMuoeRmPBITMP+cb88zgs5+ZRAInfES4y6A+Jolm88f
         +b4f/NV5UPSRoghPJKCx2DUJQkYgso6qJgmBI1vB6eO5uSOY5GJ6CoAyJBONPcj2nLZ8
         vGsQyjZdHM9xY/B1dunf+IlDHfnQm4IYk3LHQDOeKTal6j+FuMlswQPKMogb0QCft9YV
         WdaaZr9NuP50OnoWxvr5nY9vogGocoEduRhMD2Q11syypB7Lwt74JC/h9pJxnv/0L9UC
         RUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251857; x=1788856657;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLMiVP+WYQH9c6fmi64EU174ERw2OHDZTVkQEU4Pesg=;
        b=LetPXvCA889yr8VnIAY5Rw96F4BPY5BmxWlSs7C7jmdBf6e2hg+6ytjWUNJKo2ea8J
         rzVMHMdCXC4lUFvSLn13MYp+BeC0ztEcwdvCHTZY4h0y9ZnoielHb3EWg6IIOXrrF6Vg
         weFM6IGcsBXPJ1m08A9s9QpsMyCEmyf6U4+SYlEVTRm5/rm1W/s9S51EjFQH8zVWzp6e
         8oW4ROxUQZl22EEV7cby15f5/k0FWurxXE/A0bDWWvV3SbR86XO2FrZPPTyQomnVz2XN
         +ADpbwGF/A5f2llJfXNRPFi2C/bkCT+pg0u2foBZzn/oChAic0Eq5oeUh2JGxpu7aOZx
         sZvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsY9hvlUK/RPryu3C+ny9uKIAS6rzwzTm1qv2N8CzHxZM+gdHShVE4sNKrLcEEvywl5X/iWQgYE4oQWEg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mw0s8tAKJufa8VDP4o/3pPvtv2EJt+3StwMGZ9KjH7fV6M2xti
	nRdPRmhr9aUwDiJeYFCryz5Ugz44ZWHeS3DJwEqytg/kSUsaWMsKy9E3
X-Gm-Gg: AR+sD12fM0nv3qJ5n70X/Ccuxx1XL+GgZCr3r/vh2vZZImFT3oD648hcSLuP5dqR4H1
	Xqdl2p484Qy5eWdLA2pbldJvjBQRar+WocsSjTuo0mqLHj2g3Nm+jMCtAtvHig21JgChNsmclVg
	osRqFykCPcm+e3VeUCWLrfPj25NXKiUBqFZ6VWbQWmE3T7abr1SI/EI71cJKFJkZsvwDQF3BBo4
	Pxh+XABoLAFAVc/lbOTN+DcbbW1LDcVcK/1qI9rQt47z0oear7wWoSn1GpyPSnKVs+g1njWKpy4
	w3h/PDnja+QyOUhLifyJ9AI/vDRmQthTNEyEpa+plDRX/EdzYgi4Jg5TSdczEVOfarUfSvmSR7b
	5BIeA2RfKBRcENzX+VN88G9zhM0dq3xTcR9Lzgwibi9iEKlIJ5sgeiE2E8cOCZrFh8bJXN1gKN8
	4UoE174Bkq1TEyFgQShw54DAO1WOtgFprcHh0DxjH8sMS0GBlPsgKLiwM77C3ga6PkdHm+HT3Aq
	jlu0pHyNBFNPdKn1HV+wYh0hQ==
X-Received: by 2002:a05:600c:4f88:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cdc4546c9mr105399215e9.14.1788251857090;
        Tue, 01 Sep 2026 01:37:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm56391225e9.4.2026.09.01.01.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:37:36 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:37:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Brad Warrum <bwarrum@linux.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>, Ritu
 Agarwal <rituagar@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260901093735.3f5b2df2@pumpkin>
In-Reply-To: <apaF1HUtJnstuUN4@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
	<20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
	<f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
	<20260831123937.32255a49@pumpkin>
	<apaF1HUtJnstuUN4@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:59:16 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Mon, Aug 31, 2026 at 12:39:37PM +0100, David Laight wrote:
> > On Mon, 31 Aug 2026 12:13:08 +0200
> > Eli Billauer <eli.billauer@gmail.com> wrote:
> >   
> > > On 30/08/2026 9:47, Mike Rapoport (Microsoft) wrote:  
> > > > fifo_init() allocates the buffers backing the software FIFO and
> > > > endpoint_alloc() allocates the transfer buffers of a USB endpoint.
> > > > 
> > > > These buffers can be allocated with kmalloc() as there's nothing special
> > > > about them to go directly to the page allocator.    
> > > 
> > > Except that they are a bit large.
> > > 
> > > fifo_init() may be requested to allocate up to 256 MB of buffer memory. 
> > > This memory resource is split into an array of buffers (fifo->mem[i]), 
> > > each 64 kiB (or less, if there's trouble obtaining segments of this size).  
> >
> > Would it really make sense to allocate the four buffers separately?
> > And/or use vmalloc().  
> 
> My understanding is that the buffers don't need to be physically
> contiguous and vmalloc()ing the entire fifo->mem in one go should work.

What is the minimum size?
Remember PAGE_SIZE can be 64k.

David

> 
> Eli, what do you think?
>  
> > David  
> 


