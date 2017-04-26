Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCSZD0mqBzDqFk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 15:00:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Olof's autobuilder <build@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, kernel-build-reports@lists.linaro.org,
 gregkh <gregkh@linuxfoundation.org>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: stable-rc build: 0 warnings 2 failures
 (stable-rc/v4.4.63-29-ge636782)
In-Reply-To: <CAK8P3a33mtCFYJnEs0zLh_Rst9aNQhiHUM=R+6BUOnFgo1HDog@mail.gmail.com>
References: <58ff8298.11c7620a.8183e.652d@mx.google.com>
 <CAK8P3a33mtCFYJnEs0zLh_Rst9aNQhiHUM=R+6BUOnFgo1HDog@mail.gmail.com>
Date: Wed, 26 Apr 2017 15:00:19 +1000
Message-ID: <87r30f2270.fsf@concordia.ellerman.id.au>
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

Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Apr 25, 2017 at 7:08 PM, Olof's autobuilder <build@lixom.net> wrote:
>>
>> Failed defconfigs:
>>         powerpc.pasemi_defconfig
>>         powerpc.ppc64_defconfig
>>
>> -------------------------------------------------------------------------------
>>
>> Errors:
>>
>> /work/build/batch/arch/powerpc/kernel/misc_64.S:72: Error: .localentry expression for `flush_icache_range' does not evaluate to a constant
>
> This is a regression in 4.4-stable-rc, caused by the backport of commit
> 8f5f525d5b83f7d7 ("powerpc/64: Fix flush_(d|i)cache_range() called from
> modules").
>
> The patch was also backported into v4.9-stable-rc, but did not cause
> problems there. The fixes tag suggests that the patch is needed on
> every version from 3.16 up, but apparently the fix needs to be a little
> different compared to newer kernels.

Yeah, the auto-backport failed, and then I sent a version for 4.4 which
fixed the bug but broke other configs (big endian).

I've asked Greg to drop it for now.

I'll try again when I'm less sleep deprived :)

cheers
