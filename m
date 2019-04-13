Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D97EC10F11
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:01:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BBB2084D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtsmaQ4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BBB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44h40862LbzDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 16:01:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtsmaQ4r"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44h3y36z8yzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 15:59:55 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id q1so6153488pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=p+U3XZNBYlCXAicNKjwVX4CXpOasBU+Dlni3eRlZkXo=;
 b=PtsmaQ4rHHBJthYP50CrZl+uDhvb4y/qwbvf35AApWewtWd0pS51nE/roLeeoLnHrM
 E4omP5C0H74cAUvwsgSXYxRPAc8ua3ViYcL/T/FzlwNifr05l2Nj9rL/hbXsKaKw+Ae/
 b8YHtoQ9tTZEyvVUsE/cLfvEOcYbiRhLbFdNH0HlE4VJD5Lz/FLG6C2ARvN9m1VL/r0x
 exaT1aJdni7NhwVM0F8st+vRYLeKnLgYcZRV383U9181sLlh/fRAflDnaK0aYTf4dn9/
 IdHhSxeTEbunM2f+vNd4D27sX1YBGiGLlzKK1uo9uqBQ7aDndgNnRlKcLIsirUr/KAnt
 9pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=p+U3XZNBYlCXAicNKjwVX4CXpOasBU+Dlni3eRlZkXo=;
 b=S0KoxKU6UvC5xWLfrhoGvMLkvnXdHmvH8k9xJwEEjnLu3Gen472cqHwIfgYSP8+aCU
 zP8v7ozBF2N2SCP5vWMArxi/IAX/YA1a2SXRk0tCgauciqvvjiLFkG+/rp/4DESgVxLc
 pNcPBV1b8a91jH+7O6K4iMFfNEkKTFnzmF7An8tF3eCdePVnG34L1+IkwRB0KzCcd6vx
 ZsDoEtX+iUQE+xtL2O70Hjvu/AsDyqLw6PAJQq3LLpW8J503XQOAYlJirbr+NYOJpuVQ
 lpB8nqgiST45ug/WpnCscpyrB6NaKUgQ9FwKPC2NP9WunsWe04/x91VwcmXKiUx8d31p
 x+Jw==
X-Gm-Message-State: APjAAAVWjXv4FUxWmbhjiSALTtN9Nj4uv/Npo0yvuFNCkHzpAmTomnzc
 Hx6gnEiWKHWIIFECA3M3D0XEIgNd
X-Google-Smtp-Source: APXvYqwApaLLV9DpiDusJhEDf5BdiYZXRwb4l0jJ/dvXFeoOumgziS71IG4j1vgBzcJDthqGJdGTKg==
X-Received: by 2002:a63:3dc8:: with SMTP id
 k191mr57392600pga.286.1555135192166; 
 Fri, 12 Apr 2019 22:59:52 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id v82sm98170065pfa.170.2019.04.12.22.59.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Apr 2019 22:59:50 -0700 (PDT)
Date: Sat, 13 Apr 2019 15:59:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s/radix: Fix radix segment exception handling
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
References: <44fRrx4BVsz9s70@ozlabs.org>
 <1555040097.sqg9j51don.astroid@bobo.none>
 <875zrivaip.fsf@concordia.ellerman.id.au>
In-Reply-To: <875zrivaip.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555134809.jkd67z5287.astroid@bobo.none>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on April 13, 2019 1:39 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Michael Ellerman's on April 11, 2019 12:49 am:
>>> On Fri, 2019-03-29 at 07:42:57 UTC, Nicholas Piggin wrote:
>>>> Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
>>>> broke the radix-mode segment exception handler. In radix mode, this is
>>>> exception is not an SLB miss, rather it signals that the EA is outside
>>>> the range translated by any page table.
>>>>=20
>>>> The commit lost the radix feature alternate code patch, which can
>>>> cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!
>>>>=20
>>>> The original radix code would send faults to slb_miss_large_addr,
>>>> which would end up faulting due to slb_addr_limit being 0. This patch
>>>> sends radix directly to do_bad_slb_fault, which is a bit clearer.
>>>>=20
>>>> Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> Reported-by: Anton Blanchard <anton@samba.org>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>=20
>>> Applied to powerpc fixes, thanks.
>>>=20
>>> https://git.kernel.org/powerpc/c/7100e8704b61247649c50551b965e71d
>>
>> I sent a v2 with a selftests that triggers the crash if you want it.
>> Code was unchanged to no big deal there.
>=20
> Yeah I checked the kernel part was unchanged so stuck with v1.
>=20
> I also sent a self test, which is similar but slightly different to
> yours, though yours is better in general. I'll try and merge them into
> one test.

If you don't mind that would be good. The siglongjmp handler is
cleaner though, and should make it simpler to test ifetch accesses.
We just need to get the sig info into yours, and an array of
interesting addresses.

Thanks,
Nick

=
