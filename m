Return-Path: <srs0=ib65=kz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n1Zv3SqDzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:29:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41n1Zv2sWZz8wD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:29:43 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41n1Zt4rtsz9s7Q
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 20:29:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AAOLEH030789
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:29:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ks8sygecy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:29:39 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 11:29:38 +0100
Subject: Re: [PATCH v7 4/9] powerpc/pseries: Define MCE error event section.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365141396.14256.7147876868875454254.stgit@jupiter.in.ibm.com>
 <87r2j8apj1.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 15:59:33 +0530
MIME-Version: 1.0
In-Reply-To: <87r2j8apj1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <13f8280f-02c1-7b00-0a40-a045bf6ee1f6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2018 08:12 PM, Michael Ellerman wrote:
> Hi Mahesh,
> 
> A few nitpicks.
> 
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> On pseries, the machine check error details are part of RTAS extended
>> event log passed under Machine check exception section. This patch adds
>> the definition of rtas MCE event section and related helper
>> functions.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/rtas.h |  111 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
> 
> AFIACS none of this ever gets used outside of ras.c, should it should
> just go in there.

Since it was all rtas specific I thought rtas.h is better place. But
yes, I can move this into ras.c

> 
>> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>> index 71e393c46a49..adc677c5e3a4 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -326,6 +334,109 @@ struct pseries_hp_errorlog {
>>  #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
>>  #define PSERIES_HP_ELOG_ID_DRC_IC	4
>>  
>> +/* RTAS pseries MCE errorlog section */
>> +#pragma pack(push, 1)
>> +struct pseries_mc_errorlog {
>> +	__be32	fru_id;
>> +	__be32	proc_id;
>> +	uint8_t	error_type;
> 
> Please use kernel types, so u8.

Will do so.

> 
>> +	union {
>> +		struct {
>> +			uint8_t	ue_err_type;
>> +			/* XXXXXXXX
>> +			 * X		1: Permanent or Transient UE.
>> +			 *  X		1: Effective address provided.
>> +			 *   X		1: Logical address provided.
>> +			 *    XX	2: Reserved.
>> +			 *      XXX	3: Type of UE error.
>> +			 */
> 
> But which bit is bit 0? And is that the LSB or MSB?

RTAS errorlog data in BE format, the leftmost bit is MSB 0 (1: Permanent
or Transient UE.). I Will update the comment above that properly points
out which one is MSB 0.

> 
> 
>> +			uint8_t	reserved_1[6];
>> +			__be64	effective_address;
>> +			__be64	logical_address;
>> +		} ue_error;
>> +		struct {
>> +			uint8_t	soft_err_type;
>> +			/* XXXXXXXX
>> +			 * X		1: Effective address provided.
>> +			 *  XXXXX	5: Reserved.
>> +			 *       XX	2: Type of SLB/ERAT/TLB error.
>> +			 */
>> +			uint8_t	reserved_1[6];
>> +			__be64	effective_address;
>> +			uint8_t	reserved_2[8];
>> +		} soft_error;
>> +	} u;
>> +};
>> +#pragma pack(pop)
> 
> Why not __packed ?

Because when used __packed it added 1 byte extra padding between
reserved_1[6] and effective_address. That caused wrong effective address
to be printed on the console. Hence I switched to #pragma pack to force
1 byte alignment for this structure alone.

> 
>> +/* RTAS pseries MCE error types */
>> +#define PSERIES_MC_ERROR_TYPE_UE		0x00
>> +#define PSERIES_MC_ERROR_TYPE_SLB		0x01
>> +#define PSERIES_MC_ERROR_TYPE_ERAT		0x02
>> +#define PSERIES_MC_ERROR_TYPE_TLB		0x04
>> +#define PSERIES_MC_ERROR_TYPE_D_CACHE		0x05
>> +#define PSERIES_MC_ERROR_TYPE_I_CACHE		0x07
> 
> Once these are in ras.c they can have less unwieldy names, ie. the
> PSERIES at least can be dropped.

ok.

> 
>> +/* RTAS pseries MCE error sub types */
>> +#define PSERIES_MC_ERROR_UE_INDETERMINATE		0
>> +#define PSERIES_MC_ERROR_UE_IFETCH			1
>> +#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_IFETCH	2
>> +#define PSERIES_MC_ERROR_UE_LOAD_STORE			3
>> +#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_LOAD_STORE	4
>> +
>> +#define PSERIES_MC_ERROR_SLB_PARITY		0
>> +#define PSERIES_MC_ERROR_SLB_MULTIHIT		1
>> +#define PSERIES_MC_ERROR_SLB_INDETERMINATE	2
>> +
>> +#define PSERIES_MC_ERROR_ERAT_PARITY		1
>> +#define PSERIES_MC_ERROR_ERAT_MULTIHIT		2
>> +#define PSERIES_MC_ERROR_ERAT_INDETERMINATE	3
>> +
>> +#define PSERIES_MC_ERROR_TLB_PARITY		1
>> +#define PSERIES_MC_ERROR_TLB_MULTIHIT		2
>> +#define PSERIES_MC_ERROR_TLB_INDETERMINATE	3
>> +
>> +static inline uint8_t rtas_mc_error_type(const struct pseries_mc_errorlog *mlog)
>> +{
>> +	return mlog->error_type;
>> +}
> 
> Why not just access it directly?

sure.

> 
>> +static inline uint8_t rtas_mc_error_sub_type(
>> +					const struct pseries_mc_errorlog *mlog)
>> +{
>> +	switch (mlog->error_type) {
>> +	case	PSERIES_MC_ERROR_TYPE_UE:
>> +		return (mlog->u.ue_error.ue_err_type & 0x07);
>> +	case	PSERIES_MC_ERROR_TYPE_SLB:
>> +	case	PSERIES_MC_ERROR_TYPE_ERAT:
>> +	case	PSERIES_MC_ERROR_TYPE_TLB:
>> +		return (mlog->u.soft_error.soft_err_type & 0x03);
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static inline uint64_t rtas_mc_get_effective_addr(
>> +					const struct pseries_mc_errorlog *mlog)
>> +{
>> +	uint64_t addr = 0;
> 
> That should be __be64.

Sure will do.

Thanks,
-Mahesh.
