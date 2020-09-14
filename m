Return-Path: <SRS0=ST+l=CX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA0C433E2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 02:30:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03234206F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 02:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gie2ZEAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03234206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BqVhL17gTzDqWb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 12:30:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Gie2ZEAy; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BqVfP2g8PzDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 12:28:42 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id a9so4674424pjg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2020 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=tBnOPAiQAmuM/zw7OunepnMvNhW7KRIsJ8xiVhAMSfY=;
 b=Gie2ZEAyK8kU612WNHDufwN5+26XZWkfn8BPHvSMCJYgtuOJLzL4MZZT5+QnCNLiyZ
 mPVjLzY+99864U40wBb7tGfwiFDQtea35YXWYVvFGrKWUebubAt4YyYgxdOFaPr4DXwO
 QSxExkHuAw+Y/f23CeXVqmfYXI8+8o2KBaEhAjlaH0kRow6SiL0bLe95d1GUxGRlWLa6
 15MNR/xoz+d6ptPGcmOlJi+f2Zl7mtIILDP8DQYSjKW2cWJJ7p5TbCkVT0gKMm7UqiKZ
 W5Ax7RqOAqrUGw80Z0J9eDWYNh0OX6sa3AF4zhp25ToMlafA+wkrguAopIauOLknYWik
 TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=tBnOPAiQAmuM/zw7OunepnMvNhW7KRIsJ8xiVhAMSfY=;
 b=oUXGRg4Q3F8zOL8Cp7Mxpo12qkR0YFUX+i6VOHH6r1ywreR9MU2orKJwvSXqZKjhAc
 nzZmNA7fLpVsTIugM4zEV2E3mZitKqVS/eroLfjS66PkH1EXwc7u7gXXrTNrr/XQU9bP
 JD5ARDRuPLvVcvcUpYHdMQaAL8KZuLgj43gt16CQJQ0qkvDz1kApr4XxHK/VJwpZ2ghZ
 dQJsVwbgNR5rAQNRxxF1xyjvwwT1h25EjeeG5WcqQGa4dNTbl/Idbl/oaGnFNpX3pgSy
 PLQxgYxcWOCO/3FQ4Gn18e8RrNnjcKlfZv2xJ6+7usmijqeG2YhVwSTev8aWCdywrqSs
 vsvA==
X-Gm-Message-State: AOAM533NlNn1F815dcYw6N2DgHprBI0fampaboaDoC+gag3/SqeMDxI/
 +hd5snTutKLg/kZoSwPgSoE=
X-Google-Smtp-Source: ABdhPJwWpH0s9rwvXAYAPU7hBSiPDm5noXNGFxGop+M8aV0zknJAhjVngYlbq5Y81skHhxIyeyZYSw==
X-Received: by 2002:a17:90a:71c7:: with SMTP id
 m7mr12651457pjs.190.1600050519548; 
 Sun, 13 Sep 2020 19:28:39 -0700 (PDT)
Received: from localhost ([203.185.249.227])
 by smtp.gmail.com with ESMTPSA id z11sm8724267pfc.181.2020.09.13.19.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 19:28:39 -0700 (PDT)
Date: Mon, 14 Sep 2020 12:28:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] spi: fsl-espi: Only process interrupts for expected events
To: "broonie@kernel.org" <broonie@kernel.org>
References: <20200904002812.7300-1-chris.packham@alliedtelesis.co.nz>
 <ecedc71d-100a-7d7a-ff7f-ef1a3086dd74@alliedtelesis.co.nz>
In-Reply-To: <ecedc71d-100a-7d7a-ff7f-ef1a3086dd74@alliedtelesis.co.nz>
MIME-Version: 1.0
Message-Id: <1600050281.5iiy8pkb7z.astroid@bobo.none>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Chris Packham's message of September 14, 2020 8:03 am:
> Hi All,
>=20
> On 4/09/20 12:28 pm, Chris Packham wrote:
>> The SPIE register contains counts for the TX FIFO so any time the irq
>> handler was invoked we would attempt to process the RX/TX fifos. Use the
>> SPIM value to mask the events so that we only process interrupts that
>> were expected.
>>
>> This was a latent issue exposed by commit 3282a3da25bd ("powerpc/64:
>> Implement soft interrupt replay in C").
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Cc: stable@vger.kernel.org
>> ---
> ping?

I don't know the code/hardware but thanks for tracking this down.

Was there anything more to be done with Jocke's observations, or would=20
that be a follow-up patch if anything?

If this patch fixes your problem it should probably go in, unless there=20
are any objections.

Thanks,
Nick

>>
>> Notes:
>>      I've tested this on a T2080RDB and a custom board using the T2081 S=
oC. With
>>      this change I don't see any spurious instances of the "Transfer don=
e but
>>      SPIE_DON isn't set!" or "Transfer done but rx/tx fifo's aren't empt=
y!" messages
>>      and the updates to spi flash are successful.
>>     =20
>>      I think this should go into the stable trees that contain 3282a3da2=
5bd but I
>>      haven't added a Fixes: tag because I think 3282a3da25bd exposed the=
 issue as
>>      opposed to causing it.
>>
>>   drivers/spi/spi-fsl-espi.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
>> index 7e7c92cafdbb..cb120b68c0e2 100644
>> --- a/drivers/spi/spi-fsl-espi.c
>> +++ b/drivers/spi/spi-fsl-espi.c
>> @@ -574,13 +574,14 @@ static void fsl_espi_cpu_irq(struct fsl_espi *espi=
, u32 events)
>>   static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
>>   {
>>   	struct fsl_espi *espi =3D context_data;
>> -	u32 events;
>> +	u32 events, mask;
>>  =20
>>   	spin_lock(&espi->lock);
>>  =20
>>   	/* Get interrupt events(tx/rx) */
>>   	events =3D fsl_espi_read_reg(espi, ESPI_SPIE);
>> -	if (!events) {
>> +	mask =3D fsl_espi_read_reg(espi, ESPI_SPIM);
>> +	if (!(events & mask)) {
>>   		spin_unlock(&espi->lock);
>>   		return IRQ_NONE;
>>   	}
