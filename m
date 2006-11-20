Return-Path: <jschopp@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5FBA67BD9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 15:22:06 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAK4M3O2015078
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Nov 2006 23:22:03 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAK4M3Gb509980
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Nov 2006 21:22:03 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAK4M2V7023880
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Nov 2006 21:22:03 -0700
Message-ID: <45612D68.8080404@austin.ibm.com>
Date: Sun, 19 Nov 2006 22:22:00 -0600
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
References: <20061116154051.GB2008@localdomain>	
	<20061117033638.0E24B67BCE@ozlabs.org>	
	<20061117180456.GG23600@austin.ibm.com>
	<1163984914.7832.16.camel@localhost.localdomain>
In-Reply-To: <1163984914.7832.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: srinivasa@in.ibm.com, ego@in.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Anton Blanchard <anton@samba.org>, ntl@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	/* Isolation and deallocation are definatly done by
>>                                         ^^^^^^^^^
>> typo

That word definitely gives me trouble.  I'd imagine the typo originated with me.

>>
>>> +	 * drslot_chrp_cpu.  If they were not they would be
>>> +	 * done here.  Change isolate state to Isolate and
>>> +	 * change allocation-state to Unusable.
>>> +	 */
>>> +	paca[cpu].cpu_start = 0;
>> I can't figure out what the comment means with respect 
>> to this code ... 
> 
> Me either. It's unchanged from the original merge of cpu hotplug:
> http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=24c13f21f0a6abe07020a959990da2b134e6734f
> http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=blobdiff;h=72144b6122f9336e7fa242e50b65b099df0cd72b;hp=f671515c0676e61064ae414273fa4546d0c04938;hb=24c13f21f0a6abe07020a959990da2b134e6734f;f=arch/ppc64/kernel/smp.c
> 
> Which carries the name of one Joel Schopp :)
> 
> Grepping the tree at that point finds no other mention of
> drslot_chrp_cpu, so I think it's a stale comment - we should probably
> just rip it out - Joel?

It might be clearer by saying "the userspace program drslot_chrp_cpu" or "isolation and 
deallocation occur in userspace, so just stop the cpu.  If isolation and deallocation ever 
move from userpace to kernel space they would go here".  On pseries dynamic partitioning 
or cpu guard (the things that initiate a cpu hotplug) all call a userspace program drmgr, 
which calls drslot_chrp_cpu, which then talks to the firmware to isolate and unallocate 
(on remove, the opposite on add) after it has hotplug removed the cpu via the /sys 
interface.  This allows the cpu to be reassigned to another partition.

At least that's what I remember from back then when we did it.  Though I don't think it's 
changed any.  Feel free to make the comment more intelligible.
