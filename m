Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08151C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:00:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DE32087D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXgn7fuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DE32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RXxn4HZWzF3Ss
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 01:00:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZXgn7fuE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZXgn7fuE"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RXtd4fyJzDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:58:01 +1000 (AEST)
Received: by mail-it1-x141.google.com with SMTP id p64-v6so3139341itp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=V4YLpmN1ofx8DjUCcCAnT+gAIrUFV0ZMrcyHc8ddDec=;
 b=ZXgn7fuEJtYwPH0irwGdjeVH05CiPo8ulTk2CpFffZxoOIsiGslSYaA7PpIIFhUGdF
 M07qXl6lHhIkN/cVH6/sdTd6llU96GiOj55w6YAkiSqRve2u8yyYXWbgOtpHrCX/rx8q
 ObqL3Le6C7+F3y7Btb8vgiZVFtBKuAM1QRPrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=V4YLpmN1ofx8DjUCcCAnT+gAIrUFV0ZMrcyHc8ddDec=;
 b=cflosphgQROc1BT99rKHHShZkxnNbUW8gY6eWyKsXlDfwIrNqui75LJOhl7440MXdc
 iPYit36+jPp758fFTTdJbDaSx+MZWmzY62tbjLIOKTa5ca52frPE5wru3MZ6cEF8GHAr
 ZhKpVL00r3dwsNFHGpigXdcUNrYvm3YOfzto0EPAE7P4MoQ6aOGAcLMGRdxPrHs8j7kI
 FyubKv1sLxiquTITXqPygHKy71td1RHgCMFGvWi79cIrnhG+j30N7ia7C6659UlZkvXm
 umWBmWn+zDSkhvkG7wBfJY8fZwC9oLdDR8Mz2oxZdeK9kgiW6NYiZWXEI8fUkoTiIgKr
 3I1w==
X-Gm-Message-State: ABuFfogHqNMEqTKpSU7U+2Sa+r7zr7yVL7E9YXCNyP00KVFQKZ588HXM
 3uWmeIo5p8kPPgAbhRM3mMm0Y3ItjceOmE5yX/UPlg==
X-Google-Smtp-Source: ACcGV61fI6T1mVjH8VaplyzCQ9+AO2HQKBQpRu1GqT92cysWo1aqjDQRziYqmpkRL6Y0uoisfWvYPoRX1kWeQkQzhdM=
X-Received: by 2002:a24:a10b:: with SMTP id
 y11-v6mr4679847ite.148.1538751479033; 
 Fri, 05 Oct 2018 07:57:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 07:57:57 -0700 (PDT)
In-Reply-To: <20181005141433.GS19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 16:57:57 +0200
Message-ID: <CAKv+Gu-Gkf2jJ+Nn65pT=HDH6S8wceuXU_RrDpatc=biNx9ROA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: Peter Zijlstra <peterz@infradead.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
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

On 5 October 2018 at 16:14, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> new file mode 100644
>> index 000000000000..8fc3b4c9b38f
>> --- /dev/null
>> +++ b/include/linux/ffp.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __LINUX_FFP_H
>> +#define __LINUX_FFP_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> +#include <asm/ffp.h>
>> +#else
>> +
>> +struct ffp {
>> +     void    (**fn)(void);
>> +     void    (*default_fn)(void);
>> +};
>> +
>> +#define DECLARE_FFP(_fn, _def)                                               \
>> +     extern typeof(_def) *_fn;                                       \
>> +     extern struct ffp const __ffp_ ## _fn
>> +
>> +#define DEFINE_FFP(_fn, _def)                                                \
>> +     typeof(_def) *_fn = &_def;                                      \
>> +     struct ffp const __ffp_ ## _fn                                  \
>> +             = { (void(**)(void))&_fn, (void(*)(void))&_def };       \
>> +     EXPORT_SYMBOL(__ffp_ ## _fn)
>> +
>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>> +{
>> +     WRITE_ONCE(*m->fn, new_fn);
>> +}
>> +
>> +static inline void ffp_reset_target(const struct ffp *m)
>> +{
>> +     WRITE_ONCE(*m->fn, m->default_fn);
>> +}
>> +
>> +#endif
>> +
>> +#define SET_FFP(_fn, _new)   ffp_set_target(&__ffp_ ## _fn, _new)
>> +#define RESET_FFP(_fn)               ffp_reset_target(&__ffp_ ## _fn)
>> +
>> +#endif
>
> I don't understand this interface. There is no wrapper for the call
> site, so how are we going to patch all call-sites when you update the
> target?

This is the generic implementation, and in this case, it is just a
function pointer which gets dereferenced and called indirectly at each
call site.

In the arch specific implementations (for ones where it matters, see
2/9), it is more like a PLT entry, which gets called from each call
site, and which can be patched to point to another function.

So we replace a single indirect call with a direct call plus a direct jump.
