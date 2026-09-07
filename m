Return-Path: <linuxppc-dev+bounces-26649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B260C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 06:11:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdcCP5ZMYz2yvX;
	Mon, 07 Sep 2026 16:11:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788761489;
	cv=none; b=iVeRB4YPaPgSxmkH40rcHiIFasu4UpErof68vHn5C0MQGmCcYdl+I2D+PvYgHxuRF8+2Rpay+rLwA+nyIejrE7Y9PKtwcuY4TyhpvTPu6DDBbXVq0/0YF6YnrefIbissIDKTL7ssboKg/VUa6/9PPwKTSqVE4GwnVNHFuSKaJgbKjOnGiF7Brqn9Re4zMJ4GeNhoYz3qxxPR/iFptgtPolHk4dKQMM+tNTv7eVb5/huAYvVv5wcpLNzcPtQC4bx+4LFyW9aazurLSfdziwpdeJDpOoqXvW408peD7kEUoKvqXlK6zBMgjbhme9m8LvfwfVgmzeqpFliyavYGZKgN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788761489; c=relaxed/relaxed;
	bh=P3dmwjKWC6Wefq3ZCIghBfeiIweYofYEsPr73KhRS2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBr4BgfJQAybKh1iuv36otJVwa+yvR8J2/5Kbq8lv9tENCO//7bYD72V9JGQUbaPhYYZcagctKLrQLimXtIeZZNJrIczwn2ozH/QlsXTDV8wxblzinqzyVaOXxALhZVXCmWqWCxsmtwnfByyoC4qpkygw8GwfBlgwQ+vG8+y66SagRDjsp1s1eIws9KUBfO7iaJ50oQNtPNGTbiL/Yi/bQLNC9QCQpi3ECoR/8BQGq7kEw3d/3mqa/iB6jN8+uKoV3n9oqz9bCuKiHNK8ESHSIZaAcor/P+j5bB2sd+w+NTo1W01+fyk7kpn+hN1opIU/rBjB1QwBcUYJ67MaKUP+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVs8Xu5r; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVs8Xu5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdcCN4sKZz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 16:11:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4384943E11;
	Mon,  7 Sep 2026 06:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B1D1F00A3A;
	Mon,  7 Sep 2026 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761486;
	bh=P3dmwjKWC6Wefq3ZCIghBfeiIweYofYEsPr73KhRS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lVs8Xu5rqDz7930qIA7wlWJw7qb10AZRIm5YTTMxjRCX2t4BjgpcgVLZXPFoE2zuV
	 4M9SQHuqpn/loOucuyWXztqjFxihFRGD56lGccTw/1aKzhqr+FH50miDZnNnJJTcge
	 hrFj1FJ/PnBupIUwR4OzjlZwAhRsQglnRhNbbhTtDkDe+eoDZPXiFLVvXUzM7f8S27
	 KEdQ1IhnCiQ0qOmOch6tMR0gQjP7UBAb1uLBnTN5/9d2zn7ISWoLN9N/5bnBQKWNjQ
	 tkjFcPJIC12n54uQoRw8+/rW2Oom44GLwphExcwF37vyG8s3lzkoYshwdmTmvDwhXs
	 KhuinYov4BKRQ==
Date: Mon, 7 Sep 2026 09:11:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <ap5VhownyptYcTw9@kernel.org>
References: <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin>
 <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
 <apgSCyj-h2xVc2ss@kernel.org>
 <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
 <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>
 <49245a34-cc56-736e-b2b4-168c2a0b1df7@outbound.gmail.com>
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
In-Reply-To: <49245a34-cc56-736e-b2b4-168c2a0b1df7@outbound.gmail.com>

Hi Eli,

On Fri, Sep 04, 2026 at 05:29:16PM +0200, Eli Billauer wrote:
> On 03/09/2026 16:28, Vlastimil Babka (SUSE) wrote:
> > > Replacing it with a kmalloc() is confusing in my opinion, and requires
> > > that the reader is aware that kmalloc() falls back to __get_free_pages()
> > Why? The reader has only to know that kmalloc() will provide such a buffer
> > (up to sizes that the page allocator would) and whether it falls back to the
> > page allocator or not is an implementation detail.
> 
> When I see __get_free_pages(), I automatically assume there is some ugly
> low-level memory management going on, which is exactly what fifo_init()
> does.

However you allocate memory, there will be some ugly low-level memory
management underneath :)

> kmalloc() feels like something you use more for allocating memory for
> a struct.

For that we have k[mz]malloc_obj() now...

> There is no such rule, of course, but this is my subjective view on these
> two functions.

... and using it to allocate struct is becoming a rule pretty much.

> As I wrote earlier, this is a matter of taste. Maybe it's only me
> thinking like that.

Let's agree to disagree :)
I think it's more about using the right tool for a job.

For your usecase I really think vmalloc() should work. Presuming you can
spare 256MB for fifo buffers, the driver can only run on quite recent and
decent hardware and memory rates there are way higher than 400MB/s.

Even the slowest DDR3 is above 6GB/s, so taking a fault to sync page tables
on the first access is really a non-issue.
 
> And as I'm not the one deciding whether this patch is applied or not, it
> doesn't matter so much what I think about this matter. I've humbly voiced my
> opinion, and that's about as much as I can do.
> 
> Regards,
>    Eli

-- 
Sincerely yours,
Mike.

