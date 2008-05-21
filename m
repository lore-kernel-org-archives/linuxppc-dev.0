Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4CBA7DDF81
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:27:26 +1000 (EST)
Message-ID: <4833875A.9090006@windriver.com>
Date: Wed, 21 May 2008 11:22:18 +0900
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Uniformly use memstart_addr variable as the
	start address of physical memory in powerpc branch
References: <48337D1C.2070108@windriver.com>
	<BEDAF2CE-73A5-4FE4-848B-936B7D675131@kernel.crashing.org>
In-Reply-To: <BEDAF2CE-73A5-4FE4-848B-936B7D675131@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala wrote:
> 
> On May 20, 2008, at 8:38 PM, Andrew Liu wrote:
> 
>> [POWERPC]: Uniformly use memstart_addr as the start address of RAM
>>
>> The variable: memstart_addr whose initial value is got from dts file
>> is used as the start address of physical memory in PowerPC ARCH,
>> although it is used in functions: mapin_ram(pgtable_32.c) and
>> cam_mapin_ram(fsl_booke_mmu.c), however, in function: mmu_mapin_ram
>> (ppc_mmu_32.c), use 0 as the start address of physical memory, so
>> it is necessary to unify them: in mmu_mapin_ram, use memstart_addr
>> as the start address of physical memory, instead of 0.
>>
>> Signed-off-by: Andrew Liu <shengping.liu@windriver.com>
>> ---
> 
> Do you have a case where this is non-zero for ppc_mmu_32?  I left these 
> alone because I wasn't aware of one (or if its reasonable).
> 

No.
I submitted this patch just because in ppc branch, PPC_MEMSTART is used as 
the start address of physical memory uniformly, however, in powerpc branch, 
use memstart_addr and 0, although, almost for all boards which are in powerpc,
they are equal, from the aspect of code consistency, I think it is necessary to
unify them.

You know we can't make sure in future the start address of all incoming 
boards' RAM is 0, especially, in AMP system, different cpu uses the different RAM area, 
definitely, the start address of some is not 0.

BRs,
Andrew


> - k
> 
> 
