Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11A41B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:18:41 +1000 (EST)
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78C0EDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:18:40 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EIBS2B023731
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:11:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EIIZC0179284
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:18:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EIFQOh001429
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:15:26 -0400
Message-ID: <4AAE88F7.3010707@austin.ibm.com>
Date: Mon, 14 Sep 2009 13:18:31 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kernel handling of memory DLPAR
References: <4AAABC55.4070207@austin.ibm.com> <4AAABDBB.7010400@austin.ibm.com>
	<20090914063911.GB13139@centrinvest.ru>
In-Reply-To: <20090914063911.GB13139@centrinvest.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrey Panin wrote:
> On 254, 09 11, 2009 at 04:14:35PM -0500, Nathan Fontenot wrote:
>> This adds the capability to DLPAR add and remove memory from the kernel.  The
>> patch extends the powerpc handling of memory_add_physaddr_to_nid(), which is
>> called from the sysfs memory 'probe' file to first ensure that the memory
>> has been added to the system.  This is done by creating a platform specific
>> callout from the routine.  The pseries implementation of this handles the
>> DLPAR work to add the memory to the system and update the device tree.
>>
>> The patch also creates a pseries only 'release' sys file,
>> /sys/devices/system/memory/release.  This file handles the DLPAR
>> release of
>> memory back to firmware and updating of the device-tree.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
>> +static struct property *clone_property(struct property *old_prop)
>> +{
>> +	struct property *new_prop;
>> +
>> +	new_prop = kzalloc((sizeof *new_prop), GFP_KERNEL);
>> +	if (!new_prop)
>> +		return NULL;
>> +
>> +	new_prop->name = kzalloc(strlen(old_prop->name) + 1, GFP_KERNEL);
>> +	new_prop->value = kzalloc(old_prop->length + 1, GFP_KERNEL);
> 
> Memory leak here. What if one kzalloc() succeeded and another failed ?
> 

This should be fine.  The free_property routine will free the name or value
fields if they are allocated.

-Nathan

>> +	if (!new_prop->name || !new_prop->value) {
>> +		free_property(new_prop);
>> +		return NULL;
>> +	}
>> +
>> +	strcpy(new_prop->name, old_prop->name);
>> +	memcpy(new_prop->value, old_prop->value, old_prop->length);
>> +	new_prop->length = old_prop->length;
>> +
>> +	return new_prop;
>> +}
