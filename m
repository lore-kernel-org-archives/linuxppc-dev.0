Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMWDD1skczDqtV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 08:27:55 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id l64so4323884pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 15:27:55 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5 1/2] lib/raid6: Build proper files on corresponding arch
In-Reply-To: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
Date: Wed, 02 Aug 2017 08:27:43 +1000
Message-ID: <87bmnysz34.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matt,

> --- a/lib/raid6/test/Makefile
> +++ b/lib/raid6/test/Makefile
> @@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>  else
>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
> -                         gcc -c -x c - >&/dev/null && \
> -                         rm ./-.o && echo yes)
> +                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)

>From memory the change here (s/>&/>/) was necessary to get the build to
succeed - did we ever figure out why that was? I'm not enough of a shell
guru to grok the difference. If it's easy to explain it would be good to
put it in the commit message, rather than just saying you fixed an
unspecified bug.

>          ifeq ($(HAS_ALTIVEC),yes)
> -                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
> +                CFLAGS += -I../../../arch/powerpc/include
> +                CFLAGS += -DCONFIG_ALTIVEC
> +                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
> +                        vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o

You've added vpermxor here, but you don't define them until the next
patch, so the tests will fail. Please move the change to OBJS to the
next patch.

With that change, I'd be happy to formally Review this patch.

Regards,
Daniel

>          endif
>  endif
>  ifeq ($(ARCH),tilegx)
> -- 
> 2.9.3
