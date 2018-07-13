Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41S86S550KzF35W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 09:25:03 +1000 (AEST)
Subject: Re: CONFIG_ANDROID_BINDER_IPC=y (Re: powerpc: 32BIT vs. 64BIT (PPC32
 vs. PPC64))
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <87sh4uj675.fsf@concordia.ellerman.id.au>
 <CA+7wUsy2FmRhsX3OLkTPKh-9JCZCQKtTbbzP9=vLuEJ9Pn6QmA@mail.gmail.com>
 <CA+7wUsz=DUKb1WJgL7dCZNtH8aHh9KeJ--AHWoCmgjSSTRbggA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <edb2f575-5d22-0625-f742-13cc2d413057@infradead.org>
Date: Fri, 13 Jul 2018 16:24:54 -0700
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz=DUKb1WJgL7dCZNtH8aHh9KeJ--AHWoCmgjSSTRbggA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2018 04:41 AM, Mathieu Malaterre wrote:
> Randy,
> 
> On Mon, Jul 9, 2018 at 2:00 PM Mathieu Malaterre <malat@debian.org> wrote:
>>
>> On Sun, Jul 8, 2018 at 1:53 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>> Hi,
>>>>
>>>> Is there a good way (or a shortcut) to do something like:
>>>
>>> The best I know of is:
>>>
>>>> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>>>>   to get a PPC32/32BIT allmodconfig
>>>
>>> $ echo CONFIG_PPC64=n > allmod.config
>>> $ KCONFIG_ALLCONFIG=1 make allmodconfig
>>> $ grep PPC32 .config
>>> CONFIG_PPC32=y
>>>
>>> Which is still a bit clunky.
>>>
>>>
>>> I looked at this a while back and the problem we have is that the 32-bit
>>> kernel is not a single thing. There are multiple 32-bit platforms which
>>> are mutually exclusive.
>>>
>>> eg, from menuconfig:
>>>
>>>  - 512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx
>>>  - Freescale 85xx
>>>  - Freescale 8xx
>>>  - AMCC 40x
>>>  - AMCC 44x, 46x or 47x
>>>  - Freescale e200
>>
>> Most Linux distro seems to have drop support for ppc32. So I'd suggest
>> to pick Debian powperc default config (but I agree that I am a little
>> biased here).
> 
> I tried an allmode as suggest by Michael (above). But I get a build error:
> 
>   MODPOST vmlinux.o
> drivers/android/binder.o: In function `binder_thread_write':
> binder.c:(.text+0xc750): undefined reference to `__get_user_bad'
> binder.c:(.text+0xc76c): undefined reference to `__get_user_bad'
> binder.c:(.text+0xc790): undefined reference to `__get_user_bad'
> binder.c:(.text+0xc7d4): undefined reference to `__get_user_bad'
> binder.c:(.text+0xc7f4): undefined reference to `__get_user_bad'
> 
> 
> So for now I need to do: CONFIG_ANDROID_BINDER_IPC=n
> 
> How did you get passed this build failure ?

Hi,

I am not seeing an error on that driver build.

I am using gcc 8.1.0 from kernel.org:
https://mirrors.edge.kernel.org/pub/tools/crosstool/

and building on x86_64.


-- 
~Randy
