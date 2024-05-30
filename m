Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B316C25B7E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2024 03:06:48 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FlBbOh4Y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VqWGs338Vz7BSP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2024 13:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FlBbOh4Y;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VqWG10CPKz79N2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2024 13:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717038022;
	bh=iylmbElts6rbIaBJgVgvReqoNsA+FU35YPufgnhE8Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FlBbOh4Y78Fxlvp6m2kkxiz/CGCkxiwvegkQt2vP5IJIo8Pj16HZ5Oyjk250J2gA7
	 rSnu65YAx6Mw7YfRUCfLyZZV/HiYlFCnZyBYcuRJYXu8gfDlGdwD7QuXITo0Q2A6xg
	 ZHXCgnNmLl7FEDescz8psPJssk++rS1a09TjCNcCuMwc5tFOLkafLlCTEVW2yBSQkt
	 khQ4Ks+Fkvv6XxK7NDUKchc191iBZp2yB80gsSE9/xZu4qa1XMU70yqZjTLwMG9V2b
	 yanBof6OB4Pq58aEtehNgtLAgl0R6/jQohS18NpmozlnQF/9oKWeMOlVuuplCKozfh
	 NOJGnhBmx5UfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VqWFy33wKz4wqK;
	Thu, 30 May 2024 13:00:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/overlayfs: Fix build error on ppc64
In-Reply-To: <3f3a70ba-40d2-4624-b8c5-7c3ae2a025fb@linuxfoundation.org>
References: <20240521022616.45240-1-mpe@ellerman.id.au>
 <3f3a70ba-40d2-4624-b8c5-7c3ae2a025fb@linuxfoundation.org>
Date: Thu, 30 May 2024 13:00:20 +1000
Message-ID: <878qzs3sxn.fsf@mail.lhotse>
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
Cc: shuah <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 5/20/24 20:26, Michael Ellerman wrote:
>> Fix build error on ppc64:
>>    dev_in_maps.c: In function =E2=80=98get_file_dev_and_inode=E2=80=99:
>>    dev_in_maps.c:60:59: error: format =E2=80=98%llu=E2=80=99 expects arg=
ument of type
>>    =E2=80=98long long unsigned int *=E2=80=99, but argument 7 has type =
=E2=80=98__u64 *=E2=80=99 {aka =E2=80=98long
>>    unsigned int *=E2=80=99} [-Werror=3Dformat=3D]
>>=20
>> By switching to unsigned long long for u64 for ppc64 builds.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c=
 b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> index 759f86e7d263..2862aae58b79 100644
>> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #define _GNU_SOURCE
>> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>>=20=20=20
>>   #include <inttypes.h>
>>   #include <unistd.h>
>
> Applied to linux-kselftest fixes for the next rc.

Thanks.

> Michael, If you want to take this through, let me know, I can drop this.

I'm happy for you to take this one and the others.

cheers
