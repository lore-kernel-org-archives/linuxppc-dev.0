Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C844FDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 02:57:36 +1000 (EST)
Message-ID: <46F2A640.1000802@ru.mvista.com>
Date: Thu, 20 Sep 2007 20:56:32 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Sequoia kernel crash workaround.
References: <46F16CC9.3010003@ru.mvista.com>
	<200709192119.48259.sr@denx.de>	<20070919193024.GA28163@lixom.net>
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
In-Reply-To: <20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Josh Boyer <jwboyer@gmail.com>, Stefan Roese <sr@denx.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Wed, 19 Sep 2007 14:30:24 -0500
> Olof Johansson <olof@lixom.net> wrote:
> 
>> On Wed, Sep 19, 2007 at 09:19:47PM +0200, Stefan Roese wrote:
>>> Hi Valentine,
>>>
>>> On Wednesday 19 September 2007, Valentine Barshak wrote:
>>>> Disabling write pipelining really helps.
>>>> Josh, David, what is the right place to put this workaround to?
>>>>
>>>> Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
>>>> arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
>>>> or
>>>> should this be done in
>>>> arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
>>>> with dcr_map, dcr_read/write stuff?
>>> I vote for putting it into sequoia.c, since it's very likely to happen that 
>>> Sequoia will at one point be booted without the bootwrapper. Or perhaps it 
>>> should go into some common code checking the PVR and disabling it when this 
>>> 440EPx/GRx is detected, since all those boards are affected.
>> This is what we have setup_cpu functions in the cpu table for. Please
>> put it there instead of in board code.
> 
> Yes, agreed.

I was thinking about it. Looks like it's the best place, but the code 
that actually calls setup_cpu is under ifdef CONFIG_PPC64, while lots of 
cpu_setup functions are defined for ppc32 processors.
Is it OK to remove this ifdef, or should I do CONFIG_PPC64 || CONFIG_44x?

Thanks,
Valentine.

> 
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
