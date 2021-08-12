Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A8C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 05:46:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C2F60241
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 05:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6C2F60241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlbKr0d9Kz3bWg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 15:46:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=oz4IcUCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=oz4IcUCX; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlbK50BKBz2yNB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 15:46:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GlbK32Rpmz9sWl;
 Thu, 12 Aug 2021 15:46:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1628747175;
 bh=dGQNxHwNfCMGT7qUNezTN7u5TWFpZYd9MbDw4n7nvu4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=oz4IcUCX96rvOrDZuo4RUXKR9QRqrcbA8JKt2pmbgrolgDE9PmppRhqVriOGfBULB
 GUY/b2CFxa0oPPcGikaOaPTIkpjqwC/bS5B4T3fa+6Gykt34I61IG61iEwQTQxF8an
 dBypgxvMHXU/1JhLDhlswAEZ4FVPaJIxISdikqZCCOs7n0nzB3vaXLom6Rfj11UKfN
 isGYfEOT+ZP+wAk3NXc3KwMH1NLJL/3PF/HwtBDraamM2KoLvM2fYJsd2zMo34UWAh
 Blsa8p1aZq+4janK3icqMv41taJ8cqNKj7iH/AidGrLCSvGrnxCydaPR+mGtQqFFaY
 Dtpm8KmgQAOtw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: clang/ld.lld build fails with `can't create dynamic relocation
 R_PPC64_ADDR64 against local symbol in readonly segment`
In-Reply-To: <77a69755-5291-285c-45be-c1e42423fddc@molgen.mpg.de>
References: <b647b710-7ae0-3c7e-6996-92ac974b3b2a@molgen.mpg.de>
 <77a69755-5291-285c-45be-c1e42423fddc@molgen.mpg.de>
Date: Thu, 12 Aug 2021 15:46:12 +1000
Message-ID: <87r1ezmd0b.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Derek Parker <parkerderek86@gmail.com>, Dmitrii Okunev <xaionaro@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Menzel <pmenzel@molgen.mpg.de> writes:
> Am 29.07.21 um 10:23 schrieb Paul Menzel:
>
>> I just wanted to make you aware that building Linux for ppc64le with=20
>> clang/lld.ld fails with [1]:
>>=20
>>  =C2=A0=C2=A0=C2=A0 ld.lld: error: can't create dynamic relocation R_PPC=
64_ADDR64=20
>> against symbol: empty_zero_page in readonly segment; recompile object=20
>> files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in=20
>> the output
>>  =C2=A0=C2=A0=C2=A0 >>> defined in arch/powerpc/kernel/head_64.o
>>  =C2=A0=C2=A0=C2=A0 >>> referenced by=20
>> arch/powerpc/kernel/head_64.o:(___ksymtab+empty_zero_page+0x0)
>>=20
>> The patch below from one of the comments [2] fixes it.
>>=20
>> --- i/arch/powerpc/Makefile
>> +++ w/arch/powerpc/Makefile
>> @@ -122,7 +122,7 @@ cflags-$(CONFIG_STACKPROTECTOR)=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D=20
>> -mstack-protector-guard-reg=3Dr2
>>  =C2=A0endif
>>=20
>>  =C2=A0LDFLAGS_vmlinux-y :=3D -Bstatic
>> -LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) :=3D -pie
>> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) :=3D -pie -z notext
>>  =C2=A0LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=3D $(=
LDFLAGS_vmlinux-y)
>>  =C2=A0LDFLAGS_vmlinux +=3D $(call ld-option,--orphan-handling=3Dwarn)
>
> Any comments, if this is the right fix? Current Linux master branch=20
> still fails to build with `LLVM=3D1` on Ubuntu 21.04 without this change.

Sorry but I have no idea if it's the right fix. What I need is the
author (or someone else) to send a patch with a change log explaining
the change, what it does, why it's right for llvm, and why it's right
for binutils.

cheers
