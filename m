Return-Path: <jim.epost@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7ngT6mrNzDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 10:36:37 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id m138so240207itm.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 16:36:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wpgp13ki.fsf@concordia.ellerman.id.au>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
 <87wpgp13ki.fsf@concordia.ellerman.id.au>
From: Jim Davis <jim.epost@gmail.com>
Date: Tue, 1 Nov 2016 16:36:35 -0700
Message-ID: <CA+r1ZhiJW6xQ1VwgLudFzFBxkKzkURv7MZhWtmSevRHc9aUyxA@mail.gmail.com>
Subject: Re: [PATCH] cxl: Fix error handling
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 30, 2016 at 10:37 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
>
>> 'cxl_dev_context_init()' returns an error pointer in case of error, not
>> NULL. So test it with IS_ERR.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> un-compiled because I don't have the required  cross build environment.
>
> Do you run Ubuntu or Fedora? If so it's just a dnf/apt-get away:
>
> $ sudo dnf install gcc-c++-powerpc64-linux-gnu binutils-powerpc64-linux-gnu gcc-powerpc64-linux-gnu
> or
> $ sudo apt-get install gcc-powerpc64le-linux-gnu gcc-powerpc-linux-gnu libc-dev-powerpc-cross libc-dev-ppc64el-cross
>
> More here:
>
> https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels

Cool; the little-endian build worked fine, but

jim@krebstar:~/linux-rc$ make ARCH=powerpc
CROSS_COMPILE=powerpc64-linux-gnu- vmlinux
make: powerpc64-linux-gnu-gcc: Command not found
make: powerpc64-linux-gnu-gcc: Command not found
scripts/kconfig/conf  --silentoldconfig Kconfig
make: powerpc64-linux-gnu-gcc: Command not found

This is on Ubuntu 16.04; there's a /usr/bin/powerpc64le-linux-gnu-gcc
from installing gcc-powerpc64le-linux-gnu, and a
/usr/bin/powerpc-linux-gnu-gcc from installing gcc-powerpc-linux-gnu,
but no /usr/bin/powerpc64-linux-gnu-gcc.

-- 
Jim
