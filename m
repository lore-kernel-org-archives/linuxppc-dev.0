Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6577DC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B192B2177B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="JiJ5Lcuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B192B2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b83G4VS9zDqkd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 01:47:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="JiJ5Lcuh"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b81X3gH4zDqjG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 01:45:31 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id d19so13074017qtq.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yGNeuIkL24Gh5xySQwIRtRltWY8DxVmq9qFomorSdxs=;
 b=JiJ5Lcuhdi7fXVPTquwYY3xId5M9aAv0tSIrjFoZOYw1qn9TG7Z/yf+Q/O5MK+Oyhs
 5whf0thPyb9STRlnJWOtUIQCJNWrMuhke+hEH1wYvLf1iQiQvub6nicxOXMCaa3WzHCy
 /WibwbjIPZzZPmMUBd+SxYOTwVEuEjYZGUwd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yGNeuIkL24Gh5xySQwIRtRltWY8DxVmq9qFomorSdxs=;
 b=nETpDvdSMTetW7KnACl5OkC2tJguf06CCiSg4S5YFHiTO+JELcoLGwFGWzHPJbZFct
 GZUb7A52vCXAvmpZQtIW3tjfOUUFPGgEa0zqQN9pZz7XKHcDJ/Nai8NfPSZ1tz+zlfqL
 /TYLxsFVSNdtOYIfACmSM/VLu4Bxcm29TKxlvkEhmm9oba5d+zrobZFCshb7Yy1GHGLj
 2fp+EBq/GgBR/mM8WxZBFvaF2qd/1tKa/+H8JlyEzhxha1sMzDIKvDxF/ditNTbe0+Hw
 ja2gDVfNjOmrhr58uqTJvD8hZqRJTEYJfxuJxoa3bETsXHVTAymoldN6E4SXcudUAZ8z
 FEsg==
X-Gm-Message-State: AJcUukfMB/VCW9srL1ssG7kGqS84NiSVTlZiv5wCpen4i7LRMWvRDWFF
 FzE8MbvCp8fxVPyGD8+EsPn5tw==
X-Google-Smtp-Source: ALg8bN74zyoH1iF0rJdySfYiH1EKNIrdumPk04qjDacsz+pHpG0HHYT1ZAjBmRRn6UMUl4xJHsB8Lw==
X-Received: by 2002:a37:99c5:: with SMTP id b188mr9903182qke.100.1547131529196; 
 Thu, 10 Jan 2019 06:45:29 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
 by smtp.gmail.com with ESMTPSA id n68sm36676930qte.66.2019.01.10.06.45.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 06:45:27 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vdso32: Drop -mabi=elfv1 for 32 bit objects
In-Reply-To: <82aeb9f8-6d25-de79-487c-a073ea33ba69@c-s.fr>
References: <20190110014258.20963-1-joel@jms.id.au>
 <82aeb9f8-6d25-de79-487c-a073ea33ba69@c-s.fr>
Date: Fri, 11 Jan 2019 01:45:23 +1100
Message-ID: <8736q0po58.fsf@linkitivity.dja.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 10/01/2019 =C3=A0 02:42, Joel Stanley a =C3=A9crit=C2=A0:
>> From: Daniel Axtens <dja@axtens.net>
>>=20
>> All 64-bit objects need to specify the flag to be compiled correctly, we
>> just don't need it for 32-bit objects. GCC just ignored it, but clang
>> doesn't.
>>=20
>> Link: https://github.com/ClangBuiltLinux/linux/issues/240
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   arch/powerpc/kernel/vdso32/Makefile | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>=20
>> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/v=
dso32/Makefile
>> index 50112d4473bb..6bd41756e0c7 100644
>> --- a/arch/powerpc/kernel/vdso32/Makefile
>> +++ b/arch/powerpc/kernel/vdso32/Makefile
>> @@ -34,6 +34,20 @@ obj-y +=3D vdso32_wrapper.o
>>   extra-y +=3D vdso32.lds
>>   CPPFLAGS_vdso32.lds +=3D -P -C -Upowerpc
>>=20=20=20
>> +# clang refuses to accept -mabi=3Delfv1 for when using the
>> +# 64-bit target in 32-bit mode
>> +ifdef CONFIG_CC_IS_CLANG
>
> If -mabi=3Delfv1 is unneeded even for GCC, why depend on CLANG ?
>
>> +ifdef CONFIG_PPC64
>> +AFLAGS_REMOVE_getcpu.o +=3D -mabi=3Delfv1
>> +endif
>
> Why only this one is inside the ifdef ? powerpc Makefile only set=20
> -mabi=3Delfv1 when CONFIG_PPC64 is set, so all objects should be handled=
=20
> the same way.
>
> And would it harm just doing it all the time, regardless of CONFIG_PPC64 ?

I designed the patch to mirror some code earlier on, and to be
conservative in what it did. I have no issue with it being restructured,
but I probably won't have the time to do it for a month or so. I'm very
happy for you or Joel to rework it and to test any resulting patches.

Regards,
Daniel

>
> Christophe
>
>> +AFLAGS_REMOVE_sigtramp.o +=3D -mabi=3Delfv1
>> +AFLAGS_REMOVE_gettimeofday.o +=3D -mabi=3Delfv1
>> +AFLAGS_REMOVE_datapage.o +=3D -mabi=3Delfv1
>> +AFLAGS_REMOVE_cacheflush.o +=3D -mabi=3Delfv1
>> +AFLAGS_REMOVE_note.o +=3D -mabi=3Delfv1
>> +endif
>> +
>> +
>>   # Force dependency (incbin is bad)
>>   $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
>>=20=20=20
>>=20
