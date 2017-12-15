Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x235.google.com (mail-vk0-x235.google.com
 [IPv6:2607:f8b0:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz2gF19WMzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:52:24 +1100 (AEDT)
Received: by mail-vk0-x235.google.com with SMTP id m15so6355729vkf.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 12:52:24 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUszecRH7p5iHNXNqmb956PnhZa=4zCx+E4c2ur8Jzf6c4w@mail.gmail.com>
References: <CA+7wUszecRH7p5iHNXNqmb956PnhZa=4zCx+E4c2ur8Jzf6c4w@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Dec 2017 21:52:01 +0100
Message-ID: <CA+7wUsxuhWXn8raBsp29umpHhVO7BnX_B3CALTddBx5gJeLoCA@mail.gmail.com>
Subject: Re: Mac Mini G4 defconfig ?
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 8:50 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi there,
>
> Does anyone has working defconfig for a Mac Mini G4 ?
>
> Here is what I tried:
>
> $ cat ./arch/powerpc/configs/g4_defconfig
> CONFIG_PPC_FPU=y
> CONFIG_ALTIVEC=y
> $ make ARCH=powerpc g4_defconfig
> $ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- V=1
> set -e; : '  CHK     include/config/kernel.release'; mkdir -p

That is odd. Doing a quick git bisect:

$ git checkout 3298b690b21cdbe6b2ae8076d9147027f396f2b1
$ make -n ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -f ./Makefile
silentoldconfig V=1
+ make -n ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -f ./Makefile
silentoldconfig V=1
/bin/sh: line 0: [: -ge: unary operator expected
make -f ./scripts/Makefile.build obj=scripts/basic

I cannot make sense of this shell error, maybe this is unrelated but
things start breaking around this commit.
