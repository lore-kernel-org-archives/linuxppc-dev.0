Return-Path: <linuxppc-dev+bounces-26562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893F2C79F87
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 15:29:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc0kb0PL8z2y2K;
	Sat, 05 Sep 2026 01:29:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788535766;
	cv=none; b=HrB+heRDdN0Pu1qWgoCWxrXKLtKoj2KrmfpTbBk/sdJOmHG4FcQUdxccoElmPNb06sOmq2Z5bjjOiyPnQ3V2bzNvgqP6U3G9XXLxnj8Khc94hz+plf795fVH4XabH3AxPMxpLtn6LmYSDnq4mlYJvsiaVJKhXSeVuLcmvL2zA+TXZelfVQlZOtKYLkLQSTVilKaQnyJchUIwpLFe07YMHrh5AHBFU29hlQyrel8e41KGpIeUluihtt7UQF7bBwL48XKGrL2FJmTqlzbDr46WyVzUghB/A5N1AjafHmGZTy/MLpeiGtPX5tVYUw0t+We9Qp5vQmuXmhIzm364ZMMy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788535766; c=relaxed/relaxed;
	bh=b3s2kh4gj1DOKMjmkcbmo31+xgIaWNFlf4UB372dsWc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M2kMSA57ayqq5D4bjpYHMRG2SbpGhyp1aSc/eRPNgduhNFBWbwPyC5MJ0/K+GDMOWUuiCUKbwGQNOL4zMX95g9wr8m+Jkt0LiLJp8hakoVQOaDulcYnXHA6eSNGrHz8EyDmRmy0TIpNsar4IDjJjizxLX84cN3RU5aZsA2cTEf/ZC25hrzkqKHWhbsgqAkauP6btjyDad9XftbxECkJeU5sYZxK2qi7rJSyMRHPxG0VjbC5rVyqjV1qSbBf9fqfelqj3RpNaMQoqBCBeFZ9pEe71nNBmkPxhZtJaTtmGjJdm2UB2VZHv+7MVgEl+1t8QBUh7X1a0he9beDz0/VjXDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kD5l8XFG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kD5l8XFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc0kY0DHYz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 01:29:24 +1000 (AEST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso1713011a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535759; x=1789140559; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3s2kh4gj1DOKMjmkcbmo31+xgIaWNFlf4UB372dsWc=;
        b=kD5l8XFGjhneJHipy9NSHtzg2Zt564um4HsZ3revV3AG+GaTfy45cRPUurOzMz9Lyl
         zLzPoWMaFVWiCTF9Kco38YAFJ6cwWQC6CEiWYdrxGpMmkktopycy7l1e30Cf9BXBXLVg
         HkJr9YNjlgM7Ds20jdtmxVt/KKzxPQncrfVFWwOtVh3FBfYsNbmmAXfoV3/fbFu58oPC
         PaQ+ECUv8Ys0NIzJD3LTxVVzAsySfm0CtNifRd8D3cGZnxeaB5YUCW0CQ7iwzJP6hlXv
         4VfEuGwrt91uHIKNuoiP0up2MR2m2Zlt9gwIrNlPlzcnIUUnGZVx2zTAKAQyAsXoBve9
         ge8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535759; x=1789140559;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3s2kh4gj1DOKMjmkcbmo31+xgIaWNFlf4UB372dsWc=;
        b=Id8+GzMzJGbC5+OGaqjwLg3ZTigJRCtmy6ZTBGI7le5YjRWUfbfalnHn9EXjgEbVjL
         wpzTbIKXLVU3e8B8QAnfLu6DXfnFyiwyQ167SL7+rCLtlvfqqp4EYJBhxagP7NOJhy/8
         CnR9e3BMvvNlj+HEjWCwWGQct8k59p2tSab5G3MGXAdR/fm66FForH9qtoqwUYMp7Ldm
         RA9jRORVThj2HSe8acVLGGLAuh9h3mkgmKAMzEVM2HDfGvCtvLBn3SMFN0ypam4/JRWt
         xrxPUg1ZG73UTqPljaz9meN+icxrnE99i59CE80AMBNO9hlbtKc6QOPdWdRsnEYI/SzE
         uMzw==
X-Forwarded-Encrypted: i=1; AKwUvBzOoomd7K1w7IjtA9sjNTFnMLNwptjgHnt66ZPimrnhyOqYMZ066lsgTRG+iljsu3g5i/hiatNYr0n5Eo0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nOPDxQIVwtX9JiAmxCcBqniVhL0jpe8ZX5nczSO0iv7ceWkuTh
	KCOD1SOHh9Y6CnoRbCaid3s1EvzgfH1MhcQPlk97mAtjxVGVabq5e5l8
X-Gm-Gg: AYBFou10mUAZrv1dH8+UfDEGZrCpBi1CrY+ClZ5mME0hNp0GPPQKrx9n9Hjjcvq3I5C
	pE/4QKcfw4XQamnfDcLUW++byHeKUogbd27CGQwh0vlawfk3qcejcKwUPImMWUN078PO6yq+E7I
	2H8iZjyJmS9MCaCLMJkg18qo7xiQU56yxuLOQ08XWOY/zNiCtuu0WZp3H5Ib3TJcVE0t2duufTZ
	twK0Fh78pqmUTlTbmUJFJ1a6SJSqmhPd/MFSlhiSVgzlEvb8ofGQ/oyHDY8koYfTEyl00JWnNAt
	ioOOHzWYxKlSIohuJ16ZtGKGUQ0j5WPkKO39WJXMtcSAWhoLxbMpQbz9dtctPTLhsl1MmAJmY/1
	O52G9Tbc4gM4b0/rmSD7JUoe1O11/reLBnaxbUOGl/DdiCTIMASTQ66ANFD7j8VXipPFNcbDX93
	oAY5PyXsql6Ei5268Gel2MtYBvyldU6uLYgR0rgyicrvSQMCQGLSmZyM3Mx0enI+WYl3SFDK5gu
	7O8uZJkStZ/DNmA74LmSBw=
X-Received: by 2002:a05:6402:24d0:b0:6a7:ea54:386 with SMTP id 4fb4d7f45d1cf-6a7ea541e6cmr1470990a12.23.1788535759252;
        Fri, 04 Sep 2026 08:29:19 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bee8e8sm1460646a12.23.2026.09.04.08.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:29:18 -0700 (PDT)
Message-ID: <49245a34-cc56-736e-b2b4-168c2a0b1df7@outbound.gmail.com>
Date: Fri, 4 Sep 2026 17:29:16 +0200
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
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin> <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
 <apgSCyj-h2xVc2ss@kernel.org>
 <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
 <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>
Content-Language: en-US
In-Reply-To: <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 16:28, Vlastimil Babka (SUSE) wrote:
>> Replacing it with a kmalloc() is confusing in my opinion, and requires
>> that the reader is aware that kmalloc() falls back to __get_free_pages()
> Why? The reader has only to know that kmalloc() will provide such a buffer
> (up to sizes that the page allocator would) and whether it falls back to the
> page allocator or not is an implementation detail.

When I see __get_free_pages(), I automatically assume there is some ugly 
low-level memory management going on, which is exactly what fifo_init() 
does. kmalloc() feels like something you use more for allocating memory 
for a struct. There is no such rule, of course, but this is my 
subjective view on these two functions. As I wrote earlier, this is a 
matter of taste. Maybe it's only me thinking like that.

And as I'm not the one deciding whether this patch is applied or not, it 
doesn't matter so much what I think about this matter. I've humbly 
voiced my opinion, and that's about as much as I can do.

Regards,
    Eli

