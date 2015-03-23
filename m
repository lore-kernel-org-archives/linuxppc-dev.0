Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA59B1A2AC4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 12:57:40 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 429CD14011D
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 12:57:40 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 11:57:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E6F0F2BB0040
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 12:57:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2N1vQCx13828194
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 12:57:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2N1v13Q018921
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 12:57:01 +1100
Date: Mon, 23 Mar 2015 12:56:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150323015636.GA9430@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426881525-11044-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150323013945.GE25043@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150323013945.GE25043@voom.fritz.box>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2015 at 12:39:45PM +1100, David Gibson wrote:
>On Sat, Mar 21, 2015 at 06:58:45AM +1100, Gavin Shan wrote:
>> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
>> to inject the specified EEH error, which is represented by
>> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
>> ---
>>  Documentation/vfio.txt        | 12 ++++++++++++
>>  drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
>>  include/uapi/linux/vfio.h     | 36 +++++++++++++++++++++++++++++++++++-
>>  3 files changed, 57 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> index 96978ec..c6e11a3 100644
>> --- a/Documentation/vfio.txt
>> +++ b/Documentation/vfio.txt
>> @@ -385,6 +385,18 @@ The code flow from the example above should be slightly changed:
>>  
>>  	....
>>  
>> +	/* Inject EEH error, which is expected to be caused by 32-bits
>> +	 * config load.
>> +	 */
>> +	pe_op.op = VFIO_EEH_PE_INJECT_ERR;
>> +	pe_op.err.type = VFIO_EEH_ERR_TYPE_32;
>> +	pe_op.err.func = VFIO_EEH_ERR_FUNC_LD_CFG_ADDR;
>> +	pe_op.err.addr = 0ul;
>> +	pe_op.err.mask = 0ul;
>> +	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
>> +
>> +	....
>> +
>>  	/* When 0xFF's returned from reading PCI config space or IO BARs
>>  	 * of the PCI device. Check the PE's state to see if that has been
>>  	 * frozen.
>> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
>> index 5fa42db..38edeb4 100644
>> --- a/drivers/vfio/vfio_spapr_eeh.c
>> +++ b/drivers/vfio/vfio_spapr_eeh.c
>> @@ -85,6 +85,16 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>>  		case VFIO_EEH_PE_CONFIGURE:
>>  			ret = eeh_pe_configure(pe);
>>  			break;
>> +		case VFIO_EEH_PE_INJECT_ERR:
>> +			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
>> +			if (op.argsz < minsz)
>> +				return -EINVAL;
>> +			if (copy_from_user(&op, (void __user *)arg, minsz))
>> +				return -EFAULT;
>> +
>> +			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
>> +						op.err.addr, op.err.mask);
>> +			break;
>>  		default:
>>  			ret = -EINVAL;
>>  		}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 82889c3..f68e962 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -468,12 +468,23 @@ struct vfio_iommu_spapr_tce_info {
>>   * - unfreeze IO/DMA for frozen PE;
>>   * - read PE state;
>>   * - reset PE;
>> - * - configure PE.
>> + * - configure PE;
>> + * - inject EEH error.
>>   */
>> +struct vfio_eeh_pe_err {
>> +	__u32 type;
>> +	__u32 func;
>> +	__u64 addr;
>> +	__u64 mask;
>> +};
>> +
>>  struct vfio_eeh_pe_op {
>>  	__u32 argsz;
>>  	__u32 flags;
>>  	__u32 op;
>> +	union {
>> +		struct vfio_eeh_pe_err err;
>> +	};
>>  };
>>  
>>  #define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
>> @@ -490,6 +501,29 @@ struct vfio_eeh_pe_op {
>>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
>>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
>>  #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
>> +#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
>> +#define  VFIO_EEH_ERR_TYPE_32		0	/* 32-bits EEH error type    */
>> +#define  VFIO_EEH_ERR_TYPE_64		1	/* 64-bits EEH error type    */
>> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_ADDR		0	/* Memory load  */
>> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_DATA		1
>> +#define  VFIO_EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load      */
>> +#define  VFIO_EEH_ERR_FUNC_LD_IO_DATA		3
>> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_ADDR		4	/* Config load  */
>> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_DATA		5
>> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_ADDR		6	/* Memory store */
>> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_DATA		7
>> +#define  VFIO_EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store     */
>> +#define  VFIO_EEH_ERR_FUNC_ST_IO_DATA		9
>> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_ADDR		10	/* Config store */
>> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_DATA		11
>> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_ADDR		12	/* DMA read     */
>> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_DATA		13
>> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_MASTER	14
>> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_TARGET	15
>> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_ADDR		16	/* DMA write    */
>> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_DATA		17
>> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_MASTER	18
>> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_TARGET	19
>
>These all seem to duplicate (under slightly different names) the
>defines you just added in arch/powerpc/include/asm/eeh.h.  It would
>make more sense to only have the uapi copy, surely.
>

David, Thanks for your time. The defines in eeh.h is used not only
for mapping those constants defined in vfio.h, but also for validating
arguments from debugfs entry "err_injct". So it'd better to keep
them separate: one set is used by userspace, another set is used
by host kernel.

By the way, Alex Williamson, could you please ACK this if you don't
find obvious errors in the patch. I really want this to be merged
to 4.1.

Thanks,
Gavin 

>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson
