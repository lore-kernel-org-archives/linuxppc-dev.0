Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9641DDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:22:30 +1000 (EST)
In-Reply-To: <6EF5E5F8-703B-4C49-B458-92CD0CDF89A0@kernel.crashing.org>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
	<9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
	<20070911182234.GA12802@lixom.net>
	<424B650B-C272-45FC-BBC6-F090A9474082@kernel.crashing.org>
	<24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
	<6EF5E5F8-703B-4C49-B458-92CD0CDF89A0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Date: Tue, 11 Sep 2007 14:22:21 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 2:08 PM, Kumar Gala wrote:

>
> On Sep 11, 2007, at 1:43 PM, Becky Bruce wrote:
>
>>
>> On Sep 11, 2007, at 1:33 PM, Kumar Gala wrote:
>>
>>>
>>> On Sep 11, 2007, at 1:22 PM, Olof Johansson wrote:
>>>
>>>> On Tue, Sep 11, 2007 at 01:00:47PM -0500, Kumar Gala wrote:
>>>>>
>>>>> On Sep 11, 2007, at 12:20 PM, Olof Johansson wrote:
>>>>>
>>>>>> On Fri, Aug 17, 2007 at 12:03:48AM -0500, Kumar Gala wrote:
>>>>>>>
>>>>>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>>>>>> ---
>>>>>>>  arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
>>>>>>>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 +++----------
>>>>>>>  arch/powerpc/platforms/85xx/Kconfig        |    1 +
>>>>>>>  arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214
>>>>>>> ++----------------------
>>>>>>>  arch/powerpc/platforms/86xx/Kconfig        |    1 +
>>>>>>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224
>>>>>>> ++-----------------------
>>>>>>>  arch/powerpc/platforms/Kconfig             |    8 +
>>>>>>>  arch/powerpc/platforms/Makefile            |    3 +
>>>>>>>  arch/powerpc/platforms/fsl_uli1575.c       |  255
>>>>>>> ++++++++++++++++++++++++++++
>>>>>>>  9 files changed, 363 insertions(+), 545 deletions(-)
>>>>>>>  create mode 100644 arch/powerpc/platforms/fsl_uli1575.c
>>>>>>>
>>>>>>
>>>>>> Since when do we add code directly under powerpc/platforms? Isn't
>>>>>> that
>>>>>> what we have sysdev for?
>>>>>>
>>>>>> I know this is already picked up, but I just noticed it when
>>>>>> looking at
>>>>>> Kumar's 8572 patch. :-(
>>>>>
>>>>> I put it in platforms since it was related to the boards not the
>>>>> chips.  We
>>>>> can go around about what sysdev actual means, but I'm using the
>>>>> assumption
>>>>> that its for processor & bridges (for discrete processors 10x,
>>>>> mv640x0,
>>>>> etc).  Things that are board specific like the ULI I'm putting  
>>>>> under
>>>>> platforms/
>>>>
>>>> Hmm, I don't like the pollution of that directory myself,
>>>> especially since
>>>> we've been able to keep it clean up until now.
>>>
>>> What's it matter if we have files under platforms/
>>>
>>
>> The original intent of platforms as we (Kumar included) laid it  
>> out was that it *only* contain platform subdirs.  This makes it  
>> easy to poke around in platforms, and it makes reading the "ls" of  
>> that directory much more meaningful and informative.  It also  
>> makes it easy to figure out where a file might be without having  
>> to have too much knowledge about the devices themselves. I really  
>> don't like the idea of polluting this directory.
>
> That's bogus already.  Parts of platform code exist in sysdev/ or  
> arch/powerpc/kernel/ so there isnt a single place to look.  While  
> that might have been the intent its not true in practice.

No, it's not bogus.  I said "x" should only contain "y" (where "x" is  
"platforms" and "y is "all platform-related code".  You extended that  
to "all y is in x".  That doesn't follow logically.  Just because I  
want "platforms" to contain only platform subdirs makes *no  
statement* about where all platform code exists.  What I like about  
platforms is that when I go to that directory and look at what's  
there, I see a list of platforms (or platform families), not a bunch  
of random files.  If I want random files, I go to sysdev.  Maybe some  
code is in kernel, fine.  That has absolutely nothing to do with  
putting stuff in top-level platforms.

>
>>> Would you feel better if it was in platforms/common/ or platforms/ 
>>> fsl
>>>
>>>> Maybe it would make more sense for you guys to slice the platforms
>>>> differently, and have a common platform for the eval boards you  
>>>> have
>>>> with ULi on them instead of grouping it by core used by the  
>>>> processor
>>>> on the board.
>>>>
>>>> (In other words, move 86xx over under 85xx, since there wouldn't be
>>>> much
>>>> left over anyway).
>>>
>>> Moving 86xx (classic 74xx core) under 85xx (book e500 core) makes
>>> even less sense to me.
>>
>> Yeah, that makes *no* sense to me either.  It's an unfortunate  
>> artifact of the naming of boards to include the core name.  While  
>> the devices and boards may be similar, once you have bookE vs non- 
>> bookE cores, they become quite different.
>>
>> I still don't see why this isn't in "sysdev".  We intended that to  
>> be the device "kitchen sink".  If we really don't want to put it  
>> there, then I would prefer creating a "fsl_common" or "common"  
>> directory under platforms.

You still haven't, in my opinion, answered my question about why it  
can't go in sysdev, when I believe the original intent was for stuff  
like this to go there.

>>
>> I'm also guilty of not noticing the original patch - my apologies.
>
> maybe we should just have a platforms/fsl for all boards from  
> freescale.  Not having things broken up by which processor family  
> they are for.

What do you envision as being under there?  Subdirs?  How's it  
organized? In some ways that might make sense, but I think we'd need  
to sit down and think it through with all the twisted combinations  
our hardware people come up with.  The fact is that there's really no  
clean way to deal with all the wackiness.  So we just pick something  
that fits OK and go with it.

Cheers,
B
