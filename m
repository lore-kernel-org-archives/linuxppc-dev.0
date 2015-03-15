Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF43A1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 09:56:05 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B84EC14008F
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:56:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Mar 2015 08:56:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EB642CE804E
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:56:02 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2FMtsHe44433580
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:56:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2FMtSEG028639
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2015 09:55:28 +1100
Date: Mon, 16 Mar 2015 09:55:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150315225504.GB4644@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426278918.3643.123.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426278918.3643.123.camel@redhat.com>
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

On Fri, Mar 13, 2015 at 02:35:18PM -0600, Alex Williamson wrote:
>On Wed, 2015-03-11 at 17:34 +1100, Gavin Shan wrote:
>> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
>> to inject the specified EEH error, which is represented by
>> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
>>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
>>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
>>  3 files changed, 80 insertions(+), 15 deletions(-)
>> 
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>[snip]
>> @@ -490,6 +499,29 @@ struct vfio_eeh_pe_op {
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
>This data duplication from patch 1/2 is kind of concerning.  In one case
>we're adding to arch/powerpc/include/asm/eeh.h, which is a kernel
>internal interface and entirely changeable, in the other we're matching
>those current definitions in uapi, which needs to be stable.  Are these
>indexes part of a spec that we can rely on them being stable or do we
>need some sort of translation layer to go from the vfio uapi defined
>value to the kernel internal version?  Thanks,
>

All those constants are defined by PAPR specification, and those constants
defined here or by PATCH[1/2] aren't expected to be changed.

Thanks,
Gavin

>Alex
>
>
