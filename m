Return-Path: <oohall@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405CpT4vsWzDrj3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 00:05:21 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id b20so2250129iof.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 06:05:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgenf6ha.fsf@concordia.ellerman.id.au>
References: <20180319051403.23275-1-oohall@gmail.com>
 <20180319051403.23275-4-oohall@gmail.com>
 <87lgenf6ha.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Wed, 21 Mar 2018 00:05:18 +1100
Message-ID: <CAOSf1CFu4iFCMCvG3inECJUnBibDjuHk8oudGUx58RJUno_+8Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] powerpc/zImage: Rework serial driver probing
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2018 at 8:20 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>
>> Rather than checking the compatible string in serial_driver_init()
>> we call into the driver's init function and wait for a driver to
>> inidicate it bound to the device by returning zero.
>>
>> The pointers to each driver probe functions are stored in the
>> ".serialdrv" section of the zImage, similar to how initcalls and
>> whatnot are handled inside Linux. This structure allows us to
>> conditionally compile specific driver files based on the KConfig
>> settings. This is needed because we don't have access to the
>> KConfig #defines in the zImage source files (it's a giant #include
>> headache) so conditional compilation is the only way to eliminate
>> unnecessary code.
>
> Did you actually get the config.h include working? Or was it such a big
> headache that it doesn't even work?

I had a half-hearted go at it and ran into some problems with include
paths. The usual workaround for that is copying the files into the
build directory and using sed scripts to replace the <> include with a
"" include, so I said screw it and went with this instead. I'm not too
suprised about there being a few linker errors. I tested a few
different defconfigs before posting, but I figured either your CI or
the 0day bot would catch the rest ;)

> I'm pretty happy with this patch regardless, but it would be simpler and
> less bug prone if the CONFIG_ symbols were usable in the boot code.
>
> cheers
