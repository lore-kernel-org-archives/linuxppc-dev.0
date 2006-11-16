Return-Path: <jimix@watson.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E59767BD2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 05:42:11 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGIg8xm021801
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 13:42:08 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGIepJR181204
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 11:40:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGIep0L003966
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 11:40:51 -0700
In-Reply-To: <200611152304.45243.arnd@arndb.de>
References: <200611150937.kAF9b305001499@toshiba.co.jp>
	<20061115183746.GC21633@lst.de> <200611152304.45243.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45AC8C44-8193-4311-B4BF-BF7FF56C8DF4@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH 5/16] hypervisor functions for Celleb
Date: Thu, 16 Nov 2006 13:40:49 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 15, 2006, at 5:04 PM, Arnd Bergmann wrote:

> On Wednesday 15 November 2006 19:37, Christoph Hellwig wrote:
>>> +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t
>>> __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t*  
>>> __out1) {
>>> +     register uint64_t __reg0 __asm__("r3");
>>> +     register uint64_t __reg1 __asm__("r4");
>>> +     register uint64_t __reg2 __asm__("r5");
>>> +     register uint64_t __reg3 __asm__("r6");
>>> +     register uint64_t __sn __asm__("r11") = (0UL);
>>
>> No point in declaring this a register variable, gcc ignores the
>> specifier.
>
> Actually, this is the one place where gcc forces you to use the
> 'register' keyword, the '__asm__("r3")' specifier does not work
> for variables declared without it.
>
>> Is there any chance to not duplicate the inline assembly
>> for every single hypercall but have generic call with n arguments
>> helper, as for the phyp hvcalls?
>
> It's not easy to do it the way phyp does, because the assembly
> needs to pass the call number in %r11, which is not one of the
> argument registers.
>
Just make another one (or a set of them like the phyp calls) and  
define then in assembly.
Certainly a bl to a function will be negligible to the hcall its self.

Is it possible to give the parameters some meaningful names?
It would also be nice to use HMT_MEDIUM and HVSC

-JX
