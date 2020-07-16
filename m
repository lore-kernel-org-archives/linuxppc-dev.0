Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E2C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 00:59:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC4120775
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 00:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXuNLNNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC4120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6bVY3s6szDqpB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 10:59:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QXuNLNNc; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6bRd2DWyzDqlZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 10:56:29 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id z2so5069449wrp.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=2yXBU/Ro8tt3BMItLRDJ51kVPVxKauTptO3mkGGJBA4=;
 b=QXuNLNNcbcHCJVKlyt3ec4nFlNxed6bkOpNVCbyGT7xIP/sLLVIq/KuURownPgDMTQ
 nWneOJp811fwyZzhgR59lFbINHKxJvwRO5kJAHWGu4d4tPzdlVW+zfuyjml5SeO8Vpr3
 SN6hivQ4UCDd7mP/awJtIju0u7uxAzwEEoukb+GSkrK3oP1pCAe0b+vS0zdbdjNnwnoW
 zds/+Gc02beJQZ9G7VsVHIjIBeaI8bpGCDgEopzpyIeokcz/rIIs2HCOai38BHq9pI65
 vDqqSj35soma+l7UX0Gr/L7+B78RU0InawD/iglXDWrW6dk1M6BUlQ1x5VXekLrMvdp5
 9AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=2yXBU/Ro8tt3BMItLRDJ51kVPVxKauTptO3mkGGJBA4=;
 b=O/1kQShUY2BLY9cIt/uTYjAMyhu1NNGDyULrdp1KBQ3RRNkA9uidVrsIhk1qjA8HRL
 TtqscFyiaytLwstBtmYdu+K0Upkeie39WFsIs4g9qcIdhhP2VzDw4CR4CSqEDyyxuMg0
 cmJG3H+K8h4KTLixAFCkxgS+2AL+3zd16yByIBWZ1XcvtmP9jh/UO2lh2FIiBCl/0fIM
 sjtswExgH7GrAltj4Ra0GoxusCgkYaX4TybkzydiZsxsEaOPrAkgKe3YM/OhHFoWAgyV
 sNE1zb62DMjuhxugAwknIb179gR1Vsbas98XHi48UYDzphTW/R52J6fNzYakxrk0r0ag
 Aoqg==
X-Gm-Message-State: AOAM531KZdld1VZ7rxG8rqKlNlnpZ3Ck+B41X540aSh0OGT/4RRJAS5J
 1F3Np8ucSWaQJ9zmXt4sIYU=
X-Google-Smtp-Source: ABdhPJx06UjsWIdLtjR7AmKB7TrwI2JGoDMROl1S5T12YFHnWm6rbD6Kaz05BiLjXNc4lP2OXQ5Dmw==
X-Received: by 2002:a5d:63ce:: with SMTP id c14mr2411824wrw.254.1594860983680; 
 Wed, 15 Jul 2020 17:56:23 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
 by smtp.gmail.com with ESMTPSA id n14sm5774398wro.81.2020.07.15.17.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 17:56:23 -0700 (PDT)
Date: Thu, 16 Jul 2020 10:56:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To: Andreas Schwab <schwab@linux-m68k.org>
References: <20200715094829.252208-1-npiggin@gmail.com>
 <87zh816qgv.fsf@igel.home>
In-Reply-To: <87zh816qgv.fsf@igel.home>
MIME-Version: 1.0
Message-Id: <1594860957.3hoocg9gu6.astroid@bobo.none>
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
Cc: linux-arch@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Andreas Schwab's message of July 15, 2020 8:08 pm:
> On Jul 15 2020, Nicholas Piggin wrote:
>=20
>> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/inc=
lude/asm/exception-64e.h
>> index 54a98ef7d7fe..071d7ccb830f 100644
>> --- a/arch/powerpc/include/asm/exception-64e.h
>> +++ b/arch/powerpc/include/asm/exception-64e.h
>> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>>  	ori	r3,r3,vector_offset@l;		\
>>  	mtspr	SPRN_IVOR##vector_number,r3;
>> -
>> +/*
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without addi=
tional
>> + * additional synchronisation instructions.
>=20
> s/additonal//

Will fix in a respin.

Thanks,
Nick
