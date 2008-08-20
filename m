Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AED9DE2C8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 22:41:37 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7KCfU2m366460
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 12:41:30 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7KCfUY72764888
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:41:30 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7KCfTN8005244
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:41:29 +0100
Message-ID: <48AC10F5.2010506@linux.vnet.ibm.com>
Date: Wed, 20 Aug 2008 14:41:25 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191328.16934.arnd@arndb.de>
In-Reply-To: <200808191328.16934.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jimix@us.ibm.com, linuxppc-dev@ozlabs.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
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
>> +static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
>> +{
>> +       register unsigned long hcall asm ("r0") = nr;
>> +       register unsigned long arg1 asm ("r3") = p1;
>> +       register long ret asm ("r11");
>> +
>> +       asm volatile(".long %1"
>> +                       : "=r"(ret)
>> +                       : "i"(KVM_HYPERCALL_BIN), "r"(hcall), "r"(arg1)
>> +                       : "r4", "r5", "r6", "r7", "r8",
>> +                         "r9", "r10", "r12", "cc");
>> +       return ret;
>> +}
>>     
>
> What is the reasoning for making the calling convention different from
> all the existing hcall interfaces here?
>
> pseries uses r3 for the hcall number, lv1 and beat use r11, so using
> r0 just for the sake of being different seems counterintuitive.
>
> 	Arnd <><
>   
Some documentation is here 
http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI
As far as I remember it was oriented on system calls, from my point we 
can still change it atm.
When we discussed about that I was too new to the power architecture to 
really get all the details, but I assume Hollis and Jimi can answer you 
that.


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
