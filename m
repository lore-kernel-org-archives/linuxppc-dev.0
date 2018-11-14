Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11357C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 01:00:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D622089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 01:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D622089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vmQ21rm9zF3FB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 12:00:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vmN02tYvzF3M5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 11:58:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42vmN000Mfz9s7h;
 Wed, 14 Nov 2018 11:58:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: It looks like that wild_bctr on powerpc/fixes is still not
 compiling
In-Reply-To: <4dddbc2a-fc3f-5ea5-54be-8e2a5375db76@linux.vnet.ibm.com>
References: <4dddbc2a-fc3f-5ea5-54be-8e2a5375db76@linux.vnet.ibm.com>
Date: Wed, 14 Nov 2018 11:58:53 +1100
Message-ID: <87o9asv5iq.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Gromero ;)

Gustavo Romero <gromero@linux.vnet.ibm.com> writes:
> Hi mpe,
>
> Even after the latest fix for the wild_bctr selftest I'm still getting the
> following compilation (actually, an assembling error) because UL is not
> understood by the assembler:
>
> BUILD_TARGET=/home/gromero/git/linux/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
> make[1]: Entering directory '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm'
> gcc -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"v4.20-rc1-8-g2c7645b"' -I/home/gromero/git/linux/tools/testing/selftests/powerpc/include  -m64    wild_bctr.c ../harness.c  -o /home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr
> /tmp/cctUajlx.s: Assembler messages:
> /tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
> /tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
...
> /tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
> /tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
> ../../lib.mk:152: recipe for target '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr' failed
> make[1]: *** [/home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr] Error 1
> make[1]: Target 'all' not remade because of errors.
> make[1]: Leaving directory '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm'
> Makefile:39: recipe for target 'mm' failed
> make: *** [mm] Error 2
>
> For:
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git (powerpc/fixes)
> $ git describe
> v4.20-rc1-8-g2c7645b
>
> This is gcc:
> $ gcc --version
> gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>
> but it should not make a difference, so  I'm wondering if anybody else is
> getting the same error too...

It seems to make a difference :)

I've been building with Ubuntu 7.3.0-27ubuntu1~18.04 and it builds just fine.

It looks like binutils 2.27 doesn't accept ULL but binutils 2.28 does.
 
Ah yep, here:

  https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=86b80085c889cd388fa677a5ae9053fd4be3776c

> The following trivial workaround can solve it by forcing a type promotion on
> the compiler side whilst leaving the macro taken into the asm code without
> the UL string:
>
> diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
> index 90469a9..d2772f4 100644
> --- a/tools/testing/selftests/powerpc/mm/wild_bctr.c
> +++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
> @@ -47,8 +47,9 @@ static int ok(void)
>          return 0;
>   }
>   
> -#define REG_POISON     0x5a5aUL
> -#define POISONED_REG(n)        ((REG_POISON << 48) | ((n) << 32) | (REG_POISON << 16) | (n))
> +#define REG_POISON     0x5a5a
> +#define POISONED_REG(n)        (((REG_POISON+0UL) << 48) | ((n) << 32) | ((REG_POISON+0UL) << 16) | (n))
>   
>   static inline void poison_regs(void)
>   {
>
>
> Should I contribute such a fix?

Yes thanks.

cheers
