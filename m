Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTRDZ1TqhzDqjX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 20:47:24 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EAhmaZ041089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:47:21 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gdxu3ac5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:47:21 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 20:47:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 90E512BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 20:47:17 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EAlHvj3146150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 20:47:17 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EAlG2j030841
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 20:47:17 +1000
Date: Tue, 14 Jun 2016 16:17:12 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160613153446.GF10634@linaro.org>
In-Reply-To: <20160613153446.GF10634@linaro.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <575FE0B0.4030309@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/13/2016 09:04 PM, Daniel Lezcano wrote:
> On Wed, Jun 08, 2016 at 11:54:30AM -0500, Shreyas B. Prabhu wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>  a) new instruction named stop is added.
>>  b) new per thread SPR named PSSCR is added which controls the behavior
>> 	of stop instruction.
>>
>> Supported idle states and value to be written to PSSCR register to enter
>> any idle state is exposed via ibm,cpu-idle-state-names and
>> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
>> platform provided power_stop() needs to be invoked with the appropriate
>> PSSCR value.
>>
>> This patch adds support for this new mechanism in cpuidle powernv driver.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@ozlabs.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
> 
> [ ... ]
> 
>> +	rc = of_property_read_string_array(power_mgt,
>> +					   "ibm,cpu-idle-state-names", names,
>> +					   dt_idle_states);
>> +	if (rc < 0) {
>> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
>> +		goto out_free_latency;
>> +	}
>> +
>> +	/*
>> +	 * If the idle states use stop instruction, probe for psscr values
>> +	 * which are necessary to specify required stop level.
>> +	 */
>> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
>> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
>> +				    GFP_KERNEL);
> 
> if (!psscr_val) check missing.

I ignored adding this check because this is part of initcall and we are
unlikely to run out of memory at this state. But I'll add the check in
next version.
> 
>> +		rc = of_property_read_u64_array(power_mgt,
>> +						"ibm,cpu-idle-state-psscr",
>> +						psscr_val, dt_idle_states);
>> +		if (rc) {
>> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
>> +			goto out_free_psscr;
>> +		}
>> +	}
>>  	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
> 
> if (!residency_ns) check missing.
> 
> I suppose the code is relying on 'of_property_read_u32_array' to check it, 
> right ?

I'll add the NULL check for existing kzalloc's in the file as well in
the next version.

Thanks,
Shreyas
