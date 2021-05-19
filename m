Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F59C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 01:08:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC1B6112F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 01:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC1B6112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlF9z1tsPz30NR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 11:08:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=m3OIwlA0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::732;
 helo=mail-qk1-x732.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=m3OIwlA0; dkim-atps=neutral
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlF9T05cFz2xvT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 11:08:11 +1000 (AEST)
Received: by mail-qk1-x732.google.com with SMTP id l129so11239504qke.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 May 2021 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wzaOEPoeplUtFr+bx07YfPsYQXn27XlOClZpXD7nWjc=;
 b=m3OIwlA0EZsKS8DLew1TasFW8h34lvraZii9hpzHOdcp9QsKj9+qKJs1fD+UYaZxas
 bb0QWGeuKKjp5TgwwoFh/OovDpArjlPTZNEVyqvAlbqKVxbANVYi11rKzXOuS5oFS4Ka
 7oiVmR7x9Xd+gxpEpsYuSqTt+Ssl2Cb5WWEbPfOp1Vwp5dC2gP7rP2g3I/XGCfJ+Lty9
 IDi141tAnpgvvLjdZAN3weRIfTDFzw7wuhUt3Y+3h37Jk4OgtSEqKMISZfIRvXtq9uA6
 IVz9g+ie2W2YvxHNut0GKwo0hyZc+ElvejoP9VXcCOlpCv7QRpvRj1QmJET4pMOx+O25
 eTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wzaOEPoeplUtFr+bx07YfPsYQXn27XlOClZpXD7nWjc=;
 b=uCPuuthwIt+WPhg++8GeAOP+88QjA90IllJ//28HdeyCvZa3H4f0YB299tpw+0/Hml
 qjedONb9RpI7aau2aUQu1a5Gmj3dXkjyJvagXaIbssNGy+IM3IfHrmjBFBKkNdewRm6o
 DQMTJrOtqEJHJ47XhLLFY6ufvIjMo8JJ9QImW1mywdAHk/BrTIMmSufOa0dzbPMOYNtV
 XVb3C29953dLaKGgvqeXu4RVxH8X3/NkuyTOHad9i7FE5lhUsoAYOoSn5urASpE+NThv
 YVUcMx7mSJawfObxxrJdQ/WSkRVYo80cu5cJ7dQEdpTJnxbOdLDmLSSPkfg4UAtRxTWZ
 1e0g==
X-Gm-Message-State: AOAM531zehRYPqUAM+69UAQ3QWqkshs+JywdKamXTkY2o4OC4U30hBOn
 XvYCM/c0OIDBJkDW0ZM6elU=
X-Google-Smtp-Source: ABdhPJxKp16WWVK1lz2JKZEYLcLF8Bz5hWIVjTB4qvYne9t6GWyJOyqDhFNnOBeULlhxJwn4osCdWg==
X-Received: by 2002:a05:620a:13d2:: with SMTP id
 g18mr8911355qkl.233.1621386488422; 
 Tue, 18 May 2021 18:08:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 f132sm14525505qke.104.2021.05.18.18.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 18:08:07 -0700 (PDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20210422054323.150993-1-aneesh.kumar@linux.ibm.com>
 <20210422054323.150993-6-aneesh.kumar@linux.ibm.com>
 <20210515163525.GA1106462@roeck-us.net>
 <e0eba73a-c2df-71c3-e03d-d4074d908fca@linux.ibm.com>
 <d830fce9-c00a-e879-4115-94a2346a806f@roeck-us.net>
 <87pmxpqxb1.fsf@linux.ibm.com>
 <a7dd34f3-7d79-c933-fb62-eaad5c83d37a@roeck-us.net>
 <87a6ork1qp.fsf@mpe.ellerman.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 5/9] powerpc/mm/book3s64: Update tlb flush routines to
 take a page walk cache flush argument
Message-ID: <969f377f-fddb-c2de-781c-fde37d121a4d@roeck-us.net>
Date: Tue, 18 May 2021 18:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87a6ork1qp.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com, linux-mm@kvack.org, kaleshsingh@google.com,
 joel@joelfernandes.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/18/21 5:26 PM, Michael Ellerman wrote:
[ ... ]
>>> That was the generic header change in the patch. I was commenting about the
>>> ppc64 specific change causing build failures.
>>
>> Ah, sorry. I wasn't aware that the following is valid C code
>>
>> void f1()
>> {
>>       return f2();
>>       ^^^^^^
>> }
>>
>> as long as f2() is void as well. Confusing, but we live and learn.
> 
> It might be valid, but it's still bad IMHO.
> 
> It's confusing to readers, and serves no useful purpose.
> 

Agreed, but it is surprisingly wide-spread. Try to run the coccinelle
script below, just for fun. The script doesn't even catch instances
in include files, yet there are more than 450 hits.

Guenter

---
virtual report

@d@
identifier f;
expression e;
position p;
@@

void f(...)
{
<...
   return e@p;
...>
}

@script:python depends on report@
f << d.f;
p << d.p;
@@

print "void function %s:%s() with non-void return in line %s" % (p[0].file, f, p[0].line)
