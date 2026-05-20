Return-Path: <linuxppc-dev+bounces-21226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B2CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 10:00:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL6Vg6Qsgz2xqv;
	Wed, 20 May 2026 20:00:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779271243;
	cv=none; b=FJCPynC2Ic6Shjb0s/O/my++3H24KS5BTR2kKer0I1cVT6zidlbBDpCGgO/5FUmIPvXfeM81x0Wp3N43eVet2u5JO4j5fILbhjzMu2DSuOwV4VVWZGF9xyGqmIWc3ZaD34By8K8XboEM9F/68B51lrYFl18a5oAkNf4MjqZNeCzvFYqENaHv2ABAHYlbDqYa61Fgi/d2CJXqU74jJEnYmf2suRb+lCrQqnhZl6RD7bSE9juXzDurEWbvDa+xzmPYRTIe9+IZ05ae8zJLMatmAoX9bvuNLmfqHQGu4glqXVbTIUn4eA4Wf8v4nfrja7C6lbg+CySFQ78YkQj4kCoS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779271243; c=relaxed/relaxed;
	bh=eevHLhUKWkGMV3Q7eGSbySZ/65dImn12/rg7tybSy8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLVCAySLwP0xDbXEvn0lLb6vvbNJpce/iXZgUpXuBkaviPaaUnY+7/x/Mmwdnn6fF1iqxh3+ctISS0Y2LMOwrApM6ZlO/ajzDvXYO/h3fXNEnWDsVWRGTVWIq0Imj2a78xuJUuIP9G8dc0JNo5fGjVD8ZVhNw57Eqo455bNMiLqEQEPKXGFBeeXsirUy6sKABhDLUfX2NaI+VM/Xp0OIGPKsKwy6xcsRYyAyNJwXcHMmH1GeEUlHjy/lYGpUXkqfb64RjBw2647sfeV68GTz15jMnWfB+Pe2dyOlvYzOUVgJuBHUfScORM/BJdhYENcelZwmaMCwsW4ZQEDgEM6Nrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FOmz1/K6; dkim-atps=neutral; spf=temperror (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FOmz1/K6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=arista.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL6Vf1mpmz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 20:00:21 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso52291915e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779271214; x=1779876014; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eevHLhUKWkGMV3Q7eGSbySZ/65dImn12/rg7tybSy8o=;
        b=FOmz1/K6gdF3XFjiR8n6vnu63XkV3D+o/xVWY9rRqDDPt4oGsEhNKxzHPpU94dE/Xv
         9pqzojfIaDxC+EIjZCZTGO5jq5sl28zEughgE3KzpdP6OUTsRh3ptD38wua+IgWyyU5a
         Srn2ezBKqjiujcyWU+svf2Mb89/QEUjBd/1X1M9JtJravL1E0v+B0/ICfQYeFiKwQvoi
         wfVNyG7RERVhtflXB1xCWnwM77BUkX5B8N1TQFe1NjYly5a9Z7Fr+LMmH8j9UPmUnMMI
         o4Q4z0Ef0rcKqR7YeZf8BpHT0wUfR27cgLPetuYw+F64vrcYNiacNomF9+QEKF9jIaqZ
         VxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271214; x=1779876014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eevHLhUKWkGMV3Q7eGSbySZ/65dImn12/rg7tybSy8o=;
        b=DKVqZHlXEicZvznWakZ5VV3ptsLylZtdCaUxwJ1O2Y+oLAkvDTRXBitFGG/JXbIyMy
         ffHOVqgfflBQ6xrJcSFegeeOSlaOHzdoZeqAwz0mh/7xsjhDxA3WA3Sy1UGYRx8UrIsS
         gzemg/Q3q4aDMJjgA84gQ3NXSM91ShZyX+rM8um95zgu202UD7JCt0b1EuURgZsXpNHQ
         CUdEsME/mBuOcAbW910HjrO3b+G5nhroCn1WVYi6ksJBrCs9z1JHjA0wJHk402PSDq5y
         hBsdruIZXFP0e1CKp61ZXkHCUkHxgsqcc8cIN4R5t8T7xPfYfyH1coTCwBucoOraZKqC
         NFuQ==
X-Forwarded-Encrypted: i=1; AFNElJ90m7UInJEXZFLQOvEXX0k0VQDOh0obDNtC5oWz00cmySU8Lu1KfbBN/cUIg0hlchShob5K3hJzzGdnczw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKirdjpfVCWhR3O+WPqr0hQTe7AIu/l3QH9BJu2Ak/8hxkmKt7
	u48yAQbtbeNo+X3SKLSRx23sMLwwFicylSjtpRolmfm6CMneX8qle5tcpVmgq9k3hg==
X-Gm-Gg: Acq92OH2al7drCNnpiPRhXWyWVc1I/tB2Wy3w7RXoKTiziqsEteS8WfJsf13wi7dEox
	xoG6RnLybiimh92x3AmdEdJ1dmEyUaSPk2inoecMFkm8UhC8m5zinWhFFRcYX4iLXuAWX9ZKGjW
	ZlkTaLsjMm16P28wThD9+/nmWJ5O2RrsR8n49Pwqhx/S78gWLWCETETzCo3wIfACKfR2UZYxYMJ
	LWNO/rxQd2TY0nqYqVeZWhaSUvjQ52Q//OiCbLQupIt3h+8itzg2tShZtbB8BVXPafRPplJ7lzX
	/Eleu0fk30f76Bl5KTwkKXuqbmIAa14f30vlypjJwl1cJJTmoublVuzg06RL5R7L++sb34ADpE6
	gd1Tex7OPkUK1zT/nt6RG4h7enMfpJcdRtJILZe55PjQgWmd3z2PES4eFIZLWuH39UNI5P1ut5p
	rdw4yoWCFkINdfOCgDzgC5elebuGUOxc5y
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id 5b1f17b1804b1-48fe60e7a13mr343604215e9.12.1779271213845;
        Wed, 20 May 2026 03:00:13 -0700 (PDT)
Received: from [192.168.1.34] ([51.37.155.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm378173475e9.14.2026.05.20.03.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 03:00:13 -0700 (PDT)
Message-ID: <988a07dd-871d-41fe-b432-d740e3122e38@arista.com>
Date: Wed, 20 May 2026 11:00:12 +0100
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
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
 <ag10ON5pZ4ymPT9U@wunner.de>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <ag10ON5pZ4ymPT9U@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/26 09:43, Lukas Wunner wrote:

> No, is_error_source() considers bus number 0 as a bogus number
> and will iterate over all devices on the bus.

Right, if address is 0, is_error_source accepts any device with AER 
error and returns 'true' for any device on a bus. But 
when is_error_source reports 'true' for the first device on a bus, we 
stop iterating in find_device_iter. We stop iterating if 
"e_info->multi_error_valid == 0", that is our case. So, the error is 
reported only for the first device on a bus.


On 5/20/26 10:02, Lukas Wunner wrote:
> One more thing, recovery is failing here because those four devices
> on bus 46 are unbound.  I've got two patches under development to
> allow error recovery for unbound devices.  You may want to try those
> and see if error recovery succeeds:
>
> https://github.com/l1k/linux/commits/aer_unbound

I believe that aer_unbound will fix our issue. I need some time to 
confirm that the commit fixes our particular issue.

But I think that we still have an issue in the pcie_do_recovery 
function. It is still possible that AER recovery will fail. The reason 
could be different, and most of these cases should be investigated and 
fixed. But until these issues are fixed and there is possibility that 
AER recovery could fail, users should not experience the kind of issues 
I described in this patch. For me, it looks better to do an AER error 
cleanup even if AER recovery failed. We can add an error log with a 
warning that we did the AER errors cleanup although AER recovery failed.


