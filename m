Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lvH80Fk7zDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:42:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 4/9] powerpc/pseries: Define MCE error event section.
In-Reply-To: <153365141396.14256.7147876868875454254.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365141396.14256.7147876868875454254.stgit@jupiter.in.ibm.com>
Date: Thu, 09 Aug 2018 00:42:10 +1000
Message-ID: <87r2j8apj1.fsf@concordia.ellerman.id.au>
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

Hi Mahesh,

A few nitpicks.

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> On pseries, the machine check error details are part of RTAS extended
> event log passed under Machine check exception section. This patch adds
> the definition of rtas MCE event section and related helper
> functions.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas.h |  111 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)

AFIACS none of this ever gets used outside of ras.c, should it should
just go in there.

> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 71e393c46a49..adc677c5e3a4 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -326,6 +334,109 @@ struct pseries_hp_errorlog {
>  #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
>  #define PSERIES_HP_ELOG_ID_DRC_IC	4
>  
> +/* RTAS pseries MCE errorlog section */
> +#pragma pack(push, 1)
> +struct pseries_mc_errorlog {
> +	__be32	fru_id;
> +	__be32	proc_id;
> +	uint8_t	error_type;

Please use kernel types, so u8.

> +	union {
> +		struct {
> +			uint8_t	ue_err_type;
> +			/* XXXXXXXX
> +			 * X		1: Permanent or Transient UE.
> +			 *  X		1: Effective address provided.
> +			 *   X		1: Logical address provided.
> +			 *    XX	2: Reserved.
> +			 *      XXX	3: Type of UE error.
> +			 */

But which bit is bit 0? And is that the LSB or MSB?


> +			uint8_t	reserved_1[6];
> +			__be64	effective_address;
> +			__be64	logical_address;
> +		} ue_error;
> +		struct {
> +			uint8_t	soft_err_type;
> +			/* XXXXXXXX
> +			 * X		1: Effective address provided.
> +			 *  XXXXX	5: Reserved.
> +			 *       XX	2: Type of SLB/ERAT/TLB error.
> +			 */
> +			uint8_t	reserved_1[6];
> +			__be64	effective_address;
> +			uint8_t	reserved_2[8];
> +		} soft_error;
> +	} u;
> +};
> +#pragma pack(pop)

Why not __packed ?

> +/* RTAS pseries MCE error types */
> +#define PSERIES_MC_ERROR_TYPE_UE		0x00
> +#define PSERIES_MC_ERROR_TYPE_SLB		0x01
> +#define PSERIES_MC_ERROR_TYPE_ERAT		0x02
> +#define PSERIES_MC_ERROR_TYPE_TLB		0x04
> +#define PSERIES_MC_ERROR_TYPE_D_CACHE		0x05
> +#define PSERIES_MC_ERROR_TYPE_I_CACHE		0x07

Once these are in ras.c they can have less unwieldy names, ie. the
PSERIES at least can be dropped.

> +/* RTAS pseries MCE error sub types */
> +#define PSERIES_MC_ERROR_UE_INDETERMINATE		0
> +#define PSERIES_MC_ERROR_UE_IFETCH			1
> +#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_IFETCH	2
> +#define PSERIES_MC_ERROR_UE_LOAD_STORE			3
> +#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_LOAD_STORE	4
> +
> +#define PSERIES_MC_ERROR_SLB_PARITY		0
> +#define PSERIES_MC_ERROR_SLB_MULTIHIT		1
> +#define PSERIES_MC_ERROR_SLB_INDETERMINATE	2
> +
> +#define PSERIES_MC_ERROR_ERAT_PARITY		1
> +#define PSERIES_MC_ERROR_ERAT_MULTIHIT		2
> +#define PSERIES_MC_ERROR_ERAT_INDETERMINATE	3
> +
> +#define PSERIES_MC_ERROR_TLB_PARITY		1
> +#define PSERIES_MC_ERROR_TLB_MULTIHIT		2
> +#define PSERIES_MC_ERROR_TLB_INDETERMINATE	3
> +
> +static inline uint8_t rtas_mc_error_type(const struct pseries_mc_errorlog *mlog)
> +{
> +	return mlog->error_type;
> +}

Why not just access it directly?

> +static inline uint8_t rtas_mc_error_sub_type(
> +					const struct pseries_mc_errorlog *mlog)
> +{
> +	switch (mlog->error_type) {
> +	case	PSERIES_MC_ERROR_TYPE_UE:
> +		return (mlog->u.ue_error.ue_err_type & 0x07);
> +	case	PSERIES_MC_ERROR_TYPE_SLB:
> +	case	PSERIES_MC_ERROR_TYPE_ERAT:
> +	case	PSERIES_MC_ERROR_TYPE_TLB:
> +		return (mlog->u.soft_error.soft_err_type & 0x03);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static inline uint64_t rtas_mc_get_effective_addr(
> +					const struct pseries_mc_errorlog *mlog)
> +{
> +	uint64_t addr = 0;

That should be __be64.

> +
> +	switch (mlog->error_type) {
> +	case	PSERIES_MC_ERROR_TYPE_UE:
> +		if (mlog->u.ue_error.ue_err_type & 0x40)
> +			addr = mlog->u.ue_error.effective_address;
> +		break;
> +	case	PSERIES_MC_ERROR_TYPE_SLB:
> +	case	PSERIES_MC_ERROR_TYPE_ERAT:
> +	case	PSERIES_MC_ERROR_TYPE_TLB:
> +		if (mlog->u.soft_error.soft_err_type & 0x80)
> +			addr = mlog->u.soft_error.effective_address;
> +	default:
> +		break;
> +	}
> +	return be64_to_cpu(addr);
> +}
> +
>  struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
>  					      uint16_t section_id);
>  


cheers
