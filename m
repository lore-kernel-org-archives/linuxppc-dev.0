Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDLYb51DVzDqt0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 16:33:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: svaidy@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: energy driver only print message when
 LPAR guest
In-Reply-To: <20170721043526.GA12264@drishya.in.ibm.com>
References: <20170720115900.455-1-npiggin@gmail.com>
 <87eftbgt0m.fsf@concordia.ellerman.id.au>
 <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
 <20170721043526.GA12264@drishya.in.ibm.com>
Date: Fri, 21 Jul 2017 16:33:07 +1000
Message-ID: <87pocue1uk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> * Nicholas Piggin <npiggin@gmail.com> [2017-07-21 11:16:44]:
>> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
>> index 164a13d3998a..35c891aabef0 100644
>> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
>> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
>> @@ -229,10 +229,9 @@ static int __init pseries_energy_init(void)
>>  	int cpu, err;
>>  	struct device *cpu_dev;
>> 
>> -	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
>> -		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
>> -		return 0;
>> -	}
>> +	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY))
>> +		return 0; /* H_BEST_ENERGY hcall not supported */
>> +
>
> The first patch (!firmware_has_feature(FW_FEATURE_LPAR)) would be
> ideal, but we do not have this in KVM guest case also.

Yeah we do.

It should really be called FW_FEATURE_RUNNING_UNDER_PAPR_HYPERVISOR.

static int __init probe_fw_features(unsigned long node, const char *uname, int
				    depth, void *data)
{
	....
	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions", &len);
		if (prop) {
			powerpc_firmware_features |= FW_FEATURE_LPAR;


Qemu initialises that property unconditionally in spapr_dt_rtas().

cheers
