Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4621DDF48
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:12:02 +1100 (EST)
Message-Id: <D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <498718B6.3030307@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
Date: Mon, 2 Feb 2009 10:11:46 -0600
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
	<498718B6.3030307@gefanuc.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 2, 2009, at 10:00 AM, Martyn Welch wrote:

> Kumar Gala wrote:
>> On Feb 2, 2009, at 3:36 AM, Martyn Welch wrote:
>>> Becky Bruce wrote:
>>>> On Jan 30, 2009, at 8:42 AM, Kumar Gala wrote:
>>>>>
>>>>> On Jan 30, 2009, at 6:31 AM, Martyn Welch wrote:
>>>>>
>>>>>> Hi Guys,
>>>>>>
>>>>>> It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I  
>>>>>> have just updated u-boot to the latest git to see if that  
>>>>>> improved matters, however I get stuck at the following. Any  
>>>>>> ideas?
>>>>>
>>>>> did you update your .dtb as well?
>>>
>>> Yup, just double checked it. SOC mapped at ffe00000. If I use the  
>>> wrong DTB I don't get any serial output...
>>>
>>>> We've changed the memory map for that board in the latest u-boot,  
>>>> which is why you need a new .dtb.  If this still failing, let me  
>>>> know, and I'll give it a try on my board and see what's up since  
>>>> this is probably my fault :)
>>>
>>> It appears the same problem is affecting our sbc610 as well, the  
>>> location of the SOC hasn't changed on that board.
>>>
>>> Martyn
>> Hm.. maybe try a git-bisect between 2.6.28 and 2.6.29-rc3?
>
> That's was today's "little" task. I was just in the process of  
> writing an email :-)
>
> It got me to the following commit:
>
> commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>   powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
>
> I tried reverting it, but as I had kinda thought, that really didn't  
> help.
>
> I'm just recompiling to check that I didn't screw-up during the  
> bisection.

Hmm.

take a look at this thread.

http://ozlabs.org/pipermail/linuxppc-dev/2009-January/067437.html

- k
