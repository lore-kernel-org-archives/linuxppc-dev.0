Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A8C433E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 23:57:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093DE20658
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 23:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JeF6aey/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093DE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFKcM1S0tzF0gt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 09:57:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFKZD28jCzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 09:55:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JeF6aey/; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFKZC4Qlcz9sPf;
 Mon, 27 Jul 2020 09:55:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595807732;
 bh=Fr3vWGZnocWpaQCTPNmdNT8S3mTtioms9OXn3Tuj0w0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JeF6aey/KplqXVwH5q2jc8UG7RWEutJbIidNvpEBWFC/zXRJfnyoGoMQFcCTAZ24/
 xs7rXmhuZe4NZHjVHdqGb3EE8mso6nfwidi17u5nPLB1VXtLOfZl9iRDNPT3Q5AsGR
 Z4xIa+mKPAgM2jfKrUjI0Pj8IClbLHLEQJS+j0HXuh6OZtOXh3sWmGSsnxjPfYtZkW
 PMVjv3luwjfaC9NYo3EJPD4gpWNx4kSJaeYktmZ8UfU4FGfmmPpLjhggeNZL24quS1
 ZbDqCtjnQdMPMIaj0JyLws9TFTd/ZbLv8CwmKRPDKfynX01a7eCFI8qRxYM6cDx9Wo
 3qDKk3/nceWcA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
In-Reply-To: <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
 <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
Date: Mon, 27 Jul 2020 09:55:31 +1000
Message-ID: <87wo2pg7bg.fsf@mpe.ellerman.id.au>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Randy Dunlap <rdunlap@infradead.org> writes:
> On 7/26/20 7:29 AM, Christophe Leroy wrote:
>> Randy Dunlap <rdunlap@infradead.org> a =C3=A9crit=C2=A0:
>>=20
>>> Drop duplicated words in arch/powerpc/ header files.
>>=20
>> How did you detect them ? Do you have some script for tgat, or you just =
read all comments ?
>
> Yes, it's a script that finds lots of false positives, so I have to check
> each and every one of them for validity.
>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>=20
>> You say you Cc Michael, but in fact you don't ... Allthough he is the po=
werpc maintainer
>
> Thanks for noticing that.
> [time passes]
> I checked all of my emails for this patch series and they say that Mike w=
as Cc:ed
> on all of them.
>
> I am adding his email address back to this one.
> Mike, did you receive this patch series?

Yes.

There's a mailman option which drops me from being explicity on Cc,
because I'm subscribed to the list. Otherwise I get two copies of
everything.

So as long as it goes to linuxppc-dev I should see it, regardless of
whether I'm explicitly listed in Cc.

cheers
