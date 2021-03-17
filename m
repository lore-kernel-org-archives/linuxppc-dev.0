Return-Path: <SRS0=EYxI=IP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 07:58:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DC464F7F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 07:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DC464F7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0jGH1NRQz3brr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 18:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=grlmjP9c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=grlmjP9c; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0jFp6fTcz300k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 18:58:21 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id ha17so659841pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=I20ao//jp0K+ljf1zyYRmUDybDGX4o2ZQ8hxDCPtACs=;
 b=grlmjP9cLtgbJiOVVtTbtM9/sum9yzN6kUjg+qj2AT2HHoCwMg/hZ+ajTEmXhLd4Go
 8IUt/u2OhcF0Lg0BI2M4P2BRFgLjpNL/Uf1kuek5vH0u5J1q6gEKYQWGCymwOT/Mg3W4
 AXckl48lO3Q2vWc0mSuVaGOKfDPvABPsJIDaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=I20ao//jp0K+ljf1zyYRmUDybDGX4o2ZQ8hxDCPtACs=;
 b=C+wjCjd2NYOXIyKxNNj5Yz7VoJ75M3bcseeBj4OSnw6W1aGMd1WFP5hBKeyV/L8HZj
 Ov+uJQHk0sGpZ0ay52TAbbAF7uAMk2MpqMdeCIl5QrAGL2f9EQClVXWWkS3rSuVNzByu
 agufJyl/IvUnjZHiu4sBhkW8v7n0hCjiFjeq5GA2YwRECgeR/kzSBxRSpKX30shbk2bY
 4Na/g+qqUnVHvwR/w8E5XckOwm5nilKMrAQQaGSywlCje5SNq+9IHvg0scqjDmbJxv7h
 YbmQLrYo+0C9HZs0KlR15SbwQv3ongONnFgcvqOil8woq8e49/CeeNhcR7XZ5zpkrvk0
 iuKA==
X-Gm-Message-State: AOAM533Kf/pYfYbO7rkTmcGayO676+VL+u/eXAT51ZVmM5N0RJ4Dzu5t
 hc0UBOhgdN0TcVcurGlM8jBShQ==
X-Google-Smtp-Source: ABdhPJxYxOzfNLuJLRkClYD1JdcEoh936YPYAebHe0scmNtkzZ7wQeI3uoofXXe493EipbmEgLeTBQ==
X-Received: by 2002:a17:90a:ce0d:: with SMTP id
 f13mr3249699pju.85.1615967898257; 
 Wed, 17 Mar 2021 00:58:18 -0700 (PDT)
Received: from localhost
 (2001-44b8-1113-6700-13b2-19b2-2ae0-4d54.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:13b2:19b2:2ae0:4d54])
 by smtp.gmail.com with ESMTPSA id nk3sm1717212pjb.17.2021.03.17.00.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 00:58:17 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "heying \(H\)" <heying24@huawei.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com, rppt@kernel.org,
 ardb@kernel.org, clg@kaod.org, christophe.leroy@csgroup.eu
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
In-Reply-To: <f0130916-a8f3-75ba-b5da-7d37d9139ff3@huawei.com>
References: <20210316041148.29694-1-heying24@huawei.com>
 <87wnu6bhvi.fsf@dja-thinkpad.axtens.net>
 <f0130916-a8f3-75ba-b5da-7d37d9139ff3@huawei.com>
Date: Wed, 17 Mar 2021 18:58:14 +1100
Message-ID: <87tupab4a1.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
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
Cc: johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"heying (H)" <heying24@huawei.com> writes:

> Thank you for your reply.
>
>
> =E5=9C=A8 2021/3/17 11:04, Daniel Axtens =E5=86=99=E9=81=93:
>> Hi He Ying,
>>
>> Thank you for this patch.
>>
>> I'm not sure what the precise rules for Fixes are, but I wonder if this
>> should have:
>>
>> Fixes: 9a32a7e78bd0 ("powerpc/64s: flush L1D after user accesses")
>> Fixes: f79643787e0a ("powerpc/64s: flush L1D on kernel entry")
>
> Is that necessary for warning cleanups? I thought 'Fixes' tags are=20
> needed only for
>
> bugfix patches. Can someone tell me whether I am right?

Yeah, I'm not sure either. Hopefully mpe will let us know.

Kind regards,
Daniel

>
>>
>> Those are the commits that added the entry_flush and uaccess_flush
>> symbols. Perhaps one for rfi_flush too but I'm not sure what commit
>> introduced that.
>>
>> Kind regards,
>> Daniel
>>
>>> warning: symbol 'rfi_flush' was not declared.
>>> warning: symbol 'entry_flush' was not declared.
>>> warning: symbol 'uaccess_flush' was not declared.
>>> We found warnings above in arch/powerpc/kernel/setup_64.c by using
>>> sparse tool.
>>>
>>> Define 'entry_flush' and 'uaccess_flush' as static because they are not
>>> referenced outside the file. Include asm/security_features.h in which
>>> 'rfi_flush' is declared.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: He Ying <heying24@huawei.com>
>>> ---
>>>   arch/powerpc/kernel/setup_64.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup=
_64.c
>>> index 560ed8b975e7..f92d72a7e7ce 100644
>>> --- a/arch/powerpc/kernel/setup_64.c
>>> +++ b/arch/powerpc/kernel/setup_64.c
>>> @@ -68,6 +68,7 @@
>>>   #include <asm/early_ioremap.h>
>>>   #include <asm/pgalloc.h>
>>>   #include <asm/asm-prototypes.h>
>>> +#include <asm/security_features.h>
>>>=20=20=20
>>>   #include "setup.h"
>>>=20=20=20
>>> @@ -949,8 +950,8 @@ static bool no_rfi_flush;
>>>   static bool no_entry_flush;
>>>   static bool no_uaccess_flush;
>>>   bool rfi_flush;
>>> -bool entry_flush;
>>> -bool uaccess_flush;
>>> +static bool entry_flush;
>>> +static bool uaccess_flush;
>>>   DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
>>>   EXPORT_SYMBOL(uaccess_flush_key);
>>>=20=20=20
>>> --=20
>>> 2.17.1
>> .
