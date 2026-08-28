Return-Path: <linuxppc-dev+bounces-26171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248B8C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:07:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWdw90rVbz2y8F;
	Fri, 28 Aug 2026 23:07:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787922457;
	cv=none; b=W+rWyOhQb+n9mof3OSzaB9lEGhkcLoe+lCn6SEreYGwrpNJGMm/GKo9AtH1kuasWCvstr3Z5gNbNoUmtFnJi9YppxpbTzVvYNgiBT+fIWfzLTjpKxVrMgf7nwrHHhQFTgm5JAdRU1lxYlD0WsqWvXlMiJSbWXYgB5SfiFg/njGXgGwqDglchm4QpIoI+NRdWphMwMXjdomKLz3MAn9YP55s9Dd3aAshzb6/orQ+KXsQHdN+YMoXZvp0VzxTtl7M1gwBpu3Fdlvh5qaN6TxVf+ZQd6HsDcFOSZAcF5NhUkObCH47PFYAgae/3AzledMNVYfhZSfzAoZOpUG53B0dqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787922457; c=relaxed/relaxed;
	bh=E7aHFohDYwXcOP7zZuVMn7W5BMSpOSC48205QwYsUq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7P9glP4iKdzFCGNTpHKEkc9ow+TnKSbCA/KLUn+KdMXQ74Q+nf1WiPaQH8g4SJkTZAthYhNLt65EzNiuJolYXVKQz1nA5G589DXm2OjygR8zlF1vcHlVUG8pnQ/QrL1VPlqh4cNF5911zukaFHNZNQZuYzhSKKQlHbduw7ypES/CSPP0XARK42XUceRdyZklHCxncnsdDAQlfIsiTLgtAywtWjRHgqOUooasc8wPaqAMmaWx8iU3htE2YMHVB7n8KxpcLJHamoogPSEdBPBIgs4+7XR/QUBNtq3gQrZaQU3fIYG//9p7KTH7SGpC35X3UKD9yIWVoA8Q2KuVNhYTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MmkTkQ2n; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MmkTkQ2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWdw66m2yz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 23:07:33 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-495590dde14so9058935e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787922450; x=1788527250; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7aHFohDYwXcOP7zZuVMn7W5BMSpOSC48205QwYsUq4=;
        b=MmkTkQ2nJGQDzMvWbOJ/O5PCjOmdJewTh+G5bMSlmgODBwCeZxdNm/2SoREES7o9PQ
         RgkHloMwgOayE19B/Z5q+B0XMDi7XhqaIZt5D/NnuwHWXXFeDQ2SHXr2Ux6fB5HGljus
         lRF6PG4z6hhIhh48eKRAAr+mDZH9ZSAXsFAp8TF3T3QnHd4KglcsaC/rHUgLeozLpSjD
         e7t4TMR4P8vyV19dWg2KzznFkSKOHuvyUXgR1ZZ5iioYMji/h6F082hVGuyE9t370/iq
         71jPD/aQGtjbMBi8vu+4N/cthWIj2ibWhjrtlXUcJej6E+reDuBIJKYIGHmm21ZfhyMl
         j5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922450; x=1788527250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7aHFohDYwXcOP7zZuVMn7W5BMSpOSC48205QwYsUq4=;
        b=W/0WyPD+WddRIlI6fkk5DZ0bP5evPMtmQCbmrBbQMw4ART1nmDHzjgL9Zt9Og37eX5
         F6V4xBKBZ1ZYUGijS5Sho8HybTAC0mQjn0cA59txy8nvpdjSCAJ9By+YAYuWWWGH4S2v
         bZMYN88zfWUZvwEFfiyC/ub3Dmie1A09qZ2XPWiaSKzgyJZjPUMrxTrYUHNd75Ol2hUw
         X48s/vxhCegBYtFgLut7MemdEW9168foE8TxOb/4d5My0ugp9CisXHD7vlu62SEh+0x3
         q92wC/b+YLzaie0+TUieSfYt7SnAnIY96hHXWgRt0wyJJMQNRFedyufqNUIIPAZkp4BK
         a67Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrh9LwQF68d45seNXlwYoSvRmEoeRrheImayZ9gEwwAxrO0bhE+q7ljKmyMUpeWWFds/JAMiasNKxRjiD0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l/bAvtmFVxSbBHSFy3Or+v8hs60neKaD5qgins0MuUcW7SZQWT
	Xe4kFlZXeuVAjs+gRypShhmUU78LurlPtB9zDMUBH4C8J008HJs/hsOFFglBZmwmyJk=
X-Gm-Gg: AR+sD13cTya3q8g57w19cFVZad6nBzx9Cq7KvpGfEmF+HpV9uaElr2dCJwE+BsjxvDm
	W4oqBv0D0tBSyf1pQMOTHJkzJEYxYZAClRJJppGd9fDkUY45XUWiaWDXuS4ijMzZJa7729hj4h8
	wsPbCXXjasQ3pVBFcnw11GjJsIlzds5EYTDlcSIzw+ydJsi27fJFqjW2oqI5k6p5OhRmekpUhJg
	ReGUZ9d2k7v6xokShmU+5MQqmmndBu1qibXeQ+5pOCqbC1ckQwZMwTGwkhIIbbICkoQ5WInOlGx
	T6+tRpKfwHdZlrA2RcSvh1KYB6tHUORelEIoVCFCZkhrHNH2ereHpmMar10dEfsm5XvkuBNeCFr
	O+la2pNtG3SJGMxIepcilm5dKhCHE+n8Pfwa8KpSA/7MSPeN3au1LEUs67wUBMnk1dm1bkuU04z
	GAYYVsruPlN2z2m5XoXT6ZhqeqvYx2ZpRTJ7dipCIffT1tjDYU/oQuWncSfqpZYOoVcCm++o2lR
	zQ6Y72zK2eNY21hEC5AKL+4NQ==
X-Received: by 2002:a05:600c:8885:b0:49b:909e:922e with SMTP id 5b1f17b1804b1-49b91c4884amr87957605e9.10.1787922450172;
        Fri, 28 Aug 2026 06:07:30 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm56272005e9.9.2026.08.28.06.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:07:29 -0700 (PDT)
Message-ID: <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
Date: Fri, 28 Aug 2026 15:07:28 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
To: Ard Biesheuvel <ardb+git@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20260822135323.795946-11-ardb+git@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The arm64 module loader has to deal with a couple of corner cases that
> may occur when .init.text is placed out of direct branch range of .text:
> 
> - ordinary direct branches from .init.text into .text may require the
>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>   only that additional PLT entries need to be allocated for
>   cross-section calls, but also that .init.text needs its own PLT
>   reservation, as the one in .text will be out of range as well;
> 
> - dynamic patching of the ftrace handler into .init.text code needs its
>   own dedicated trampoline as the one in .text may be too far away.
> 
> - recent compilers may omit BTI veneers for static functions that never
>   have their address taken, and so additional veneers will need to be
>   added to .text in case cross-section direct branches from .init.text 
>   require a PLT entry (and therefore a landing pad at the target end).
> 
> This is unfortunate, because it is actually somewhat unusual for .text
> and .init.text to be so far away from each other: only when allocating
> either of them (but not both) exhausts the 'near' (PLT-less) module
> region, the other will be allocated from the spillover region, which is
> not in direct branching range, and therefore requires PLT entries for
> cross-section calls.
> 
> This series addresses this wart by allocating both of them as a single
> chunk, and freeing the .init.text part along with the other init
> sections at the appropriate time. This ensures that the two regions will
> never require veneers for cross-section calls, allowing the arm64 module
> loader to be simplified.

It looks like this should also be useful for ppc64, which currently
merges .init.text and .text because keeping them separate would require
stubs between the two, and consequently .init.text is never released in
modules on this architecture.

-- 
Thanks,
Petr

