Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCAAC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 13:07:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A062070C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 13:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A062070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Vp9m4mq0zDqLP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 00:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vp7z1k1QzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 00:06:06 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id n32so36676057qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2019 05:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w9aaSlBEfs02Fpr+zeCWXVAb/7p4+cE52NJxtYH16UY=;
 b=EOUf1OC0WxenQwG23ehSVNKj3Bb91R3e1WwKRWSnsw/LdhFx4+tImgtodzLH6E5qdz
 meculT7j/Metiw0wLTMD1gsG3wua96N4xYtLjk9y4S36UYAGIWeY3tN6QAB1lGVV90Ig
 zfNZ5QAl9Dhpif1khc/Ff+l5YkMIIEnmcXF+bUx7jeMVJzQTdSD852dKryzHByaWtbEj
 kobwPCxYej/uTY8wJIedHat3z3ldwug3bRpOPcKhXhkQ8R5F2oHCqbk+yF4YkIOJu1HG
 gyCcv8vT3QHlkYfJrumPrvCSAQbgu39VWukfE9+KbGYlcAz2H6T0gwN5S3cNOkSFswTg
 QzZw==
X-Gm-Message-State: AJcUukdsEmZ/WbLC3PQz8bvspprj6ur+J80WR9D2QWluyS/a9ebpD3J0
 VehMWJmsGBKbay+47XRUDOw=
X-Google-Smtp-Source: ALg8bN7PH3sjV7L2qgOAcTUyndsgKIr2NOSGPu/0Ysqkt0MKEacEuHxHkFgWYevAVL7hmMWt9wx0Bg==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr46736206qtp.350.1546520764950; 
 Thu, 03 Jan 2019 05:06:04 -0800 (PST)
Received: from [10.0.0.8] ([189.29.25.55])
 by smtp.gmail.com with ESMTPSA id j36sm28869558qtk.15.2019.01.03.05.06.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 05:06:04 -0800 (PST)
Subject: Re: [PATCH] selftests/powerpc: New TM signal self test
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1542828069-29100-1-git-send-email-leitao@debian.org>
 <1543411413-23863-1-git-send-email-leitao@debian.org>
 <875zvoqs2b.fsf@concordia.ellerman.id.au>
From: Breno Leitao <leitao@debian.org>
Message-ID: <20c993da-a3ca-ba2c-1195-a81efb1cc342@debian.org>
Date: Thu, 3 Jan 2019 11:05:59 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <875zvoqs2b.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On 12/20/18 10:51 AM, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> A new self test that forces MSR[TS] to be set without calling any TM
>> instruction. This test also tries to cause a page fault at a signal
>> handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
>> thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
>> when tm_recheckpoint() is called.
>>
>> This test is not deterministic since it is hard to guarantee that the page
>> access will cause a page fault. Tests have shown that the bug could be
>> exposed with few interactions in a buggy kernel. This test is configured to
>> loop 5000x, having a good chance to hit the kernel issue in just one run.
>> This self test takes less than two seconds to run.
>>
>> This test uses set/getcontext because the kernel will recheckpoint
>> zeroed structures, causing the test to segfault, which is undesired because
>> the test needs to rerun, so, there is a signal handler for SIGSEGV which
>> will restart the test.
> And reference the ucontext->mcontext MSR using UCONTEXT_MSR() macro.
> Hi Breno,
> 
> Thanks for the test, some of these TM tests are getting pretty advanced! :)
> 
> Unfortunately it doesn't build in a few configurations.
> 
> On Ubuntu 18.10 built with powerpc-linux-gnu-gcc I get:
> 
>   tm-signal-force-msr.c: In function 'trap_signal_handler':
>   tm-signal-force-msr.c:42:19: error: 'union uc_regs_ptr' has no member named 'gp_regs'; did you mean 'uc_regs'?
>     ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
>                      ^~~~~~~
>                      uc_regs
>   tm-signal-force-msr.c:17:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
>    #define __MASK(X)       (1UL<<(X))
>                                ^~
>   tm-signal-force-msr.c:20:25: note: in expansion of macro '__MASK'
>    #define MSR_TS_S        __MASK(MSR_TS_S_LG) /* Transaction Suspended */
>                            ^~~~~~
>   tm-signal-force-msr.c:42:38: note: in expansion of macro 'MSR_TS_S'
>     ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
>                                         ^~~~~~~~
> 

That is because I missed the -m64 compilation flag on Makefile. I understand
that this test only make sense when compiled in 64 bits. Do you agree?

I might also add a macro to address ucontext->mcontext MSR. This will avoid
problems like that in the future.

 index ae43a614835d..7636bf45d5d5 100644
 --- a/tools/testing/selftests/powerpc/include/utils.h
 +++ b/tools/testing/selftests/powerpc/include/utils.h
 @@ -102,8 +102,10 @@ do {


  #if defined(__powerpc64__)
  #define UCONTEXT_NIA(UC)       (UC)->uc_mcontext.gp_regs[PT_NIP]
 +#define UCONTEXT_MSR(UC)       (UC)->uc_mcontext.gp_regs[PT_MSR]
  #elif defined(__powerpc__)
  #define UCONTEXT_NIA(UC)       (UC)->uc_mcontext.uc_regs->gregs[PT_NIP]
 +#define UCONTEXT_MSR(UC)       (UC)->uc_mcontext.uc_regs->gregs[PT_MSR]
  #else
  #error implement UCONTEXT_NIA
  #endif

> And using powerpc64le-linux-gnu-gcc I get:
> 
>   In file included from /usr/powerpc64le-linux-gnu/include/string.h:494,
>                    from tm-signal-force-msr.c:10:
>   In function 'memcpy',
>       inlined from 'trap_signal_handler' at tm-signal-force-msr.c:39:2:
>   /usr/powerpc64le-linux-gnu/include/bits/string_fortified.h:34:10: error: '__builtin_memcpy' accessing 1272 bytes at offsets 8 and 168 overlaps 1112 bytes at offset 168 [-Werror=restrict]
>      return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Damn, that is because I do not know how to use C pointers. Fixing it on v3 also.
