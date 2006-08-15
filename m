Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05B5F67B71
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 20:23:12 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7FAN7gi076440
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 10:23:07 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7FAOxk6107298
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 11:24:59 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7FAN6vt002916
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 11:23:07 +0100
Message-ID: <44E19765.7030301@de.ibm.com>
Date: Tue, 15 Aug 2006 11:44:05 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com>	
	<1155190921.9801.43.camel@localhost.localdomain>	
	<44E07267.7070007@de.ibm.com>
	<1155600499.9047.13.camel@localhost.localdomain>
In-Reply-To: <1155600499.9047.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Mon, 2006-08-14 at 14:53 +0200, Jan-Bernd Themann wrote:
>> Michael Ellerman wrote:
>>>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000000000 -0800
>>>> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
>>>> +
>>>> +#define EHEA_PAGESHIFT  12
>>>> +#define EHEA_PAGESIZE   4096UL
>>>> +#define EHEA_CACHE_LINE 128
>>> This looks like a very bad idea, what happens if you're running on a
>>> machine with 64K pages?
>>>
>> The EHEA_PAGESIZE define is needed for queue management to hardware side.
> 
> You mean the eHEA has its own concept of page size? Separate from the
> page size used by the MMU?
> 

yes, the eHEA currently supports only 4K pages for queues

>>>> +/*
>>>> + *  h_galpa:
>>>> + *  for pSeries this is a 64bit memory address where
>>>> + *  I/O memory is mapped into CPU address space
>>>> + */
>>>> +
>>>> +struct h_galpa {
>>>> +	u64 fw_handle;
>>>> +};
>>> What is a h_galpa? And why does it need a struct if it's just a u64?
>>>
>> The eHEA chip is not PCI attached but directly connected to a proprietary
>> bus. Currently, we can access it by a simple 64 bit address, but this is not
>> true in all cases. Having a struct here allows us to encapsulate the chip
>> register access and to respond to changes to system hardware.
>>
>> We'll change the name to h_epa meaning "ehea physical address"
> 
> Hmm, I'm not convinced. Having the struct doesn't really encapsulate
> much, because most of the places where you use the h_galpa struct just
> pull out the fw_handle anyway. So if you change the layout of the struct
> you're going to have to change most of the code anyway. And in the
> meantime it makes the code a lot less readable, most people understand
> what "u64 addr" is about, whereas "struct h_galpa" is much less
> meaningful. </2c>
> 
> cheers
> 

We already use the h_galpa struct for simulation purposes where we use
this encapsulation to add further required fields to be able to access
the registers (h_galpa has been renamed to h_epa). The name of the
fw_handle element will be changed. Instead of fw_handle, we'll call it
ebus_addr which will make it more readable.

Regards,
Jan-Bernd
