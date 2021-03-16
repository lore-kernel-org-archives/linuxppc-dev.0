Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0726AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:07:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E57864F94
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E57864F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F049T6nXNz30KB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:07:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=q7uyClws;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=q7uyClws; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F04911JSYz2xy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 18:07:00 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so925100pjg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=c9unWKBXKK+e6Zx4wNk9RU7FUA5RYqSKk66VHkORapE=;
 b=q7uyClwsNA6GxC6pcFi9cLwCFfUq0kjk5C/KLHkm+V9L8ufiOneCB0+7RlUz5af6xA
 jzTlk8PbZaqxSJ3bQlYaqg/TXzFNzzBTXecCIjhAk2hxa0vIoYZKViNtwtkFr8BDbD00
 0YyVq1Uqto2edBIMWuT9LB/ekeDFaOFB3x8nK8fGvjdhkL4aeYU8QlPhuR0gJuaeLyVR
 pogbQUIBUh29ZVbISqgWd2M2ccWcm2d2QmKb5syaEU5yrbv8ypKCRQX1jViqnTEnPcpZ
 hAJkP92k/j7H85RGrdvQBg9tAk0Fq5CrRBkZ4HrnbqKVdi+HC9+FCvb5F/ptPGd/90P2
 HFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=c9unWKBXKK+e6Zx4wNk9RU7FUA5RYqSKk66VHkORapE=;
 b=aDGxsNPLv01hotvEcEBWJWQI1lh18vr0fSCagYPtfSHdwrsir1NQQ8jf8xwj8BI1Rf
 00hIjIpX69A0JmUb68kvUpeYWVL4UrtefkMbKET7rfWqS4QwSrdNa9bDrtBdho96lBfL
 CLfAHZ1oe6Iwx77Lxr+fPAgz2fjV2+4a9Sskyg4CbUioyyvwP0YDcvCJRym4r6wulVmf
 K5Aqi06LgiYSaRBRXfhS3TCQij5HryD+q4nohIK4k61Ek8tEPP3QC1Y2bNJYMgfVB/Mo
 8NazRjiIEMyorWzpMLzVrOsk/0jxodRdq7mCM96spjAFdRKNe+Bpq/WT0bxcz7vnh9ub
 EjIA==
X-Gm-Message-State: AOAM533YkKNNfq5CCH3j6PYQpMY55cEUc7jRHZsg0JaOhiD8WSipTcN0
 Xo+cBLpe0hk6Xrfhc+amz5M=
X-Google-Smtp-Source: ABdhPJxdqFawxrcW1L47Tsu/lwUejdAYXxGBWB3hxpIZcN/f/jmXRpbe4/3XFK0BnvuxHs6wRlR+eQ==
X-Received: by 2002:a17:903:20c1:b029:e6:8df3:f3ec with SMTP id
 i1-20020a17090320c1b02900e68df3f3ecmr15594113plb.60.1615878418738; 
 Tue, 16 Mar 2021 00:06:58 -0700 (PDT)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id j10sm1793045pjs.11.2021.03.16.00.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 00:06:58 -0700 (PDT)
Date: Tue, 16 Mar 2021 17:06:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 07/10] powerpc/64e/interrupt: handle bad_page_fault in C
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210315031716.3940350-1-npiggin@gmail.com>
 <20210315031716.3940350-8-npiggin@gmail.com>
 <6e0873c6-7102-ff8b-1552-8ce158613fd7@csgroup.eu>
In-Reply-To: <6e0873c6-7102-ff8b-1552-8ce158613fd7@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615878278.tnfqwhhg95.astroid@bobo.none>
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
Cc: Scott Wood <oss@buserror.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of March 16, 2021 12:07 am:
>=20
>=20
> Le 15/03/2021 =C3=A0 04:17, Nicholas Piggin a =C3=A9crit=C2=A0:
>> With non-volatile registers saved on interrupt, bad_page_fault
>> can now be called by do_page_fault.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/kernel/exceptions-64e.S | 6 ------
>>   arch/powerpc/mm/fault.c              | 5 +----
>>   2 files changed, 1 insertion(+), 10 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/=
exceptions-64e.S
>> index a059ab3542c2..b08c84e0fa56 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -937,12 +937,6 @@ storage_fault_common:
>>   	ld	r14,PACA_EXGEN+EX_R14(r13)
>>   	ld	r15,PACA_EXGEN+EX_R15(r13)
>>   	bl	do_page_fault
>> -	cmpdi	r3,0
>> -	bne-	1f
>> -	b	interrupt_return
>> -	mr	r4,r3
>> -	addi	r3,r1,STACK_FRAME_OVERHEAD
>> -	bl	__bad_page_fault
>=20
> Then __bad_page_fault() can be static now.

Good point, I'll change it.

Thanks,
Nick
