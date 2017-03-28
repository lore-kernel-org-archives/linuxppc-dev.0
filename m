Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsm371qZrzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 20:35:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Walker <danielwa@cisco.com>, Oliver O'Halloran <oohall@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 xe-linux-external@cisco.com
Subject: Re: Build failure -- powerpc/boot: Add OPAL console to epapr wrappers
In-Reply-To: <9100013b-da43-9476-3c60-b41045e37cf2@cisco.com>
References: <1596fddf-b6c0-02cc-cbbd-0f74606206aa@cisco.com>
 <CAOSf1CFrhMJiD0XPboNVkgKvgG+EOdHJSzUsN8wVuB1YsO-K7g@mail.gmail.com>
 <9100013b-da43-9476-3c60-b41045e37cf2@cisco.com>
Date: Tue, 28 Mar 2017 20:35:28 +1100
Message-ID: <874lydbv6n.fsf@concordia.ellerman.id.au>
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

Daniel Walker <danielwa@cisco.com> writes:

> On 03/24/2017 07:16 PM, Oliver O'Halloran wrote:
>> On Sat, Mar 25, 2017 at 4:00 AM, Daniel Walker <danielwa@cisco.com> wrote:
>>> I get this build failure,
>>>
>>>
>>> In file included from arch/powerpc/boot/fdt.c:51:
>>> ../arch/powerpc/boot/libfdt_env.h:9: error: redefinition of typedef
>>> 'uint32_t'
>>> ../arch/powerpc/boot/types.h:20: note: previous declaration of 'uint32_t'
>>> was here
>>> ../arch/powerpc/boot/libfdt_env.h:10: error: redefinition of typedef
>>> 'uint64_t'
>>> ../arch/powerpc/boot/types.h:21: note: previous declaration of 'uint64_t'
>>> was here
>>> make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
>>> make[1]: *** [uImage] Error 2
>>> make[1]: Leaving directory `/nobackup/danielwa/linux/t1040'
>>> make: *** [sub-make] Error 2
>>>
>>>
>>> and it bisects to ,
>>>
>>>
>>> commit 656ad58ef19e2a763fa5c938b20ae0f6b8d67242
>>> Author: Oliver O'Halloran <oohall@gmail.com>
>>> Date:   Fri Jul 1 00:34:37 2016 +1000
>>>
>>>      powerpc/boot: Add OPAL console to epapr wrappers
>>>
>>>      This patch adds an OPAL console backend to the powerpc boot wrapper so
>>>      that decompression failures inside the wrapper can be reported to the
>>>      user. This is important since it typically indicates data corruption in
>>>      the firmware and other nasty things.
>>>
>>>      Currently this only works when building a little endian kernel. When
>>>      compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
>>>      compatible with some 32 bit firmwares. BE support will be added at a
>>>      later date. Another limitation of this is that only the "raw" type of
>>>      OPAL console is supported, however machines that provide a hvsi console
>>>      also provide a raw console so this is not an issue in practice.
>>>
>>>      Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>      Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>>>      [mpe: Move #ifdef __powerpc64__ to avoid warnings on 32-bit]
>>>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>
>>>
>>> I can provide a config file if needed. My apologies if this was already
>>> reported.
>> Thanks for the report, I don't think this is a known bug. mpe's build
>> testing is pretty thorough so I'm surprised this wasn't caught sooner.
>>
>> A config file and the version of gcc that you're using would be useful.
>
>
> Config attached , it's for a Fresecale t1042 machine. The GCC is custom 
> based on 4.4.1 .

o_O

So only an 8 year old compiler! :D

I can't reproduce here with 4.6.3 sorry, which is the oldest I have handy.

Can you debug it a bit further at your end? I assume your toolchain is
built with libc?

cheers
