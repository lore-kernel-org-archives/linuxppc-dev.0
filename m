Return-Path: <linuxppc-dev+bounces-26439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3CBC624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 12:10:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZhPL6G5cz2xmh;
	Wed, 02 Sep 2026 22:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788350998;
	cv=none; b=mPtySvZFB7/Gq6uOBiqZbQ1hO2T72KRFn3RMJnFyJe83vnIdpiJePj6RxUxcZLNDJRMR+Z+FgB+XUd+nDATA86DegcuFE8J6zYoXizHf3oGOWUEdUM0R6UwYM7ffKAVYcvidiORKKuDE11G18QqkfAgh/l5Oc7eFaoaIs5XoZTM948x4jV3Da+ZWkFZAQGdkS5o6MC94XmRThdkTUovWmKWgHFdIqoJB6Qgu2l0muqMPJl+Qf4No5u8XO9QU92Vxpb9nWXGoJbndxFWUFEf/n0OQwV6pgodANcaaC4Ga9mdWqV1um5Dlpnf5RqDP+kvi5cFr4RgbikhZ5zWQjKdgig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788350998; c=relaxed/relaxed;
	bh=jIXfuktxBX9npVbn29PNwEDcICMHnTCbs+iOm5eKoxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHxCO/yNcwTcdbtY/W1/LA/+RMdI6Kf/U7DKnNiqGHAuB4nWUStHjKV/Gr0yzbMa2QrWs6yAx0aHQkcrE57KsevIX9H1eUjhkvPXxLlYLncU6WPQqRtEzyqArjJqUUYbrkl23GtKnukvPjR00/Xk3F9cXwTK+k5nCy1lmCnBR9qZX6DlN7VZpFX0VP056ndK17vO1kBL+t6nKCQ9PV04NEvNSZpXlX1U9tyfn0VNPsVk5V4NnbmTvVf+sWbvoLVjg0SiStiR4RAWNehRyd2cf7tL4XJPtMYE+nvllyIgZnU8PMDMcc2JyvHjQmc8UQcxgAsbJh8Cm3+TTaU+4usneQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQFuAyuN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQFuAyuN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZhPL0DP5z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 22:09:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 387DC43AF5;
	Wed,  2 Sep 2026 12:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35051F00A3D;
	Wed,  2 Sep 2026 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350996;
	bh=jIXfuktxBX9npVbn29PNwEDcICMHnTCbs+iOm5eKoxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CQFuAyuNHerDnWsaFITNdyKdYk0CDRDVo85WOXqItPK45gd2qprMEyHWZtia5OZSD
	 F+oNuD69Rox5filuXKINVTARp9sP3eAtoharI+a3M2Rss1fvn2x2VqC6o2bnFRH5lX
	 sWfvLXb1DLtYNwb7jeTUmS/hQ/87QH/5c2hyMiXPXNLunXSDqWjqqIHT7fx0mtt1cb
	 p1IfB55BWUQcWZ/99vYKL/i24P6KmHe42oWKm5A/Bq3divRGIFn/AZs9yj28TGXlGE
	 TBOPKGpJU+vTbGBPFq8cP7Iz3+tYBQsIeMQbIxlczwpxE4pmP+9v23ctQP2IEoPg8k
	 nC6gFCN9OuuFA==
Date: Wed, 2 Sep 2026 15:09:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
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
Message-ID: <apgSCyj-h2xVc2ss@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin>
 <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
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
In-Reply-To: <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>

On Wed, Sep 02, 2026 at 01:41:54PM +0200, Eli Billauer wrote:
> On 01/09/2026 19:46, Mike Rapoport wrote:
> > > * Does vmalloc() guarantee that non-pageable physical RAM is allocated when
> > > it returns?
> > It's not pageable in the sense of demand paging. Some architectures lazily
> > synchronize vmalloc page tables and this can cause page faults that will
> > take care of the page table synchronization.
> > 
> 
> Thanks for this clarification.
> 
> This sounds like a showstopper to me. Immediately after the allocation of
> these buffers, data from the USB device can arrive at 400 MB/s. If the data
> flow is throttled as a result of handling page faults while trying to write
> the data to these buffers, this could lead to an overflow in the USB
> device's own RAM buffers. This is because the USB device is an FPGA, where
> RAM is an expensive resource.
> 
> So using vmalloc() may result in a malfunction in the data transport where
> the __get_free_pages() would have been successful. This outweighs the
> benefit of a somewhat higher probability of success in allocating very large
> buffers, and surely the improved aesthetics of the kernel code.

kmalloc() still works, just like __get_free_pages()
 
> Regards,
>    Eli
> 

-- 
Sincerely yours,
Mike.

