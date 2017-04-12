Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2vvy0HVbzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 17:01:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-raid@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH 1/2] lib/raid6: Build proper files on corresponding arch
In-Reply-To: <20170412013552.21650-1-matthew.brown.dev@gmail.com>
References: <20170412013552.21650-1-matthew.brown.dev@gmail.com>
Date: Wed, 12 Apr 2017 17:01:01 +1000
Message-ID: <87wpaqt8ia.fsf@concordia.ellerman.id.au>
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

Matt Brown <matthew.brown.dev@gmail.com> writes:

> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
> index 9c333e9..62b26d1 100644
> --- a/lib/raid6/test/Makefile
> +++ b/lib/raid6/test/Makefile
> @@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>  else
>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
> -                         gcc -c -x c - >&/dev/null && \
> -                         rm ./-.o && echo yes)
> +			 gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
>          ifeq ($(HAS_ALTIVEC),yes)
> -                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
> +		CFLAGS += -I../../../arch/powerpc/include
> +		CFLAGS += -DCONFIG_ALTIVEC
> +		OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
> +			vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o

The whitespace in here is a bit of a mess, but you should follow what's
there and use spaces to indent your additions.

cheers
