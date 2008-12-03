Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D635DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 01:48:27 +1100 (EST)
Message-Id: <234C3BEB-1747-493E-B903-A564959A8671@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20081203053118.GH6829@localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Remove modpost warning with start_secondary
Date: Wed, 3 Dec 2008 08:48:20 -0600
References: <1228278723-1153-1-git-send-email-galak@kernel.crashing.org>
	<20081203053118.GH6829@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 2, 2008, at 11:31 PM, Nathan Lynch wrote:

> Kumar Gala wrote:
>> WARNING: vmlinux.o(.text+0x2aa): Section mismatch in reference from  
>> the variable __secondary_start to the  
>> function .devinit.text:start_secondary()
>> The function __secondary_start() references
>> the function __devinit start_secondary().
>>
>> start_secondary gets called by __secondary_start which is in asm  
>> code so its
>> not marked as __devinit.  Its easier to just remove the __devinit  
>> from
>> start_secondary than try and deal with __secondary_start.
>
> Which just gets another mismatch warning here:
>
> WARNING: arch/powerpc/kernel/built-in.o(.text+0x23cc4): Section  
> mismatch in reference from the function .start_secondary() to the  
> function .devinit.text:.smp_store_cpu_info()
> The function .start_secondary() references
> the function __devinit .smp_store_cpu_info().
> This is often because .start_secondary lacks a __devinit
> annotation or the annotation of .smp_store_cpu_info is wrong.
>
> Isn't there a better way to address this?  It doesn't seem right to
> increase the kernel's memory usage to get rid of a modpost warning.

Fair.. what defconfig did you build?

- k
