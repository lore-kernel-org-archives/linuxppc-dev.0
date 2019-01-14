Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C90C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:48:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1767320656
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1767320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dFFQ6fBBzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:48:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dFCl2srpzDq96
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:46:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43dFCj0lVQz9s1l;
 Mon, 14 Jan 2019 11:46:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Holland <samuel@sholland.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v5 1/2] powerpc/32: add stack protector support
In-Reply-To: <f5600a1d-71ca-f1d7-3973-026462990059@sholland.org>
References: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
 <f5600a1d-71ca-f1d7-3973-026462990059@sholland.org>
Date: Mon, 14 Jan 2019 11:46:40 +1100
Message-ID: <87k1j8dq1b.fsf@concordia.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Samuel Holland <samuel@sholland.org> writes:
> Hello all,
>
> On 09/27/18 02:05, Christophe Leroy wrote:
> [..snip..]
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 07d9dce7eda6..45b8eb4d8fe7 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -112,6 +112,9 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
>>  KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>>  endif
>>  
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
>> +
>>  LDFLAGS_vmlinux-y := -Bstatic
>>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>>  LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
>> @@ -404,6 +407,13 @@ archclean:
>>  
>>  archprepare: checkbin
>>  
>> +ifdef CONFIG_STACKPROTECTOR
>> +prepare: stack_protector_prepare
>> +
>> +stack_protector_prepare: prepare0
>> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
>> +endif
>> +
>
> This breaks when building out-of-tree kernel modules. GCC is not getting passed
> the -mstack-protector-guard-offset argument, so the default offset is used. The
> kernel then panics the first time a function with stack protector is called.
>
> I'm seeing this on powerpc64. It looks like it was reported for powerpc on
> kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201891

Thanks for the bug report.

Alexey also hit this and sent an RFC fix.

  https://patchwork.ozlabs.org/patch/1022751/

But Masahiro thought we could do something less hacky, and hopefully he
can help us come up with something better.

cheers
