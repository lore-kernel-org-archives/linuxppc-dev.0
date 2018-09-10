Return-Path: <luc.vanoostenryck@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4285Yr6hFQzF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 21:34:54 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id j192-v6so21125951wmj.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 04:34:54 -0700 (PDT)
Date: Mon, 10 Sep 2018 13:34:49 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
 Kees Cook <keescook@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org,
 sparse@chrisli.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910113448.dxnfvznyimtj3tkv@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 09:56:33AM +0000, Christophe Leroy wrote:
> 
> # export REAL_CC=ppc-linux-gcc
> # make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5
> -D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
> scripts/kconfig/conf  --syncconfig Kconfig
> #
> # configuration written to .config
> #
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   CC      kernel/bounds.s
>   CC      arch/powerpc/kernel/asm-offsets.s
>   CALL    scripts/checksyscalls.sh
>   CHECK   scripts/mod/empty.c
> Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2

OK. Clearly nobody has ever used it so :(
There is an infinite loop because cgcc use the env var CHECK
to call sparse while kbuild use CHECK to call cgcc here.

The following seems to work here.
$ export REAL_CC=ppc-linux-gcc
$ make CHECK="CHECK=sparse cgcc -target=ppc ...

It's a bit kludgy, I admit.

-- Luc
