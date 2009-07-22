Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CAC1BB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 09:41:04 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45EFFDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 09:41:03 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6MNZVOu026105
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 19:35:31 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6MNet3Z254172
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 19:40:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6MNesLQ020994
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 19:40:55 -0400
Message-ID: <4A67A3A2.4050508@us.ibm.com>
Date: Wed, 22 Jul 2009 16:41:22 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
References: <4A5E4D68.6070909@us.ibm.com>	 <1247708506.9851.8.camel@concordia>
	<4A5F5675.6040104@us.ibm.com> <1247790973.16836.11.camel@concordia>
In-Reply-To: <1247790973.16836.11.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2009-07-16 at 09:33 -0700, Mike Mason wrote:
>> Michael Ellerman wrote:
>>> On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
>>>> This patch increments the device_node reference counter when an EEH
>>>> error occurs and decrements the counter when the event has been
>>>> handled.  This is to prevent the device_node from being released until
>>>> eeh_event_handler() has had a chance to deal with the event.  We've
>>>> seen cases where the device_node is released too soon when an EEH
>>>> event occurs during a dlpar remove, causing the event handler to
>>>> attempt to access bad memory locations.
>>>>
>>>> Please review and let me know of any concerns.
>>> Taking a reference sounds sane, but ...
>>>
>>>> Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 
>>>>
>>>> --- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53.000000000 -0700
>>>> +++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00.000000000 -0700
>>>> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
>>>>  	if (event == NULL)
>>>>  		return 0;
>>>>  
>>>> +	/* EEH holds a reference to the device_node, so if it
>>>> +	 * equals 1 it's no longer valid and the event should
>>>> +	 * be ignored */
>>>> +	if (atomic_read(&event->dn->kref.refcount) == 1) {
>>>> +		of_node_put(event->dn);
>>>> +		return 0;
>>>> +	}
>>> That's really gross :)
>> Agreed.  I'll look for another way to determine if device is gone and
>> the event should be ignored.  Suggestions are welcome :-)

Actually, it turns out the atomic_read() isn't necessary.  I just need to take the reference to the device_node when the EEH error is detected and let EEH try to handle the error.  EEH detects the fact that the device is no longer valid, aborts the recovery attempt, then gives the device_node reference back.  Works as expected.

I'll resubmit the patch without the atomic_read().

> 
> Benh and I had a quick chat about it, and were wondering whether what
> you really should be doing is taking a reference to the pci device
> (perhaps as well as the device node).

EEH already does that 3 lines before the of_node_get (see below).

> 
> @@ -140,7 +149,7 @@ int eeh_send_failure_event (struct devic
>         if (dev)
>                 pci_dev_get(dev);
>  
> -       event->dn = dn;
> +       event->dn = of_node_get(dn);
>         event->dev = dev;
> 

Thanks,
Mike
