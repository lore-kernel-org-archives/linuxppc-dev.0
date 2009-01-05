Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 04D47DE29C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:37:10 +1100 (EST)
Date: Mon, 5 Jan 2009 19:37:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20090105163708.GB7345@oksana.dev.rtsoft.ru>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231174125.GA13027@oksana.dev.rtsoft.ru>
	<950062C1-9944-4B34-9D1D-18F35E1933E2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <950062C1-9944-4B34-9D1D-18F35E1933E2@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 01, 2009 at 08:29:39AM -0600, Kumar Gala wrote:
[...]
>>>>>> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
>>>>>> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
>>>>>
>>>>> the size on the 0xb0000000 seems wrong
>>>>
>>>> This is how FSL U-Boots configure the cfg window, and I'm trying to
>>>> retain the compatibility. Anyway, now Linux maps only the first 4kB
>>>> of that area, so we don't actually care about this, but dts is still
>>>> correct for older u-boots. Newer U-Boots might want to correct this
>>>> value if they want to use other cfg window setup...
>>>
>>> I'd rather not pollute the .dts with this
>>
>> So you prefer to change the cfg window size to 0x1000?
>
> I'd prefer to drop it (assuming that is reasonable).

I see. Yes, we can drop it and just read the outwin0 BAR register
to find out the cfg space base address.

> Does the PCI-express OF draft spec cover describing cfg space
>
> http://playground.sun.com/1275/proposals/New/516-it.txt

If I understood correctly, the spec describes directly mapped
cfg space, this won't work for 83xx PCI-E.

I'll post new patches soon.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
