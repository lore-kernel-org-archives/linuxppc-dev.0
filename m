Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gcyz3SGKzF3P5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 12:30:50 +1000 (AEST)
Received: by mail-qk1-x744.google.com with SMTP id p84-v6so7174927qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 19:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230756.26035-1-joel@jms.id.au>
 <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
In-Reply-To: <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 21 Sep 2018 12:00:36 +0930
Message-ID: <CACPK8Xcx7i_pe65PH+ECA6z0M_h5H1uW3wdUKS3RG5HYxEhgpg@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 christophe.leroy@c-s.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2018 at 16:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 19 Sep 2018 at 01:08, Joel Stanley <joel@jms.id.au> wrote:
> >
> > This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> > polynomial").
> >
> > The cleanup added a dependency on include/linux, which broke the PowerPC
> > boot wrapper/decompresser when KERNEL_XZ is enabled:
> >
> >   BOOTCC  arch/powerpc/boot/decompress.o
> >  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
> >                  from arch/powerpc/boot/decompress.c:42:
> >  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
> >  linux/crc32poly.h: No such file or directory
> >   #include <linux/crc32poly.h>
> >            ^~~~~~~~~~~~~~~~~~~
> >
> > The powerpc decompressor is a hairy corner of the kernel. Even while building
> > a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> > files from include/linux.
>
> I fixed the build error here:
> https://lkml.org/lkml/2018/8/29/179
>
> If you choose to remove any includes from /linux, then go ahead but
> please use original reported-by :)

Okay. I'll try Christophe's suggestion instead.

Cheers,

Joel
