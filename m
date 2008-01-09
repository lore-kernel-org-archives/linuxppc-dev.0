Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 254C6DDFB5
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:28:49 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09JSWsl031143
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:28:32 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09JSW0D139058
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:28:32 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09JSWt9020118
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:28:32 -0500
Message-ID: <4785205E.4070604@austin.ibm.com>
Date: Wed, 09 Jan 2008 13:28:30 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com>	<20080109042911.GT14201@localdomain>	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
In-Reply-To: <20080109184437.GU14201@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org,
	Linas Vepstas <linasvepstas@gmail.com>, lkessler@us.ibm.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> I used the word "actually".  I already know that it is intended to be
> faster.  :)
> 
>> it should blow it away, as, after all,
>> it requires one less reboot!
> 
> There's more than rebooting going on during system dump processing.
> Depending on the system type, booting may not be where most time is
> spent.
> 
> 
>> As a side effect, the system is in
>> production *while* the dump is being taken;
> 
> A dubious feature IMO.  Seems that the design potentially trades
> reliability of first failure data capture for availability.
> E.g. system crashes, reboots, resumes processing while copying dump,
> crashes again before dump procedure is complete.  How is that handled,
> if at all?

This is a simple version. The intent was not to have a complex dump taking
mechanism in version 1. Subsequent versions will see planned improvement
on the way the pages are tracked and freed. 

Also it is very easily possible now, to register for another dump as soon as the
scratch area is copied to a user designated region. But for now this simple implementation
exists. 

It is also possible to extend this further to only preserve pages that are
kernel pages and free the non required pages like user/data pages etc. This
would reduce the space preserved and would prevent any issues that are
caused by reserving everything in memory except for the first 256 MB. 

Improvements and future versions are planned to make this efficient. But for
now the intent is to get this off the ground and handle simple cases.

> 
> 
>> with kdump,
>> you can't go into production until after the dump is finished,
>> and the system has been rebooted a second time.  On
>> systems with terabytes of RAM, the time difference can be
>> hours.
> 
> The difference in time it takes to resume the normal workload may be
> significant, yes.  But the time it takes to get a usable dump image
> would seem to be the basically the same.
> 
> Since you bring up large systems... a system with terabytes of RAM is
> practically guaranteed to be a NUMA configuration with dozens of cpus.
> When processing a dump on such a system, I wonder how well we fare:
> can we successfully boot with (say) 128 cpus and 256MB of usable
> memory?  Do we have to hot-online nodes as system memory is freed up
> (and does that even work)?  We need to be able to restore the system
> to its optimal topology when the dump is finished; if the best we can
> do is a degraded configuration, the workload will suffer and the
> system admin is likely to just reboot the machine again so the kernel
> will have the right NUMA topology.
> 
> 
>>>> +Implementation details:
>>>> +----------------------
>>>> +In order for this scheme to work, memory needs to be reserved
>>>> +quite early in the boot cycle. However, access to the device
>>>> +tree this early in the boot cycle is difficult, and device-tree
>>>> +access is needed to determine if there is a crash data waiting.
>>> I don't think this bit about early device tree access is correct.  By
>>> the time your code is reserving memory (from early_init_devtree(), I
>>> think), RTAS has been instantiated and you are able to test for the
>>> existence of /rtas/ibm,dump-kernel.
>> If I remember right, it was still too early to look up this token directly,
>> so we wrote some code to crawl the flat device tree to find it.  But
>> not only was that a lot of work, but I somehow decided that doing this
>> to the flat tree was wrong, as otherwise someone would surely have
>> written the access code.  If this can be made to work, that would be
>> great, but we couldn't make it work at the time.
>>
>>>> +To work around this problem, all but 256MB of RAM is reserved
>>>> +during early boot. A short while later in boot, a check is made
>>>> +to determine if there is dump data waiting. If there isn't,
>>>> +then the reserved memory is released to general kernel use.
>>> So I think these gymnastics are unneeded -- unless I'm
>>> misunderstanding something, you should be able to determine very early
>>> whether to reserve that memory.
>> Only if you can get at rtas, but you can't get at rtas at that point.
> 
> Sorry, but I think you are mistaken (see Michael's earlier reply).
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
