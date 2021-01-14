Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8939AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 03:55:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C489223877
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 03:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C489223877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGVnx4y10zDsdP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 14:55:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ju54jMEI; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGVkK3FV3zDrg0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 14:52:09 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id u4so2468856pjn.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 19:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=8VcNEPPO45awZMpJUVWCvmfj/4ZqApj06khQqIXHhU0=;
 b=Ju54jMEIMkq9sHJ3NaRWhStBvWQL3XEgP7JJ4aagOkRtwldnuz4hhB4c7R9t0gmFlj
 Ez+Q9CvvHT9NL/PrVl0GRLW8ramRFNRpFpE/ls1rChaaB8QrrMAEIlgdbtPAIDpKtgZr
 SxOiN5U70e+XD8kwoFCGGskYdqglg2B0C7LvxTcybDc5Yq5zrtRyYQDLNtKiMGjW1b4M
 wFOikwywsMre4cWafAwMXTrvaXvLsxuwuk+MxM+hDgpGKDFgdCZ/snDSZWB9JNXKwosN
 bGjmCLem4QRIJyV+sXCn3QqC/jSRsaK+wSYyC3ajwY6ql5W9cR6AR9Y3tkMqIV0lBhbF
 /5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=8VcNEPPO45awZMpJUVWCvmfj/4ZqApj06khQqIXHhU0=;
 b=ePExAZtC4pRJu/FWj/t2CIRcZJ3hlIP2OLLpxDardAiojnw/+wjdsGIqvwrBSauW3F
 b3N9PIMIT80bR9v9MkYOsHOdBMW+DuXOczD0apHXMiwQbPCzVAIMs2ltvkHhU1v1UL1J
 4DHuxn8oEQN3iP3XHFzpHHb+k/C7DSUI4zA+tEGxqa0sTa1HgPXf2hxzB22FJQWCTTQS
 Ytq9GUD4yX6IzCuAVNoTfsfNPelULJvM72YF4G9Oz0r5WKSMkNNr79wi6FUjXQ/aQB1z
 96Xp7VTSJW0ySvaKDovkawTay0Y23XiC+t7GW07u6oPwi0nDWip2z5GnfH5pHv45q4Ph
 Eieg==
X-Gm-Message-State: AOAM531jkrls50GqwAL4GGGXzgSCtoskk4fzpatbGTGUL1d2WKsUzmvH
 TRXEp0lTX+wPegAUtUarAw2TsJkA9l/WTw==
X-Google-Smtp-Source: ABdhPJy3fQ8rEteQl4srRPNzOr45xZvzhg7r1GIGktUIQcU1NzT3K+uPLaOeQiYDyzQu7klCBU7TaQ==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr2796596pjb.207.1610596325989; 
 Wed, 13 Jan 2021 19:52:05 -0800 (PST)
Received: from localhost ([1.132.229.164])
 by smtp.gmail.com with ESMTPSA id x1sm4089226pfj.95.2021.01.13.19.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 19:52:05 -0800 (PST)
Date: Thu, 14 Jan 2021 13:51:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 16/21] powerpc/64: move account_stolen_time into its
 own function
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210113073215.516986-1-npiggin@gmail.com>
 <20210113073215.516986-17-npiggin@gmail.com>
 <fa2c9884-81c8-d4cc-a33d-3aacdacfafd7@csgroup.eu>
In-Reply-To: <fa2c9884-81c8-d4cc-a33d-3aacdacfafd7@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1610596302.t3nvixhx10.astroid@bobo.none>
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

Excerpts from Christophe Leroy's message of January 14, 2021 12:59 am:
>=20
>=20
> Le 13/01/2021 =C3=A0 08:32, Nicholas Piggin a =C3=A9crit=C2=A0:
>> This will be used by interrupt entry as well.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/include/asm/cputime.h | 15 +++++++++++++++
>>   arch/powerpc/kernel/syscall_64.c   | 10 +---------
>>   2 files changed, 16 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/a=
sm/cputime.h
>> index ed75d1c318e3..3f61604e1fcf 100644
>> --- a/arch/powerpc/include/asm/cputime.h
>> +++ b/arch/powerpc/include/asm/cputime.h
>> @@ -87,6 +87,18 @@ static notrace inline void account_cpu_user_exit(void=
)
>>   	acct->starttime_user =3D tb;
>>   }
>>  =20
>> +static notrace inline void account_stolen_time(void)
>> +{
>> +#ifdef CONFIG_PPC_SPLPAR
>> +	if (IS_ENABLED(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) &&
>=20
> Arent' you already inside a CONFIG_VIRT_CPU_ACCOUNTING_NATIVE section ?

Yes, will fix.

Thanks,
Nick
