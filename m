Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFAEC2C00B6
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Nov 2013 21:41:41 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 26 Nov 2013 20:41:36 +1000
Message-ID: <52947A8E.1040200@linux.vnet.ibm.com>
Date: Tue, 26 Nov 2013 16:10:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "mpe@ellerman.id.au" <michael@ozlabs.org>
Subject: Re: [V3 02/10] powerpc, perf: Enable conditional branch filter for
 POWER8
References: <20131126060619.48B5D2C00BC@ozlabs.org>
In-Reply-To: <20131126060619.48B5D2C00BC@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, michaele@au1.ibm.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2013 11:36 AM, mpe@ellerman.id.au wrote:
> On Wed, 2013-16-10 at 06:56:49 UTC, Anshuman Khandual wrote:
>> Enables conditional branch filter support for POWER8
>> utilizing MMCRA register based filter and also invalidates
>> a BHRB branch filter combination involving conditional
>> branches.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/power8-pmu.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
>> index 2ee4a70..6e28587 100644
>> --- a/arch/powerpc/perf/power8-pmu.c
>> +++ b/arch/powerpc/perf/power8-pmu.c
>> @@ -580,11 +580,21 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
>>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
>>  		return -1;
>>  
>> +	/* Invalid branch filter combination - HW does not support */
>> +	if ((branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) &&
>> +			(branch_sample_type & PERF_SAMPLE_BRANCH_COND))
>> +		return -1;
> 
> What this doesn't make obvious is that the hardware doesn't support any
> combinations. It just happens that these are the only two possibilities we
> allow, and so this is the only combination we have to disallow.
> 
>>
>>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
>>  		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
>>  		return pmu_bhrb_filter;
>>  	}
>>  
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
>> +		pmu_bhrb_filter |= POWER8_MMCRA_IFM3;
>> +		return pmu_bhrb_filter;
>> +	}
>> +
>>  	/* Every thing else is unsupported */
>>  	return -1;
>>  }
> 
> I think it would be clearer if we actually checked for the possibilities we
> allow and let everything else fall through, eg:
> 
> 	/* Ignore user/kernel/hv bits */
> 	branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;
> 
> 	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY)
> 		return 0;
> 
> 	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL)
> 		return POWER8_MMCRA_IFM1;
> 
> 	if (branch_sample_type == PERF_SAMPLE_BRANCH_COND)
> 		return POWER8_MMCRA_IFM3;
> 	
> 	return -1;
> 

Please look at the 9th patch (power8, perf: Change BHRB branch filter configuration).
All these issues are taken care of in this patch. It clearly indicates that any combination
of HW BHRB filters will not be supported in the PMU and hence zero out the HW filter component
and processes all of those filters in the SW.
