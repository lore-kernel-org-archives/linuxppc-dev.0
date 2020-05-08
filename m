Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_GREY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6787C35280
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 03:31:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1468E2085B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 03:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fqUtXKhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1468E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JG8J67wdzDqtZ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 13:31:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JG5z0HbJzDqsX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 13:29:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=fqUtXKhr; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49JG5y2PbRz9sRY;
 Fri,  8 May 2020 13:29:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588908566;
 bh=XDybYTLhEyfcQ5Ul1H/c8Jh69Px4gSCQF03KL1ZrcQ8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fqUtXKhrnwDQEHXRyDVPnbvEltA8stfBQPi+lMN4WTXr1hJwcNHkBsaSnsn+aos34
 I67kwdi6dQ6hIKLTx1Z+/9SZpjETnAQdowTHPQY/BPDH44/f0HQNrdf/fxo+PzIDyP
 SHiVaRyoCZra4U0+GgxgdQ5JjNfQ4SxamUATQf6FIU/hqVUAZiJOAWIFgNJRwcEhMh
 31BN+KyJtk7oc+3E6i5gfduQE76sVBL3/JQ7kuwAqg8nHmrtUx+FkxC2bOk478XIS5
 o+AVdqQY3xCfQcJQGSEkinI0Bi8STX3FsNqR/wkDdUuD3+GF474UiQJguKLd2Y6cRq
 snC7GrURum96Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Fwd: [CRON] Broken: ClangBuiltLinux/continuous-integration#1432
 (master - 0aceafc)
In-Reply-To: <CAKwvOdmendjEgurRBAyi4R0rDZRdwfHjddS_pfOQ6761XiiFMA@mail.gmail.com>
References: <ClangBuiltLinux/continuous-integration+164415390+broken@travis-ci.com>
 <5eb43a0c8d43d_13fb5db924ca0104770@travis-pro-tasks-6cc9887df6-4zmjd.mail>
 <CAKwvOdmendjEgurRBAyi4R0rDZRdwfHjddS_pfOQ6761XiiFMA@mail.gmail.com>
Date: Fri, 08 May 2020 13:29:45 +1000
Message-ID: <87d07fcdee.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nick Desaulniers <ndesaulniers@google.com> writes:
> Looks like ppc64le powernv_defconfig is suddenly failing the locking
> torture tests, then locks up?
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/=
329211572#L3111-L3167
> Any recent changes related here in -next?  I believe this is the first
> failure, so I'll report back if we see this again.

Thanks for the report.

There's nothing newly in next-20200507 that seems related.

Odd that it just showed up.

cheers


> ---------- Forwarded message ---------
> From: Travis CI <builds@travis-ci.com>
> Date: Thu, May 7, 2020 at 9:40 AM
> Subject: [CRON] Broken: ClangBuiltLinux/continuous-integration#1432 (mast=
er
> - 0aceafc)
> To: <ndesaulniers@google.com>, <natechancellor@gmail.com>
>
>
> ClangBuiltLinux
>
> /
>
> continuous-integration
> <https://travis-ci.com/github/ClangBuiltLinux/continuous-integration?utm_=
medium=3Dnotification&utm_source=3Demail>
>
> [image: branch icon]master
> <https://github.com/ClangBuiltLinux/continuous-integration/tree/master>
> [image: build has failed]
> Build #1432 was broken
> <https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/buil=
ds/164415390?utm_medium=3Dnotification&utm_source=3Demail>
> [image: arrow to build time]
> [image: clock icon]7 hrs, 0 mins, and 54 secs
>
> [image: Nick Desaulniers avatar]Nick Desaulniers
> 0aceafc CHANGESET =E2=86=92
> <https://github.com/ClangBuiltLinux/continuous-integration/compare/877d00=
2bdcfe6bc5cb0255c3c39192e8175e2c19...0aceafcfcca7c4a095957efae0939a612d7550=
77>
>
> Merge pull request #182 from ClangBuiltLinux/i386
>
> i386
>
> Want to know about upcoming build environment updates?
>
> Would you like to stay up-to-date with the upcoming Travis CI build
> environment updates? We set up a mailing list for you!
> SIGN UP HERE <http://eepurl.com/9OCsP>
>
> [image: book icon]
>
> Documentation <https://docs.travis-ci.com/> about Travis CI
> Have any questions? We're here to help. <support@travis-ci.com>
> Unsubscribe
> <https://travis-ci.com/account/preferences/unsubscribe?repository=3D67187=
52&utm_medium=3Dnotification&utm_source=3Demail>
> from build emails from the ClangBuiltLinux/continuous-integration
> repository.
> To unsubscribe from *all* build emails, please update your settings
> <https://travis-ci.com/account/preferences/unsubscribe?utm_medium=3Dnotif=
ication&utm_source=3Demail>.
>
> [image: black and white travis ci logo] <https://travis-ci.com>
>
> Travis CI GmbH, Rigaer Str. 8, 10427 Berlin, Germany | GF/CEO: Randy Jaco=
ps
> | Contact: contact@travis-ci.com | Amtsgericht Charlottenburg, Berlin, HRB
> 140133 B | Umsatzsteuer-ID gem=C3=A4=C3=9F =C2=A727 a Umsatzsteuergesetz:=
 DE282002648
>
>
> --=20
> Thanks,
> ~Nick Desaulniers
