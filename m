Return-Path: <bart.vanassche@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 8B654DDF00
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 01:19:27 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so451022fga.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 08:19:24 -0700 (PDT)
Message-ID: <e2e108260806280819i75aeee08j521515c252ca029c@mail.gmail.com>
Date: Sat, 28 Jun 2008 17:19:24 +0200
From: "Bart Van Assche" <bart.vanassche@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.25.9] Make sure that include/asm-powerpc/spinlock.h
	does not trigger compilation warnings
In-Reply-To: <08A80326-6E58-43BC-9AB1-3136A0285A84@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806280851.35417.bart.vanassche@gmail.com>
	<08A80326-6E58-43BC-9AB1-3136A0285A84@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 28, 2008 at 5:07 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jun 28, 2008, at 1:51 AM, Bart Van Assche wrote:
>
>> When compiling kernel modules for ppc that include <linux/spinlock.h>, gcc
>> prints a warning message every time it encounters a function declaration
>> where
>> the inline keyword appears after the return type. The patch below makes
>> sure
>> that the order of the inline keyword and the return type is as gcc expects
>> it.
>> Additionally, the __inline__ keyword is replaced by inline, as checkpatch
>> expects.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@gmail.com>
>
> what version of gcc and what config are you building for?

The gcc details are as follows (openSUSE 10.3 PPC running on a PS3):

$ gcc -v
Using built-in specs.
Target: powerpc64-suse-linux
Configured with: ../configure --enable-threads=posix --prefix=/usr
--with-local-prefix=/usr/local --infodir=/usr/share/info
--mandir=/usr/share/man --libdir=/usr/lib --libexecdir=/usr/lib
--enable-languages=c,c++,objc,fortran,obj-c++,java,ada
--enable-checking=release
--with-gxx-include-dir=/usr/include/c++/4.2.1 --enable-ssp
--disable-libssp --disable-libgcj --with-slibdir=/lib
--with-system-zlib --enable-shared --enable-__cxa_atexit
--enable-libstdcxx-allocator=new --disable-libstdcxx-pch
--program-suffix=-4.2 --enable-version-specific-runtime-libs
--without-system-libunwind --with-cpu=default32 --enable-secureplt
--with-long-double-128 --host=powerpc64-suse-linux
Thread model: posix
gcc version 4.2.1 (SUSE Linux)

Bart.
