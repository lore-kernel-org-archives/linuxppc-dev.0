Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C237DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:14:58 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2BFCDe4004348
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:12:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2BFEsGC169428
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:14:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2BFErsM027500
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:14:53 -0400
Message-ID: <49B7D569.7010602@austin.ibm.com>
Date: Wed, 11 Mar 2009 10:14:49 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pseries failed reconfig notifier chain call
	cleanup
References: <49B02DB5.7020301@austin.ibm.com>
	<1236750467.7086.42.camel@pasglop>
In-Reply-To: <1236750467.7086.42.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
> On Thu, 2009-03-05 at 13:53 -0600, Nathan Fontenot wrote:
>> The return code from invoking the notifier chain when updating the
>> ibm,dynamic-memory property is not handled properly. In failure
>> cases (rc == NOTIFY_BAD) we should be restoring the original value
>> of the property.  In success (rc == NOTIFY_OK) we should be returning
>> zero from the calling routine.
> 
> This is actually not clear to me ... if the memory has been added or
> removed, we must make sure the device-tree is up to date... ie, we can't
> tell the firmware that we failed can we ?
> 

Once the memory is added or removed the device tree is updated to reflect
the change.  The case for systems where the memory in the device tree is
specified in the ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
property is slightly different.  Because it is a property that is being
updated (as opposed to addition or removal of a device tree node for
memory specified as memory@XXXX nodes) The kernel updates the property
in the device tree then invokes the notifier chain.  If anyone on the
notifier chain returns a failure we should restore the property to its
previous value.  I think that part is understood.

The main user (and probably only user) of this interface is the drmgr
tool that handles DLPAR of memory and other conmponents.  The drmgr
tool tries to update the property after acquiring it from firmware. If
the property update fails, drmgr cleans up and returns the memory to
firmware.  This update ensures that the device tree property is not left
in a state that implies that the system owns the memory.

Hope that helps.

-Nathan

> Ben.
> 
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/reconfig.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> Index: linux-2.6/arch/powerpc/platforms/pseries/reconfig.c
>> ===================================================================
>> --- linux-2.6.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-10-23 22:29:24.000000000 -0500
>> +++ linux-2.6/arch/powerpc/platforms/pseries/reconfig.c	2009-03-05 13:20:00.000000000 -0600
>> @@ -468,9 +468,13 @@
>>  
>>  		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
>>  						  action, value);
>> +		if (rc == NOTIFY_BAD) {
>> +			rc = prom_update_property(np, oldprop, newprop);
>> +			return -ENOMEM;
>> +		}
>>  	}
>>  
>> -	return rc;
>> +	return 0;
>>  }
>>  
>>  /**
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
