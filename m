Return-Path: <linuxppc-dev+bounces-26441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAEEC624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 12:26:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZhmN3CpPz2y21;
	Wed, 02 Sep 2026 22:26:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788351988;
	cv=none; b=btj7iuEhyR/SmiAiSuKcBICOxAGs0l4YX2vNZFk89lB32qThJiHpFP270cNf/w2WNGbg4DxvBqstiW4e9x6LHkZFb/QjyGFI7P4M0QuL70oDcLerKe4DxsxYYyhb6x3xyRcz4iqjQGE6jHO0yBxTLJ9407tiqoREbXhdLALsSGeSF+P5oCZ+PvpejRKV9CuYweSLAUEzbMxUTuMvAoBrEOyvHmw9KVOUUyWWcEP2q6gtTEgogLAfqbOoeFUGiuIujCuq5Pz9Er/nFxV2Sh789RwA/QcbC1gj8xvVcheucJ4/9YvcLa201Tf5yTrTBuKdyLLdn7hmh1JvLSc3Hsw0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788351988; c=relaxed/relaxed;
	bh=036mA8orffinoqt2iQHKcFlBXTwc5/7dbRbRMf6syWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUb0jyQCHm9DoM4TUq2l7vLpM6NbKeWF0Vv63pEax2mtsXnfqdnh3rW82mca+BSrXK9kJitVVqQdLQ3i8abWx9Etgvbb+/CoYnY1zO3c4YVhU5rtOy3QIa9eBb7Ptg2RFlLHf8RHPwUko0o5PpOjdbiCFGbmAUD8zjlEfjbRNqmc0IvePQ58nBuaD3QFNtwBa5OfJtMz6ySahY2aNSLeemv2PzH69DAgx5j1jTFa1BKH3hNjKZ8eINJN3E+7rPDu00wP9tPqzuwhzfQFxLHkNUK+Vtx1YTZBGHFPHiIDG2gX9Xh7mb1wcnAGsEH+xWwjDx6KmwzLTUUJHmQM0EiIKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dShjsbe+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dShjsbe+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZhmL6RyZz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 22:26:26 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-484415c8bf2so803463f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351983; x=1788956783; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=036mA8orffinoqt2iQHKcFlBXTwc5/7dbRbRMf6syWk=;
        b=dShjsbe+aU+qsZ3tyzoRZa+ozVcloWdH+VGmxzWv98bww4qxLviIvV2Zw6o38UMOtN
         dZsCC8B9JELf/TGQV8D6JY/VFRwH+Anp7xnX6Gw57gYqTRTefdvyXhgbZKUUEEmFSCh4
         /DEghfjoyjkGRAV2rdLb0HjQPO1mpOhc0IIlSgAaFYpWWh07iyDRMot7B7Wk1e7WVHV1
         xF+oJ4+UqXqCHRQaJ1i9/ywhsYuPfA19km1lcTtIK+K4FVuTYU9awb69/1yXrNf0KUqV
         qTqCwrq+fzcqrTM087v3CuqNCnvPYWMvQl7vHwQ8GS0sb2HO5n+IaZjAxla2BiHN2oZZ
         7Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351983; x=1788956783;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=036mA8orffinoqt2iQHKcFlBXTwc5/7dbRbRMf6syWk=;
        b=qRqNOg5J5Se5thIeEhVpjIygbGf51bFKtW1om85xAMkmQA53mRaS04BiJ6eI9zpcaY
         1lR1Ft2XFCfqPJ1CiuyYg8UOSr4AWQoDBsOi6HLnE9Aa646Ot8va7GjH1AaevpGD+AIA
         nJJ7l8jSd6IZR73Xe7R+/ocNuxVBjtx1EZy6pMfTmlS1pbkAD1vZgE37rFO91fxe/qBK
         UwZQ9NmHdi5XT/yGSpYJV1XoqCQC8H9SGkqRc1+bR5vY1fuFfdZKxWC19a848fNvqw/n
         HSB4Z8beo0ytRGZvZJbxJVe4kWmW9AEtZmC8KD/1bTAw/+IWVzeX/82e9XcpYsk2jgzR
         RPPg==
X-Forwarded-Encrypted: i=1; AKwUvBx1DUb1T9uMD8MrfX1LcfOnaGinVOTtabfmK6CF1dMWCYo0FPHLpZKjFTfqeIeXf8AlagzRpIZNDckcPNc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++khCg1ugILa0jHsFN90llPhW1G85G2BJa4nqafLSv8DXT2fxk/6
	EJwAbB8O2mIg4GRBJyRiy5i3VyHnYlTeSMvck1IU+rP8YhApIZ6AkyQ8
X-Gm-Gg: AYBFou0XJAkIAJfCwe3Gphw+bmfde+qdHsnA1vhE4bzsM3LnbCw3wNh05hmG1XSV9gQ
	MgLnHMSYM60kQ9iAikRrdEwe9S8/9FYGIYp2ZmzPgeacc+VDAygrSZTOkhi/dRyHR4K5EOxYqaK
	G12BPFfR7+Bzb5drRkcfh5dExbimry0HFZxEneDiHGZlBX26//BqfDV6kPQyxhZzRgVFVSGOeac
	xVx1EQSU5eRLx7gqQqpKf0hqkW4Pu7tAozjg94V1GlnHB4/3FR7qkniqAV6VYGX/BX66XPSO96b
	4rd1DJMrWHxqH1SzzNrGeVSiTVxLUoXx1nUVYimdkBRNCUD1Z3ipbPDXBIgGDQ5JrBUnYidGIE5
	E8rdT1F0A0nJuri+hpT5nMbHXoHRxE6hqLULRfiHMULuvRrxergLlr7vKA4sknL39XheTRVI+t3
	gxX23/+BEpmJdrL1BqhfaTVd6rlvJK4Z8ZdX9o0DocPvI7F5kLc86DfueB+y90Unu7rBCwe52JD
	iukz/Whaj9ye1dcYDFGvdx9/wkSuiptToNV
X-Received: by 2002:a05:6000:4b1d:b0:481:503b:b663 with SMTP id ffacd0b85a97d-48488f1ac85mr8671422f8f.18.1788351983076;
        Wed, 02 Sep 2026 05:26:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm6635359f8f.34.2026.09.02.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:26:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:26:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brad
 Warrum <bwarrum@linux.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>, Ritu
 Agarwal <rituagar@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260902132621.7444266b@pumpkin>
In-Reply-To: <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
	<20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
	<f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
	<20260831123937.32255a49@pumpkin>
	<apaF1HUtJnstuUN4@kernel.org>
	<1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
	<apcPg_y-HsMki7we@kernel.org>
	<9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
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

On Wed, 2 Sep 2026 13:41:54 +0200
Eli Billauer <eli.billauer@gmail.com> wrote:

> On 01/09/2026 19:46, Mike Rapoport wrote:
> >> * Does vmalloc() guarantee that non-pageable physical RAM is allocated when
> >> it returns?  
> > It's not pageable in the sense of demand paging. Some architectures lazily
> > synchronize vmalloc page tables and this can cause page faults that will
> > take care of the page table synchronization.
> >   
> 
> Thanks for this clarification.
> 
> This sounds like a showstopper to me. Immediately after the allocation 
> of these buffers, data from the USB device can arrive at 400 MB/s. If 
> the data flow is throttled as a result of handling page faults while 
> trying to write the data to these buffers, this could lead to an 
> overflow in the USB device's own RAM buffers. This is because the USB 
> device is an FPGA, where RAM is an expensive resource.

IIUC The faults don't usually happen.
But if one cpu write the address somewhere and another cpu picks it up
immediately and access the buffer you can get a fault.
Even if they do happen they are unlikely to be worse than normal
interrupt latency.

If you are trying to receive data at very high speed I'd have thought that
you'd want the USB data written directly into you buffer list.
(Much the same way as most ethernet hardware handles rx frames.)
I realise the the usb kernel code isn't really written for that sort
of access (some of usbnet could do with it).

David 

> 
> So using vmalloc() may result in a malfunction in the data transport 
> where the __get_free_pages() would have been successful. This outweighs 
> the benefit of a somewhat higher probability of success in allocating 
> very large buffers, and surely the improved aesthetics of the kernel code.
> 
> Regards,
>     Eli


