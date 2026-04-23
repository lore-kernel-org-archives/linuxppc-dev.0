Return-Path: <linuxppc-dev+bounces-20015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA34FC0340
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 14:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1fJf4Zk6z2y8d;
	Fri, 24 Apr 2026 00:54:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776956098;
	cv=none; b=VXnHcPKT9Ir9V/w7z57MDSP8OR6srenhDqyJwme9TBuOCLp87CgBV8uYXwPFBQyMJ/P9KmZzXPg5Iwz7gua7M8C5UCaJyfg2cB1u7TXZpUY2jCAQzS7OlZ0ZF8CDIoFc1DVNeA5agHGuEkDTM7A0w/iUcuxx/bH7114T57VgrzOqM331DhM+3M0cW1VNj6nE5tG03l4tqROA6w+fe7Syw1LQ6lsOdvdwWz5+xrWzaJ+QcrWKDZ4sjeC/6J5CH7/rVNlv9l9xOh6DtPGYSx6akD3QGwW6pajPf3Mw5KRw9/292RIUwRYbGxvac2x62+W0gcCn7nNStp4MjHXvbRykBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776956098; c=relaxed/relaxed;
	bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HomV0sS6/I/bt6EacWtlIKiLfwF4uK0JQfHKuDVzs0J5WUHc6d1ceCcqwunafL2M3tP6H6u4/nIkzYZObYw1Yh7R9ddXosEzm2NfZ1YGHSVUGbbd0tiHGWV4fuys9QPAvQYEj4Bdtp/l+XeVFmrccq5f16WU6aH17AjlQpDaKAKuhNToAP4zivO4e93QMKD1KZVjB9XayjUCzREb/paX7s2S+HR5+FiPjb4cfjbGHt4QedrZHSaqOXCwF7pTbkFhE21Lah4ghQmBDrkT5z4d7YGXoLTIqPWKDbcC9G1N3ViZRmAmJETroof5E56kM7uaIzrfCCrtTd1OSjcgRFzrXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dV1tzpp+; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dV1tzpp+; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dV1tzpp+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dV1tzpp+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1fJY1qRqz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 00:54:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776956086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
	b=dV1tzpp+JGeoe/daPipG6Clwob+O64hgsnMkp/Z6gm4LfvThcwuXrqyra7fNPl5Bf3k/5o
	SgBJ7fyoo0bXcR5gXaF/kPX0b6yg/QaEUPv6jqntEycM0/mD/bqpTbd+pOJuHLKlEaeMkX
	Nv3o5nC0r44dUQVn0A7yIk1na1bQ4Fw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776956086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
	b=dV1tzpp+JGeoe/daPipG6Clwob+O64hgsnMkp/Z6gm4LfvThcwuXrqyra7fNPl5Bf3k/5o
	SgBJ7fyoo0bXcR5gXaF/kPX0b6yg/QaEUPv6jqntEycM0/mD/bqpTbd+pOJuHLKlEaeMkX
	Nv3o5nC0r44dUQVn0A7yIk1na1bQ4Fw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-E3NscQzYMKW8x5Xy16IRgw-1; Thu, 23 Apr 2026 10:54:43 -0400
X-MC-Unique: E3NscQzYMKW8x5Xy16IRgw-1
X-Mimecast-MFC-AGG-ID: E3NscQzYMKW8x5Xy16IRgw_1776956082
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so4264435f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956082; x=1777560882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
        b=HZzFr7ux6+81cSEhtGd0u5Ya7B6SuT4ya03WSyg8cPlQMw6USWXvZvu726iy6c0uVi
         lgdSDPmGjAsFTQX8PsRAP+oQZrcbWw2Ugrdf7hgPqWMTO2gRGdd5DqwEYYUcL+TAP3Mq
         tExnI+f0PcRVf9+VR+VvuPZTJ/Ku33Gvhj7rlQVbnswfw/06Ox5uoOk7N0LZqCjCqm5Q
         akuAWoAZL4YmwWV4VchTFkp7RQIE7b9mnUrN1uE3rDuB7y6VEyF261KajgYmSwMotoo6
         zh0QE/phbXHp5qLLysm5ptcH1HKro/jCRZBatu560gunJUBkhNyeFTNdTjOVxMVNGTc5
         q9fA==
X-Forwarded-Encrypted: i=1; AFNElJ89ddgbeCDc+EZ7C90tT5DOE+g16hpJcdADSvi5jpE9QDwtELQHQNpzJenPptzJQyGaoM568gaxuqUyZVo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2GSVLJbUdtqjZhZ48y2188/yMUjkYjae79mv2mQKnrVvpaHH1
	Y9wLu1I17ZmNir9xDz+fxxfdb21PjsbpWxKVsVWRPZA48NUIMPnhKHTaJuO+hXlMXRU0MTYxVXz
	RZWhyQxpPXOj+l4JfKAXoUXUdCdq8jSGV6X9Nu9k1o1so2eqc2Sb69MORrdTK99hTPEo=
X-Gm-Gg: AeBDieucD3he8xGYYwyhrzXKKlwQaWPPGzvIrcIxaiXTcKt2mMTssCNAX4iSTQtn8JO
	KbUJy6PA2MdDXfMMq66yT5EjOB7CWstjUxHafg2dGr5lER5ma5nNH2WGK1hL8lzWvecF5zSoBwh
	fH+vz4zVpwTcabSaeGZqm12PUqUxmfcj3SSS8dAUEBcDNlV1Ul72Ko6lUfB7J6kUHMyc9IzMjXn
	MUCgKLi1mX/a2TBfGjANGmQTGg0X7Ou07iF5whdc01fuOSwNTcJPZY3e5qDwPhr2a011WpuC3m3
	xFzkW21D8HmljLmGwxJb8HPfeWMIhrsh9/FIRbFkiISUbKHEibZn7xA8Lp46AxbFpDyZFCrPlO/
	sNowLYCcCNQbP+v1XfkOTQbE7ggBQwO0cP9lI61Z2k8scMUZbAC9y2HehFbYDdGO6/cQ=
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059669f8f.13.1776956081745;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059588f8f.13.1776956081154;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm52345982f8f.33.2026.04.23.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:54:40 -0700 (PDT)
Message-ID: <8e81d2a9-e095-4687-ae37-e4328bedb7a6@redhat.com>
Date: Thu, 23 Apr 2026 16:54:37 +0200
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
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org,
 idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org,
 tytso@mit.edu, herbert@gondor.apana.org.au, geert@linux-m68k.org,
 ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com,
 kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org
References: <20260422041846.2035118-1-kuba@kernel.org>
 <aeh0CV3UQw1quCXv@ashevche-desk.local>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aeh0CV3UQw1quCXv@ashevche-desk.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ktzNsMaOUq2jr8LWIJIdeJnkNhgTmTFyvYWawz4CJ0_1776956082
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 9:08 AM, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 09:18:44PM -0700, Jakub Kicinski wrote:
>> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
>> that are no longer in active use.
>>
>> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
>> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
>> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
>>
>> Removed ATM protocol modules:
>>  - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>>  - net/atm/lec.c - LAN Emulation Client (LANE)
>>  - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
>>
>> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>>  - adummy, atmtcp - software/testing ATM devices
>>  - eni - Efficient Networks ENI155P (OC-3, ~1995)
>>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>>  - lanai - Efficient Networks Speedstream 3010
>>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>>  - solos-pci - Traverse Technologies ADSL2+ PCI
>>  - suni - PMC S/UNI SONET PHY library
>>
>> Also clean up references in:
>>  - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>>    br_fdb_test_addr)
>>  - net/core/dev.c - remove br_fdb_test_addr_hook export
>>  - defconfig files - remove ATM driver config options
>>
>> The removed code is moved to an out-of-tree module package (mod-orphan).
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> v2:
>>  - keep BR2684
>>  - correct the claim that Traverse Technologies is defunct,
>>    I'm still deleting the solos driver, chances are nobody uses it.
>>    Easy enough to revert back in since core is still around.
>>    The guiding principle is to keep USB modems and delete
>>    the rest as USB ADSL2+ CPEs were most popular historically.

A possible alternative would be moving the solos driver (and others
similarly old, possibly not used anymore drivers into the staging dir
(and let them be removed after some reasonable grace period).

/P


