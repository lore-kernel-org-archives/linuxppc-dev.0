Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSgpM1fgcz2y71;
	Mon, 16 Nov 2026 19:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794817355;
	cv=none; b=GU6xDQ+6U1qq7mhLuAHl2e+VefF3Zm22l4OsNDoY8/469m8O8zz8TE9hQSgkaz9K5oZT7UEQuHA28WavhuISeVr0A8c9RmFfCjq+X9d4oKP5achu8UnKAkrIXD1wUEREThrSgCyk5ilRp8OsRljmgYiXOr1u0QbptkzAjplCaIiGNb8y04WKa4AGUTiGzVOdPlfk6tt5i7dFqrwLCvhW+ngN1DIvhcUZ6WL4rxoBLKyGTF5zByJCpF71OnnQsnbRL28TAsX521/rmdg474HOrHpF2uUg8zvDC1FubS4mSkOWTLGOeIB4y7Nn+oEoOcQGRnTe+DtIm6MwGHb2tBa0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794817355; c=relaxed/relaxed;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ESSOSt5wfUnolLrw5ajjG1mQw2Bsjrn9KhxnrpgNG8AH694Z64w3vp/nF0ipZho+b8PSEoh14AUhGzpSjbd7M7EIcm6IUtJZDTkbT/LtVs0Y8kmFgO3hvcoLPcD2RPjcvyhgxIulk0MZB/AaJ1Z7JmIF9ny+4DaFgfWzYZEUjLVxJ0fJ+yD3GF3kDQg/4CG8vP7frUWIrip/c8LSNyPMSuZjmMEOf8HoADqyZsE8rJ1jblOEQGCsb4ByqkEIclOofB3Po5U5pciDRO8Bxrju0yDBaT1YhJWYMKudh7W154qcb3VwDMFMmFLpdA9rNJlXDqq24EJ5KjL3KPnp3NzPag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTipTCZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSgpK6zLlz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 19:22:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	b=YLTipTCZ5BxWzJteFSBSR8Fpwiel7CfB5tdYm8b2FHEMWKvj+dLXw2esQzAlt9Pz1jbgI7
	sKuvNvH0MXTFqsngXLv9XZjjvJJaHmJZQWagIjh6Oqfa+XMWz+jUMxuyYDEV1Jm7NHxLJj
	JiWRbYWC3VCk5u7ilKhhytfl99eaEWc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	b=YLTipTCZ5BxWzJteFSBSR8Fpwiel7CfB5tdYm8b2FHEMWKvj+dLXw2esQzAlt9Pz1jbgI7
	sKuvNvH0MXTFqsngXLv9XZjjvJJaHmJZQWagIjh6Oqfa+XMWz+jUMxuyYDEV1Jm7NHxLJj
	JiWRbYWC3VCk5u7ilKhhytfl99eaEWc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	b=YLTipTCZ5BxWzJteFSBSR8Fpwiel7CfB5tdYm8b2FHEMWKvj+dLXw2esQzAlt9Pz1jbgI7
	sKuvNvH0MXTFqsngXLv9XZjjvJJaHmJZQWagIjh6Oqfa+XMWz+jUMxuyYDEV1Jm7NHxLJj
	JiWRbYWC3VCk5u7ilKhhytfl99eaEWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-bpRnQR9JNq6ZXydeFibDwA-1; Mon, 16 Nov 2026 03:22:25 -0500
X-MC-Unique: bpRnQR9JNq6ZXydeFibDwA-1
X-Mimecast-MFC-AGG-ID: bpRnQR9JNq6ZXydeFibDwA_1794817344
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb64c99bb8so12773025e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 00:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817344; x=1795422144;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
        b=mQDEiLIpwx3xoqf/jmIUxK6CFaYjtXCWnDo5c2q7Sxumkvo+wa1jefHy822yuH3QPi
         l5xrA4lgY4V79m9mBoznZiGfPl61H1JaJFbgpr0T0pxdaVb6LZQFq1k2gXMMyCv6CY4C
         cKOZ/HrWby7z1oOMv0GYC6sC5xTZDcbjg/Isw7dnSgrGEPjbWIvMVHzq0N2AMOH2WLvL
         zFAkE0miVrltz6h63U5wzej0f6O6YXTpdIzR5QB/C/+5ShEkJjj7aJWasixgERc/Hkge
         30ATY+r6dtECF0z3+BVmncfElvlkl08jsiKyBQU/JP7OzkRR5k0bVXh80FBUp6xOMlaq
         l3zg==
X-Forwarded-Encrypted: i=1; AL+hErHCTroSoOScHCnOEvbX3aHLcxVWbw58YA4qrJtzbGFbixhwvFUPf9pjv9ewxde+K4zdB1ofTzuSbStAtn8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+mO9w/nFzjEWPA+2//HIXeFh6QZVRULNCkLZRtlb8efFhej4TG
	fgFt3gHehRu2GeqAMJowUS3t9k1MTIzZlcPa/0GMlKFSufRDEHgyLyDCo2OxTyUpFm0sMi6nBJt
	DrkFk/vXtQ7nrKpBPXZq9znNQij7vObiXiIFbheTniUXRiAhsxiIjF4t/2juOPYGi0OY=
X-Gm-Gg: AYBFou3BJPN4B3nDAMiqfByztDg9ZjdWGxediPi3DHWEY8B7iUk2RugWkXcIrmB6fL+
	G2JtBtoR/3guM4By/2rB6jJAYsfykNiXXVKGVrD4h2hV9p/5t2eBgj9AwVZFsxplxwGbr7PvX33
	m6feFDMEOCKmzAyySOYpKuyqEEUOPoyDr/lr5+cL849iAWZvEggfF+c4rDY911BHTift4j59bGP
	BFb76pYwVgj9r7T9/jirdX40taFtxUv9t8w7a03BCzWCCFCdWXDFB5u6AlhTzSS2jC6zMIgPXFt
	8CRfv1uZSdj3aORX8rkqw9jVXQEUS/Q8yXXT2kv+sJc5xTFZ8wUjW7nmOCkn0nq89HwsBdPsrA4
	y09FyhM/9AL9M8twEU2X45JFEBXonxxz0U98j60yG4DGG
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb69b2d82fmr80275615e9.25.1794817344415;
        Mon, 16 Nov 2026 00:22:24 -0800 (PST)
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb69b2d82fmr80275195e9.25.1794817344000;
        Mon, 16 Nov 2026 00:22:24 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb52bab8bbsm276579265e9.13.2026.11.16.00.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 00:22:23 -0800 (PST)
Message-ID: <942375ef-cab9-4746-ab18-184b2761a8d1@redhat.com>
Date: Mon, 16 Nov 2026 09:22:21 +0100
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
Subject: Re: [PATCH] powerpc: Link with -z notext
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
 <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
 <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KJfMGGC8086zVMa-XcDw4cRbYEQgUHVW-ozJPTD4q5g_1794817344
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.26 um 13:03 schrieb Thomas Huth:
> Am 11.11.26 um 11:18 schrieb Amit Machhiwal:
>> Hi Thomas,
>>
>> On 2026/11/11 08:54 AM, Thomas Huth wrote:
>>> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
>>>> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
>>>> test binaries:
>>>>
>>>>     /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>>   Hi!
>>>
>>> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
>>> 44) ... which compiler and distro are you using?
>>
>> Thanks for checking!
>>
>> I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more 
>> details
>> are below).  Are you cross compiling on an x86 host by any chance where 
>> you are
>> not seeing this problem?
> 
> Yes, I was cross-compiling, so that's likely the reason why I did not see 
> the issue.
> 
> Anyway, could you please check the following patch to see whether it fixes 
> the issue for you, too:
> 
>    https://lore.kernel.org/kvm/20261113120101.145183-1-thuth@redhat.com/
> 
> ... that compiles the powerpc code with "-fpie" in the CFLAGS, so I think it 
> should cure the issue, too, and it's likely the better way instead of 
> suppressing the warnings with "-z notext".
I was finally able to get access to a ppc64 machine, and my patch is 
apparently causing other trouble there:

  /usr/bin/ld.bfd: powerpc/cstart64.o: warning: relocation against 
`stackptr' in read-only section `.init'

So I went ahead and pushed your patch with "-z notext" instead to have at 
least a workaround 'til we figured out whether we can and want to push the 
"-pie" flag to the cpu-specific folders or not.

  Thomas


