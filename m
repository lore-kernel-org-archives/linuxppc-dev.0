Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 10:54:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A280E64F53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 10:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280E64F53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F213z0xz1z2xZw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 21:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=dUJfgsL9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=dUJfgsL9; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F213W49v4z2yyC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 21:53:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F213L6lDVz9sSC;
 Fri, 19 Mar 2021 21:53:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616151231;
 bh=A9UtJ6CsoBJ0YID5f30nH4NRkis6eO4gedPV6cG2crk=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=dUJfgsL94gbpLB64F0bJvYc67DwLlLWTYQ7+94zK5tc74D2H6kHyoqx+/WVYZEJbq
 Z6TUDkSJGYnuOLPwqydzny8ba39FJVOB4ZpBWvM9eFR4bplw+y3u1C8afZdfkFE3vV
 h59QWke/as/eMfDH8gP5xud4Y8D7wZheWGkZcQ+CB6iyLt7mHf+Gbhz+s9MlLJCrJ5
 zHFNEG0zFGtPGNhNihNmzpAAvIbYOSPhlX9ev453A/zzuSTtBTqW2FQW/AXRLCBWRx
 bEAzwj49hBq13zaVt0CgAueaKO21SvahXiZx1uvzjkistiRzBUfTt3fsodSO2sPdOk
 euRVdae6cnPRQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/8] powerpc: check for support for -Wa, -m{power4,
 any}
In-Reply-To: <1616117194.vwe39qw3i4.astroid@bobo.none>
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-3-dja@axtens.net>
 <1616117194.vwe39qw3i4.astroid@bobo.none>
Date: Fri, 19 Mar 2021 21:53:47 +1100
Message-ID: <87ft0r8ldw.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Daniel Axtens's message of February 25, 2021 1:10 pm:
>> LLVM's integrated assembler does not like either -Wa,-mpower4
>> or -Wa,-many. So just don't pass them if they're not supported.
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  arch/powerpc/Makefile | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 08cf0eade56a..3e2c72d20bb8 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -252,7 +252,9 @@ cpu-as-$(CONFIG_E500)		+= -Wa,-me500
>>  # When using '-many -mpower4' gas will first try and find a matching power4
>>  # mnemonic and failing that it will allow any valid mnemonic that GAS knows
>>  # about. GCC will pass -many to GAS when assembling, clang does not.
>> -cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4 -Wa,-many
>> +# LLVM IAS doesn't understand either flag: https://github.com/ClangBuiltLinux/linux/issues/675
>> +# but LLVM IAS only supports ISA >= 2.06 for Book3S 64 anyway...
>> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-mpower4) $(call as-option,-Wa$(comma)-many)
>>  cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
>>  
>>  KBUILD_AFLAGS += $(cpu-as-y)
>
> I'm wondering why we even have this now. Kbuild's "AS" command goes 
> through the C compiler now with relevant options like -mcpu.

It uses $(CC) but it doesn't pass it $CFLAGS AFAIK. So it would use
whatever the compiler default is for -mcpu etc. I think.

> I assume it used to be useful for cross compiling when as was called
> directly but I'm not sure.

We still use it directly in vdso32/Makefile.

cheers
