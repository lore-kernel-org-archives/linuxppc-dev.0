Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 33D49DDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 04:53:47 +1100 (EST)
Message-ID: <4748651E.2020806@scram.de>
Date: Sat, 24 Nov 2007 18:53:34 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
References: <4745BB5F.6060002@scram.de>	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
	<20071123005121.4d38d877@kernel.crashing.org>
In-Reply-To: <20071123005121.4d38d877@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

>>> +       printk(KERN_ERR "%s(): Not able to issue CPM command\n",
>>> +               __FUNCTION__);
>>> +       return -EIO;  
>>>       
>> Do these need to be protected with a spin lock?
>>     
> Even that might be not enough - we may have simultaneous call of this func in non-smp case...
> I was thinking of some kind of refcount, so one that is going to issue CPM command, must do say pq_cpmp_get()
> and another driver won't be able to mangle with cpcr while it's not done with previous request.
>
> Yet I am not telling it was better the way it used to be - this approach looks okay but needs some efforts to defend against
> deadlocks while we are at it

Wouldn't spin_lock_irqsave() prevent a deadlock?

Thanks,
Jochen
