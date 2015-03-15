Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB57B1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 09:40:58 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C883140119
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:40:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Mar 2015 08:40:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7CC0D3578047
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:40:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2FMelNQ39583858
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:40:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2FMeLfi008905
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:40:21 +1100
Date: Mon, 16 Mar 2015 09:39:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] powerpc/eeh: Introduce eeh_pe_inject_err()
Message-ID: <20150315223957.GA4438@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426278513.3643.117.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426278513.3643.117.camel@redhat.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 13, 2015 at 02:28:33PM -0600, Alex Williamson wrote:
>On Wed, 2015-03-11 at 17:34 +1100, Gavin Shan wrote:
>> The patch defines PCI error types and functions in eeh.h and
>> exports function eeh_pe_inject_err(), which will be called by
>> VFIO driver to inject the specified PCI error to the indicated
>> PE for testing purpose.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/eeh.h | 24 ++++++++++++++++
>>  arch/powerpc/kernel/eeh.c      | 63 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index 9de87ce..eb20c62 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -196,6 +196,28 @@ enum {
>>  #define EEH_RESET_COMPLETE	4	/* PHB complete reset		*/
>>  #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
>>  #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
>> +#define EEH_ERR_TYPE_32		0	/* 32-bits PCI error	*/
>> +#define EEH_ERR_TYPE_64		1	/* 64-bits PCI error	*/
>> +#define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
>> +#define EEH_ERR_FUNC_LD_MEM_DATA	1
>> +#define EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load	*/
>> +#define EEH_ERR_FUNC_LD_IO_DATA		3
>> +#define EEH_ERR_FUNC_LD_CFG_ADDR	4	/* Config load	*/
>> +#define EEH_ERR_FUNC_LD_CFG_DATA	5
>> +#define EEH_ERR_FUNC_ST_MEM_ADDR	6	/* Memory store	*/
>> +#define EEH_ERR_FUNC_ST_MEM_DATA	7
>> +#define EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store	*/
>> +#define EEH_ERR_FUNC_ST_IO_DATA		9
>> +#define EEH_ERR_FUNC_ST_CFG_ADDR	10	/* Config store	*/
>> +#define EEH_ERR_FUNC_ST_CFG_DATA	11
>> +#define EEH_ERR_FUNC_DMA_RD_ADDR	12	/* DMA read	*/
>> +#define EEH_ERR_FUNC_DMA_RD_DATA	13
>> +#define EEH_ERR_FUNC_DMA_RD_MASTER	14
>> +#define EEH_ERR_FUNC_DMA_RD_TARGET	15
>> +#define EEH_ERR_FUNC_DMA_WR_ADDR	16	/* DMA write	*/
>> +#define EEH_ERR_FUNC_DMA_WR_DATA	17
>> +#define EEH_ERR_FUNC_DMA_WR_MASTER	18
>> +#define EEH_ERR_FUNC_DMA_WR_TARGET	19
>>  
>>  struct eeh_ops {
>>  	char *name;
>> @@ -296,6 +318,8 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option);
>>  int eeh_pe_get_state(struct eeh_pe *pe);
>>  int eeh_pe_reset(struct eeh_pe *pe, int option);
>>  int eeh_pe_configure(struct eeh_pe *pe);
>> +int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>> +		      unsigned long addr, unsigned long mask);
>>  
>>  /**
>>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index 60a0f15ce..dbab1a4 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1657,6 +1657,69 @@ int eeh_pe_configure(struct eeh_pe *pe)
>>  }
>>  EXPORT_SYMBOL_GPL(eeh_pe_configure);
>>  
>> +/**
>> + * eeh_pe_inject_err - Injecting the specified PCI error to the indicated PE
>> + * @pe: the indicated PE
>> + * @type: error type
>> + * @function: error function
>> + * @addr: address
>> + * @mask: address mask
>> + *
>> + * The routine is called to inject the specified PCI error, which
>> + * is determined by @type and @function, to the indicated PE for
>> + * testing purpose.
>> + */
>> +int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>> +		      unsigned long addr, unsigned long mask)
>> +{
>> +	/* Invalid PE ? */
>> +	if (!pe)
>> +		return -ENODEV;
>> +
>> +	/* Unsupported operation ? */
>> +	if (!eeh_ops || !eeh_ops->err_inject)
>> +		return -ENOENT;
>> +
>> +	/* Check on PCI error type */
>> +	switch (type) {
>> +	case EEH_ERR_TYPE_32:
>> +	case EEH_ERR_TYPE_64:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Check on PCI error function */
>> +	switch (func) {
>> +	case EEH_ERR_FUNC_LD_MEM_ADDR:
>> +	case EEH_ERR_FUNC_LD_MEM_DATA:
>> +	case EEH_ERR_FUNC_LD_IO_ADDR:
>> +	case EEH_ERR_FUNC_LD_IO_DATA:
>> +	case EEH_ERR_FUNC_LD_CFG_ADDR:
>> +	case EEH_ERR_FUNC_LD_CFG_DATA:
>> +	case EEH_ERR_FUNC_ST_MEM_ADDR:
>> +	case EEH_ERR_FUNC_ST_MEM_DATA:
>> +	case EEH_ERR_FUNC_ST_IO_ADDR:
>> +	case EEH_ERR_FUNC_ST_IO_DATA:
>> +	case EEH_ERR_FUNC_ST_CFG_ADDR:
>> +	case EEH_ERR_FUNC_ST_CFG_DATA:
>> +	case EEH_ERR_FUNC_DMA_RD_ADDR:
>> +	case EEH_ERR_FUNC_DMA_RD_DATA:
>> +	case EEH_ERR_FUNC_DMA_RD_MASTER:
>> +	case EEH_ERR_FUNC_DMA_RD_TARGET:
>> +	case EEH_ERR_FUNC_DMA_WR_ADDR:
>> +	case EEH_ERR_FUNC_DMA_WR_DATA:
>> +	case EEH_ERR_FUNC_DMA_WR_MASTER:
>> +	case EEH_ERR_FUNC_DMA_WR_TARGET:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>
>Potentially a good use case for an enum for both type and func.  Then
>you could close each enum with a "MAX" entry and simply test type/func <
>MAX.  Thanks,
>

Yes, It's reasonable to have following macro as all constants in eeh.h
are represented by macros.

#define EEH_ERR_FUNC_MAX 19

	if (func > 19)
		return -EINVAL;

Thanks,
Gavin
 
>Alex
>
>> +
>> +	return eeh_ops->err_inject(pe, type, func, addr, mask);
>> +}
>> +EXPORT_SYMBOL_GPL(eeh_pe_inject_err);
>> +
>>  static int proc_eeh_show(struct seq_file *m, void *v)
>>  {
>>  	if (!eeh_enabled()) {
>
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe kvm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
