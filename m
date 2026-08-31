Return-Path: <linuxppc-dev+bounces-26288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EED4C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:39:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRqP6Cp1z2y2f;
	Mon, 31 Aug 2026 21:39:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788176385;
	cv=none; b=dG0tMGFtLyQWw9zQwuWmGCGsnTDki9kdjpDrCziBIEeJv+XScdHQnP5MvYHe1tRgduqcMoMoU/hyxNozpd+bQPJAZ7YsS5YU+FL/N1PuZ1ekqhijjNoXC1pBMyzrbfllin/5+O6m5wTqxn2yzmj8wGzEyII82zTXuI9BxxIWuFWIq+6sK2L6NLEcKRMg7tg7Q7G4CL3sxRrLkmmaJU6S2jj6r5+cqkXDp/zS/qyuqR5SHeenDrRD36LbpEYIlZyx24/YWkapxBKE+0+cT66Q2Cw3hOghYLe773ovSf3cgv+ULfpBkctCWcUron6v+Td2jTk6h7DhRTSctjBNzMWMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788176385; c=relaxed/relaxed;
	bh=t+e3nkWCWmnCXTSnQisaZ/JcY9969zoxFZBJ4/hDxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB3FkY8/qWJdrJGZq7cMRd/pqZ7K/Ri75Uk/fI1Gz1Q2x21+KKscHxs1zG10fDBfamZKAc1lWjRDH+OKg5fJ68vZFvqJ7S7UVGITabwkBY0Uwq1Jj492Ccjvz5l2JkWwvpL2bQX/GV+ODCSD2MIKzBgWm9r5K2ImUTiYN/YgJ8kgi1oxeMYXH3/i1FJqaQlEAq1TOsSOKFfCUzQQIHKVCQvX5xaRtAVJLjGPNKbTWSs1S9SRSbFsNhrcTUPXF0Yqy1dZphWnvJ1C91kkAePA8/+1IV8oLF0Hypf8dIIzeDm2cC4quHt3VmbypDTz7UDqRnHg2eFdwm40GObBVEoNQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G1QJ/nJE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G1QJ/nJE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRqN2xMmz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:39:43 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2928226f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788176379; x=1788781179; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t+e3nkWCWmnCXTSnQisaZ/JcY9969zoxFZBJ4/hDxuA=;
        b=G1QJ/nJEn50l6J/AVOYguDMB7j17Ev2WdqMewOT2LBvam3RiWpsGvKd3NAekeiGFlr
         QATxDvWY3dr3tXj1FQoxRZfS0Vj5pVpO2KEFHsqf99/n65MdeRVGSPZOP+oWujgTjfSE
         mCa6+GGX2MZ0lTqGxQzZbHvcPk3bSUlhMTTCfKtoUskXlwYBqHb8OG+PbeaT6OPsQp8M
         tUQleyqNne4bGoxI6SaXNZ+LkifzUHvcM+6TGBpFleaQQyiPKD795ScNNUmf9OQrkd7k
         iVDFZW+YBV17qwMmm+2fWcLkRV3AMVJpCoafS0IkVUfhmDMXEMSMx0tFtuYoBL8/sixp
         0XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176379; x=1788781179;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+e3nkWCWmnCXTSnQisaZ/JcY9969zoxFZBJ4/hDxuA=;
        b=sMbTSlBsiCP/nTYmNkmALedR1wiNr4gdA/SnZ0DDgr11CFOL0s/gxwCwDnS36bIhNc
         gSU3vn5C/6MeG04HQkIwY4aBY5CamcrsAn0ke2VMT/MMOR/1zDmkWI02sIPs1cayFhoD
         hQrj2iGM6Ravb29QS2tawlGhghmdQUFilWjcAa02v+kCBBEeKG8Qc7UTV40HnGk61vv6
         Yp9cOGbuhHYArTmWX3Sz4g1rrsve51ZiVn5fQu0vEhPc77XWHL1w3kzyO26MyrOM6aRN
         fq67uNRRgTJK3+sbMuj9XcGLmZ8IjHJaCLXCZwjLoe3A55R6AibLwPlShexpp14WjALn
         rA4w==
X-Forwarded-Encrypted: i=1; AKwUvByi3v4pu69oNv6IuzKPY7Cp/77ZhCY91QMzHnDavfgw7XDS8g/AsPxIhzFl3ngZz8IQZTx1RZDQzE03XWQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mx3k0DnXsYIllw5H5kFERAbvbhHmZ/uQ+F36VGZsr0UGxw9arT
	x54E85Ts278Jsr5w0i3PWK2mfpyZFQNPQgJPUojuWafyMNjFHD7wByja
X-Gm-Gg: AYBFou0Uj/NCMQsds40wVdpP63gEdYnWmt+43YLDYiAjcSQc9Elp2L4iH2TC3YfQXao
	T/P4ydlHuUsYCHM4BFX7whJF8H9+7dOLGBpYDoWXWNtrNTMrBrFSEv4sa7rbc5W4Pxzl7bzuCck
	No/rCpJBaenuwiLC/2m9unWmgvg4u3s34Z5bTHz2TnCG/2/7GbJkfcLhZnFB6DU4dS8S4oFiYQx
	Aj6yll3lc/Do2qqy9ligK1lVaycAB/fOv8Khj2WE/5a0CcUCzYLyYiagEcd+eKrqosNKMyccsrb
	JKW/dIE3xYmr65Q9iGViFMOvBYi+wbth8pkkOU8FM3tCOoDigDc6L1vz6xSq+7aPb1DOOCAS2wO
	duYA3ppj3dhKLiuY8qAkJkVBD+X+f+mpTCfhmqncExRIW8hyS46a8Y81UZ5ni07KfYgHtHRUXPP
	CTjFPGqBLtJPFX9gVAjXoLh2sL4N5tOyT4wxi1RoM0gfvytu2FfHgFMZGjqZqOMIzkv9U513H06
	f/0xOzEBvL2D6WzclpWQgp1Mg==
X-Received: by 2002:a05:6000:480c:b0:484:3f5d:7dc3 with SMTP id ffacd0b85a97d-4843f5d7de3mr3330798f8f.5.1788176378681;
        Mon, 31 Aug 2026 04:39:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab29sm14535272f8f.0.2026.08.31.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:39:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:39:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>, Ritu
 Agarwal <rituagar@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260831123937.32255a49@pumpkin>
In-Reply-To: <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
	<20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
	<f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
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

On Mon, 31 Aug 2026 12:13:08 +0200
Eli Billauer <eli.billauer@gmail.com> wrote:

> On 30/08/2026 9:47, Mike Rapoport (Microsoft) wrote:
> > fifo_init() allocates the buffers backing the software FIFO and
> > endpoint_alloc() allocates the transfer buffers of a USB endpoint.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about them to go directly to the page allocator.  
> 
> Except that they are a bit large.
> 
> fifo_init() may be requested to allocate up to 256 MB of buffer memory. 
> This memory resource is split into an array of buffers (fifo->mem[i]), 
> each 64 kiB (or less, if there's trouble obtaining segments of this size).

Would it really make sense to allocate the four buffers separately?
And/or use vmalloc().

David

> 
> Citing Documentation/core-api/memory-allocation.rst:
> 
> "The maximal size of a chunk that can be allocated with `kmalloc` is 
> limited. The actual limit depends on the hardware and the kernel 
> configuration, but it is a good practice to use `kmalloc` for objects 
> smaller than page size."
> 
> Regards,
>     Eli
> 


