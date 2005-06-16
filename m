Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id 2D02967A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:42:08 +1000 (EST)
In-Reply-To: <678305db5ee1488bb48a26a4a89c121a@freescale.com>
References: <0fc7d3f2fe1266cdd0beaf44a71bc27c@embeddededge.com>
	<678305db5ee1488bb48a26a4a89c121a@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8a775fb36a415f9b45ed713e4c63caa@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Thu, 16 Jun 2005 08:42:08 -0700
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> If I understand you correctly this is not any different than how we 
> handle the TSEC (gianfar) on 85xx.  The platform device structure just 
> gives us physical address (start & end) and IRQs and we use a 
> structure in the driver that maps to the start address.
>
> - kumar
>

So have we answered your question regarding the inclusion of DMA and 
CPM in the platform_device array? If I am reading this correctly, all 
the individual CPM "objects" should be defined in the device structure 
with their physical address location defined. The complete IMMAP 
structure can then be constructed from these objects if required.

Is it possible to add some flags to the IORESOURCE information to 
address the differences in SCC structures between processor types? 
Perhaps something like this could be used to apply the correct 
structure cast in the device driver. Just a thought...

-- Allen

>> Having just converted an different SoC part from using offsets to data
>> structures, I have to say that tables/defines of offsets are more of a
>> mess
>> than a data structure.  We don't have to define the whole of the 
>> IMMAP,
>> but
>> using the data structures for the individual device spaces is quite
>> effective.
>> The advantage of using the data structure is it also conveys the data
>> type
>> size, adding a level error checking.  I also dislike io accessor
>> functions/macros,
>> especially on these processor specific devices.
>>
>>
>> Thanks.
>>
>> 	-- Dan
>
>
