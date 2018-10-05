Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6340CC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:22:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD7D2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJRiL9S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD7D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdQX496xzF3cR
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:22:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJRiL9S3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJRiL9S3"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rbwz6TmDzF3bS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:15:15 +1000 (AEST)
Received: by mail-it1-x143.google.com with SMTP id j81-v6so3574206ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dU9e3rgpB1fsPGYP9fVdia6W/fR8iyw7Oa8Se3v/bRk=;
 b=FJRiL9S33QUtPnZ8LhpgH2DVhAXeRMRjeCmklufK77gqT1oh6Tb68pkyIrBX1JQTGx
 uiIpvb6qKPtxauC72/riYpuaKups5i/cygnQlKf5YLNFleXx/5CTdS61NtVQsSwbXEyj
 hXzyFXDnclJWjhVpY6/tN2hBtOudWCr1sXKKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dU9e3rgpB1fsPGYP9fVdia6W/fR8iyw7Oa8Se3v/bRk=;
 b=i8uAnn7EryJQmqXM229XpCApEQ06sNmoJGK4F0Z8Awv3l2n4J3o25HWTkgxS31bIrW
 Ku9LIXAb9Bemgb1CBxEVdh0SWdBhZIpqqq57QnpNYobcDKhspHye4PONfcRJ6yqV6/Fg
 Hxmy318ujzck+3rwZ0wEjbrd+X3kBq8rbB7+8qo57K9jTjX1rgNUkAqmA16TI4cft3VN
 ILjcYVa7SlcwfA/K3z9ab7vl917MZ+yaj9oEDIp5b6lEA61GsZZndL2GnjAWT+5cysmK
 Z2hv+qrK6hzLgkEANpeoNNx6ks2IzvqKKda3ba9BE4UXSttRaZ4SCc8QFU/HeDEcoMhf
 S+/g==
X-Gm-Message-State: ABuFfohrmr3c7Rd6TSCzXnk13hOe1p564rBJufItIjh8nHaQSOHgoens
 I07VrIlGEPIouT5r0WX3wjnbwFf1cKiD1PYYDebDBw==
X-Google-Smtp-Source: ACcGV63xsEJDmC4QBY9m900LfP+j45gZh9MtwHkoJdrsrYXSX9+DQR1U476LLXbyqOri9X52OIOYh77qtEABzeRZaAM=
X-Received: by 2002:a02:5147:: with SMTP id
 s68-v6mr9292226jaa.62.1538759713791; 
 Fri, 05 Oct 2018 10:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 10:15:13 -0700 (PDT)
In-Reply-To: <20181005133705.GA4588@zx2c4.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 19:15:13 +0200
Message-ID: <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
...
> Therefore, I think this patch goes in exactly the wrong direction. I
> mean, if you want to introduce dynamic patching as a means for making
> the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> world, sure, go for it; that may very well be a good idea. But
> presenting it as an alternative to Zinc very widely misses the point and
> serves to prolong a series of bad design choices, which are now able to
> be rectified by putting energy into Zinc instead.
>

This series has nothing to do with dynamic dispatch: the call sites
call crypto functions using ordinary function calls (although my
example uses CRC-T10DIF), and these calls are redirected via what is
essentially a PLT entry, so that we can supsersede those routines at
runtime.
