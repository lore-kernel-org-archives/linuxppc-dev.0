Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F210EDDFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 03:38:31 +1000 (EST)
Date: Thu, 20 Sep 2007 12:32:56 -0500 (CDT)
Message-Id: <200709201732.l8KHWuGA035995@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: Sequoia kernel crash workaround.
In-Reply-To: <46F2A640.1000802@ru.mvista.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Sep 21 02:56:32 EST 2007, Valentine Barshak wrote:
> Josh Boyer wrote:
>> On Wed, 19 Sep 2007 14:30:24 -0500
>> Olof Johansson <olof at lixom.net> wrote:
>> 
>>> On Wed, Sep 19, 2007 at 09:19:47PM +0200, Stefan Roese wrote:
>>>> Hi Valentine,
>>>>
>>>> On Wednesday 19 September 2007, Valentine Barshak wrote:
>>>>> Disabling write pipelining really helps.
>>>>> Josh, David, what is the right place to put this workaround to?
>>>>>
>>>>> Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
>>>>> arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
>>>>> or
>>>>> should this be done in
>>>>> arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
>>>>> with dcr_map, dcr_read/write stuff?
>>>> I vote for putting it into sequoia.c, since it's very likely to happen that 
>>>> Sequoia will at one point be booted without the bootwrapper. Or perhaps it 
>>>> should go into some common code checking the PVR and disabling it when this 
>>>> 440EPx/GRx is detected, since all those boards are affected.
>>> This is what we have setup_cpu functions in the cpu table for. Please
>>> put it there instead of in board code.
>> 
>> Yes, agreed.
> 
> I was thinking about it. Looks like it's the best place, but the code 
> that actually calls setup_cpu is under ifdef CONFIG_PPC64, while lots of 
> cpu_setup functions are defined for ppc32 processors.
> Is it OK to remove this ifdef, or should I do CONFIG_PPC64 || CONFIG_44x?

head_32.S calls call_setup_cpu in misc_32.S to call the cpu setup functon.

Note that these functions are called before the kernel is copied down to
0, so on ppc32 you will need the PTRRELOC type stuff.  Also the callsite
implies that the cpu number is available in r24, which may or may not be
true when called from C.

Its probably easier to just call call_setup_cpu in the other 32 bit 
head_xxx files.

milton
