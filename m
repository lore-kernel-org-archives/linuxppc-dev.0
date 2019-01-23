Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F1C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:49:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E7620861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="GJRrsCb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E7620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzW228L6zDqMh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:49:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzTD2lxhzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:48:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GJRrsCb7"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kzTD26hrz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:48:16 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kzTD1k8yz9s9h; Wed, 23 Jan 2019 19:48:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GJRrsCb7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43kzT96YZyz9s3q
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 19:48:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43kzT55jXWz9tykc;
 Wed, 23 Jan 2019 09:48:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=GJRrsCb7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id U1MvptXIYz5Y; Wed, 23 Jan 2019 09:48:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43kzT54WSSz9tykb;
 Wed, 23 Jan 2019 09:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548233289; bh=ZobjhE4PbE82e9dbUFIQZr7ASgaTmFfYK8kg67XzM8A=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=GJRrsCb7LowtsghdSVWqOEkdqag0lH3GsqkVr2/oxWD5b5m/YnqwFvk5bzDfXIMKA
 thI406ZiKlNZObWaK9GQa6TZIYomAV1e79jZYRF4n2qZArm6MZw5fyGW1NCmFTZiyM
 vXhi0ya/vnjX/0rAz63XRZ4caIr+RawE+3cmw/D0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A5A2D8B7F7;
 Wed, 23 Jan 2019 09:48:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LLINlZzZdoYl; Wed, 23 Jan 2019 09:48:10 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C3488B7F5;
 Wed, 23 Jan 2019 09:48:10 +0100 (CET)
Subject: Re: [PATCH 2/2] selftests/powerpc: benchmarks/context_switch.c use
 vector instructions/types
To: Cyril Bur <cyrilbur@gmail.com>
References: <1457046400-29276-1-git-send-email-cyrilbur@gmail.com>
 <1457046400-29276-2-git-send-email-cyrilbur@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bf98ab1d-a997-a994-47a5-728668f85bda@c-s.fr>
Date: Wed, 23 Jan 2019 08:47:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1457046400-29276-2-git-send-email-cyrilbur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Cyril,

On 03/03/2016 11:06 PM, Cyril Bur wrote:
> Currently it doesn't appear the resulting binary actually uses any Altivec
> or VSX instructions the solution is to explicitly tell GCC to use vector
> instructions and use vector types in the code.
> 
> Part of this this issue can be GCC version specific:
> 
> GCC 4.9.x is happy to use Altivec and VSX instructions if altivec.h is
> includedi (and possibly if vector types are used), this also means that
> 4.9.x will use VSX instructions even if only -maltivec is passed. It is
> also possible that Altivec instructions will be used even without -maltivec
> or -mabi=altivec.
> 
> GCC 5.2.x complains about the lack of -maltivec parameter if altivec.h is
> included and will not use VSX unless -mvsx is present on commandline.
> 
> GCC 5.3.0 has a regression that means __attribute__((__target__("no-vsx"))
> fails to build. A fix is targeted for 5.4.
> 
> Furthermore LTO (Link Time Optimisation) doesn't play well with
> __attribute__((__target__("no-vsx")), LTO can cause GCC to forget about the
> attribute and compile with VSX instructions regardless. Be weary when
> enabling -flfo for this test.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

This patch breaks the build on my setup:

ppc-linux-gcc -std=gnu99 -O2 -Wall -Werror 
-DGIT_VERSION='"v5.0-rc3-560-ge0ce62731d77"' 
-I/root/linux-powerpc/tools/testing/selftests/powerpc/include  -O2 
-maltivec -mvsx -mabi=altivec    context_switch.c ../harness.c 
../utils.c -lpthread -o 
/root/linux-powerpc/tools/testing/selftests/powerpc/benchmarks/context_switch
context_switch.c:1:0: error: -mvsx requires hardware floating point 
[-Werror]
  /*
  ^
cc1: all warnings being treated as errors
../harness.c:1:0: error: -mvsx requires hardware floating point [-Werror]
  /*
  ^
cc1: all warnings being treated as errors
../utils.c:1:0: error: -mvsx requires hardware floating point [-Werror]
  /*
  ^
cc1: all warnings being treated as errors
make[1]: *** 
[/root/linux-powerpc/tools/testing/selftests/powerpc/benchmarks/context_switch] 
Error 1


By removing the -mvsx option, it compiles just fine.

Is that option really required ? According to gcc doc, it is 
automatically selected when compiling for cpus that support it.

I'm using:

[root@po16846vm linux-powerpc]# ppc-linux-gcc -v
Using built-in specs.
COLLECT_GCC=ppc-linux-gcc
COLLECT_LTO_WRAPPER=/opt/cldk-1.4.0/libexec/gcc/ppc-linux/5.4.0/lto-wrapper
Target: ppc-linux
Configured with: /root/cldk/gcc-5.4.0/configure --target=ppc-linux 
--with-headers=yes --with-cpu=860 --prefix=/opt/cldk-1.4.0 
--bindir=/opt/cldk-1.4.0/bin --sbindir=/opt/cldk-1.4.0/sbin 
--libexecdir=/opt/cldk-1.4.0/libexec --datadir=/opt/cldk-1.4.0/share 
--sysconfdir=/opt/cldk-1.4.0/etc --libdir=/opt/cldk-1.4.0/lib 
--includedir=/opt/cldk-1.4.0/usr/include 
--oldincludedir=/opt/cldk-1.4.0/usr/include 
--infodir=/opt/cldk-1.4.0/share/info --mandir=/opt/cldk-1.4.0/share/man 
--with-glibc-version=2.18 --enable-languages=c,c++
Thread model: posix
gcc version 5.4.0 (GCC)


Christophe

> ---
>   tools/testing/selftests/powerpc/benchmarks/Makefile         |  1 +
>   tools/testing/selftests/powerpc/benchmarks/context_switch.c | 11 ++++++++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> index 912445f..6816fc2 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> @@ -7,6 +7,7 @@ all: $(TEST_PROGS)
>   $(TEST_PROGS): ../harness.c
>   
>   context_switch: ../utils.c
> +context_switch: CFLAGS += -maltivec -mvsx -mabi=altivec
>   context_switch: LDLIBS += -lpthread
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> index e6af382..a36883a 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> @@ -25,7 +25,9 @@
>   #include <sys/types.h>
>   #include <sys/shm.h>
>   #include <linux/futex.h>
> -
> +#ifdef __powerpc__
> +#include <altivec.h>
> +#endif
>   #include "../utils.h"
>   
>   static unsigned int timeout = 30;
> @@ -37,12 +39,15 @@ static int touch_fp = 1;
>   double fp;
>   
>   static int touch_vector = 1;
> -typedef int v4si __attribute__ ((vector_size (16)));
> -v4si a, b, c;
> +vector int a, b, c;
>   
>   #ifdef __powerpc__
>   static int touch_altivec = 1;
>   
> +/*
> + * Note: LTO (Link Time Optimisation) doesn't play well with this function
> + * attribute. Be very careful enabling LTO for this test.
> + */
>   static void __attribute__((__target__("no-vsx"))) altivec_touch_fn(void)
>   {
>   	c = a + b;
> 
