Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A5C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 00:14:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B7B20840
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 00:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t8F0IN0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B7B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sHZm28X6zF3dx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 11:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t8F0IN0R";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=ghackmann@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="t8F0IN0R"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s82K0GPQzF3LT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 05:34:26 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id 17so941273pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JxD7kSkr4geOJC7eAPZ5I5uWHT9Cuv2yw07CVEu3ka0=;
 b=t8F0IN0RccyPgUJchAX8wq6xyLMo1oGUhuAWW8CFx9XB7F6FLFKtKQS4w1SwCo/iuA
 F0Udee4DAVY/JujMk1ocjUq7iqh7S9Pk8MnVUWzDcoTrzYNkAQVblRxZXgcIYAmg7Sfs
 GQ2jnE2tCx1FCS+wuv9lZwmEIOMckDEvdvHgNaUedoEZJaToFTNH4tZEj53IeMtQLOYx
 0SRJcgJcN+Iqr4mmxtLf3+ZkxmdjGqDiatqM1lXkEJ/S3fzbsv/iSqNRjAzFguIgKA9Z
 7ai1qlLAPUtq4nuzgl6GExwgVb30hlGiAb/8KF6tynCFaBCMwqldV/LTRoajgG5fKQu4
 zkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JxD7kSkr4geOJC7eAPZ5I5uWHT9Cuv2yw07CVEu3ka0=;
 b=dZ4ST3p5ge5EXOFF/tP5XCUrPLTXYOzVUyenoZry/XCq/9bMlSx5eQXzZxzb3qZnMt
 zvQptctELjC2hQ/aEJZrhIRYivvag8zyevaqPIvp81N/Kd39srGEoPmUrUTvzDRKIR6b
 Uh/SoA5EPrZvYnMQ8dpc2D04ioxraI9Hh3CwKzFA0srJYnuirjAJBLb8I50TVsSDNdkC
 E1SDdDeDXqKeO+3oX16vGvhBaQl1pSSiofsWRcNrtbNT7piCZVg/EaLzRNaf6hjBMG4x
 Fr0HHFtoASobSm9fIygoZySJCN4M4oTG6tklaa/l300dC3uc53q/gx2oDjW2JZqH/9eJ
 9/qA==
X-Gm-Message-State: AGRZ1gJmF/R6YbbTv5Ho8zuGUPWXzAsdzs1Wy3VlNZybv2Zy4CNwdo++
 MEfXmFDpncMk1GcpjkNpIuztzw==
X-Google-Smtp-Source: AJdET5dAhFEyxJohMBANUoZ5fGj+1zU8rhgCO6S/pRCu+vziPH2AOjgU88aNdZKjlS3uP/jglQ+8HQ==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr8236693pgh.394.1541788464604; 
 Fri, 09 Nov 2018 10:34:24 -0800 (PST)
Received: from hackmann.mtv.corp.google.com
 ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
 by smtp.gmail.com with ESMTPSA id q195sm7870491pgq.7.2018.11.09.10.34.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Nov 2018 10:34:23 -0800 (PST)
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To: Nick Desaulniers <ndesaulniers@google.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
From: Greg Hackmann <ghackmann@google.com>
Message-ID: <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com>
Date: Fri, 9 Nov 2018 10:34:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 10 Nov 2018 11:12:25 +1100
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Matthias Kaehlcke <mka@chromium.org>, joel@jms.id.au,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/09/2018 10:29 AM, Nick Desaulniers wrote:
> On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
>> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
>> easily reused in other parts of Makefile.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
>>
>>   Makefile | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index da11700..e173a73 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -487,18 +487,17 @@ endif
>>
>>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>>   ifneq ($(CROSS_COMPILE),)
>> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
>> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
>>   GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
>> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
>> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>>   GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>>   endif
>>   ifneq ($(GCC_TOOLCHAIN),)
>> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>>   endif
>> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> -KBUILD_CFLAGS += -no-integrated-as
>> -KBUILD_AFLAGS += -no-integrated-as
>> +CLANG_FLAGS    += -no-integrated-as
>> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
>> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
>>   endif
>>
>>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
>> --
>> 2.7.4
>>
> 
> Thanks for this patch, Masahiro, it's a good simplification.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Would you mind waiting for a tested-by from Stefan, and maybe an ack
> from Greg (added to cc)?
> 

Acked-by: Greg Hackmann <ghackmann@google.com>
