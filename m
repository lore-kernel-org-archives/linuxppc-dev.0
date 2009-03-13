Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CFACDE10E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 02:23:27 +1100 (EST)
Message-Id: <D4F18914-8CE5-46E4-9BBB-3AEF7E2DD2CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200903131524.36865.david.jander@protonic.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] [PATCH v2] MPC5121 TLB errata workaround
Date: Fri, 13 Mar 2009 10:23:15 -0500
References: <200903131121.00077.david.jander@protonic.nl>
	<9223B51A-4340-4636-B1F8-6D49A5F8833A@kernel.crashing.org>
	<200903131524.36865.david.jander@protonic.nl>
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


On Mar 13, 2009, at 9:24 AM, David Jander wrote:

> On Friday 13 March 2009 14:21:57 Kumar Gala wrote:
>>>
>>
>> What does cat /proc/cpuinfo show on this board?
>
> # cat /proc/cpuinfo
> processor       : 0
> cpu             : e300c4
> clock           : 400.000000MHz
> revision        : 1.0 (pvr 8086 2010)
> bogomips        : 99.84
> timebase        : 50000000
> platform        : MPC5121 Generic
>
>>> +#ifdef CONFIG_PPC_MPC512x
>>> +/* MPC512x: workaround for errata in die M36P and earlier:
>>> + * Implement LRW for TLB way.
>>> + */
>>
>> This errata impacts a number of cores and so we should make this a  
>> CPU
>> feature fixup rather than #ifdef code.
>
> It should impact only MPC5121e and probably MPC5123, but according to
> Freescale no other processors that use this core...

Not sure about that.. But the errata impacts all e300c2/c3/c4 parts.

> Anyway, I'll try to investigate about how to write a "CPU feature  
> fixup",
> I've never done that before (If you could give me a hint?)

I've posted a patch that should add the CPU feature support.  This is  
only compile tested.  You'll need to try it out on real HW :)

>>> +       mfspr   r3,SPRN_DMISS
>>> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
>>> +       lis     r2,lrw@ha       /* Search index in lrw[] */
>>> +       addi    r2,r2,lrw@l
>>> +       tophys(r2,r2)
>>> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
>>> +       cmpwi   0,r1,0         /* Was it way 0 last time? */
>>
>> Why not use a bit vector since we only need one bit of information.
>> Additionally we can use a single SPRG at that point instead to keep
>> track of the LRU information.
>
> Sounds interesting. I am just learning my first steps in powerpc- 
> assembly, so
> please forgive if this is a little inefficient still. I'll try again  
> next week.

Not at all.  This has been on my todo list just not high priority so  
I'm happy to get someone to work on it and have setup already that can  
show perf differences.

I might work up a newer version w/the SPRG idea if I'm feeling up to it.

- k
