Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427xdC3Gg7zF397
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 15:37:19 +1000 (AEST)
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
To: Radu Rendec <radu.rendec@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
 <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
 <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c0b2c45c-815c-d627-e975-a2d622494223@c-s.fr>
Date: Mon, 10 Sep 2018 07:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Le 10/09/2018 à 01:13, Radu Rendec a écrit :
> Hi,
> 
> On Fri, 2018-08-24 at 16:20 +0000, Christophe Leroy wrote:
>>> On 08/03/2018 04:36 PM, Radu Rendec wrote:
>>>
>>> Is there any kernel code that handles the "reset status register" (RSR)
>>> on MPC83xx? I looked at arch/powerpc/platforms/83xx/misc.c, but it seems
>>> to only map the reset register area and it's static. The watchdog driver
>>> (drivers/watchdog/mpc8xxx_wdt.c) doesn't seem to look at it either (for
>>> the bootstatus flags).
>>
>> How do you boot your Linux kernel ?
>>
>> My 832x board boots using U-boot, and U-boot reads the RSR then clears
>> it. So when Linux kernel reads it, it is just 0.
> 
> I'm using U-boot as well, but it's just not configured to read or clear
> the RSR. I'm curious: if U-boot reads/clears the RSR in your case, how
> do you make the initial value available to user space programs running
> under Linux?

I'm surprised. When looking at U-boot code, I don't see any way to 
configure that. It seems just do by default in function cpu_init_f():

https://elixir.bootlin.com/u-boot/v2018.07/source/arch/powerpc/cpu/mpc83xx/cpu_init.c#L217

	/* RSR - Reset Status Register - clear all status (4.6.1.3) */
	gd->arch.reset_status = __raw_readl(&im->reset.rsr);
	__raw_writel(~(RSR_RES), &im->reset.rsr);


Do you know any user space program in Linux that needs this value ?

> 
>>> Basically I need to check the CPU reset reason and I thought I would ask
>>> first, before starting to write any code of my own.
>>
>> Anyway, find below a set of two patches I used for testing. Feel free to
>> use them if you bootloader doesn't clear the register
> 
> Thank you very much for the patches. Is there any chance they can be
> submitted upstream?

I see no problem submitting them upstream, but are they really worth it 
? Adding Michael in copy to get his opinion.

> 
> Of course, just printing the decoded bits is only helpful for testing. I
> was thinking of a way to make the value available to both the kernel
> (as an exported symbol) and user space (e.g. via sysfs). Is there a
> standard or preferred way to do this?
> 
> I tried to look for something similar on other platforms or architectures,
> but couldn't find anything.

I believe furst thing is to identify some app needing such an 
information, then we'll be able to investigate how to handle it.

Christophe

> 
> Thanks,
> Radu Rendec
> 
