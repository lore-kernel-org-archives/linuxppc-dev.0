Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t856r1cfmzDt26
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 22:12:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jim Davis <jim.epost@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix error handling
In-Reply-To: <CA+r1ZhiJW6xQ1VwgLudFzFBxkKzkURv7MZhWtmSevRHc9aUyxA@mail.gmail.com>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
 <87wpgp13ki.fsf@concordia.ellerman.id.au>
 <CA+r1ZhiJW6xQ1VwgLudFzFBxkKzkURv7MZhWtmSevRHc9aUyxA@mail.gmail.com>
Date: Wed, 02 Nov 2016 22:12:50 +1100
Message-ID: <87eg2unnil.fsf@concordia.ellerman.id.au>
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

Jim Davis <jim.epost@gmail.com> writes:

> On Sun, Oct 30, 2016 at 10:37 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> More here:
>>
>> https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels
>
> Cool; the little-endian build worked fine, but

Yay, thanks for trying.

> jim@krebstar:~/linux-rc$ make ARCH=powerpc
> CROSS_COMPILE=powerpc64-linux-gnu- vmlinux
> make: powerpc64-linux-gnu-gcc: Command not found
> make: powerpc64-linux-gnu-gcc: Command not found
> scripts/kconfig/conf  --silentoldconfig Kconfig
> make: powerpc64-linux-gnu-gcc: Command not found

Ah sorry.

> This is on Ubuntu 16.04; there's a /usr/bin/powerpc64le-linux-gnu-gcc
> from installing gcc-powerpc64le-linux-gnu, and a
> /usr/bin/powerpc-linux-gnu-gcc from installing gcc-powerpc-linux-gnu,
> but no /usr/bin/powerpc64-linux-gnu-gcc.

It's the powerpc-linux-gnu-gcc one.

That is a 32 and 64-bit compiler, it's 32-bit by default, but the kernel
Makefiles will pass -m64 appropriately.

You can actually build a single compiler that builds 32/64-bit BE, and
64-bit LE, but the distros don't do that for whatever reason.

cheers
