Return-Path: <SRS0=/Qvz=43=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE147C10F27
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2595324686
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="myWQjj6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595324686
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48cDHP3pBszDqTN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 23:02:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48cDDn6zmTzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 23:00:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=myWQjj6o; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48cDDn5Zgvz9sRN; Tue, 10 Mar 2020 23:00:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48cDDm2kHrz9sQx;
 Tue, 10 Mar 2020 23:00:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1583841624;
 bh=IOL1pQ8k+h2icJ3+rdfKQ0FCcEAuFYRuFoHqHy9IlP4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=myWQjj6ou9M/rx0t6WppLArlcp+X62GAuWKKpOnbPPnrled0bjPkm6keJHrkThfrs
 MVIJ4XU8hsmpo3lYwjj6XaEof4a9dw1MBHyRZSaU2Qp6WdLSb1pmkhhFNplYT84goq
 SFkv3VIkrG/i5lUUzC1D7USo4Jo2Trweix6nchWDVLKq4deu8xSR67RbIcABnaO6ud
 oNqCvaogrZu90PPuuv234bt05tO35Y1lIKl+rWny0zdlvXHbIhJat1rgNkICdZoeT6
 0YM/z3sDxJl1dxyqJsT2ZxVH7hCK0kjQ/GWh8wsvi+jD+f43M/iEnqOonRX6n2Cfty
 2fYA1ZVIjRcbQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/Makefile: Mark phony targets as PHONY
In-Reply-To: <CAK7LNAQfREwzk4NwE5PzxOXGLcsk2BtjYNKvKx8g4_vxHmNHdw@mail.gmail.com>
References: <20200219000434.15872-1-mpe@ellerman.id.au>
 <48YT3Y2QBsz9sSs@ozlabs.org>
 <CAK7LNAQfREwzk4NwE5PzxOXGLcsk2BtjYNKvKx8g4_vxHmNHdw@mail.gmail.com>
Date: Tue, 10 Mar 2020 23:00:21 +1100
Message-ID: <87r1y0ifmy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@ozlabs.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Fri, Mar 6, 2020 at 9:27 AM Michael Ellerman
> <patch-notifications@ellerman.id.au> wrote:
>>
>> On Wed, 2020-02-19 at 00:04:34 UTC, Michael Ellerman wrote:
>> > Some of our phony targets are not marked as such. This can lead to
>> > confusing errors, eg:
>> >
>> >   $ make clean
>> >   $ touch install
>> >   $ make install
>> >   make: 'install' is up to date.
>> >   $
>> >
>> > Fix it by adding them to the PHONY variable which is marked phony in
>> > the top-level Makefile, or in scripts/Makefile.build for the boot
>> > Makefile.
>> >
>> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> Applied to powerpc next.
>>
>> https://git.kernel.org/powerpc/c/d42c6d0f8d004c3661dde3c376ed637e9f292c22
>>
>
> You do not have to double your Signed-off-by.

Oops :/

My scripts don't cope with applying my own patches very well. Will try
to fix it.

cheers
