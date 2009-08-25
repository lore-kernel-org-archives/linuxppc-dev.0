Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5DB1EB7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 12:05:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A74A2DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 12:05:04 +1000 (EST)
Message-Id: <BF5D9DCD-A15E-4E11-B35E-1144B2DF722E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090812150709.GM14754@codiert.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: change to of MTD partition parsing
Date: Mon, 24 Aug 2009 21:04:53 -0500
References: <8AADD34E-A0B7-442D-85D8-977A761084EF@kernel.crashing.org>
	<20090812150709.GM14754@codiert.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

We need a better solution to the problem.  What does the device tree  
on SLOF look like?

- k

On Aug 12, 2009, at 10:07 AM, Benjamin Krill wrote:

> Hi Kumar,
>
> slof has a further node inside the flash node which is not a partition
> entry. The old code just used all children and since the further node
> isn't a partition not all needed properties are there.
>
> cheers
> ben
>
>
> * Kumar Gala | 2009-08-12 09:46:10 [-0500]:
>
>> Ben,
>>
>> The following commit breaks the previous definition of flash  
>> partitions according to
>> Documentation/powerpc/dts-bindings/mtd-physmap.txt.  Using the  
>> 'name' field is bad practice.  What was going
>> on w/the SLOF case?
>>
>> - k
>>
>>
>> commit 4b08e149c0e02e97ec49c2a31d14a0d3a02f8074
>> Author: Benjamin Krill <ben@codiert.org>
>> Date:   Fri Jan 23 17:18:05 2009 +0100
>>
>>   [MTD] ofpart: Check name property to determine partition nodes.
>>
>>   SLOF has a further node which could not be evaluated
>>   by the current routine. The current routine returns
>>   because the node hasn't the required reg property. As
>>   fix this patch adds a check to determine the partition
>>   child nodes. If the node is not a partition the number
>>   of total partitions will be decreased and loop continues
>>   with the next nodes.
>>
>>   Signed-off-by: Benjamin Krill <ben@codiert.org>
>>   Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
>>
