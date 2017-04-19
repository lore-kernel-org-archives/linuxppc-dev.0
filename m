Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7NZx1YRgzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:46:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Anton Blanchard <anton@samba.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
In-Reply-To: <1492606204.7284.1.camel@gmail.com>
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
 <1492071568.8380.20.camel@gmail.com> <20170419211346.5e228370@kryten>
 <1492606204.7284.1.camel@gmail.com>
Date: Wed, 19 Apr 2017 23:46:47 +1000
Message-ID: <87lgqw5x2w.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, 2017-04-19 at 21:13 +1000, Anton Blanchard wrote:
>> Hi Balbir,
>> 
>> > > FTRACE is quite CPU consumming, shouldn't it really be on by
>> > > default ?  
>> > 
>> > It does some work at boot to NOP out function entry points at _mcount
>> > locations. Is that what you are referring to? Or the overhead of the
>> > code in terms of size? Most distro kernels have tracing on by default.
>> > 
>> > The rest of the overhead is enablement based.
>> 
>> Unfortunately the overhead is somewhat high without
>> CONFIG_MPROFILE_KERNEL, and enabling that option will break old
>> toolchains. It would be great if we could automatically enable it based
>> on the toolchain.
>> 
>> Even with CONFIG_MPROFILE_KERNEL enabled, we aren't noping out the
>> redundant mflr at the start of each function.
>
> Very good catch! I sent the enablement assuming that we want to have these
> enabled to ensure we generally have these enabled in the distro kernels
> and ideally want to test with these enabled and many of us turn them
> on in any case. Do you see an issue with this being enabled by default?
> I presume most workloads run on kernels that have them enabled these days?

No definitely not. Most distro kernels don't even have the code, it only
went into 4.6.

> CONFIG_MPROFILE_KERNEL depends on CC_USING_MPROFILE_KERNEL which is

No it doesn't:

config MPROFILE_KERNEL
	depends on PPC64 && CPU_LITTLE_ENDIAN
	def_bool !DISABLE_MPROFILE_KERNEL

> automatically detected and is LE only.

It's automatically detected at build time, which is too late, so our
only option is to break the build:

ifdef CONFIG_MPROFILE_KERNEL
    ifeq ($(shell $(srctree)/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
        CC_FLAGS_FTRACE := -pg -mprofile-kernel
        KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
    else
        # If the user asked for mprofile-kernel but the toolchain doesn't
        # support it, emit a warning and deliberately break the build later
        # with mprofile-kernel-not-supported. We would prefer to make this an
        # error right here, but then the user would never be able to run
        # oldconfig to change their configuration.
        $(warning Compiler does not support mprofile-kernel, set CONFIG_DISABLE_MPROFILE_KERNEL)
        CC_FLAGS_FTRACE := -mprofile-kernel-not-supported
    endif
endif


So in short it's a big PITA.

cheers
