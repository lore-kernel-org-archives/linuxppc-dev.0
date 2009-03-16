Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29857DDFB5
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 22:41:37 +1100 (EST)
Message-Id: <4A2B46D3-A304-4F66-82F9-4FFF37D0A0E8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903161144.48861.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 06:41:21 -0500
References: <200903131121.00077.david.jander@protonic.nl>
	<200903131524.36865.david.jander@protonic.nl>
	<D4F18914-8CE5-46E4-9BBB-3AEF7E2DD2CA@kernel.crashing.org>
	<200903161144.48861.david.jander@protonic.nl>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 5:44 AM, David Jander wrote:

> On Friday 13 March 2009 16:23:15 Kumar Gala wrote:
>> [...]
>>>> This errata impacts a number of cores and so we should make this a
>>>> CPU
>>>> feature fixup rather than #ifdef code.
>>>
>>> It should impact only MPC5121e and probably MPC5123, but according  
>>> to
>>> Freescale no other processors that use this core...
>>
>> Not sure about that.. But the errata impacts all e300c2/c3/c4 parts.
>
> Can someone please check if this is true? There should be errata's  
> for all
> other parts that use one of these cores then.
>
>>> Anyway, I'll try to investigate about how to write a "CPU feature
>>> fixup",
>>> I've never done that before (If you could give me a hint?)
>>
>> I've posted a patch that should add the CPU feature support.  This is
>> only compile tested.  You'll need to try it out on real HW :)
>
> That's a problem right now: The only useable kernel for the MPC5121e  
> is the
> one on the 'ads5121' head from denx, and that is version 2.6.24.6.  
> Your patch
> (v3) does not apply to that kernel, so I would have to change a few  
> things
> before I can actually try it out:
>
>> #define CPU_FTR_NEED_DTLB_SW_LRU       ASM_CONST(0x0000000000010000)
>
> In 2.6.24.6 this constant is used for something else. Would it be  
> possible to
> pick anotherone, in order to make dual-kernel patches easier to  
> maintain for
> now?
>
>>>>> +       mfspr   r3,SPRN_DMISS
>>>>> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
>>>>> +       lis     r2,lrw@ha       /* Search index in lrw[] */
>>>>> +       addi    r2,r2,lrw@l
>>>>> +       tophys(r2,r2)
>>>>> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
>>>>> +       cmpwi   0,r1,0         /* Was it way 0 last time? */
>>>>
>>>> Why not use a bit vector since we only need one bit of information.
>>>> Additionally we can use a single SPRG at that point instead to keep
>>>> track of the LRU information.
>>>
>>> Sounds interesting. I am just learning my first steps in powerpc-
>>> assembly, so
>>> please forgive if this is a little inefficient still. I'll try again
>>> next week.
>>
>> Not at all.  This has been on my todo list just not high priority so
>> I'm happy to get someone to work on it and have setup already that  
>> can
>> show perf differences.
>
> On your Todo list? Does that mean you know about another processor  
> that has
> the same problem?

Yes, I work at Freescale and am aware that the errata impacts all c2/ 
c3/c4 class chips.

>> I might work up a newer version w/the SPRG idea if I'm feeling up  
>> to it.
>
> Do you mean it is possible to just pick an SPRG that will be used  
> only by this
> handler and make sure no other piece of software will touch it?  
> Would be
> great. Is there a way of knowing which SPRG's are used by linux? I  
> read in
> the e300 core-RM, that SPRG4...7 are unique to this iteration of the  
> G2
> anyway, so one of those might be a good candidate?

I was thinking one from SPRG4..7 should be fine since Linux doesn't  
use them for anything.

We should try this w/SPRG & w/memory to see if we notice any perf  
difference.

> I have quite a lot of work pressure right now, and unfortunately  
> very little
> time I can dedicate to this. Given the fact that I also cannot test  
> patches
> for mainline, because MPC5121e support is just not complete enough  
> yet, do
> you agree if I modify my own patch (with ifdef's instead of  
> CPU_FTR...) to
> give you feedback on performance impacts, while you implement it as  
> CPU_FTR
> afterwards for mainline? That way I can avoid doing double work, and  
> spend
> more time on testing it actually....
> If you agree, I'll start hacking away on the SPRG version  
> immediately :-)

I think that's fine.  The CPU feature bit is minor to deal with and  
Ben has stated he wants it to be a MMU feature which is something new  
as well.  It should be easy to convert the CPU_FTR wrapping into  
#ifdefs instead.

I have a few other patches related to this that I am not sure if they  
will apply to the 2.6.24.6 tree you are based on.

- k
