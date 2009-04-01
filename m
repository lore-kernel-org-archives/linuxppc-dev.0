Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9E56DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 17:40:16 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n316eAqY013506
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 12:10:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n316eJNJ3690718
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 12:10:19 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n316e9mP009329
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 12:10:10 +0530
Message-ID: <49D30C48.4090902@in.ibm.com>
Date: Wed, 01 Apr 2009 12:10:08 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
References: <49D1E21E.3090505@in.ibm.com> <1238539469.17330.70.camel@pasglop>
In-Reply-To: <1238539469.17330.70.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-03-31 at 14:57 +0530, Sachin Sant wrote:
>   
>> While executing CPU HotPlug[1] tests i observed that during
>> every cpu offline process an exception is thrown.
>>     
>
> Looks like a BUG_ON() to me... can you look at what other
> messages just before that ?
>   
I don't get any other messages when the problem occurs. Infact
if i don't have xmon enabled the machine just hangs without
any messages on the console. I extracted the dmesg log
(attached in my previous mail) through xmon. Here are last few
related messages from 2.6.29-git8 kernel during problem recreation.

<4>IRQ 18 affinity broken off cpu 2
<4>cpu 2 (hwid 2) Ready to die....
<7>CPU0 attaching NULL sched-domain..
<7>CPU1 attaching NULL sched-domain..
<7>CPU2 attaching NULL sched-domain..
<7>CPU3 attaching NULL sched-domain..
<7>CPU0 attaching sched-domain:.
<7> domain 0: span 0-1 level SIBLING.
<7>  groups: 0 1.
<7>  domain 1: span 0-1,3 level CPU.
<7>   groups: 0-1 3.
<7>   domain 2: span 0-1,3 level NODE
<7>    groups: 0-1,3.
<7>CPU1 attaching sched-domain:.
<7> domain 0: span 0-1 level SIBLING.
<7>  groups: 1 0.
<7>  domain 1: span 0-1,3 level CPU.
<7>   groups: 0-1 3.
<7>   domain 2: span 0-1,3 level NODE.
<7>    groups: 0-1,3.
<7>CPU3 attaching sched-domain:.
<7> domain 0: span 0-1,3 level CPU.
<7>  groups: 3 0-1.
<7>  domain 1: span 0-1,3 level NODE.
<7>   groups: 0-1,3...

> That or lookup where the PC and LR values are in System.map
> and maybe get us a backtrace from xmon ?
>
> (You seem to have no symbols, have you built with kallsyms ?)
I have kallsyms and debug info options enabled.

CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_DEBUG_INFO=y

Here is the related information from 2.6.29-git8 kernel. 

llm62 login: cpu 0x2: Vector: 700 (Program Check) at [c0000000074c7ca0]
   pc: 00000000007b6640
   lr: 000000000079ddc0
   sp: c0000000074c7f20
  msr: 8000000000081002
 current = 0xc0000000fe1c8580
 paca    = 0xc000000000ab2800
   pid   = 0, comm = swapper
enter ? for help
[c0000000074c7f20] 0000000000018694 (unreliable)
[c0000000074c7f90] 0000000000008278
SP (4f00000003) is in userspace
2:mon> la %pc
00000000007b6640
2:mon> la c0000000007b6640
c0000000007b6640: .kmem_cache_init+0x2d8/0x528
2:mon> la %lr
000000000079ddc0
2:mon> la c00000000079ddc0
c00000000079ddc0: .mem_init+0x150/0x22c
2:mon>

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
