Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3yBv6jqlzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 12:46:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
In-Reply-To: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
Date: Wed, 03 Aug 2016 12:46:47 +1000
Message-ID: <87y44elgbs.fsf@concordia.ellerman.id.au>
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

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

> Are linux-next builds being tested for powerpc with allyesconfig and
> allmodconfig ?

Yes, every single version:

  http://kisskb.ellerman.id.au/kisskb/target/2659/

> I have some changes I'm making and while debugging my
> build issues I decided to give a clean build a shot and see linux-next
> next-20160729 up to next-20160729 all have build failures without my
> changes. I get:
>
> /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> drivers/built-in.o: .opd is not a regular array of opd entries
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> drivers/built-in.o: .opd is not a regular array of opd entries
> drivers/built-in.o: In function `.ipw2100_up':
> ipw2100.c:(.text+0x1ff9c90): relocation truncated to fit:
> R_PPC64_REL24 (stub) against symbol `.round_jiffies_relative' defined
> in .text section in kernel/built-in.o

And yes this is a known problem, there have been attempts to fix it, but
none that quite got working.

In fact it's our bug #1 :)

  https://github.com/linuxppc/linux/issues/1


Please use allmodconfig, which should build in general. Or one of our
other defconfigs, eg. ppc64/ppc64le defconfig.

cheers
