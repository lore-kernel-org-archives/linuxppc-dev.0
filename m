Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB68CDE49E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 23:31:55 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id m7LDVmPD031594
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 13:31:48 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7LDVmpt1663020
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:31:48 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7LDVldu026940
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:31:48 +0200
Message-ID: <48AD6E42.6060406@linux.vnet.ibm.com>
Date: Thu, 21 Aug 2008 15:31:46 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
	<48AC13E5.5010503@linux.vnet.ibm.com>
	<1219257000.14362.90.camel@localhost.localdomain>
	<1219258333.26429.29.camel@jdub.homelinux.org>
	<1219259211.14362.94.camel@localhost.localdomain>
	<20080820151848.69cb8f16@zod.rchland.ibm.com>
In-Reply-To: <20080820151848.69cb8f16@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	kvm-ppc@vger.kernel.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Wed, 20 Aug 2008 14:06:51 -0500
> Hollis Blanchard <hollisb@us.ibm.com> wrote:  
>   
>>>>> To be honest I unfortunately don't know how big the impact for 
>>>>> non-virtualized systems is. I would like to test it, but without 
>>>>> hardware performance counters on the core I have I'm not sure (yet)
>>>>> how 
>>>>> to measure that in a good way - any suggestion welcome.
>>>>>           
>>>> I don't see why we need performance counters. Can't we just compare any
>>>> bare metal benchmark results with the patch both applied and not?
>>>>         
>>> Do you know of one that causes a large amount of
>>> local_irq_{disable,enable}s to be called?
>>>       
>> I think *every* workload causes a large number of
>> local_irq_{disable,enable} calls... :)
>>     
>
> Well, sure.  I was just going for "test the change as specifically as
> possible."  One could write a module that did X number of
> disable/enable pairs and reported the timebase at start and end to
> compare.  X could even be a module parameter.  Just to try and
> eliminate noise or whatever from the testing.
>
> /me shrugs.
>
> josh
>   
yeah I thought of something like that too, because I expect the 
difference to be very small.
Instead of a module I wanted to put this somewhere prior to the kernel 
mounting root-fs to avoid interferences from whatever userspace is doing 
(e.g. causing  thousands of interrupts come back while the module 
perform that test.).
Eventually we need a synthetic benchmark like that AND a check how it 
affects a common system to be sure.


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
