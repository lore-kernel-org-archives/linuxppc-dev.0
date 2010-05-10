Return-Path: <brking@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE932B7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 May 2010 23:40:51 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4ADUQCT019519
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 09:30:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4ADeh3W577776
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 09:40:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4ADegBR008870
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 10:40:42 -0300
Message-ID: <4BE80CD5.809@linux.vnet.ibm.com>
Date: Mon, 10 May 2010 08:40:37 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] powerpc: Add power management support to VIO bus
References: <201005071158.o47BwxPT013700@d03av03.boulder.ibm.com>
	<1273458906.6591.4.camel@concordia>
In-Reply-To: <1273458906.6591.4.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2010 09:35 PM, Michael Ellerman wrote:
> On Fri, 2010-05-07 at 13:58 -0500, Brian King wrote:
>> Adds support for suspend/resume for VIO devices. This is needed for
>> support for HMC initiated hibernation.
>>
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>>
>>  arch/powerpc/kernel/vio.c |   24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm arch/powerpc/kernel/vio.c
>> --- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-05-07 13:49:16.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-05-07 13:49:16.000000000 -0500
>> @@ -1358,6 +1358,29 @@ static int vio_hotplug(struct device *de
>>  	return 0;
>>  }
>>  
>> +static int vio_pm_suspend(struct device *dev)
>> +{
>> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +
>> +	if (pm && pm->suspend)
>> +		return pm->suspend(dev);
>> +	return 0;
>> +}
>> +
>> +static int vio_pm_resume(struct device *dev)
>> +{
>> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +
>> +	if (pm && pm->resume)
>> +		return pm->resume(dev);
>> +	return 0;
>> +}
>> +
>> +const struct dev_pm_ops vio_dev_pm_ops = {
>> +	.suspend = vio_pm_suspend,
>> +	.resume = vio_pm_resume,
>> +};
> 
> That just looks like boiler plate, is there not a generic version
> somewhere?

Looks there is. I'll update the patch to use the generic helpers.

Thanks,

Brian


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
