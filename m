Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7A45B681B8
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 03:34:59 +1100 (EST)
In-Reply-To: <0298A03B-4A0D-48CE-B941-EB3D0CEA9606@kernel.crashing.org>
References: <Pine.LNX.4.61.0601311746250.18350@cde-tx32-ldt329.sps.mot.com>
	<17384.30426.76075.491857@cargo.ozlabs.ibm.com>
	<0298A03B-4A0D-48CE-B941-EB3D0CEA9606@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5F1B7DEF-3AB6-4A7B-A5EB-AEF24348E556@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: [PATCH] powerpc: Fix Kernel FP unavail exception for BookE
Date: Tue, 7 Feb 2006 10:35:25 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, galak@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2006, at 8:28 AM, Kumar Gala wrote:

>
> On Feb 7, 2006, at 4:30 AM, Paul Mackerras wrote:
>
>> Becky Bruce writes:
>>
>>> powerpc: Correct BookE FP unavailable exception
>>
>> ...
>>
>>> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/ 
>>> kernel/head_booke.h
>>
>> Ummm... which tree has head_booke.h?
>
> powerpc.git should have it.  If not this is an issue that should be  
> fixed.


>
> Becky, is this change also needed for arch/ppc?  If so can you  
> fixup arch/ppc/kernel/head_booke.h and provide patch that  
> duplicates head_booke.h in arch/powerpc/kernel if its not there.

No change needed there - it was correct in arch/ppc, just not in arch/ 
powerpc.  The 8540 patch was based on a slightly older copy of the  
file that didn't have this change and we didn't catch the problem in  
testing because the FPU isn't enabled for 8540.  I discovered this  
later.

The 8540 flat tree support patch added this file to arch/powerpc/ 
kernel.  As you pointed out in a different mail, this patch has  
disappeared from the tree recently.

-B
