Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0BCDDDEF0
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Mar 2008 02:14:04 +1100 (EST)
Message-Id: <2B4FC926-6ECD-4C1C-AE96-61157FF596B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <47D1EF73.7030200@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] bootwrapper: Allow specifying of image physical
	offset
Date: Sat, 8 Mar 2008 09:13:48 -0600
References: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
	<47D1EF73.7030200@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2008, at 7:44 PM, Geoff Levand wrote:

> On 03/07/2008 08:55 AM, Kumar Gala wrote:
>> Normally we assume kernel images will be loaded at offset 0. However
>> there are situations, like when the kernel itself is running at a  
>> non-zero
>> physical address, that we don't want to load it at 0.
>>
>> Allow the wrapper to take an offset.  We use this when building u- 
>> boot images.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/boot/Makefile |    7 +++++++
>> arch/powerpc/boot/wrapper  |   12 ++++++++++--
>> 2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index f43dd6e..1b4bfc6 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -35,6 +35,12 @@ endif
>>
>> BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/libfdt
>>
>> +ifdef CONFIG_MEMORY_START
>> +MEMBASE=$(CONFIG_MEMORY_START)
>
> We have the powerpc config option CONFIG_KERNEL_START.  I'm
> wondering  how this CONFIG_MEMORY_START is different.  I just
> did a quick search, and it seems that CONFIG_MEMORY_START is
> only defined for the renesas arch's.

KERNEL_START is the virtual address of the kernel.  It makes no claims  
about what the physical address is.

MEMORY_START will be the physical address that the kernel is at.  This  
will only be supported on platforms like Book-e that can have  
exception vectors at roughly any address.

- k
