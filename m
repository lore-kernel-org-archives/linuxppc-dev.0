Return-Path: <linuxppc-dev+bounces-26438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDDEC624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 11:42:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZgn46HVRz2xyl;
	Wed, 02 Sep 2026 21:42:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788349320;
	cv=none; b=MbnqFo1LsLgiCUZwj7i73JrArW6/3g/p1LmzOyifU7MwHXFbY+cFZdwjS90Dqb2o34TwVQCvZ2CfBVxbeoDVMZdFeC2Qnp/cfeIl7dL8wK51QumcjrcBaOy1vi3Vvt6vAopmB0gd3OI1CA1MtBEVyLu+XyZw+kLS6eBVq0YE77MRcYJzMu/uOYQwFN8XqEjdmzjyqteWsEJaJgcnnpnK4z5uJzBpHrP/iwxnggDouhacwMGngwRm6C6r53rVZG6uECItbcMGMk2sb2CcJFdYkkoVUQKvBYudJ1293fEPM2ADn3Jo6M0Uk/rrJeJFGtJciZuo62MREe2lqlK1ZxKorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788349320; c=relaxed/relaxed;
	bh=Z8Dfh++0Ud+IxXdfXwfXS9P60ggh+Cfx9Hb6zf15cRc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nzIDWy79zAQbamPM4K6BPhi7RUNkTZSETfrFD+CYAwD9bg6soktum0k7y47fVeKeB2D7XpZfuHazEojvmJVurYVPWECCxBx1Y6IJqNdgDX6K5F/vwwrlITh4U/WSXR75E4NRM8x1pVqLtxCZWec2rW0sZzBd0NSWHM3EGfHJJ284fBl2OU67PGkCmG7q+7mSJvqSLnntmw5Osb4a9fNvQMMwrlVfbesG4jx6/ZjE50WY/VPXz+5IacRAzMg9eE+JGKdzFbrMadqNhJ1ju4e3mHQQUXd56XXPW3jJj0aYiwERTJ1XwouymCjZk2NfH7KmOSDpnSYqWvUK2qJJANX9JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jU5o/uTi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jU5o/uTi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZgn36BVLz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 21:41:59 +1000 (AEST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1521858a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349316; x=1788954116; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8Dfh++0Ud+IxXdfXwfXS9P60ggh+Cfx9Hb6zf15cRc=;
        b=jU5o/uTi19oS7uX8YCNCCE+bY0MHl5E8vkPnmEb/IQ1sFceBCJYvChF4bHmBaUJa8h
         JHvv3wENXT0+qRG40AaurPbM4rM01rvy8LmgM4X7G1h3mxAW+yJI0hcihfjC47MInj6f
         b5DToAmyI6VOFdcpY9bZhCzTE7blK+L7noVpvMXL7LWVxJwQ7Sswl6rAa2vXrPGMlI2O
         /aBXlS7ydmGlyh5a9IeF7EGX7SxDyPgd84e4uXdGDp/YWBr0uiyW2PL/qoMVsutYkbxO
         Q4Oo/W/rLVUk3H9iMluVTGYpPE5W4KHuJobJVaUjk4boX/N2VWjw82huzkEPJJ/70GF+
         qxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349316; x=1788954116;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8Dfh++0Ud+IxXdfXwfXS9P60ggh+Cfx9Hb6zf15cRc=;
        b=h3RT7bdeigPaRMo87ytSA27FIHHGhsOG+DotNIs6ZXWtUreDM4/koutn1LDA/0wKxk
         EjwTyBGTR7EIsgueYK/Yc3dwpzYr4h0kAJsWJvb0bo8qlylgFvnTOZpJvZW8zcDussHG
         nrybNJ0vH7Ah1xuZDz8zj3ofJSTahniPKCG53RiZ+/80lGcFOZEIFMnBX4QAYVvf/BRi
         91NFkS2iNuYKQe0eR93sCcsGXg0QOx5JSy15cHDCb4sLkAPYTQqf7RQT07yKGByfE6CP
         tiUi8mrL+plW9ncosBTseOzm4e1scu4epbFsn59C414iOLWQN5nLbxVBS3C/RhiP/2mK
         UDOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSNEQOmHjjrXQGITmoeGorHv01lFqCHmak4rQCRwuzlowwpWU8CVuZzwcLaDvlPUsLi6So7f+aLgUMACI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l/NyhAAcq4kikjb1ZopBSsb91g2YptKY0RerjUmUwbuq6ses3L
	egr0JZLNTBa5XK0qCf7y4jrbnA0R4zAuFzjWQrZ5RzAjQQIKhc1JwMj01RGQaXhF
X-Gm-Gg: AYBFou1ffBnynweI4+ku6xFUOlLZIadG9lbCpwKBm4iw5atJ893GKpm36jUmuAhGs/G
	C/tejsUy/wIlgwzLrREIqzdj6SppSePmmimtG/NG3WSmoVEMOwIvgqH/7FKI6HJCTjtubrGGW5L
	6ljdbsfwOQ9CyT23ERBb3DHcVHP0HfYno0ES3ehUCbE5i3MGWPqSe+m3+tyHsgEZR+k5jcpTNup
	c2SxktuamnSsUKahsC1s7kWBHdZaYoBtdunzloovKJVsmqWtbPFhPtj/Hzu5252/OlgHWjBn9Nu
	8Zvu9+ktDMEuzA/F0edWnQQuze2zwO1NTDIdcttMltzjsDaiCTuK7s5VulhtgLq2tImV2JJbMCg
	l7VpYU7GSTzWOkxvSk6VfWw8qmUVBYslAzfBYdu+nJVy4GHDmzlLGWIzTC3PGAP5GZZfSCFtViI
	oCaPVx/uiskdp4zj2y/OOBgjDc/EwOfOi5JSC/81rMxNxpeVfAUqnxp6oDZPrrvti6cQooZ1Dgv
	DfhIUFiqLQQULHLs6Bk3AU=
X-Received: by 2002:a05:6402:3608:b0:6a6:32f5:556f with SMTP id 4fb4d7f45d1cf-6a682ac0a4amr2806106a12.17.1788349316334;
        Wed, 02 Sep 2026 04:41:56 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d044d776sm117567566b.62.2026.09.02.04.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 04:41:55 -0700 (PDT)
Message-ID: <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
Date: Wed, 2 Sep 2026 13:41:54 +0200
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
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
To: Mike Rapoport <rppt@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin> <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
Content-Language: en-US
In-Reply-To: <apcPg_y-HsMki7we@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 19:46, Mike Rapoport wrote:
>> * Does vmalloc() guarantee that non-pageable physical RAM is allocated when
>> it returns?
> It's not pageable in the sense of demand paging. Some architectures lazily
> synchronize vmalloc page tables and this can cause page faults that will
> take care of the page table synchronization.
> 

Thanks for this clarification.

This sounds like a showstopper to me. Immediately after the allocation 
of these buffers, data from the USB device can arrive at 400 MB/s. If 
the data flow is throttled as a result of handling page faults while 
trying to write the data to these buffers, this could lead to an 
overflow in the USB device's own RAM buffers. This is because the USB 
device is an FPGA, where RAM is an expensive resource.

So using vmalloc() may result in a malfunction in the data transport 
where the __get_free_pages() would have been successful. This outweighs 
the benefit of a somewhat higher probability of success in allocating 
very large buffers, and surely the improved aesthetics of the kernel code.

Regards,
    Eli

