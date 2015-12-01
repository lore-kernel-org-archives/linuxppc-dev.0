Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 961EF1A0B84
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 07:51:10 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 13:51:07 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3B8CF6E804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 15:39:13 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB1Kp3uh12583054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 20:51:03 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB1Kp2aH013021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 15:51:02 -0500
Subject: Re: [PATCH v2 4/6] powerpc/pseries: Add CPU dlpar remove functionality
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
 <562FC1E8.9040902@linux.vnet.ibm.com>
 <1448514168.9839.6.camel@ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <565E0835.20806@linux.vnet.ibm.com>
Date: Tue, 1 Dec 2015 14:51:01 -0600
MIME-Version: 1.0
In-Reply-To: <1448514168.9839.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2015 11:02 PM, Michael Ellerman wrote:
> On Tue, 2015-10-27 at 13:26 -0500, Nathan Fontenot wrote:
> 
>> Add the ability to dlpar remove CPUs via hotplug rtas events, either by
>> specifying the drc-index of the CPU to remove or providing a count of cpus
>> to remove.
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index f080e81..635f0ba 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -570,6 +571,143 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>>  	return 0;
>>  }
>>  
>> +static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
>> +{
>> +	struct device_node *dn;
>> +	u32 my_index;
>> +	int rc;
>> +
>> +	for_each_node_by_type(dn, "cpu") {
>> +		rc = of_property_read_u32(dn, "ibm,my-drc-index", &my_index);
>> +		if (rc)
>> +			continue;
>> +
>> +		if (my_index == drc_index)
>> +			break;
>> +	}
>> +
>> +	return dn;
>> +}
>> +
>> +static int dlpar_cpu_remove_by_index(u32 drc_index)
>> +{
>> +	struct device_node *dn;
>> +	int rc;
>> +
>> +	dn = cpu_drc_index_to_dn(drc_index);
>> +	if (!dn)
>> +		return -ENODEV;
>> +
>> +	rc = dlpar_cpu_remove(dn, drc_index);
>> +	of_node_put(dn);
> 
> Does dlpar_cpu_remove() work when you still hold a reference to the dn?

Yes, this works while holding the dn reference here.
> 
> It looks like dlpar_detach_node() does an of_node_put() also.

Correct. The of_node_put() in dlpar_detach_node() is there to do a put
from the initial node creation, without this the reference count would never
go to zero and the node would not be released.

> 
>> +	return rc;
>> +}
>> +
>> +static u32 *dlpar_cpus_to_remove(int cpus_to_remove)
>> +{
>> +	struct device_node *dn;
>> +	u32 *cpu_drcs;
>> +	int cpus_found = 0;
>> +	int i, rc;
>> +
>> +	cpu_drcs = kcalloc(cpus_to_remove, sizeof(*cpu_drcs), GFP_KERNEL);
>> +	if (!cpu_drcs)
>> +		return NULL;
>> +
>> +	i = 0;
>> +	for_each_node_by_type(dn, "cpu") {
>> +		cpus_found++;
>> +
>> +		if (cpus_found > cpus_to_remove) {
>> +			of_node_put(dn);
>> +			break;
>> +		}
>> +
>> +		rc = of_property_read_u32(dn, "ibm,my-drc-index",
>> +					  &cpu_drcs[i++]);
>> +		if (rc) {
>> +			of_node_put(dn);
>> +			break;
> 
> I'm not sure about the logic here with cpus_found and i. If you break here
> cpus_found will be 1, but you found zero, which seems odd.
> 

Agreed, it is a bit odd. The cpus_found var is meant to count the number of
cpus we find when looping through for_each_node_by_type() whereas i is just
meant to be an index into the cpu_cars array so we can save the drc-index
of the cpus we find. The variable i is just to index the array, nothing more.

Perhaps instead of having i to use as an index into the cpu_drcs array I
could just use [cpus_found - 1] to index cpu_drcs and get rid of i. Not sure
if that makes the code any easier to read.

> If instead you delayed the increment of i:
> 
> 		rc = of_property_read_u32(dn, "ibm,my-drc-index",
> 					  &cpu_drcs[i]);
> 		if (rc) {
> 			of_node_put(dn);
> 			break;
> 		}
> 
> 		i++;
> 	}
> 
> Then i would equal the number of cpus found at all times. If you need to count
> one more in the if below you can just do that there.
> 
>> +
>> +	/* We want to find cpus_to_remove + 1 CPUs to ensure we do not
>> +	 * remove the last CPU.
>> +	 */
>> +	if (cpus_found <= cpus_to_remove) {
>> +		pr_warn("Failed to find enough CPUs (%d of %d) to remove\n",
>> +			cpus_found, cpus_to_remove);
>> +		kfree(cpu_drcs);
>> +		cpu_drcs = NULL;
>> +	}
> 
> On my two cpu system when I do "cpu remove count 1" this always says:
> 
>   pseries-hotplug-cpu: Failed to find enough CPUs (1 of 1) to remove
> 
> Which confuses me.
> 
> I suspect that's because I actually have one cpu *node*, which appears to Linux
> as two cpus (due to SMT). So I think it's working as expected, but it's not
> very clear from a user's perspective.
> 

You are correct. For Power CPU DLPAR works on a node basis. If there
is only one node it will not remove the last CPU.

I should update the cpus_found to check to print a message if the remove
request would entail removing the last CPU and that the request is being
failed because of that.


Thanks for the feedback,
-Nathan
