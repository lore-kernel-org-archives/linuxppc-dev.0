Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C3C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 04:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013AE6101A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 04:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013AE6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9r0t3PS8z30Gt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=otEeA36C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=otEeA36C; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9r0Q1KMcz2yxw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 15:33:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F9r0G3VJcz9sRf;
 Thu,  1 Apr 2021 15:33:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617251598;
 bh=wRu7ThPbLuUkFDWwkgb0lsalLwoPfWRY58ouNkBsX0k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=otEeA36Cj4+17EP9f4va3/Da3w2s4/MBh3E+sEeaAjmqK/wDQ2NKFiVj2YcnQyssI
 krtHRDfMK7qlU7lc5iwBxlq+/m1Lod9pwkzGfqsQg1+b/2I/3ndJSFANLyCYs7vwan
 dh/pbRIKTW65MyvCy5TFas6Rsj2eVCozF7K9xDZCcygyBODCoZH5dtR4tLiQhgiGi5
 5lrULe3tjOuZqGSXHXxmZjl+pweunu5GHqj9nh48a7c0h7U90FB6aMj4nDWzv7eBQA
 krbqyZD15xzUAr0PGTjVa86Lf0K1TVGAJ7+cwKgMCb/7x3Z4DlztvbwN2SqgdZDQK5
 SaOh6et7BcUUQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/8xx: Load modules closer to kernel text
In-Reply-To: <e50f8127-3a87-92eb-d88a-72aa1557ffe7@csgroup.eu>
References: <db20abbecb129c49d3c663de67dac6a87501ac0b.1617001615.git.christophe.leroy@csgroup.eu>
 <87czvf788t.fsf@mpe.ellerman.id.au>
 <e50f8127-3a87-92eb-d88a-72aa1557ffe7@csgroup.eu>
Date: Thu, 01 Apr 2021 15:33:13 +1100
Message-ID: <87ft0a1v5i.fsf@mpe.ellerman.id.au>
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
Cc: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 31/03/2021 =C3=A0 15:39, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> On the 8xx, TASK_SIZE is 0x80000000. The space between TASK_SIZE and
>>> PAGE_OFFSET is not used.
>>>
>>> Use it to load modules in order to minimise the distance between
>>> kernel text and modules and avoid trampolines in modules to access
>>> kernel functions or other module functions.
>>>
>>> Define a 16Mbytes area for modules, that's more than enough.
>>=20
>> 16MB seems kind of small.
>>=20
>> At least on 64-bit we could potentially have hundreds of MBs of modules.
>>=20
>
> Well, with a 16 MB kernel and 16 MB modules, my board is full :)

Heh.

> Even on the more recent board that has 128 MB, I don't expect more than a=
 few MBs of modules in=20
> addition to the kernel which is approx 8M.
>
> But ok, I'll do something more generic, though it will conflict with Jord=
an's series.

Don't feel you have to. You're the expert on 8xx, not me.

cheers
