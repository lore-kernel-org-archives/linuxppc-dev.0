Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fsLV0FfrzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 19:57:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
In-Reply-To: <CAK7LNASKiO8J8yTRGp4ngo2=ErC6S2_0bNENVsc4PoYpENQfTQ@mail.gmail.com>
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
 <4f3a5969-88d5-134d-508d-7617947c588c@infradead.org>
 <20180707221316.5b75e075@roar.ozlabs.ibm.com>
 <c0a17b80-6384-7437-045c-3688d9e5e7f9@infradead.org>
 <CAK7LNASKiO8J8yTRGp4ngo2=ErC6S2_0bNENVsc4PoYpENQfTQ@mail.gmail.com>
Date: Tue, 31 Jul 2018 19:57:36 +1000
Message-ID: <87lg9rhgmn.fsf@concordia.ellerman.id.au>
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

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> 2018-07-07 23:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> On 07/07/2018 05:13 AM, Nicholas Piggin wrote:
>>> On Fri, 6 Jul 2018 21:58:29 -0700
>>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> On 07/06/2018 06:45 PM, Benjamin Herrenschmidt wrote:
>>>>> On Thu, 2018-07-05 at 14:30 -0700, Randy Dunlap wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Is there a good way (or a shortcut) to do something like:
>>>>>>
>>>>>> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>>>>>>   to get a PPC32/32BIT allmodconfig
>>>>>>
>>>>>> and also be able to do:
>>>>>>
>>>>>> $make ARCH=powerpc O=PPC64 [other_options] allmodconfig
>>>>>>   to get a PPC64/64BIT allmodconfig?
>>>>>
>>>>> Hrm... O= is for the separate build dir, so there much be something
>>>>> else.
>>>>>
>>>>> You mean having ARCH= aliases like ppc/ppc32 and ppc64 ?
>>>>
>>>> Yes.
>>>>
>>>>> That would be a matter of overriding some .config defaults I suppose, I
>>>>> don't know how this is done on other archs.
>>>>>
>>>>> I see the aliasing trick in the Makefile but that's about it.
>>>>>
>>>>>> Note that arch/x86, arch/sh, and arch/sparc have ways to do
>>>>>> some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
>>>>>> sh and sparc based on a recent "fix" patch from me):
>>>>>
>>>>> I fail to see what you are actually talking about here ... sorry. Do
>>>>> you have concrete examples on x86 or sparc ? From what I can tell the
>>>>> "i386" or "sparc32/sparc64" aliases just change SRCARCH in Makefile and
>>>>> 32 vs 64-bit is just a Kconfig option...
>>>>
>>>> Yes, your summary is mostly correct.
>>>>
>>>> I'm just looking for a way to do cross-compile builds that are close to
>>>> ppc32 allmodconfig and ppc64 allmodconfig.
>>>
>>> Would there a problem with adding ARCH=ppc32 / ppc64 matching? This
>>> seems to work...
>>
>> Yes, this mostly works and is similar to a patch (my patch) on my test machine.
>> And they both work for allmodconfig, which is my primary build target.
>>
>> And they both have one little quirk that is confusing when the build target
>> is defconfig:
>>
>> When ARCH=ppc32, the terminal output (stdout) is: (using O=PPC32)
>>
>> make[1]: Entering directory '/home/rdunlap/lnx/lnx-418-rc3/PPC32'
>>   GEN     ./Makefile
>> *** Default configuration is based on 'ppc64_defconfig'   <<<<< NOTE <<<<<
>> #
>> # configuration written to .config
>> #
>> make[1]: Leaving directory '/home/rdunlap/lnx/lnx-418-rc3/PPC32'
>>
>
>
> Maybe, we can set one of ppc32 defconfigs to KBUILD_DEFCONFIG
> if ARCH is ppc32 ?

We could, but as I said in another reply I'd rather we didn't play
tricks with ARCH.

I've merged a patch to add three new allmodconfig targets for ppc32,
ppc64le and ppc64_book3e:

  https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=54457&state=*


cheers
