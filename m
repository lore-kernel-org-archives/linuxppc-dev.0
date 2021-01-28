Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C5C433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 08:53:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3748F64D92
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3748F64D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRDlS0gHyzDrgN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 19:53:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12e;
 helo=mail-lf1-x12e.google.com; envelope-from=sergei.shtylyov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BvV+OmW8; dkim-atps=neutral
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRCZk5NLqzDrh9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 19:00:46 +1100 (AEDT)
Received: by mail-lf1-x12e.google.com with SMTP id v24so6391832lfr.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 00:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gnZ/GDloV555+OnWhNxGUyFa3V1UNr+TUyX9DCKmvmo=;
 b=BvV+OmW8dWjmNJDvcrvjzcva8OWBy7a8Wldf3TYz+i6X3QYbdYVdx8XtO5leAkHTrU
 w3YMC/VHtwxm1x/Ic4nsp2y26eWjsO1yakRgVNAsk/+vPQ3tFI4ORflBdiqudTUbNQ15
 4udiNHAeivKX5c5MMjdj7/0f+Ywbb21vVg6oz3mMUyOwECoUO5sTQ+F7gyKkdUAVhOze
 vsQP8Kn/mYUO89v8SJNtfvxDDv5uZaZ+sphCBYtGqh9qpfbAr39PdAciszAdWiMDq33U
 CM0tCQ9qP6AgV+zPptT62EH2DQH0UbsDLxpsVPp63My+wTEFFdBYjDtMPkofAyv61LZq
 z8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gnZ/GDloV555+OnWhNxGUyFa3V1UNr+TUyX9DCKmvmo=;
 b=ayTFTeMvtzh8L5TZgZ3ajPN9IuA/+elm7/Rrp73RwaF1aTYD8ZnJUxqnPCSBQ+cKqb
 tVO9WXOwFPmOj9asRAypvlheaYAQNh1HIOp/jDZUWg2z51F3KU3mRTuAw0QlDJyXhtbU
 zik4gvc4ynY+fOTXg3OaxWen6jf7/axK57BGUaaqJ4NHCsGRmyVYGGwj1D+5Dbw64sdC
 Jtxi0FMsbl9MPXM8KYOMnWG8PzHHBBWLTLZErO3WZq5V/9nq4dQfBDYQ4Nm1rK8pydSD
 wX1+1fCp+rSQhh1zgdfexCLIJTDG0hIL3/aEWUVCdcznn/l9hzDGi8vL/6q0KbdCQcDG
 BNzw==
X-Gm-Message-State: AOAM530mXD7HPnhNExwhfljGBh1hvl6dQdSaGxa6Z+NUaY8U09f3NVZ5
 /ZIRq4LHkwaqdEH6vXTDzTE=
X-Google-Smtp-Source: ABdhPJx0NmJx1f9alnrCE9Umt15J9iBGC/sPqz1LULvUs4CMEHAB23hGApY2DMjRufppP/iSttVSHw==
X-Received: by 2002:ac2:4907:: with SMTP id n7mr4218547lfi.213.1611820841569; 
 Thu, 28 Jan 2021 00:00:41 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.159])
 by smtp.gmail.com with ESMTPSA id b18sm1359053lfj.140.2021.01.28.00.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 00:00:41 -0800 (PST)
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-arch@vger.kernel.org,
 x86@kernel.org
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org>
 <dd37a7f2-55e1-2e96-0c93-4a40980b8ef2@gmail.com>
Organization: Brain-dead Software
Message-ID: <605cea27-bd69-5b21-f285-2d3d0f6abd23@gmail.com>
Date: Thu, 28 Jan 2021 11:00:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dd37a7f2-55e1-2e96-0c93-4a40980b8ef2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Jan 2021 19:51:42 +1100
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
Cc: linux-xtensa@linux-xtensa.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 28.01.2021 10:59, Sergei Shtylyov wrote:

[...]
>> Building kernel/sys_ni.c with W=1 omits tons of -Wmissing-prototypes
> 
>     Emits?
> 
>> warnings.
>>
>> $ make W=1 kernel/sys_ni.o
>>    [ snip ]
>>    CC      kernel/sys_ni.o
>> In file included from kernel/sys_ni.c:10:
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous 
>> prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
>>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>        |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro 
>> '__COND_SYSCALL'
>>    100 |  __COND_SYSCALL(x64, sys_##name)
>>        |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro 
>> '__X64_COND_SYSCALL'
>>    256 |  __X64_COND_SYSCALL(name)     \
>>        |  ^~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>     39 | COND_SYSCALL(io_setup);
>>        | ^~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous 
>> prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
>>     83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>        |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro 
>> '__COND_SYSCALL'
>>    120 |  __COND_SYSCALL(ia32, sys_##name)
>>        |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro 
>> '__IA32_COND_SYSCALL'
>>    257 |  __IA32_COND_SYSCALL(name)
>>        |  ^~~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>     39 | COND_SYSCALL(io_setup);
>>        | ^~~~~~~~~~~~
>>    ...
>>
>> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
>> declarations. Let's do likewise for __COND_SYSCALL() to fix the
>> warnings.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>   arch/x86/include/asm/syscall_wrapper.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/syscall_wrapper.h 
>> b/arch/x86/include/asm/syscall_wrapper.h
>> index a84333adeef2..80c08c7d5e72 100644
>> --- a/arch/x86/include/asm/syscall_wrapper.h
>> +++ b/arch/x86/include/asm/syscall_wrapper.h
>> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs 
>> *regs);
>>       }
>>   #define __COND_SYSCALL(abi, name)                    \
>> +    __weak long __##abi##_##name(const struct pt_regs *__unused);    \
>>       __weak long __##abi##_##name(const struct pt_regs *__unused)    \
> 
>     Aren't these two lines identical?

     Ah, got it! :-)

[...]

MBR, Sergei
