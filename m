Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410zgC72xjzF2NS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 16:44:39 +1000 (AEST)
Subject: Re: Problems building ppc images in v4.14.y and v4.16.y using gcc
 7.3.0 / 8.1.0 from kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, stable <stable@vger.kernel.org>
References: <e11832b0-f071-b709-be34-417f2d3bc343@roeck-us.net>
 <CAK8P3a3CFhkjPCX8bgZbx7aYwrUVsKE5ct4ghnMxJLo5OSYqbA@mail.gmail.com>
 <20180605160624.GA30373@roeck-us.net>
 <CAK8P3a0CjKCYCyhGejF6e3-Mk0mQ2=x3Kd76U8B4iB1amNr76g@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <8c064173-30c8-9be3-2377-d2018841a2eb@c-s.fr>
Date: Wed, 6 Jun 2018 08:44:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0CjKCYCyhGejF6e3-Mk0mQ2=x3Kd76U8B4iB1amNr76g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/06/2018 à 21:47, Arnd Bergmann a écrit :
> On Tue, Jun 5, 2018 at 6:06 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jun 05, 2018 at 04:31:00PM +0200, Arnd Bergmann wrote:
>>> On Tue, Jun 5, 2018 at 3:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> Hi Arnd,
>>>>
>>>> when using the ppc64 compiler from kernel.org, I see the following problems
>>>> when trying to compile ppc:allnoconfig in v4.14.y or v4.16.y.
>>>>
>>>> gcc 7.3.0: Compilation of kernel.cpu.o hangs
>>>>
>>>> The problem goes away if I apply the following two patches (tested with
>>>> 4.16.y)
>>>>
>>>> 17a2f1ced028 cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states
>>>> fcb3029a8d89 cpu/hotplug: Fix unused function warning
>>>
>>> This is probably the same as
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84038
>>>
>>> I thought I had included the fix in my builds.
>>>
>> Guess not.
> 
> I probably had it in one build and then forgot about it when I did a
> rebuild of 7.3 :(
> 
> I'm still planning to do a new set of gcc-7.3 binaries (or maybe 7.4
> if that gets
> released soon) and should try to remember doing that.
> 
>>>
>> I think it may have cached the flags from the other compiler version.
>> "make mrproper" prior to "make defconfig" took care of the issue.
>>
>> However, that doesn't really help - I get lots of
>>          error: 'sys_spu_create' alias between functions of incompatible types
>>          error: 'strncpy' output truncated before terminating nul
>> if I try to use gcc 8.1.0.
>>
>> Oh well. I'll try gcc 6.4.0 next.
> 
> On the upside, those two errors are just a result of arch/power/*/*.c getting
> built with -Werror, they are warnings that gcc-8 introduced that we should
> either shut up or fix.

They are fixed in next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2479bfc9bc600dcce7f932d52dcfa8d677c41f93
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c95998811807d897ca112ea62d66716ed733d058

Christophe

> 
>          Arnd
> 
