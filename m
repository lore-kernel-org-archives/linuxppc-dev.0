Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ECDC282DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:22:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ACF214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsXPUQ0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ACF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l1YH47JPzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsXPUQ0L"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l1Wg72vxzDqNW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 11:20:47 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id 8so302872pfr.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=SbD2klD17et5BIlO7W2rYGH3pP0FGj2EC50NrIVF+2k=;
 b=nsXPUQ0LZEgELmxv/LoCknDShfq64eNSsoxnpVJ4/r1AZhrIH+lLopoUHvluZts1eg
 +rI76d8g7GCujyUdqE4fD3vMFrUcYnFp0hnuND11A0+X5vNlkuQ7dYwS/i4B0CbMCp3X
 P4hzIZ5mdPoN+GNXSQsxT7mGNUYJVQL+4rOEH+avYN2riMKyQxbWE449nT4jQxFBV/mn
 TlEx+YJNeQcqHIWU1UTkL2Xo2Z2vh4RtxxQKKamfqeOxFwWpxjxoVTsbNj9ytfNpmvcn
 8H0XUPncj+TWHno17zo2UAZJKCeZxrNIacr8CDw+w2is4ZO3wMANjxEq5kn+0XI/l9Au
 ON9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=SbD2klD17et5BIlO7W2rYGH3pP0FGj2EC50NrIVF+2k=;
 b=oL6HkzWFPF+y5zE18mEF4zCV7Ko8rqLs6Yyi/oNK4ZPGMtAaQsrSeLtCEMc+Rj/2Rd
 dNI4/yvzfUYcEXpYq4v57XB8EJvgAIzU8/lGQAz+q7WrqgnvQLWLo7ZmSVziKMJI4d51
 El2dPJ2kcGUYzbDhE0tmqa6nKKMYz/J3Gk2S+S5YfceT8c1PXoQ8dCmWoMxQy2K1tVG3
 dR5fCPAbwkNf2dJCo0yihEvIj0GX6aeqPoBR37xD6ntKHJzmRHEe87gs6D82MKqCCtX0
 NQYfrzdd/o6gwm9JS7H4Vn88oth7OebgKiKJ5qbywj961eFuuvlzxXugViRX+9VsVFJk
 Fd8A==
X-Gm-Message-State: APjAAAW/ypXv9y4ZkKtjlT3ou4yGOgnWfqlyVkeDViobrSFN+d4NsFtv
 pcrRfv/z6gBcwJhuC2/ol8A=
X-Google-Smtp-Source: APXvYqwm4BTM3FCPQDG6srbX6X2D6QYgEDvOAsRQCHW6igOjXcNcDtYcU/BkbT3ANOfWlIaFDqLorg==
X-Received: by 2002:a62:e411:: with SMTP id r17mr92072583pfh.127.1555550444363; 
 Wed, 17 Apr 2019 18:20:44 -0700 (PDT)
Received: from localhost (14-202-58-58.tpgi.com.au. [14.202.58.58])
 by smtp.gmail.com with ESMTPSA id l74sm549174pfi.174.2019.04.17.18.20.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 18:20:43 -0700 (PDT)
Date: Thu, 18 Apr 2019 11:20:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 7/8] powerpc/mm: Consolidate radix and hash address map
 details
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, paulus@samba.org
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
 <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
 <1555422365.eio3zgx55b.astroid@bobo.none>
 <878sw8vmha.fsf@concordia.ellerman.id.au>
In-Reply-To: <878sw8vmha.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555549336.anl2oa7tyc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on April 17, 2019 10:34 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Aneesh Kumar K.V's on April 16, 2019 8:07 pm:
>>> We now have
>>>=20
>>> 4K page size config
>>>=20
>>>  kernel_region_map_size =3D 16TB
>>>  kernel vmalloc start   =3D 0xc000100000000000
>>>  kernel IO start        =3D 0xc000200000000000
>>>  kernel vmemmap start   =3D 0xc000300000000000
>>>=20
>>> with 64K page size config:
>>>=20
>>>  kernel_region_map_size =3D 512TB
>>>  kernel vmalloc start   =3D 0xc008000000000000
>>>  kernel IO start        =3D 0xc00a000000000000
>>>  kernel vmemmap start   =3D 0xc00c000000000000
>>
>> Hey Aneesh,
>>
>> I like the series, I like consolidating the address spaces into 0xc,
>> and making the layouts match or similar isn't a bad thing. I don't
>> see any real reason to force limitations on one layout or another --
>> you could make the argument that 4k radix should match 64k radix
>> as much as matching 4k hash IMO.
>=20
> I don't think I agree. The 4K and 64K layouts must be different because
> the page size is different and therefore the span of the page tables is
> different. (Unless you shrunk the 64K layouts to match 4K but that would
> be silly)

Both 4K and 64K radix map 52 bits of EA.

> On the other hand there's no good reason why hash & radix need to
> differ, it's just that radix has a more strictly defined layout and it
> didn't match what hash used when we added radix. We really should have
> done this realignment of the hash address ranges before we merged radix.

Well radix is limited by hardware, hash is more limited by software.

There is no real reason to define the addressing limit for radix any
less than what the hardware supports, for example. Hash is free to
match those limits if that's what we implement but it also does not
need to.

>> I wouldn't like to tie them too strongly to the same base defines
>> that force them to stay in sync.
>>
>> Can we drop this patch? Or at least keep the users of the H_ and R_
>> defines and set them to the same thing in map.h?
>=20
> I don't understand why that would be a good thing?

Hash could be expanded in future, radix may be expanded or get
different page table layouts. I don't see why you'd tie them
together artificially.

> We have all this indirection through variables at the moment, for what
> appear to be constants. It makes the code harder to follow and it's less
> efficient as well.

What part is less efficient that matters?

Thanks,
Nick

=
