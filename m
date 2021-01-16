Return-Path: <SRS0=P4SC=GT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4199C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 00:46:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A2B23382
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 00:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A2B23382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHfW26DH1zDskM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 11:46:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a;
 helo=mail-pf1-x42a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ChQuMVvh; dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHfSF3B22zDskM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 11:43:57 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id c12so6542358pfo.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=iD4DvkyUpKC0TmIEHyF5NvBvNlTKRDkGIBCwbt9M/fA=;
 b=ChQuMVvhqwxnVu5hmIhgH8wg+JKeBc58oKQhiDu0a5TBVPlpTfxPJaek80Ku2mNs8q
 nhU6PdHn9PXqD+e3degIpm3LZ/7DccpEp9l8at8vRqoXorDYN4y0l4h4zmG/u+XdUwWE
 +AVa4Vp8Rdrhci5LqYGh/hKoTrA6SPp7reqS/HMucLxjAyjrfMVCJ/BWZeIZXCjL3Rqj
 wb0EMqobzoiONgADa/ZL7XKYx9FlX+2+cXsfHM68HSNzadb60ySbEv88lP1papojf5jz
 WhGW4kbYPJnjIDbkjIzxLcUkqusrpbPfbqmODtliyzcetJqkrwSc4Vv4GhrFh6uPpEHO
 BejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=iD4DvkyUpKC0TmIEHyF5NvBvNlTKRDkGIBCwbt9M/fA=;
 b=dNUMmCyfIg6GRYNlvLsKJablxXOvrm8VIivgTm4d/52RK41Z3MRj+w/2hqrVWnL6Ba
 AY2md2uaGazOTiwN6m96SyysNMKA/UhsGYwW5UDoiTmTYCOnaWiWiIrIAvum7czRpyip
 1YRLrxwKYnHO/x6H1IuvZTVuEol+ixEz/DcsUeXkRe3FpwmCkUPskq6CiVI1/4LS4Src
 s72Wk+jcuxgqXCweJGbrTW5ONPA1vGsJK/XK1xV7YdWIGd5HIE+c5xkuXq1ofmk0X2ik
 77j1pLD5wvmPIO89neXjspQ5879hKTCqob7bSEg6kXAT0wAaaLA+U1C9Q/43pvzNPI4r
 mgrw==
X-Gm-Message-State: AOAM5317jBYa1KdVjPKyvx1En4wO37KibI6n2jfc4A1KPvNOc2GDQTPZ
 0udB/zz/JSnJEqj08IZgx1Y=
X-Google-Smtp-Source: ABdhPJw/aEApokrrtUhDHEEAZbVYNI70uYQUDmNBz71xfqk/s4jzxWxPGZsGIhvBqCGB+KqyxxlR6Q==
X-Received: by 2002:a62:3002:0:b029:1aa:d858:cdd7 with SMTP id
 w2-20020a6230020000b02901aad858cdd7mr15656902pfw.1.1610757833636; 
 Fri, 15 Jan 2021 16:43:53 -0800 (PST)
Received: from localhost ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id r20sm9399151pgb.3.2021.01.15.16.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 16:43:53 -0800 (PST)
Date: Sat, 16 Jan 2021 10:43:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 17/39] powerpc/fsl_booke/32: CacheLockingException
 remove args
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210115165012.1260253-1-npiggin@gmail.com>
 <20210115165012.1260253-18-npiggin@gmail.com>
 <1bd92a69-71ab-cc7f-fec5-e2a67830c81b@csgroup.eu>
In-Reply-To: <1bd92a69-71ab-cc7f-fec5-e2a67830c81b@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1610757796.o87kxvdq5e.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of January 16, 2021 3:14 am:
>=20
>=20
> Le 15/01/2021 =C3=A0 17:49, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Like other interrupt handler conversions, switch to getting registers
>> from the pt_regs argument.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
>>   arch/powerpc/kernel/traps.c          | 5 +++--
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/=
head_fsl_booke.S
>> index fdd4d274c245..0d4d9a6fcca1 100644
>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>> @@ -364,12 +364,12 @@ interrupt_base:
>>   	/* Data Storage Interrupt */
>>   	START_EXCEPTION(DataStorage)
>>   	NORMAL_EXCEPTION_PROLOG(DATA_STORAGE)
>> -	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
>> +	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it3 */
>>   	stw	r5,_ESR(r11)
>> -	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
>> +	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it */
>> +	stw	r4, _DEAR(r11)
>>   	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
>>   	bne	1f
>> -	stw	r4, _DEAR(r11)
>>   	EXC_XFER_LITE(0x0300, handle_page_fault)
>>   1:
>>   	addi	r3,r1,STACK_FRAME_OVERHEAD
>=20
> Why isn't the above done in patch 5 ?

I don't think it's required there, is it?

Thanks,
Nick
