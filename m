Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A21ADDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:37:30 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U0b6Hs013250
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:37:06 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U0fS64256352
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:41:29 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U0bdpr029588
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:37:39 +1000
Message-ID: <4817BF4D.7070706@au1.ibm.com>
Date: Wed, 30 Apr 2008 10:37:33 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] Add struct iommu_table argument to
	iommu_map_sg()
References: <4816AF79.502@au1.ibm.com> <20080429175413.GA10269@lixom.net>
In-Reply-To: <20080429175413.GA10269@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Tue, Apr 29, 2008 at 03:17:45PM +1000, Mark Nelson wrote:
>> Make iommu_map_sg take a struct iommu_table. It did so before commit
>> 740c3ce66700640a6e6136ff679b067e92125794 (iommu sg merging: ppc: make
>> iommu respect the segment size limits).
>>
>> This stops the function looking in the archdata.dma_data for the iommu
>> table because in the future it will be called with a device that has
>> no table there.
> 
> The logical thing would be to add the archdata.dma_data to said device
> instead, no? Without seeing the rest of the code that makes use of it
> it's hard to tell anyway, so please post that.

I'll post the follow on series of patches as an RFC to give you a better
understanding of what I'm trying to do; but basically I'm building on
the new dma_*map*_attrs() interfaces that Andrew Morton sent to Linus
last night and implementing them for powerpc (in particular the Cell
platform). To cut a longish story short, the fixed linear mapping for
the Cell's IOMMU can be set to either be weakly or strongly ordered,
and so a device that has been identified as being able to use the
fixed mapping can later request a mapping that cannot be satisfied using
the fixed mapping (eg: it may request a weakly ordered mapping when
the fixed mapping is strongly ordered, or vice versa). Devices that
use the fixed mapping use the dma_direct_ops with their dma_data being
the necessary offset, but for the case above they have to use the
iommu_map*() functions that the dma_iommu_ops use. So that's how we end
up calling iommu_map_sg() with a device that doesn't have the table
in the dma_data (and already has something useful in dma_data).

I'll try to get the follow on series of patches cleaned up today and
send them out asap, so if my ramblings above turned out to be too
obscure the code will hopefully clear things up.

Thanks!

Mark.

> 
>> This also has the nice side effect of making iommu_map_sg() match the
>> other map functions.
> 
> Consistency is good, but I wonder if the opposite wouldn't be the better
> way to go here: always just pass down just the dev pointer instead. The
> table can be reached from it.
> 
> 
> -Olof
> 
