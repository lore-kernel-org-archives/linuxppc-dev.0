Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B96C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 04:46:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3906140F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 04:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3906140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GB4Fv2WwCz3c0r
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 14:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JDhyVLTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JDhyVLTa; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GB4FP4gbKz3015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 14:45:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GB4FK3w17z9sW8;
 Fri, 25 Jun 2021 14:45:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624596343;
 bh=uVkWgUgdzjG7EIytkJ0IMCXeV3RaBwOniskWOKBd278=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JDhyVLTamP1ZDt17AIQgSDO8ma1v5gjn/ofgmOOsF4J5sDyV1yWXA5F963cwK7sYM
 5IW0BtJI1sHEG8k6TSOcu7N/ZCDWUN0seVheP5ao0lJWwAGcRWbo2KOhcA2S7ji6gW
 yRSsekFuyqKXevNI3PnmcY5dKUmt+c7ukfh0BqQzwzF70U0MwZo1WJkW4Z/TGDxnnG
 S4Hq66yS0g13tjLOxcy5xXMa0TwD6t1Fp4VrGaTUH72ZeI4bAGB1YtIf++f9G0lQkw
 dAd/Qdk8IBfUvZVDV97I6670A0H1AGsl4o+7ItxnsdLMNeiayGnZCXRVjC/WAPqZo4
 fsiwrBIx9ex5w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/4] mm: pagewalk: Fix walk for hugepage tables
In-Reply-To: <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
 <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
Date: Fri, 25 Jun 2021 14:45:37 +1000
Message-ID: <874kdm1rim.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
 Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Le 19/04/2021 =C3=A0 12:47, Christophe Leroy a =C3=A9crit=C2=A0:
>> Pagewalk ignores hugepd entries and walk down the tables
>> as if it was traditionnal entries, leading to crazy result.
>>=20
>> Add walk_hugepd_range() and use it to walk hugepage tables.
>
> I see you took patch 2 and 3 of the series.

Yeah I decided those were bug fixes so could be taken separately.

> Do you expect Andrew to take patch 1 via mm tree, and then you'll take
> patch 4 once mm tree is merged ?

I didn't feel I could take patch 1 via the powerpc tree without risking
conflicts.

Andrew could take patch 1 and 4 via mm, though he might not want to pick
them up this late.

I guess step one would be to repost 1 and 4 as a new series. Either they
can go via mm, or for 5.15 I could probably take them both as long as I
pick them up early enough.

cheers
