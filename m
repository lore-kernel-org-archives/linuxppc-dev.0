Return-Path: <linuxppc-dev+bounces-22201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2513CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:57:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYts90L6Wz2yS0;
	Mon, 08 Jun 2026 23:57:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780927052;
	cv=none; b=dYukRsVGeT7lGpteapJ80o9TMwQ8YK2zrhKg9xGfSOaftPeboRYoxQgIxbtEw1O1Hf9iBNYYfLN7pLtbnnRilIqOiap7iQ+SQyRs8reuJDxJL9U2xlvtGqTMwpMWZgUFx2zmzdOwIZa75bCs0mOqZg1YN/6vMvjU6QY00AbLpAO2biXPOAbjyiVKBI2lZzptQ8E697b10ULLyrC3EEMS3C33OO/UKGHT9wahBXJQoO10LCPC3AkAmpLz2ooVh3U989GK4m3HU8Ah59G0C2qHknuURbQcoj+Wl2n7NzhICKe0f5Z6DxnXBTv9MJv72EfbKpsRQD7NC/5VdJ4QA1pkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780927052; c=relaxed/relaxed;
	bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hq6/ar97Tqpil6mebtba4Ar7SHkYXccIc56RiZR5VMpEl4NUbaIfw05D/wACZp/N+PLf0XZwpDmL8fkBc9qIKHK9RN8OheduINwHSP4o8NXwtWDBW+5kRENXeBh61ilV5BcFdIGXdGN4tDZT3iH5hQ5N7WDURjfMm/E+y55evKXuR19Um+7cH49fK2dlsEC3Zc3KxZjO5BJmN7GHB1FQqS3dfJwNdMVWs7bfk3EU4+4uf2hURAQuTOUD7nNVmfrFJ2eHpbpdYp8Kn/ipKt1S25HSdnAUolsVOS2WkvHaLNL2QGuR6aPYjHpi2cJVgpLDpkfl983zBM232maoi37f2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e6vVR6Lf; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V16x2U05; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e6vVR6Lf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V16x2U05;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYts74G5wz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:57:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780927045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
	b=e6vVR6Lf1nDszuE3FklvJPAz0A4C/fTXkDsepIfVZrKhLKK9QGZa60Yq4z1yanUn76Eru9
	/se4qve9qpdy2x0MIcR2OITgn2nVvzIMHpq50AdCseJ6qHyfjOqCv0TV9t20tIEScKejmX
	VpID4N94rQaS8yXQYy//L+K+9au0LX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780927046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
	b=V16x2U05GT0Z47vD8JZ/jpSBFYjgKQx1JozSe7FVStZCaCq7cYw+4jYSCjRwCy9sZATswx
	okX4A0MuBgg8eqWwOYleWppRiAxFxCaswnKeIsfjMD9hAHazFmpenoYBUfcRqOmD8wROkR
	09y2f46t3kLniV13aYjTM4lzcsZY2Hs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-UefaeTqkPN-O5bMLucd3SQ-1; Mon, 08 Jun 2026 09:57:18 -0400
X-MC-Unique: UefaeTqkPN-O5bMLucd3SQ-1
X-Mimecast-MFC-AGG-ID: UefaeTqkPN-O5bMLucd3SQ_1780927037
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600cf05f07so2115813f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 06:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927037; x=1781531837;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
        b=fH779+oPi++4aH9i64f6Af9m6r16oFC8tziaNVA2Sv6/Ul9CQHOnu2I3Q5dm1TIhNo
         HhkJmobtFn47q6Gswd+Jcp8cD30gogPrMu69cMixQ7xHGUk8gDYhbiIYduqws2bZgCFi
         HBNYGR88OQd0l0/bBBrYUTvS+9dGE64OKCpXDJZP9R78Q+PgY76klpCi89J6E10iPE0X
         1zZsTVXszkyrhbqtvf4WQNBKaN0W2M1PQKtA/AEgBPyaYxlUXPny4CsH0eGDVhTF02qy
         kmFTCsNM6rq+D09nCQwr7+UgH/ulteeCLX2DV1NAtItzTjSas8969GSogbIzZCZnFHUI
         H7Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/AgXwtmgPiw7tVgxs2KVaFk9Jz6kZOAc0BZv/jsYe+rGY2NS8vlcISDiNggD3Xjlw+zpp9AOC+DezIP3M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyn0Pxwp7p/R6kEj1MySEoBF51FOP0ssDX5mLQCF6kCCB+e5kov
	H5z1+UN52xN5U9fAkUGABkmTwRpqA0xEcjENKlMl+UrEi1JvdPb7S0K0hfBgZrmWxBfOabyTKwM
	VYg+jI5PQN7tTzLWjSGWTZlEWNtAmKIhjE3IHiEAEtkmikb0Wd5vpK/3YQ+/0eiG+kU0=
X-Gm-Gg: Acq92OG27Wk8VqAABhBCYLKwe1HmYZI4Yi8NLpQyQCYPrk8f2CrvDATOvJwsgyhozUt
	/k1Vf0Eq/ilkF3iSXlCnYZOmDB/028YryTeGNth9vCVv+hhEzL8uqie36SQg0Gu9NsT1P+p1Q0e
	LvHZJc/621KvGavhbbNIngwkPcBIA22/B4yhxnPcsVkIRsKzAY37ENnmUvu2Xfc4Qgq/1uXWIXY
	2fv/2wycinORA4ZeYNgqvRP1WAy9rgRtMMOXlCaS/nAJDokuSieZUDvWJB4BLrWP1WSvEcfqzkL
	SCwaD4XCtUmcAkWMeZ8EgoD0ruryoINQxq68ZVeT75WfjDBUzNdbMhJk3cKTOfIOZkb6g2fxLRv
	vfAbt40uKhn/t+iLD1hvqHQ90Ov5yfg==
X-Received: by 2002:a05:600c:620c:b0:490:b28d:a6f9 with SMTP id 5b1f17b1804b1-490c256f1f1mr258398395e9.8.1780927037302;
        Mon, 08 Jun 2026 06:57:17 -0700 (PDT)
X-Received: by 2002:a05:600c:620c:b0:490:b28d:a6f9 with SMTP id 5b1f17b1804b1-490c256f1f1mr258398055e9.8.1780927036954;
        Mon, 08 Jun 2026 06:57:16 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm40542835f8f.10.2026.06.08.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:57:16 -0700 (PDT)
Message-ID: <0c95c25f-1400-4912-befc-c5b32968d9ab@redhat.com>
Date: Mon, 8 Jun 2026 15:57:15 +0200
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
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
From: Thomas Huth <thuth@redhat.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
 <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-a4K0OHOWZC3uFJf1zzuPoqZCHe8qQAw8EZSXMQV_U_1780927037
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/06/2026 14.45, Thomas Huth wrote:
> On 02/06/2026 08.48, Chinmay Rath wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> Add some initial PMU testing.
>>
>> - PMC5/6 tests
>> - PMAE / PMI test
>> - BHRB basic tests
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   lib/powerpc/asm/processor.h |   2 +
>>   lib/powerpc/asm/reg.h       |   9 +
>>   lib/powerpc/asm/setup.h     |   1 +
>>   lib/powerpc/setup.c         |  20 ++
>>   powerpc/Makefile.common     |   3 +-
>>   powerpc/pmu.c               | 567 ++++++++++++++++++++++++++++++++++++
>>   powerpc/unittests.cfg       |   3 +
>>   7 files changed, 604 insertions(+), 1 deletion(-)
>>   create mode 100644 powerpc/pmu.c
> 
>   Hi Chinmay,
> 
> the problem with Clang on Travis [*] still seems to persist:
> 
>   https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142
> 
> Could you please have a look?
> 
>   Thanks,
>    Thomas
> 
> 
> [*] This already happened with Nicolas' last version:
> 
>   https://www.spinics.net/lists/kvm/msg351218.html

I managed to get access to a ppc64 machine. The error is:

/tmp/pmu-eab466.s: Assembler messages:
/tmp/pmu-eab466.s:1649: Error: unrecognized opcode: `ldat'
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)
make: *** [<builtin>: powerpc/pmu.o] Error 1

  HTH,
   Thomas


