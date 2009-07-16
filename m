Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81994B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 02:39:44 +1000 (EST)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 168D4DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 02:39:42 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6GGUqn0013436
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 10:30:52 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6GGYBsb256266
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 10:34:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6GGYBfL010511
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 10:34:11 -0600
Message-ID: <4A5F5675.6040104@us.ibm.com>
Date: Thu, 16 Jul 2009 09:33:57 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
References: <4A5E4D68.6070909@us.ibm.com> <1247708506.9851.8.camel@concordia>
In-Reply-To: <1247708506.9851.8.camel@concordia>
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
> On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
>> This patch increments the device_node reference counter when an EEH
>> error occurs and decrements the counter when the event has been
>> handled.  This is to prevent the device_node from being released until
>> eeh_event_handler() has had a chance to deal with the event.  We've
>> seen cases where the device_node is released too soon when an EEH
>> event occurs during a dlpar remove, causing the event handler to
>> attempt to access bad memory locations.
>>
>> Please review and let me know of any concerns.
> 
> Taking a reference sounds sane, but ...
> 
>> Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 
>>
>> --- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53.000000000 -0700
>> +++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00.000000000 -0700
>> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
>>  	if (event == NULL)
>>  		return 0;
>>  
>> +	/* EEH holds a reference to the device_node, so if it
>> +	 * equals 1 it's no longer valid and the event should
>> +	 * be ignored */
>> +	if (atomic_read(&event->dn->kref.refcount) == 1) {
>> +		of_node_put(event->dn);
>> +		return 0;
>> +	}
> 
> That's really gross :)

Agreed.  I'll look for another way to determine if device is gone and the event should be ignored.  Suggestions are welcome :-)

> 
> And what happens if the refcount goes to 1 just after the check? ie.
> here.
> 
>>  	/* Serialize processing of EEH events */
>>  	mutex_lock(&eeh_event_mutex);
>>  	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
> 
> 
> cheers
> 
