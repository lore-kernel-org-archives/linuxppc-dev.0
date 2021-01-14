Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 03:50:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1C023787
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 03:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1C023787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGVhb6gLyzDsMm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 14:50:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630;
 helo=mail-pl1-x630.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=B6pTRb74; dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGVfg5rHtzDqlm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 14:48:59 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id r4so2227249pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=GcMC/wDYasiak0391aBsjcU+97ddVCpASa8KLxdsPf0=;
 b=B6pTRb74qc74gyqq2usfOYLfONVVbfYdfVIi6gSiYX8umZK/fHKugIrLwPEaLbKt4s
 lCnfUMaqqOKo3Lf+6OAIp5rxABWNG1akKnOlxS7Ihxy1HAjjvrnU0cIRtToJi+i3w/zX
 Obi//HCfoMHSihjvR0KQj+Vrs+SlGgt6KTEyk1ALwMOAWH4pOT4khR7U+2xPz1WsuuuL
 hHezXZ+NBXV/TxaALEOsJl8J1AJkhymhzE8+35IvfVIIxFm/aJvU35B1XfKTHQvNC3EX
 v7fxkrZLof8xqe2ENH4q73wtrPOl6cclny+1gCrkk1zfABwXh22rdekOL+BMm+S+VQ9x
 jv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=GcMC/wDYasiak0391aBsjcU+97ddVCpASa8KLxdsPf0=;
 b=J64wvjInC4/sqixNd9izPbVYY6mbOKTwBRljSeDGy2Ldj/WMSVRPz7jZuKN6kHdT72
 L9kMkx/W6mrmWrSOkWk7OjMxZ/LJkxx1huZjjGJl/eMsIvCZxZz2cnjsEEMTbZKk/OpG
 rt6cnffBpY7IEnB6SaDy1JKvlaBH4FSTqGy/gyZQ6xuF9hts2kJvIvMtXnzArOzWBoUx
 IM8qebhNblHJ7bIDUlkwOR2Vsr6UT+bs3FXHfQ36SR6pXK/bBr1LgLi7jhzY+JP+qwfi
 8ttafeTEaxN1G2ucEyuSGw7uZLl2IPyqe3oEZHhDqZcLutqvZEe5RDwdnUXq5HECt1NC
 m3cg==
X-Gm-Message-State: AOAM532H8NBKlgm+2Y4t5TNxezvJyx9MzttKoo8yIF/5del56nNXmrm3
 nmrFltJ0D37mWz+SY4zEozYnYXut/e9BzQ==
X-Google-Smtp-Source: ABdhPJydFgjGn2k84NJBQLh8AX5EonIvv4+6DGNM6lSBV31A+az9RIFuwOz3aantGD8QVZ+FwzG7tg==
X-Received: by 2002:a17:90a:f683:: with SMTP id
 cl3mr2845168pjb.136.1610596135977; 
 Wed, 13 Jan 2021 19:48:55 -0800 (PST)
Received: from localhost ([1.132.231.248])
 by smtp.gmail.com with ESMTPSA id t8sm4449989pjd.51.2021.01.13.19.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 19:48:55 -0800 (PST)
Date: Thu, 14 Jan 2021 13:48:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 09/21] powerpc/64: context tracking remove _TIF_NOHZ
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210113073215.516986-1-npiggin@gmail.com>
 <20210113073215.516986-10-npiggin@gmail.com>
 <6527f4ec-2011-75b3-1db2-ec6d9b120dd9@csgroup.eu>
In-Reply-To: <6527f4ec-2011-75b3-1db2-ec6d9b120dd9@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1610595756.inx7moy5ns.astroid@bobo.none>
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

Excerpts from Christophe Leroy's message of January 14, 2021 12:50 am:
>=20
>=20
> Le 13/01/2021 =C3=A0 08:32, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Add context tracking to the system call handler explicitly, and remove
>> _TIF_NOHZ.
>>=20
>> This saves 35 cycles on gettid system call cost on POWER9 with a
>> CONFIG_NOHZ_FULL kernel.
>=20
> 35 cycles among 100 cycles, or among 5000 cycles ? I meant what pourcenta=
ge to you win ?

I can re-check when I update and retest. On the order of about 500
IIRC, so quite significant proportion of the cost.

Thanks,
Nick
