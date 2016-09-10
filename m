Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWTsQ128mzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 19:53:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
In-Reply-To: <5f47ce4e-646f-9532-307a-2904c298e64e@physik.fu-berlin.de>
References: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
 <20160907012356.GA21443@fergus.ozlabs.ibm.com>
 <87a8fhlv2t.fsf@concordia.ellerman.id.au>
 <5f47ce4e-646f-9532-307a-2904c298e64e@physik.fu-berlin.de>
Date: Sat, 10 Sep 2016 19:53:13 +1000
Message-ID: <87oa3wnks6.fsf@concordia.ellerman.id.au>
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

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> On 09/09/2016 03:29 AM, Michael Ellerman wrote:
>> Interestingly it builds fine for me, even for 32-bit configs, I assume
>> because my toolchains are 32/64-bit they are able to cope with it. I'll
>> try and built a 32-bit only toolchain to catch these problems in future.
>
> Yeah, I was just asking myself the same question after seeing your patch
> on the list as the kernel package builds fine on Debian's powerpc port [1].
>
> However, the powerpc Debian package always builds a 64-bit kernel image
> as well in order to be able to use a 32-bit userland on a 64-bit kernel
> when the hardware is capable of 64-bit. So, your guess above might actually
> be true, but I haven't tested it.

I built a 32-bit only toolchain, ie. one that doesn't accept -m64. But
it still happily assembles a .S with "ld" in it. So not sure what's
going on with that.

> What I do know is that "ld" is definitely not available on PowerPC e500
> while "lwz" is available, see 3-68 in the e500 reference manual [2].

Yep.

> Thanks for the quick fix!

I assume by that it worked for you? I'll add a Tested-by: for you?

cheers
