Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEAEC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 06:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1529F64DE4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 06:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1529F64DE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1tqm3QmNz3c3Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 17:13:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=dHEsJThK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=dHEsJThK; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1tqJ6mwHz30RT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 17:12:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F1tqF66thz9sRR;
 Fri, 19 Mar 2021 17:12:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616134378;
 bh=kJ9iQxu1PdbwXZcwj4ZBrsy/tjV2YT8oyoulfIvvYvQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dHEsJThKTbS8knKU3kL+At8dlDbHUQpzaaBSaeVNKpkkRHlddPvbhiCJii5n778p+
 S5DRTTijhRKa+dWrwu6T84fmEf2SWH2hftQXgrtud+YIuTKqddtCHmMhJV6DI15xj0
 xpHJnCVn7zh6n3O5yAxVq2PC277XXm+CK6MyGmpJIiF0d0jzqwdclDZKF8JI1Q8Ypa
 qGkCEaFigwneWYC7wrA4icgWrmve7eG049RxVV3364Asw/yvE3YujJ5SdeHd/ihbXZ
 bvfcsthLH3TsKgOjOpBrojudXQmD0mtk6HUbVymKROnXOeZIJzDDYiAjrkIUhTSKfw
 cCRktfJ+rQ1mA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/kexec: Don't use .machine ppc64 in trampoline_64.S
In-Reply-To: <20210316024434.GE16691@gate.crashing.org>
References: <20210315034159.315675-1-mpe@ellerman.id.au>
 <20210316024434.GE16691@gate.crashing.org>
Date: Fri, 19 Mar 2021 17:12:53 +1100
Message-ID: <87ft0r6596.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Mon, Mar 15, 2021 at 02:41:59PM +1100, Michael Ellerman wrote:
>> The ".machine" directive allows changing the machine for which code is
>> being generated. It's equivalent to passing an -mcpu option on the
>> command line.
>> 
>> Although it can be useful, it's generally a bad idea because it adds
>> another way to influence code generation separate from the flags
>> passed via the build system. ie. if we need to build different pieces
>> of code with different flags we should do that via our Makefiles, not
>> using ".machine".
>
> It does not influence code generation.  It says which instructions are
> valid, instead.  There are a few cases where the same mnemonic will
> generate a different binary encoding depending on machine selected,
> maybe you mean that?

Yeah that's what I was referring to. Which is code generation in my
mind, but I guess that's probably not the right terminology to use
around compiler people :)

And I guess you're right, the more common case is that the mnemonics are
just not valid for other machines and wouldn't assemble at all.

I'll reword it.

> It is *normal* to use .machine push/pop and a specific .machine around
> instructions that require a machine other than what you are building
> for.  The compiler does this itself, and it is the recommended way to
> use "foreign" instructions in inline assembler.

Right, but it also makes it easy to build code that won't run :) So we'd
like to avoid it.

We had that in the past where we were building the power7-only memcpy
routines for Book3E 64. They weren't being used due to runtime patching
stuff, but it's better to not build them in the first place for those
CPUs because they could never work.

> That said...
>
>> However as best as I can tell the ".machine" directive in
>> trampoline_64.S is not necessary at all.
>> 
>> It was added in commit 0d97631392c2 ("powerpc: Add purgatory for
>> kexec_file_load() implementation."), which created the file based on
>> the kexec-tools purgatory. It may be/have-been necessary in the
>> kexec-tools version, but we have a completely different build system,
>> and we already pass the desired CPU flags, eg:
>> 
>>   gcc ... -m64 -Wl,-a64 -mabi=elfv2 -Wa,-maltivec -Wa,-mpower4 -Wa,-many
>>   ... arch/powerpc/purgatory/trampoline_64.S
>> 
>> So drop the ".machine" directive and rely on the assembler flags.
>
>> -	.machine ppc64
>
> Please make sure to test this on a big endian config.

Done.

> A ppc64le-linux assembler defaults to power8.  A ppc64-linux assembler
> defaults to power3 (that is the same as .machine ppc64).  Or maybe it
> makes it power4?  I get lost :-)

For book3s64 we always specify -mpower4 since 15a3204d24a3
("powerpc/64s: Set assembler machine type to POWER4") (Apr 2018).

That does leave 64-bit book3e, but I just tested that and it also builds
fine.

> It certainly *should* work, but, test please :-)
>
> (And with a *default* powerpc64-linux config, not one that defaults to
> power7 or power8 or similar!  Arnd's toolchains at
> <https://mirrors.edge.kernel.org/pub/tools/crosstool/>
> are fine for this.)

Yep, I used Arnd's 10.1.0.

> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks.

cheers
