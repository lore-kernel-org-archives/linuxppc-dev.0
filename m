Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD34C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:57:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17902064E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17902064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XNV64D1LzF3Dq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 22:57:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XNRt2lLrzF39c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 22:55:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XNRt1yxjz9s9h; Sat, 13 Oct 2018 22:55:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42XNRs6n7pz9s7h;
 Sat, 13 Oct 2018 22:55:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
 Segher Boessenkool  <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix stackprotector detection for non-glibc
 toolchains
In-Reply-To: <7e1acec1-c840-321b-0a93-99679fce6cb3@c-s.fr>
References: <20181012225832.13827-1-mpe@ellerman.id.au>
 <7e1acec1-c840-321b-0a93-99679fce6cb3@c-s.fr>
Date: Sat, 13 Oct 2018 22:55:01 +1100
Message-ID: <87k1mm12p6.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 13/10/2018 =C3=A0 00:58, Michael Ellerman a =C3=A9crit=C2=A0:
>> If GCC is not built with glibc support then we must explicitly tell it
>> which register to use for TLS mode stack protector, otherwise it will
>> error out and the cc-option check will fail.
>
> Oh ? I didn't encounter such a problem with the nolibc GCC from=20
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Yes, you're right.

  $ /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-l=
inux-gcc -o empty.o -Wall -c empty.c -mstack-protector-guard=3Dtls=20
  $ echo $?
  0

But with mine:
  $ /home/kerkins/toolchains/ppc/gcc-8-branch/powerpc-linux/bin/powerpc-lin=
ux-gcc -o empty.o -Wall -c empty.c -mstack-protector-guard=3Dtls=20
  cc1: error: =E2=80=98-mstack-protector-guard=3Dtls=E2=80=99 needs a valid=
 base register


So it's only my cross compilers that don't work.

The kernel.org ones are:
  Configured with: /home/arnd/git/gcc/configure --target=3Dpowerpc64-linux
  --enable-targets=3Dall
  --prefix=3D/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/powerpc64-linux
  --enable-languages=3Dc --without-headers --disable-bootstrap
  --disable-nls --disable-threads --disable-shared --disable-libmudflap
  --disable-libssp --disable-libgomp --disable-decimal-float
  --disable-libquadmath --disable-libatomic --disable-libcc1
  --disable-libmpx --enable-checking=3Drelease

Whereas mine is:
  Configured with: ../../src/gcc/configure
  --prefix=3D/home/kerkins/workspace/gcc-build/gcc/gcc-8-branch/target/ppc/=
build/install/powerpc-linux
  --disable-multilib --disable-bootstrap --enable-languages=3Dc
  --with-pkgversion=3D'Custom 2c79ff811dfcee1c' --target=3Dpowerpc-linux
  --enable-targets=3Dall


So I wonder if something in there is making the difference?

I guess I'll just rewrite the change log to say "some toolchains".

cheers
