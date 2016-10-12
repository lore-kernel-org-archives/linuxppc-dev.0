Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x236.google.com (mail-qk0-x236.google.com
 [IPv6:2607:f8b0:400d:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sv15d5vmszDsrc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 15:26:29 +1100 (AEDT)
Received: by mail-qk0-x236.google.com with SMTP id z190so15802340qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 21:26:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0a0d0909-cee3-f375-4cf4-75f0beb5b8b7@gmail.com>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
 <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
 <877f9g7r4l.fsf@concordia.ellerman.id.au>
 <62241a1e-51c0-c1cd-1ecd-fa54a3842da0@gmail.com>
 <0a0d0909-cee3-f375-4cf4-75f0beb5b8b7@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 12 Oct 2016 15:26:25 +1100
Message-ID: <CAOSf1CHLO1UL+33nLQfF8uK1ysyu1tM=HwRSdLQCB+__Rbc67Q@mail.gmail.com>
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 11, 2016 at 7:06 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> IMHO in case of using cuboot no CONFIG_KERNEL_<COMPR TYPE> config option
>> should be set and Makefile + code in arch/powerpc/boot should be able
>> to deal with this situation:
>> - don't copy and build the decompression stuff
>> - use an alternative version of prep_kernel() in main.c which doesn't
>>   attempt to decompress the kernel image
>>
>> This should be a cleaner solution than probing the kernel image whether
>> it's compressed or not.
>>
>
> This would be the patch implementing the idea. Advantage is that all
> the unnecessary decompression code isn't built. Works fine for me.

I don't think this approach is viable. The wrapper code is shared
among the various output image formats some of which *will* contain a
compressed kernel image so we can't simply remove the decompressor
from the wrapper. A random example I found in the makefile was
CONFIG_BAMBOO:

> image-$(CONFIG_BAMBOO) += treeImage.bamboo cuImage.bamboo

When building for this platform Kbuild will produce treeboot and a
cuboot image. Unlike uboot, Treeboot doesn't do any decompression so
the wrapper needs to decompress the kernel itself. The probing
solution more or less matches the old behaviour (which we know works)
so I think we should just stick with that.

- Oliver
