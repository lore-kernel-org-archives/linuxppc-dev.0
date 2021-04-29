Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAEEC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 10:47:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40166103E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 10:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40166103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWBz26WFjz30FL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 20:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VQOwBi56;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VQOwBi56; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWByd0xLNz2xZG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 20:47:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FWByb2Rz9z9sXM;
 Thu, 29 Apr 2021 20:47:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1619693224;
 bh=BuUX/MQeNvK8ek0vVbGufgGkbaoJbzRkvexK7mrrEQ8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VQOwBi56J0Q3Q56nyEelSANIHcFbGvXrbISMbYiDwshzQiBbwEYIfJPArU41/HMx8
 eunTumtszlVEwHjNdZgHmJksa69idX101EeBSbna2E0Ctoj6JSCLMLWxqDKf1KddhD
 LyMknRiQQA6ievew3qrLMQtd3uE/goZyOcf9gBzChQ7LxDYbguUgzOLvsbOQBewoKP
 Uio7GhF+O2YDyiXkQcsRKmwa/cGXVxavR5EKNodIim6np7BAdlJg307nq+ULJoT23S
 QR8N+JINBCtwGTEwxm4PiqdpL2c3SBm71T8+Hg9vtz9kqM5hRiawIiFiaes4r2feKi
 scq0h8W84IDbg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/makefile: Do not redefine $(CPP) for
 preprocessor
In-Reply-To: <87mttqylho.fsf@dja-thinkpad.axtens.net>
References: <20210422092737.895392-1-aik@ozlabs.ru>
 <87mttqylho.fsf@dja-thinkpad.axtens.net>
Date: Thu, 29 Apr 2021 20:47:00 +1000
Message-ID: <87lf919xln.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Hi Alexey,
>
>> The $(CPP) (do only preprocessing) macro is already defined in Makefile.
>> However POWERPC redefines it and adds $(KBUILD_CFLAGS) which results
>> in flags duplication. Which is not a big deal by itself except for
>> the flags which depend on other flags and the compiler checks them
>> as it parses the command line.
>>
>> Specifically, scripts/Makefile.build:304 generates ksyms for .S files.
>> If clang+llvm+sanitizer are enabled, this results in
>> -fno-lto -flto -fsanitize=cfi-mfcall  .... -fno-lto -flto -fsanitize=cfi-mfcall
>
> Checkpatch doesn't like this line:
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #14: 
> -fno-lto -flto -fsanitize=cfi-mfcall  .... -fno-lto -flto -fsanitize=cfi-mfcall
> However, it doesn't make sense to wrap the line so we should just ignore
> checkpatch here.
>
>> in the clang command line and triggers error:
>>
>> clang-13: error: invalid argument '-fsanitize=cfi-mfcall' only allowed with '-flto'
>>
>> This removes unnecessary CPP redifinition.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/Makefile | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index c9d2c7825cd6..3a2f2001c62b 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -214,7 +214,6 @@ KBUILD_CPPFLAGS	+= -I $(srctree)/arch/$(ARCH) $(asinstr)
>>  KBUILD_AFLAGS	+= $(AFLAGS-y)
>>  KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
>>  KBUILD_CFLAGS	+= -pipe $(CFLAGS-y)
>> -CPP		= $(CC) -E $(KBUILD_CFLAGS)
>
> I was trying to check the history to see why powerpc has its own
> definition. It seems to date back at least as far as merging the two
> powerpc platforms into one, maybe it was helpful then. I agree it
> doesn't seem to be needed now.
>
> Snowpatch claims that this breaks the build, but I haven't been able to
> reproduce the issue in either pmac32 or ppc64 defconfig. I have sent it
> off to a fork of mpe's linux-ci repo to see if any of those builds hit
> any issues: https://github.com/daxtens/linux-ci/actions

It does break the build.

cheers
