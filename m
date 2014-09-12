Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 314B01A0027
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 05:05:55 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 13:05:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 180313E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 13:05:51 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8CH1kCo12059118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:01:47 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8CJ5oV0014520
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 13:05:50 -0600
Message-ID: <5413440D.2060804@linux.vnet.ibm.com>
Date: Fri, 12 Sep 2014 14:05:49 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] pseries: Fix endian issues in cpu hot-removal
References: <1410388904-20061-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1410512019.17540.12.camel@concordia>
In-Reply-To: <1410512019.17540.12.camel@concordia>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2014 03:53 AM, Michael Ellerman wrote:
> On Wed, 2014-09-10 at 17:41 -0500, Thomas Falcon wrote:
>> When removing a cpu, this patch makes sure that values
>> gotten from or passed to firmware are in the correct
>> endian format.
>>
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/dlpar.c       | 14 +++++++-------
>>   arch/powerpc/platforms/pseries/hotplug-cpu.c |  8 ++++----
>>   2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index cd425dc..c5ecfdb 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -442,7 +442,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>>   	int rc = 0;
>>   	unsigned int cpu;
>>   	int len, nthreads, i;
>> -	const u32 *intserv;
>> +	const __be32 *intserv;
>>   
>>   	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
>>   	if (!intserv)
>> @@ -453,7 +453,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>>   	cpu_maps_update_begin();
>>   	for (i = 0; i < nthreads; i++) {
> Can you please do the conversion once here for each value of i.
>
> You can call the converted value "thread" ?
>
>>   		for_each_present_cpu(cpu) {
>> -			if (get_hard_smp_processor_id(cpu) != intserv[i])
>> +			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv[i]))
>>   				continue;
> Rather than doing it for every cpu in the system for every value of i.
>
> Not that performance is really an issue, but it's just ugly.
>
> And obviously the other places that use it in the loop should use the converted
> value.
>
>
>> @@ -494,7 +494,7 @@ out:
>>   static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>   {
>>   	struct device_node *dn;
>> -	const u32 *drc_index;
>> +	const __be32 *drc_index;
>>   	int rc;
>>   
>>   	dn = of_find_node_by_path(buf);
>> @@ -513,7 +513,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>   		return -EINVAL;
>>   	}
> Here again you should do the conversion once.
>
> Better still use of_property_read_u32().
>
>> -	rc = dlpar_release_drc(*drc_index);
>> +	rc = dlpar_release_drc(be32_to_cpup(drc_index));
>>   	if (rc) {
>>   		of_node_put(dn);
>>   		return rc;
>> @@ -521,7 +521,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>   
>>   	rc = dlpar_detach_node(dn);
>>   	if (rc) {
>> -		dlpar_acquire_drc(*drc_index);
>> +		dlpar_acquire_drc(be32_to_cpup(drc_index));
>>   		return rc;
>>   	}
> cheers

Thanks for the feedback.  Sending patches with your suggested changes.

tom

>
