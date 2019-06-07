Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6E6C28CC3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 06:36:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBE7208C0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 06:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvG7A/8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBE7208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Kt8R47YkzDqw9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 16:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvG7A/8R"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Kt5F5lQBzDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 16:33:21 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id g9so426861plm.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jun 2019 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=FMq1+yhjaa4/6JYRj7g9m3mzV5lNsGwmEBtT8uI58tI=;
 b=gvG7A/8RseiB3lbU57nEd4ug7kBcV7GGqvz/oV155Z6bmsLUyvViGSousf2P7TCtFF
 cDGEACAEe+nf7WsQC7vLDn9THKH1RjlD4NpnX9B9r1h1QpYuRfHTlWHDTE4H8N0K4jxB
 2apjaa5FImCGk9NdLLEYv/RZMmXMAgCL7jnYAgPzDG3+H+ABVVYdOh03AOpxLQu+zCo2
 e/HF1GZAAW6zonmdADfkjMPPyGX85ti8Y2SvdmL2p76gtBNgrFxPW7IlkGqhQCgrS2Kw
 6xbHyGjnOMTYk6pB+G66JltJmQWVtC9MEDbUFReYO5g2mBf8r+/IzUboM/thXbaAitug
 7jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=FMq1+yhjaa4/6JYRj7g9m3mzV5lNsGwmEBtT8uI58tI=;
 b=QrxZXtbRHnKs2iUeSQ4r4OrkWnxbUMe3Xdzzr4XOT02ypjt9d1+q47YIgJatGgYMSp
 XRQ6kcwVzxnbJgEpL+ZI8GbVQ8Ck1FVkz4y1CxHgsVtBHV5vj4ht2M+tivNR8LU7zu63
 73bDkiYpk09EEGMYifJq9cWDKyXUA0r5fNU/BRQrIIvxtR+XJaST6a0BxjudgYN4ktoC
 g+PW5ofad4J3sgvdtKiifpCRZnZMcfZbosvvTo/YlC9SKK+yHF6PosTypvI54Hntud2C
 0gaTcxT36aSaboFo1bC6K3PBSfI1hOmMkZUxul2npqxFTi089TRJfXnbJkq4+Tilqwsk
 bI5g==
X-Gm-Message-State: APjAAAVZnq13GjUcExC/hnKS8RUFy1A1xluPn5Sk696xUfQ4HttIhcqB
 qXAvVr2tW/VlpcElYhke2OM=
X-Google-Smtp-Source: APXvYqxibB5VeXMQ4uKwvZ62GDzXmqUcFvMCDp/sFAnv/wvUMxTJU3tA8rSwcfuxgx/qlhFak7YQAQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id
 d8mr46668889plr.73.1559889197930; 
 Thu, 06 Jun 2019 23:33:17 -0700 (PDT)
Received: from localhost ([202.125.30.143])
 by smtp.gmail.com with ESMTPSA id g8sm1072895pgd.29.2019.06.06.23.33.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 06 Jun 2019 23:33:17 -0700 (PDT)
Date: Fri, 07 Jun 2019 16:31:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: __find_linux_pte synchronization vs
 pmdp_invalidate
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
References: <20190607035636.5446-1-npiggin@gmail.com>
 <20190607035636.5446-2-npiggin@gmail.com>
 <46295970-4740-5648-efb4-513ab6a5c1c0@c-s.fr>
In-Reply-To: <46295970-4740-5648-efb4-513ab6a5c1c0@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559889014.vrn7eh65ke.astroid@bobo.none>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy's on June 7, 2019 3:35 pm:
>=20
>=20
> Le 07/06/2019 =C3=A0 05:56, Nicholas Piggin a =C3=A9crit=C2=A0:
>> The change to pmdp_invalidate to mark the pmd with _PAGE_INVALID broke
>> the synchronisation against lock free lookups, __find_linux_pte's
>> pmd_none check no longer returns true for such cases.
>>=20
>> Fix this by adding a check for this condition as well.
>>=20
>> Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _=
PAGE_PRESENT bit")
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/mm/pgtable.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index db4a6253df92..533fc6fa6726 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -372,13 +372,25 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned lon=
g ea,
>>   	pdshift =3D PMD_SHIFT;
>>   	pmdp =3D pmd_offset(&pud, ea);
>>   	pmd  =3D READ_ONCE(*pmdp);
>> +
>>   	/*
>> -	 * A hugepage collapse is captured by pmd_none, because
>> -	 * it mark the pmd none and do a hpte invalidate.
>> +	 * A hugepage collapse is captured by this condition, see
>> +	 * pmdp_collapse_flush.
>>   	 */
>>   	if (pmd_none(pmd))
>>   		return NULL;
>>  =20
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +	/*
>> +	 * A hugepage split is captured by this condition, see
>> +	 * pmdp_invalidate.
>> +	 *
>> +	 * Huge page modification can be caught here too.
>> +	 */
>> +	if (pmd_is_serializing(pmd))
>> +		return NULL;
>> +#endif
>> +
>=20
> Could get rid of that #ifdef by adding the following in book3s32 and=20
> nohash pgtable.h:
>=20
> static inline bool pmd_is_serializing()  { return false; }

I don't mind either way. If it's an isolated case like this, sometimes=20
I'm against polluting the sub arch code with it.

It's up to you I can change that if you prefer.

Thanks,
Nick

=
