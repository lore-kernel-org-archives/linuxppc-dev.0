Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91EF4B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 08:02:08 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5TLbNeb018376
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 17:37:23 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5TM24vt1605742
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 18:02:04 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5TM24Yn016784
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 18:02:04 -0400
Message-ID: <4E0BA0C3.6030805@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2011 15:01:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
References: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>	<1308072658.2452.10.camel@orca.stoopid.dyndns.org>	<1308075422.13495.8.camel@dhcp-100-2-27.bos.redhat.com>
	<20110614140431.31ae4357__48367.5367352136$1308078343$gmane$org@schlenkerla.am.freescale.net>
In-Reply-To: <20110614140431.31ae4357__48367.5367352136$1308078343$gmane$org@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nathan Lynch <ntl@pobox.com>, linuxppc-dev@lists.ozlabs.org,
	Steve Best <sfbest@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2011 12:04 PM, Scott Wood wrote:
> On Tue, 14 Jun 2011 14:17:01 -0400
> Steve Best<sfbest@us.ibm.com>  wrote:
>
>> On Tue, 2011-06-14 at 12:30 -0500, Nathan Lynch wrote:
>>> Hi Steve,
>>>
>>> On Tue, 2011-06-14 at 12:58 -0400, Steve Best wrote:
>>>> +/*
>>>> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
>>>> + * is valid. The argument is a physical page number.
>>>> + *
>>>> + * On PowerPC, access has to be given to data regions used by X. We have to
>>>> + * disallow access to device-exclusive MMIO regions and system RAM.
>>>> + */
>>>> +int devmem_is_allowed(unsigned long pfn)
>>>> +{
>>>> +        if ((pfn>= 57360 || pfn<= 57392))
>>>> +                return 1;
>>>
>>> That seems... fragile.  Where do these numbers come from, and are they
>>> appropriate for all platforms and configurations?
>>
>> This is the range I got from testing pseries blades and servers. maybe
>> there is a better way to get this range anyone know of a way?
>
> Use iomem_is_exclusive(), as other architectures (e.g. x86, arm) do.
>
> Anything else is both platform-specific, and inappropriate hardcoding of
> policy.

x86 allows access to the first 256 pages. Are there other regions that 
we should allow in power besides the !iomem_is_exclusive() region ?

>
> -Scott
