Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A59A167B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 14:55:28 +1000 (EST)
Message-ID: <4535B40A.80401@oracle.com>
Date: Tue, 17 Oct 2006 21:56:42 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] ramdisk: make powerpc allmodconfig build
References: <20061017094742.a61c4873.randy.dunlap@oracle.com>	
	<20061017180447.GC822@shell0.pdx.osdl.net>
	<1161141055.7906.0.camel@localhost.localdomain>
In-Reply-To: <1161141055.7906.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2006-10-17 at 11:04 -0700, Judith Lebzelter wrote:
>> Hi Randy,
>>
>> There is another section in that function which depends on 
>> 'CONFIG_BLK_DEV_INITRD' being defined.  Although it does not throw an
>> error, it does depend on some of the variables set in this section,
>> but not 'rd_size'.  I think for consistancy it might be better to do 
>> somthing like this(below)?  Or else add the same ifdef down there...
>>
>> Judith
>>
>>
>> Index: 2/linux/arch/powerpc/platforms/iseries/setup.c
>> ===================================================================
>> --- 2.orig/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:49:31.423551104 -0700
>> +++ 2/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:52:22.682515784 -0700
>> @@ -305,8 +305,10 @@
>>  		initrd_end = initrd_start + naca.xRamDiskSize * HW_PAGE_SIZE;
>>  		initrd_below_start_ok = 1;	// ramdisk in kernel space
>>  		ROOT_DEV = Root_RAM0;
>> +#if defined(CONFIG_BLK_DEV_RAM)
>>  		if (((rd_size * 1024) / HW_PAGE_SIZE) < naca.xRamDiskSize)
>>  			rd_size = (naca.xRamDiskSize * HW_PAGE_SIZE) / 1024;
>> +#endif /* CONFIG_BLK_DEV_RAM */
>>  	} else
>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>  	{
> 
> That code is bogus, we'll remove it entirely.

Great, thanks.  :)

-- 
~Randy
