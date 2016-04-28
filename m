Return-Path: <joel.stan@gmail.com>
Received: from mail-ob0-x242.google.com (mail-ob0-x242.google.com
 [IPv6:2607:f8b0:4003:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwTYV5Fz8zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 17:51:42 +1000 (AEST)
Received: by mail-ob0-x242.google.com with SMTP id ds1so5731607obc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:51:42 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CAGF64GWNqfiWH6Joq0C7sCwQkuM2X-D6Ce-xM+iQGXPoaYYxnQ@mail.gmail.com>
References: <CAGF64GWNqfiWH6Joq0C7sCwQkuM2X-D6Ce-xM+iQGXPoaYYxnQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Apr 2016 17:21:21 +0930
Message-ID: <CACPK8XeCOMRBVVHKEt3eDeD==E5BxB6H8B7c6H5tMjP++mBK6g@mail.gmail.com>
Subject: Re: error while trying to compile linux kernel with powerpc arch
To: Marwa Hamza <marwahamza63@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Apr 28, 2016 at 2:13 AM, Marwa Hamza <marwahamza63@gmail.com> wrote:
> hello
> every time i try to compile the linux kernel with arch=powerpc i got this
> error
>
> WRAP arch / powerpc / boot / zImage.pseries
> powerpc-linux-gnu-ld: unrecognized emulation mode: -T
> Emulations supported: elf32ppclinux elf32ppc elf32ppcsim elf64ppc elf32_spu
> make [1]: *** [arch / powerpc / boot / zImage.pseries] Error 1
> make: *** [zImage] Error 2
>
> im using powerpc-linux-gnu ( sudo apt-get install powerpc-linux-gnu)  and
> linux-4.4.1
> make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  pseries_defconfig
> make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> ubuntu 14.04
> any suggestion ?

You need a 64 bit compiler, as the pseries configuration is for a 64
bit machine.

$ head -n1 arch/powerpc/configs/pseries_defconfig
CONFIG_PPC64=y

'apt-get install gcc-powerpc64-linux-gnu' should do the trick. Set
CROSS_COMPILE=powerpc64-linux-gnu- and you will be good to go.

Cheers,

Joel
