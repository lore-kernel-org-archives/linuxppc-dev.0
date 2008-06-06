Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D810DE0D8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 01:42:11 +1000 (EST)
Message-Id: <0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1212766264.6788.4.camel@ld0161-tx32>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Default flats for running dtc from kernel build
Date: Fri, 6 Jun 2008 10:42:01 -0500
References: <20080606143347.B35CC247FE@gemini.denx.de>
	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
	<1212766264.6788.4.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 10:31 AM, Jon Loeliger wrote:

> On Fri, 2008-06-06 at 09:51 -0500, Kumar Gala wrote:
>
>>>
>>> I will. But wouldn't it make sense to allow at least for  some   
>>> level
>>> of  compatibility with older versions of U-Boot? Adding these  
>>> options
>>> as default would probably not hurt?
>>
>> Agreed.  I didn't realize we could actually do this from the kernel
>> build system.
>>
>> I'm sure others will have their two cents to add.
>>
>> But something like:
>>
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index c40fb82..52db85a 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -29,6 +29,8 @@ ifdef CONFIG_DEBUG_INFO
>>  BOOTCFLAGS     += -g
>>  endif
>>
>> +DTS_FLAGS      ?= -R4 -S 0x3000
>> +
>>  ifeq ($(call cc-option-yn, -fstack-protector),y)
>>  BOOTCFLAGS     += -fno-stack-protector
>>  endif
>
> Hrm.  Should we use -p <extra_space> instead of -S <total_space>?
> Seems someone added this DTC commit last November:
>
>        commit 2b7dc8dce549ad72ad437b254bf756d7ba4c2a5a
>        Author: Kumar Gala <galak@kernel.crashing.org>
>        Date:   Wed Nov 28 10:21:12 2007 -0600
>
>            Add an option to pad the blob that is generated
>
>            There are times when we need extra space in the blob and  
> just want
>            to have it added on w/o know the exact size to make it.
>
>            The padding and min size options are mutually exclusive.
>
>            Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> A thought,
> jdl
>

Yeah, I think the -R isn't need either.

So maybe:

DTS_FLAGS	?= -P 0x1000

1k seems like more than enough default padding.

- k
