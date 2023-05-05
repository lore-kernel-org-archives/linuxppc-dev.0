Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE98C77B75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 May 2023 12:22:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QCVDf2VBtz3fJj
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 May 2023 22:22:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CmV1kkBU;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QCVCh6CT9z3c9s
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2023 22:21:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CmV1kkBU;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QCVCc12ytz4x3k;
	Fri,  5 May 2023 22:21:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1683289276;
	bh=42mSeZ5RJes33EWFCs3qopc/X9jfm5CfBgAsBcAfbCQ=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=CmV1kkBUWLzbUkFmIX1zaXUQVNPqmXCCnLEqr98fZ4KIl8bMzTh+UcdD5dUXF90ro
	 6p8CsUE15YpVeb2FeBQGplNbvhykatokDaQYgQAUAbkesL43busv2ON3qqJx1/izov
	 UP6FL4Rcy6m29TLmKzcq/bueAsczJFehRqJknnZYdbf6cBTVI1tXJ4OJegR3rOmFvn
	 AA7KSha6opDnKPMqka6GlXl5sCE+W0X2URyGWWtL46OucD2D1EWmpno2P27WeZ2CO7
	 q+pC3FbgBYrmvUqXMXaHQoZduZsx6xdtueQkQ9+sPYwiT4JvLIKNB0vYAhVRYMEa38
	 +xEQJbANJOprw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 0/4] powerpc/64: ELFv2 conversion
In-Reply-To: <6d0609ae-e31b-8530-7509-7861b07d66c7@csgroup.eu>
References: <20230505071850.228734-1-npiggin@gmail.com>
 <6d0609ae-e31b-8530-7509-7861b07d66c7@csgroup.eu>
Date: Fri, 05 May 2023 22:21:15 +1000
Message-ID: <87wn1n55qc.fsf@mail.lhotse>
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 05/05/2023 =C3=A0 09:18, Nicholas Piggin a =C3=A9crit=C2=A0:
>> This series has the steps to remove ELFv1 from the kernel build.
>> Patch 1 is a build fix, 2 defaults everything to ELFv2, 3 is
>> really a separate issue that concerns userspace. 4 removes v1
>> support.
>
> I see CONFIG_MPROFILE_KERNEL is restricted to LITTLE_ENDIAN. Is that=20
> correct ? Don't we have mprofile_kernel as well on BIG ENDIAN once=20
> switched to ABI v2 ? If so, can we drop the -pg based profiling=20
> completely, or is CLANG still not supporting mprofile_kernel ?

Clang does not support -mprofile-kernel.

AIUI they would like us to switch to -fpatchable-function-entry which
could then be supported on GCC & clang.

That would be a nice cleanup but also a bunch of work that no one has
found time to do.

https://github.com/linuxppc/issues/issues/447
https://github.com/llvm/llvm-project/issues/57031


So for now we need to keep the -pg based version.

cheers
