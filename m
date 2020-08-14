Return-Path: <SRS0=ETne=BY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD66C204EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Re/QT7l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD66C204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BSkHB4CJ2zDqn4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 23:07:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BSkCl2L8jzDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2020 23:04:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Re/QT7l9; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BSkCk62srz9sTX; Fri, 14 Aug 2020 23:04:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSkCk3f7Jz9sTH;
 Fri, 14 Aug 2020 23:04:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597410242;
 bh=F69dGnWaBlj+wL4ncm6g5az+o/dHoITJxi+nIAhoGbw=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=Re/QT7l9ZTjUlWVaoftXq2GqEnabaGKuvY2o35pZhGVTya9/NE7kL+rd3RX0JxnCq
 41hYHDnU2ItdJth6XYZG/1DjR5z+Rm5upY/VDUS0RC6TTFKNSTp3Ia0RUU0Zf4tZQl
 t5/zAwdw1dhs4aYi0rpXbfsd5I4D6rnd+U0hLx0pDwdIt9AhaAFMqjOXCgA90jq+kw
 6tUNAldmZ7RajLI0YGArM/T1i9GAB2V3eUnsJTC7vwzZsNIQeaaWv1QNmXXyseASI7
 XKHVpzBCi/TIhn9affMjVzYbGd8kGMN5GlTwgA0Nr/PA4oJPv9Ny30NyXVbVE2/z6y
 4fXwCWboNwq4w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] powerpc: Introduce asm-prototypes.h
In-Reply-To: <b50b9bdd-b731-44ed-435b-e3e4b179a89a@csgroup.eu>
References: <1463534212-4879-1-git-send-email-dja@axtens.net>
 <1463534212-4879-2-git-send-email-dja@axtens.net>
 <b50b9bdd-b731-44ed-435b-e3e4b179a89a@csgroup.eu>
Date: Fri, 14 Aug 2020 23:04:01 +1000
Message-ID: <87d03t9y66.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 18/05/2016 =C3=A0 03:16, Daniel Axtens a =C3=A9crit=C2=A0:
>> Sparse picked up a number of functions that are implemented in C and
>> then only referred to in asm code.
>>=20
>> This introduces asm-prototypes.h, which provides a place for
>> prototypes of these functions.
>
> It looks like this is a mis-use of asm-prototypes.h
>
> On other architectures, asm-prototypes.h is there to allow MODVERSION to=
=20
> sent versions for exported assembly functions (I checked history of that=
=20
> file in x86 and arm64).

Look closer :)

42f5b4cacd78 ("powerpc: Introduce asm-prototypes.h") (Jun 2016)
334bb7738764 ("x86/kbuild: enable modversions for symbols exported from asm=
") (Dec 2016)
c3296a1391cb ("arm64: add <asm/asm-prototypes.h>") (Dec 2018)

> It looks like you have used it on the other way round, you have declared=
=20
> in it C functions used by ASM functions, whereas it is supposed to be=20
> dedicated to declaring exported ASM functions used by C functions.

But yes, it's since been co-opted for the modversions stuff.

I guess the contents should be split out into appropriate headers
depending on what the prototypes are for.

chers
