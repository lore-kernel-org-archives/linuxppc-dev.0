Return-Path: <SRS0=8kw5=EQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CBC388F7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 08:21:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9023D2080A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 08:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="musmIBLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9023D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CVgmn4H7bzDqVn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 19:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=musmIBLC; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CVgkQ2ylpzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2020 19:19:07 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id v12so10694644pfm.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2020 00:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=Bj6FvF0dMymlG1IYOFrlXzbGYhQTttklijVWdYwmj1A=;
 b=musmIBLCiPScDgGkG45umMgp1VcX+WFimaHptF29Cnv2orYbHUm+P1rgIKtL5RwHx1
 XeqldW9aqRNKzEralyt2MuBQZviTHKDMQUhVp1dgqd2YNYEvRpk0jXcMHyDxC8LacieQ
 Wj7rZbmPER0dX7K0F3Awm38rMtORtwMUwmIBG9PB0FN3+UUtwfaBaVu1rTRoL6+2/gsr
 6OyVPBFTOQd35Z+zWdpsvZVxDut2sucihCK9utGwSXVPrmu7lH+AujZgW/LsLQl8+Tfx
 Oc3BaM/QlQghwpUvKaMQRbvgGVCEBJyGsdaxG2wOPVuLvdvVUIpl4LKWUBr2bUL8ePm1
 wFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=Bj6FvF0dMymlG1IYOFrlXzbGYhQTttklijVWdYwmj1A=;
 b=cMnqKcv+VUjlFigkRHfYt6hj+TMU7IIYxTWjUaCHRUd8H+X2auhrpy0WLIYq4Gu8Ic
 62whMPZhvtQBhSqme+CbepCo3HGTLxjgF3tPwvGmTBKHSRHd0gtXQt7vhRZdOILaOeFU
 vuQM5a3zfwAvCX1OBd7nXqVnetKATUGWP+lG5vmO9xGmvrxY1IxPqJzM5105BzDUFQN5
 HoCQNj7uQhY2P2NwZsljIFWKR5AyUjHA2Qt/vLO6/WBbVX3UTyzKGqzvf8M0QXGOb8PN
 GFDoSLPM4331jfSfqjb2KmHMXn/97l5eMk9u7zNMVvaG8DLIC+4LAJXXNq8yoYvoPix+
 Bv3A==
X-Gm-Message-State: AOAM532eduP+fLSRrCQvF2T6+dyc/ICsanYeClvklxy9bfePQ/jNu4Fv
 RAcY/YS/ENGm4W89/Q1zNnBw8kSr3M4=
X-Google-Smtp-Source: ABdhPJygNUdKIL9v0SzFuJwNLbGuwzxdiZN9UQn8tq/zJYm+dTic6NsAe13KO0s9stGWL7fplt8oPA==
X-Received: by 2002:a17:90a:f00a:: with SMTP id
 bt10mr3606826pjb.91.1604996346088; 
 Tue, 10 Nov 2020 00:19:06 -0800 (PST)
Received: from localhost (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id a28sm13517009pfk.50.2020.11.10.00.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 00:19:05 -0800 (PST)
Date: Tue, 10 Nov 2020 18:18:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: add compile-time support for lbarx, lwarx
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20201107032328.2454582-1-npiggin@gmail.com>
 <311a1f6d-01ca-e35f-d145-3c643fb40f74@csgroup.eu>
In-Reply-To: <311a1f6d-01ca-e35f-d145-3c643fb40f74@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1604995561.t19n2j4wpv.astroid@bobo.none>
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

Excerpts from Christophe Leroy's message of November 7, 2020 6:15 pm:
>=20
>=20
> Le 07/11/2020 =C3=A0 04:23, Nicholas Piggin a =C3=A9crit=C2=A0:
>> ISA v2.06 (POWER7 and up) as well as e6500 support lbarx and lwarx.
>> Add a compile option that allows code to use it, and add support in
>> cmpxchg and xchg 8 and 16 bit values.
>=20
> Do you mean lharx ? Because lwarx exists on all powerpcs I think.

Thanks all who pointed out mistakes :) Yes lharx.

>=20
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/Kconfig                   |   3 +
>>   arch/powerpc/include/asm/cmpxchg.h     | 236 ++++++++++++++++++++++++-
>>   arch/powerpc/platforms/Kconfig.cputype |   5 +
>>   3 files changed, 243 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index e9f13fe08492..d231af06f75a 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -266,6 +266,9 @@ config PPC_BARRIER_NOSPEC
>>   	default y
>>   	depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
>>  =20
>> +config PPC_LBARX_LWARX
>> +	bool
>=20
> s/LWARX/LHARX/ ?
>=20
> And maybe better with PPC_HAS_LBARX_LWARX ?

Yes you're right, PPC_HAS_ fits better.

[...]

>> +#endif
>=20
> That's a lot of code duplication. Could we use some macro, in the same sp=
irit as what is done in=20
> arch/powerpc/include/asm/io.h for in_be16(), in_be32(), in_be64() and fri=
ends ?

For now I don't get too fancy. It's a bit ugly but I'm working through a=20
generic atomics conversion patch and trying to also work out a nice form
for larx/stcx operation generation macros, I'll look at tidying up this
some time after then.

Thanks,
Nick

