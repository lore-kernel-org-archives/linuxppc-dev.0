Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2E1C48BF6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Feb 2024 22:58:04 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FeUQA2v9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tm67t6hhLz3vdb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2024 09:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FeUQA2v9;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tm6714Pbqz3brL
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2024 09:57:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709247437;
	bh=itYBaBippbMWC/C0xJlt/4GyP66AD1FY1F2a8aBFV68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FeUQA2v9Llhv5GuB0CFNiiB3Uk3FQwaNrcHS5NEQ4iiAo18X5w4BcWhuQEkxmVxim
	 M6UBKG/amHEo1ZZzSkcITLj5SjSioqwuOk1pLLgsu7E4lGjfM6ipz8J98e0ncRS8TD
	 S+SybN3BdejymxTdmjDurXam1CoOUugd68OeXmXmDTwEA20GGz2yCU5S8GnPSWLATE
	 X/n8leB89BUuMs6IaVOh11KkJhryfOv4gJE6W4DTgzYdMUZCBqtMZpL3P49TOFVC65
	 Jr9+q6EzX1ehXaOT32NxzNHxjqAEo9rNNc0QZu8V7NC0lsoLPDAPD18ntDI4efms0p
	 SgSg+UBRSj2DQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm67130jdz4wcb;
	Fri,  1 Mar 2024 09:57:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sachin Sant
 <sachinp@linux.ibm.com>
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
In-Reply-To: <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
 <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
Date: Fri, 01 Mar 2024 09:57:17 +1100
Message-ID: <87le72g9pu.fsf@mail.lhotse>
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
Cc: tanzhasanwork@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Sachin Sant <sachinp@linux.ibm.co=
m> wrote:
>>
>> Powerpc specific selftests (specifically powerpc/primitives) included in=
 linux-next
>> tree fails to build with following error
>>
>> gcc -std=3Dgnu99 -O2 -Wall -Werror -DGIT_VERSION=3D'"next-20240229-0-gf3=
03a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerp=
c/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primit=
ives    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/t=
ools/testing/selftests/powerpc/primitives/load_unaligned_zeropad
>> In file included from load_unaligned_zeropad.c:26:
>> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or dire=
ctory
>>     7 | #include <linux/bitops.h>
>>       |          ^~~~~~~~~~~~~~~~
>> compilation terminated.
>>
>> The header file in question was last changed by following commit
>>
>> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>>     kernel.h: removed REPEAT_BYTE from kernel.h
>
> Thanks for the report.
> What is missing here are the steps to reproduce it here. E.g., I have
> an x86_64 machine, I can use QEMU if required.

The patch I just posted should fix it.

Cross building the selftests is not too hard, you need a cross toolchain
with libc. There's some instructions on our wiki[1], the tldr is:

  cd ~/tmp
  wget https://toolchains.bootlin.com/downloads/releases/toolchains/powerpc=
64le-power8/tarballs/powerpc64le-power8--glibc--stable-2023.11-1.tar.bz2
  tar -xf powerpc64le-power8--glibc--stable-2023.11-1.tar.bz2
  export CROSS_COMPILE=3D$PWD/powerpc64le-power8--glibc--stable-2023.11-1/b=
in/powerpc64le-linux-
  cd ~/src/linux
  export ARCH=3Dpowerpc
  make defconfig
  make headers
  make -C tools/testing/selftests/powerpc

cheers

1: https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels
