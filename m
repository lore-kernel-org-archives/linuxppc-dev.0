Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43BC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 05:27:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8CA20870
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 05:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8CA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bWZm2cN4zDr2l
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 16:27:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bWXv42cszDr0s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 16:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43bWXt46Gwz9sN1;
 Fri, 11 Jan 2019 16:25:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules
 building
In-Reply-To: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
References: <20190110054216.74248-1-aik@ozlabs.ru>
 <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Date: Fri, 11 Jan 2019 16:25:33 +1100
Message-ID: <877efbg3zm.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Thu, Jan 10, 2019 at 2:44 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
...
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 488c9ed..0492f62 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -419,7 +419,11 @@ archheaders:
>>  ifdef CONFIG_STACKPROTECTOR
>>  prepare: stack_protector_prepare
>>
>> +ifeq ($(KBUILD_EXTMOD),)
>>  stack_protector_prepare: prepare0
>> +else
>> +stack_protector_prepare:
>> +endif
>
>
> Honestly, I think this is ugly.

Yes I would call it a hack :)

> Do you want me to send an alternative solution?

I don't grok how external modules are built well enough to work out what
the right solution is. So if you can come up with something better that
would be awesome.

cheers
