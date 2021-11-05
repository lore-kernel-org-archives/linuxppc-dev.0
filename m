Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F30C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 01:29:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93BF61183
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 01:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C93BF61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HljbP3Cxyz3bW6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 12:29:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LJbj0v//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=LJbj0v//; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HljZg275Nz2xtw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Nov 2021 12:28:42 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id gt5so2036120pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Nov 2021 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=Oa7EEK6wtNCUhrKTiM/VsPfmTBtTzL+yd3pd6B53+Ks=;
 b=LJbj0v//+5mksfs5awoZVD8giZDwIhtDOuyeAxgw9WgmsBfAMnY9qLGL7IvogX8A35
 TElPfUHdZrWvMJhBS/2B1Lad6E6vZRIhRUppIhDanOCdHmrmWvW0Yon1GIo+wTBHAFOZ
 pTSGp9UmFWIXSrUi7qOl8yx8mRzUtoxGu3e34m7aIAXirV4h56WxRIDMcdpfjHSlyjz9
 elQMZE3z+Hl5W7qHfyNCt++0SEnwrj1GXbT3w5h182F+z2O1BJw9Wj+gXMmFmtPrQj03
 jNjrew+6yf3JBCSrGV4woc6Z7cqt+bi+ttcdDmlrbVJfgT3u8TR98SpelR+eJA8TPBS/
 7x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=Oa7EEK6wtNCUhrKTiM/VsPfmTBtTzL+yd3pd6B53+Ks=;
 b=f0mIIjzpijaZBbzX7Djp3ZnLMxERFdZGFD5mbNwUyYBqvZrmce8Pg9r1p4gln+9f9/
 LZp7WjDLjPS0yAjx1ukFdD8hhZEqyx6Xv9ptfo6LF7hdbKr0whzRl9WqOnMsOJJswRWQ
 N1R6SWOA6myrM3f+EbgtV7b57MbIkGL5H0QfMYUs1WQAX6xfBcTKBPVzMTWfhijYvlXU
 rpjdkk1aywb/gx8ynMZMW1Daxzff2poJgzc+dReG/cElnRLSvXRZRv9eEXgRntdFrvXs
 B43T5nMCx5qyRG+H2PyqEv7vwOFRFAerrcXtpxuzdEHteQ9U4XuvQIVs8OvpcM7dthps
 C2ZA==
X-Gm-Message-State: AOAM530T6j5Ie6F/Q3tpsvRnFGjOSMGYwbUe0jqvuG53b8T1ZCFrXti6
 7gpHVGsI1f4SbxUECWJb5PA=
X-Google-Smtp-Source: ABdhPJy1Qx6+7+0LaOC1QTHOR3zQ2TrpEtbsDThstOF8N7Naxl1H2lWciewrJQlC1U8e/Pyldvyniw==
X-Received: by 2002:a17:90a:c394:: with SMTP id
 h20mr26715071pjt.136.1636075718970; 
 Thu, 04 Nov 2021 18:28:38 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
 by smtp.gmail.com with ESMTPSA id d7sm6509468pfj.91.2021.11.04.18.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Nov 2021 18:28:38 -0700 (PDT)
Date: Fri, 05 Nov 2021 11:28:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 5/5] powerpc/watchdog: Remove backtrace print from
 unstuck message
To: Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20211104161057.1255659-1-npiggin@gmail.com>
 <20211104161057.1255659-6-npiggin@gmail.com>
 <1e50adff-1e07-23e9-807b-43f97cab2844@linux.ibm.com>
In-Reply-To: <1e50adff-1e07-23e9-807b-43f97cab2844@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1636075611.9gk4baa011.astroid@bobo.none>
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

Excerpts from Laurent Dufour's message of November 5, 2021 2:48 am:
> Le 04/11/2021 =C3=A0 17:10, Nicholas Piggin a =C3=A9crit=C2=A0:
>> The watchdog unstuck message can't be serialised with other watchdog
>> messages because that might prevent watchdog reporting. This removes
>> the big backtrace from the unstuck message, which can get mixed with
>> other messages and confuse logs, and just prints a single line.
>=20
> I'm not sure that's a good idea to remove the registers and backtrace her=
e.
> I agree that this output may interleaved (and usually it does), but it is=
 also=20
> providing some good information about the culprit block of code. Usually,=
 it's=20
> pointing the IRQ release code, and so the IRQ blocking one which are real=
ly useful.

Okay, I was thinking that be inferred from the context usually, but=20
sometimes it's not that easy which I guess is why I added it in the
first place.

> I don't have a good way to prevent trace interleaving here, but I think=20
> interleaved traces are better here than nothing.

Okay we can leave this patch off.

Thanks,
Nick
