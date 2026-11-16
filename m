Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5589606A323
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnDm09f4z2yps;
	Mon, 16 Nov 2026 23:27:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794832039;
	cv=none; b=L5YkN96dbn/RwkmloNWDGlTj71kvVg67gupgqAuCU8WyOmcqibzVZLfbavm3V/Au2mUJJPJo+9qt8rKWiBMA1Xm5YDVnwgDlpihpsdz/FQmj2TeXWEX4VT+JqVJ6QZuxeBvAyewrb1sMxz2rcmovfNSkpvx93a2lnFB/cv3GW+YcAvoGVPAcK3+hC5O1RXx+G6cRWp/vb6KJRaHjbnDKx0WpM3X7r/CMZa1i0FZ5w521NlaXLchNo+/B2+JzRA7lHhUDB4x4EHcfE3fPKSXVM0c4xZ59NTdLLOofFZyO1B606yoJi+W0iojtH/uRcEa3b9BpprTvpsl/XbgcPAgD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794832039; c=relaxed/relaxed;
	bh=M/OF7APoumABD9WbwERDFCvwADBJ4fBfCeOD/oHIzwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxQ6OIrJck477jwGyQ5FRb3XxRXc4M3DCeQOxz+ff4k/gFaRQKbt9yArS6p7lJf82oQecjjA307WlQW37pC+VTwYxOJTsxIsDI04s+XzGC6Gx0ztReVeWD6r6mAokNDCM+9MtFQHeJhhXTD+GgEhZ4D4Aw3+LXNEEhhfcJpLYpzD80OBEnCzcFvptm64HJ+wadqkIpsplwoHHXL5IKPiKdr2gNn23SThOTDBw5+771vjDWNuLzq+K0BRiG8v/IQtDUlF3KURY6a+E59UR7HLup4eVr676KTGw5zAaOxXK/E9yEjK2mj51CpOpFnPtfH0mkK7oLV0tp1kCviDmHYRcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M72DO2Kc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnDk6GY5z2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:27:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794832034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/OF7APoumABD9WbwERDFCvwADBJ4fBfCeOD/oHIzwM=;
	b=M72DO2KcGxCq3SQ8gc204fLLtSijoDaKmAF5HtLH+MAettGLhzCpPxrQs0ZsB2eRxblaBo
	q9MdXGpXbqn3vSmgcH80P+oNYtjeC2Mo5ervsn17kircXQhIfMsQbCZxfAgL10mSC8vb+5
	5cTAg6eF0hLVIOH5POhWTvDphpecFDs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794832034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/OF7APoumABD9WbwERDFCvwADBJ4fBfCeOD/oHIzwM=;
	b=M72DO2KcGxCq3SQ8gc204fLLtSijoDaKmAF5HtLH+MAettGLhzCpPxrQs0ZsB2eRxblaBo
	q9MdXGpXbqn3vSmgcH80P+oNYtjeC2Mo5ervsn17kircXQhIfMsQbCZxfAgL10mSC8vb+5
	5cTAg6eF0hLVIOH5POhWTvDphpecFDs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794832034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M/OF7APoumABD9WbwERDFCvwADBJ4fBfCeOD/oHIzwM=;
	b=M72DO2KcGxCq3SQ8gc204fLLtSijoDaKmAF5HtLH+MAettGLhzCpPxrQs0ZsB2eRxblaBo
	q9MdXGpXbqn3vSmgcH80P+oNYtjeC2Mo5ervsn17kircXQhIfMsQbCZxfAgL10mSC8vb+5
	5cTAg6eF0hLVIOH5POhWTvDphpecFDs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-uxe-EJSMNoqM2fxjjft9qQ-1; Mon, 16 Nov 2026 07:27:12 -0500
X-MC-Unique: uxe-EJSMNoqM2fxjjft9qQ-1
X-Mimecast-MFC-AGG-ID: uxe-EJSMNoqM2fxjjft9qQ_1794832031
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so23531375e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 04:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794832031; x=1795436831;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/OF7APoumABD9WbwERDFCvwADBJ4fBfCeOD/oHIzwM=;
        b=b6mupCWo9zx9nGRNHRa4LITQpt9fgr9OoSrI4VzckprMT57eXPWXU77p/n2Qk+oLbw
         xGwGgH3K/UlRACxG4C64VEnvj+X3trm7sidkwUQ6nruK/+EgKhNCWArGSGWbAVfIE1ba
         izNYbty/U4uLc5jwF7g2/H33N8a8BFX+R4GLEZqiFly5RvhIBifEser9H7fchgT4e/Tt
         fXCVSLTHWCY73nkCB4cP1YVZhPNVHvHWte2p86mQOg7kqo5upHLYECYrtM6c9KkXZdyV
         3SAI1BjY/wpJEJ9TTpf3N2rwfiANAir9SkDtWRnf5cCpBMnY1IKm50eFeTXh4iNG6/PT
         0TpA==
X-Forwarded-Encrypted: i=1; AL+hErHJYQ6yuKtcPDj/HDCe7RQptx7hhmeXb/DQsZWHJAUT6eD6m6KfUvOaAfCanjR5gxkl8DxqanH2ptsWdeQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Wgs4TQLylexxH4GghS5hzolaUjwmClFBGuiv/FMyCT6Q2zB+1
	7QcVOS6QpzL9mhBACH16DCFJmdCXF6Zla0/0oe2ErE6nZmQyOyowyhBRwnQg8uhC5F4dfNOpsMe
	cSYNyyUOS2gpDntTKAj0V/WJAVyJqyqIS5DeQcd0zvp+g17thbNAXFFdfC0zGnXRzoNM=
X-Gm-Gg: AYBFou3vVsKH7WLY6hPIg2mx7JP0E3U37cXuS3Pa6XFUMbtmPwjpT6ldWgQTcA92oMl
	5rvMg8rw23yP1e/rvMkbpRVB//IAQFRsk2fo7GdMFWG/2igsmHi9xWXV8p9rBhWgup8eIwlTRs4
	t73SzifYykvbTXsfswmhxcdRjywaJm8vmrHMsTgAxYNpNmDVfJ2+1nuliGNtI3n+NXwX3+5Qgqo
	gGHkdGUOjHZPEEQpyqCwtucD5Xb4uR8x8sstW3DszPuHAPfRqd3Eo/txgN4O+Qtpq2Cy9B1BQw8
	Y/00hsrOYHkc8ziQ+Ql8SWAXdxpj8VRgdsw+THpxPJTzMTcaJreCYyb9pOUMTQhHQ1K460QXGHv
	+a6OKS/IRTn7ikYDBd1tmicjo+Zcd9n3RjJU9T+nP0TL8
X-Received: by 2002:a05:600c:3496:b0:4bb:6de4:2f7c with SMTP id 5b1f17b1804b1-4bb6de43047mr75923915e9.20.1794832031464;
        Mon, 16 Nov 2026 04:27:11 -0800 (PST)
X-Received: by 2002:a05:600c:3496:b0:4bb:6de4:2f7c with SMTP id 5b1f17b1804b1-4bb6de43047mr75923195e9.20.1794832030971;
        Mon, 16 Nov 2026 04:27:10 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5faf05f8sm169923545e9.10.2026.11.16.04.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 04:27:10 -0800 (PST)
Message-ID: <562b9015-6967-4858-8f17-a49978b30f2a@redhat.com>
Date: Mon, 16 Nov 2026 13:27:08 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/powerpc: Fix set-but-not-used errors with GCC
 v16.2
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Segher Boessenkool <segher@kernel.crashing.org>
References: <20261116103710.674746-1-thuth@redhat.com>
 <b2abcfcd-2d89-44a3-ac03-7354c3be2436@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b2abcfcd-2d89-44a3-ac03-7354c3be2436@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _I65SjIgTyySu40_6Uzj-INQYfpLMZQYOwjMRCJ5Ks0_1794832031
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 16.11.26 um 12:07 schrieb Christophe Leroy (CS GROUP):
> 
> 
> Le 16/11/2026 à 11:37, Thomas Huth a écrit :
>> When compiling the powerpc selftests with GCC v16.2, the compilation
>> fails with:
>>
>>   ../pmu/lib.c: In function ‘eat_cpu_child’:
>>   ../pmu/lib.c:86:22: error: variable ‘i’ set but not used [- 
>> Werror=unused-but-set-variable=]
>>      86 |         volatile int i = 0;
>>         |                      ^
>>
>> and:
>>
>>   ebb.c: In function ‘ebb_child’:
>>   ebb.c:352:18: error: variable ‘val’ set but not used [-Werror=unused- 
>> but-set-variable=]
>>     352 |         uint64_t val;
>>         |                  ^~~
>>   cc1: all warnings being treated as errors
>>
>> Add some "asm volatile" statements here to make to mark the variables
>> as used and to avoid that the compiler might optimize the code away.
> 
> This looks really uggly, a cleaner way is likely possible, see below
> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tools/testing/selftests/powerpc/pmu/ebb/ebb.c | 1 +
>>   tools/testing/selftests/powerpc/pmu/lib.c     | 5 ++++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/ 
>> testing/selftests/powerpc/pmu/ebb/ebb.c
>> index 21537d6eb6b7d..f4ef92bacd9ab 100644
>> --- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> @@ -391,6 +391,7 @@ int ebb_child(union pipe read_pipe, union pipe 
>> write_pipe)
>>           val  = mfspr(SPRN_MMCRA);
>>           val |= mfspr(SPRN_MMCR2);
>>           val |= mfspr(SPRN_MMCR0);
>> +        asm volatile("" :: "r"(val) : "memory");
> 
> If val is not used, why not just do:
> 
>          mfspr(SPRN_MMCRA);
>          mfspr(SPRN_MMCR2);
>          mfspr(SPRN_MMCR0);
> 
> mfspr() is already an 'asm volatile' so it will be executed even if the 
> result is not used.

Ok, agreed, that makes sense.

>>       }
>>       ebb_global_disable();
>> diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/ 
>> selftests/powerpc/pmu/lib.c
>> index 3213579874084..32cafd40d2c56 100644
>> --- a/tools/testing/selftests/powerpc/pmu/lib.c
>> +++ b/tools/testing/selftests/powerpc/pmu/lib.c
>> @@ -95,7 +95,10 @@ static int eat_cpu_child(union pipe read_pipe, union 
>> pipe write_pipe)
>>       wait_for_parent(read_pipe);
>>       /* Soak up cpu forever */
>> -    while (1) i++;
>> +    while (1) {
>> +        i++;
>> +        asm volatile("" :: "r"(i) : "memory");
>> +    }
> 
> If 'i' is not used, why keep it ?
> 
> Just do
> 
>      while (1)
>          ;
I assume the original intention was to make the CPU do something beside a 
"branch to self" instruction ... ? Not sure whether it makes a difference 
for these pmu tests, though?

  Thomas


