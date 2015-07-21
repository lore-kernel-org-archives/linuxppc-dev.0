Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2DD71A0877
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 05:14:48 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 13:14:46 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 152C11FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 13:05:52 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LJDqgs49545248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:13:52 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LJEejE017572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 13:14:41 -0600
Message-ID: <55AE9A1E.5020002@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 14:14:38 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/6] pseries: Update CPU hotplug error recovery
References: <20150721044649.A4DD8140DF7@ozlabs.org>
In-Reply-To: <20150721044649.A4DD8140DF7@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/20/2015 11:46 PM, Michael Ellerman wrote:
> On Mon, 2015-22-06 at 20:59:20 UTC, Nathan Fontenot wrote:
>> Update the cpu dlpar add/remove paths to do better error recovery when 
>> a failure occurs during the add/remove operation. This includes adding
>> some pr_info and pr_debug statements.
> 
> So I'm happy with the idea there, but ..
> 
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index f58d902..7890b2f 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -18,6 +18,8 @@
>>   *      2 of the License, or (at your option) any later version.
>>   */
>>  
>> +#define pr_fmt(fmt)     "pseries-hotplug-cpu: " fmt
> 
> This is good.
> 
>>  #include <linux/kernel.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>> @@ -386,22 +388,35 @@ static ssize_t dlpar_cpu_add(struct device_node *parent, u32 drc_index)
>>  	struct device_node *dn;
>>  	int rc;
>>  
>> +	pr_info("Attempting to add CPU, drc index %x\n", drc_index);
>> +
>>  	rc = dlpar_acquire_drc(drc_index);
>>  	if (rc)
>>  		return -EINVAL;
>>  
>>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>> -	if (!dn)
>> +	if (!dn) {
>> +		pr_debug("Failed call to configure-connector\n");
>> +		dlpar_release_drc(drc_index);
>>  		return -EINVAL;
>> +	}
>>  
>>  	rc = dlpar_attach_node(dn);
>>  	if (rc) {
>> +		pr_debug("Failed to attach node (%d)\n", rc);
>>  		dlpar_release_drc(drc_index);
>>  		dlpar_free_cc_nodes(dn);
>>  		return rc;
>>  	}
>>  
>>  	rc = dlpar_online_cpu(dn);
>> +	if (rc) {
>> +		pr_debug("Failed to online cpu (%d)\n", rc);
>> +		dlpar_detach_node(dn);
>> +		dlpar_release_drc(drc_index);
>> +	}
>> +
>> +	pr_info("Successfully added CPU, drc index %x\n", drc_index);
>>  	return rc;
> 
> 
> But this is the opposite of what we want.
> 
> By default this will print two info lines for each successful cpu hotplug, but
> when we get an error nothing will be printed - because pr_debug() is off by
> default. What's worse, if dlpar_online_cpu() fails, the pr_debug() will produce
> nothing but we will *still* print "Successfully added CPU".
> 
> So the pr_info()s should go entirely and the pr_debugs() should become
> pr_warns(). The warning messages should become more verbose so they stand on
> their own, ie. include the drc_index.
> 
> When everything goes perfectly there should be no output.
>

So... good idea, bad implementation :)

I have a feeling I may have messed this up somewhere else in the patch set too
so I'll take a look at all the pr_* calls.
 
> 
>> @@ -465,18 +480,29 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>>  {
>>  	int rc;
>>  
>> +	pr_info("Attemping to remove CPU, drc index %x\n", drc_index);
>> +
>>  	rc = dlpar_offline_cpu(dn);
>> -	if (rc)
>> +	if (rc) {
>> +		pr_debug("Failed top offline cpu (%d)\n", rc);
>                                    ^
> 				   should be to
> 
>>  		return -EINVAL;
>> +	}
>>  
>>  	rc = dlpar_release_drc(drc_index);
>> -	if (rc)
>> +	if (rc) {
>> +		pr_debug("Failed to release drc (%d)\n", rc);
>> +		dlpar_online_cpu(dn);
>>  		return rc;
>> +	}
>>  
>>  	rc = dlpar_detach_node(dn);
>> -	if (rc)
>> +	if (rc) {
>> +		pr_debug("Failed to detach cpu node (%d)\n", rc);
>>  		dlpar_acquire_drc(drc_index);
> 
> But that can fail?
> 
>> +		dlpar_online_cpu(dn);
> 
> And if it did this would presumably not be safe?

Ahh, good catch. I'll fix in the next version of patches.

Thanks for the review.

-Nathan
