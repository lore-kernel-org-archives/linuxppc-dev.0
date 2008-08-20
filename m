Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F2A9DE040
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 22:54:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7KCrxR2158636
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 12:53:59 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7KCrwvs2314454
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 14:53:58 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7KCrw6s010284
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 14:53:58 +0200
Message-ID: <48AC13E5.5010503@linux.vnet.ibm.com>
Date: Wed, 20 Aug 2008 14:53:57 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191342.29918.arnd@arndb.de>
In-Reply-To: <200808191342.29918.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
>   
>> Dependent on the already existing CONFIG_KVM_GUEST config option this patch
>> changes wrteei to wrtee allowing the hypervisor to rewrite those to nontrapping
>> instructions. Maybe we should split the kvm guest otpimizations in two parts
>> one for the overhead free optimizations and on for the rest that might add
>> some complexity for non virtualized execution (like this one).
>>
>> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>     
>
> How significant is the performance impact of this change for non-virtualized
> systems? If it's very low, maybe you should not bother with the #ifdef, and
> if it's noticable, you might be better off using dynamic patching for this.
>
> 	Arnd <><
>   
To be honest I unfortunately don't know how big the impact for 
non-virtualized systems is. I would like to test it, but without 
hardware performance counters on the core I have I'm not sure (yet) how 
to measure that in a good way - any suggestion welcome.
I'm really sure that any jumping around style dynamic patching in the 
guest like function pointers etc will be slower than just let the load 
be there. Unfortunately I can not rewrite it from the hypervisor because 
for "wrteei" I would need a "stwi" to rewrite it in one instruction.
The patch as it is today let you choose between 10% benefit for 
virtualized guest and an unkown but surely very small overhead on native 
hardware.

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
