Return-Path: <linuxppc-dev+bounces-26912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BDC79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfxJB2gpYz2ygp;
	Wed, 09 Sep 2026 20:05:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788948314;
	cv=none; b=nPoTLKbcDJvzgc+V6gsK3uP1V0jJjdhQu2rtWjf8KEpbKugomk8x5+Cq5bB6fX+1+C6IuALSBdd4Mj93qhkr4MTw56wO48MQ+1yqFRE5e/ok1p30vSMpTZqgI1F8Cp1oZh/W6m8gStc/7VvEFq6vt85SJvnnZxuY/E6XVdzJfuSqgsgAo1UgxelUbjahSGSFoEklFuE/MtGYh/BQ5zXP1FRQWoTIGZeMf2GT/KxFS6R1YYtY0fTgNrHGcbSbuDGnYZIycUweRnEL6V6kTXpXomcRX1DqkislWk0F1cVlrFusM00irL6pijWYu2ERyHAAhHk9NuR1LrpoCPJaFw6RYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788948314; c=relaxed/relaxed;
	bh=Ne0O7Jrbbh35lHn6AVgsM7/xJO5tCKCdyIfi82Y0KOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/fNaz0V8P3yWXk7EhPz498I0rpRWZq/EnawWBPsz9nXHdsdiO3GjgQqYcuDxVFdAHkpuiMEfsS9/rtwlG2BfNpnki2OMpKQaerVsbRuRz/5oyoZnG+dnNMtcbOFD61bErxbiIEUv1GGKinIVgSiDjYDl1jvNfB0RhNWpa74j+FdLXeF3yB5qmCkhTkh+4HfOvqm5cwnY8x9bQNHSE/qRVmpOhM36vjhUFPHBPuYYNCbTn1NLoeYkaPQrpmq6h6ZrIOSuYMWl/wATML+GcjaTwGkwP9TAalPMxZ00RD1eFNKHnvtGUK+W8NM+ycq1j/fd1ee6S/GrSncjAzJdB43ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Jm6TGgcO; dkim-atps=neutral; spf=pass (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=thibault.ferrante@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Jm6TGgcO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=thibault.ferrante@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfxJ72nZxz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 20:05:09 +1000 (AEST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E2BA53F28A
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2026 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788948304;
	bh=Ne0O7Jrbbh35lHn6AVgsM7/xJO5tCKCdyIfi82Y0KOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Jm6TGgcOQK/6ZCcK8Dl+mP0k/bS5qAXb6aqP7cLnHZpZZT3DAmXUlW9Jlrs9jRDtk
	 4k41+uC5HdMFZu3mQrfxgT8YUG+/N1tUuVQDkr4uahhK1fQtP7Dcl5NMZpOxDCIjLu
	 zjOUgGtsuK5Mbtiw9gVj85J2z+PT5JV47U55JYu+aNsAgA1FzntMZGafE/afp8HLU0
	 3SROjoDZnPzoF/aiOgf61b8WaCbamn8y9ppjL21srbgTsAXTWNqUtyRcTU1vc+z04j
	 3WiVA4wkR353+VsVTCLtygQKbIBrdky2hMqmrOeUJ1F0wxTlhMGsiUWNGpww+z8Dld
	 aw9BWn1BZKiwXDOCcTDjrrjb+2E/ICZDYEMIkWujUJHxJp40hsPjYUS5mWjbDiWzxC
	 Eow2nXkImAAVSLE/qKOilG9E4fnl6Jb2xtTbkX4ZFD2bxCoQmZp8XtxhJnVbIwdSZa
	 +1at6KmTUTRpQBGPnTwGobVp+sf9NZXjNH7CsigoONlBfYhRzDq2YogQGn9DnjbXSk
	 oqsjZlck9Qu27+BtwRef0tx8gVf6X3wEmiKdJ+jNzO9hNr51c47I8C7AwTs4v8/w0d
	 3FoZrIPUanA6lV9OEgX8YnuzzdpYa1TFCp5bIdJxcK9AmQfhvYZeFwyYKxjbjj6/5w
	 F/D6mbhQjR3vnaB1xwsxfENw=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-485b14fed5aso178925f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 03:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948304; x=1789553104;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ne0O7Jrbbh35lHn6AVgsM7/xJO5tCKCdyIfi82Y0KOw=;
        b=tKewIGKU6NUNCULPrEse2aHkaN3XpmqYsod3pltecz4mbIYrj4zTiO10/adFTFDoxz
         vDNW7VYeAy3ifA03By3/TydngthFxPR3mnT4v1M822uTyFhJbOD0WguxngUFVXSHzaaT
         wBKRzp1ihNxlj4yuNWjoUR+0Io6J75jfVflXoFmX6UC+Tu7vNoPxpR/4UL+4Ra196sKi
         um0jf9o3Um/3eUXBEKymmL1O52RjbGAfOMF3bUjLmbfFad+YcRcyQuIR2m+pkQnK5mhl
         NTsgWAZGccqVFY/84pm5w8LZhNvsDQ4n1d+dsqpGwZSlPcL1StWXnldAUkEv3z1uzhNO
         XZow==
X-Gm-Message-State: AFuF++k5Qg7GRXsLWAXLNOrPsc8mR9cYZL6BuZ944/WvjqPRpnMMEloF
	I6Nneil/KyMVRRmuuvRBIeHcIfzMhflN1kypLQljMpR5RVRCqMkenC3S+ebJBNHf12fA52WEMPJ
	QtarZ/BxMrXbk/OFowB8snvtgoEYE1GxPIJ1C5Wzwhq/TEt/KYF8bvYEBMuxYiktVTJfb8MQd0c
	K70gnoGSU=
X-Gm-Gg: AYBFou3V7ZyUdMrZjb2IAxCtdPXruBxsTOEOKM5o8xhL68Jqyt2nC8FP0LAovfeM7Mm
	+qBabmGA6EukyHjuS3cL8xPnJCl+KuguCgJmUZM0yL0zAHZAcYgrzwiXN2r3g1NbGkYTAVqBA1U
	6RiI8kCF00C3BJxPWmAVQ0/nYspWVEWgx8vF30eOQ28gg0M637ir1x3hb+Tisl4DP7hBzATRHkQ
	Gc7GkWeDvBStVV2hp3yrVRZSVsjJdOflAc0+QN3Dy+oMQeElEtP5GmBLH3bYhjq0XXJzJauXKG9
	643LWJHyrzie/8x5xbetthwwM5rGMQGumfGI0T4GbJcXOZjY/OCjrok1jxh8CHTlYu2okvXaS92
	CXljBp16qkmmpiR7dc1vvyBlpFqe98Bk4MEdcuazhxd0KYR1LjkMCiw5UCZ9ECbkaMPPfxkvnce
	CtW8ryBQEq3RmmV7VdGA0b/BwIMGkhCUl/oNZx/cINelT7UXxiCbHqNmETP3O+hdMttMDuai7Lk
	g3rbikrHfU=
X-Received: by 2002:a05:6000:228a:b0:485:8c16:a331 with SMTP id ffacd0b85a97d-4858c16a578mr30841002f8f.38.1788948304411;
        Wed, 09 Sep 2026 03:05:04 -0700 (PDT)
X-Received: by 2002:a05:6000:228a:b0:485:8c16:a331 with SMTP id ffacd0b85a97d-4858c16a578mr30840951f8f.38.1788948303969;
        Wed, 09 Sep 2026 03:05:03 -0700 (PDT)
Received: from ?IPV6:2a01:cb06:c054:d70d:4174:4522:1a58:40cc? (2a01cb06c054d70d417445221a5840cc.ipv6.abo.wanadoo.fr. [2a01:cb06:c054:d70d:4174:4522:1a58:40cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm35849463f8f.13.2026.09.09.03.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:05:02 -0700 (PDT)
Message-ID: <1940bd28-3dda-4a03-a8b9-37fd0731282a@canonical.com>
Date: Wed, 9 Sep 2026 12:05:00 +0200
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
Subject: Re: [PATCH] selftests/powerpc/tm: Fix tcheck() reading uninitialised
 CR value
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Venkat <venkat88@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
 <4206CE63-979B-4464-BECE-F89D0B1BDC91@linux.ibm.com>
 <d80d892c-8505-4530-a23f-e3b6daf72d03@kernel.org>
Content-Language: en-US
From: Thibault Ferrante <thibault.ferrante@canonical.com>
In-Reply-To: <d80d892c-8505-4530-a23f-e3b6daf72d03@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2026 10:56, Christophe Leroy (CS GROUP) wrote:
>>> diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
>>> index c03c6e778876..6024ce4ba6ff 100644
>>> --- a/tools/testing/selftests/powerpc/tm/tm.h
>>> +++ b/tools/testing/selftests/powerpc/tm/tm.h
>>> @@ -105,8 +105,12 @@ static inline bool failure_is_nesting(void)
>>> static inline int tcheck(void)
>>> {
>>> long cr;
>>> - asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
>>> - return (cr >> 28) & 4;
>>> + asm volatile("tcheck 0;"
> 
> Why not use cr7 instead of using cr0 and doing cr >> 28 below ?

That would work, but that's not consistent with other asm in selftest/powerpc: tbegin./tend./tabort. and vas_paste() all target cr0 and shift as needed.

