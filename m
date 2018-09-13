Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429s786JfpzF3Ry
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 18:21:24 +1000 (AEST)
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
To: Radu Rendec <radu.rendec@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, oss@buserror.net, mpe@ellerman.id.au,
 eric.miao@marvell.com
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
 <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
 <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
 <c0b2c45c-815c-d627-e975-a2d622494223@c-s.fr>
 <CAD5jUk-oEoMwndqqPUs+AWnQThUjH+DA6fJUb5_W2rOPB1Njtw@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d30e4a1e-187b-2a07-ec9c-50f889375cde@c-s.fr>
Date: Thu, 13 Sep 2018 10:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAD5jUk-oEoMwndqqPUs+AWnQThUjH+DA6fJUb5_W2rOPB1Njtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/09/2018 à 00:17, Radu Rendec a écrit :
> Hi,
> 
> On Mon, 2018-09-10 at 07:37 +0200, Christophe Leroy wrote:
>> Le 10/09/2018 à 01:13, Radu Rendec a écrit :
>>>
>>> I'm using U-boot as well, but it's just not configured to read or clear
>>> the RSR. I'm curious: if U-boot reads/clears the RSR in your case, how
>>> do you make the initial value available to user space programs running
>>> under Linux?
>>
>> I'm surprised. When looking at U-boot code, I don't see any way to
>> configure that. It seems just do by default in function cpu_init_f():
>>
>> https://elixir.bootlin.com/u-boot/v2018.07/source/arch/powerpc/cpu/mpc83xx/cpu_init.c#L217
>>
>>          /* RSR - Reset Status Register - clear all status (4.6.1.3) */
>>          gd->arch.reset_status = __raw_readl(&im->reset.rsr);
>>          __raw_writel(~(RSR_RES), &im->reset.rsr);
> 
> I'm working as a contractor in a large embedded project, so I don't know
> all the bits and pieces. I just checked the U-boot code. Whoever was
> maintaining it, "configured" it by commenting out the __raw_writel()
> that clears the register :)
> 
> Probably the reason was specifically to be able to read it from Linux,
> but unfortunately the guy is not here any more to ask him.
> 
> It may make more sense to read it from U-boot, but (1) the value must
> still be passed to Linux somehow and (2) in my case, I would prefer not
> to touch U-boot.
> 
>> Do you know any user space program in Linux that needs this value ?
> 
> I don't know of any "standard" program that needs it. In the project I'm
> working on, there are multiple peripherals on the board and initialization
> is slightly different when the reset line is physically asserted vs. a
> soft CPU reset. Besides, we need to show the reset reason to the user.
> 
> I guess in the embedded world this is a fairly common use case, so
> perhaps others can benefit from that if I fix it in a way that can be
> pushed upstream.
> 
>>> Thank you very much for the patches. Is there any chance they can be
>>> submitted upstream?
>>
>> I see no problem submitting them upstream, but are they really worth it
>> ? Adding Michael in copy to get his opinion.
> 
> I guess it's worth if they are changed to make the value available to
> the kernel and user space rather than just decoding/printing it, for the
> reasons I mentioned above.
> 
> The MPC83xx also has a watchdog and the kernel driver (mpc8xxx_wdt.c)
> could also be improved to support the WDIOC_GETBOOTSTATUS ioctl and
> properly report if the system rebooted due to a watchdog.

Very good idea.

I just submitted a patch for that. Please look at it.
I'm sure any driver which needs reset status information can do the same.

If we want to do something more central, maybe we should look at what 
was done on ARM:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04fef228fb00

Christophe


> 
>>> I tried to look for something similar on other platforms or architectures,
>>> but couldn't find anything.
>>
>> I believe furst thing is to identify some app needing such an
>> information, then we'll be able to investigate how to handle it.
> 
> Well, I guess I explained my reasons and use case. If there is any
> interest in that, I will gladly implement it in a way that makes sense
> to upstream. Let's see what Michael thinks.
> 
> Thanks,
> Radu Rendec
> 
