Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnHYh3YLRzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:58:00 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L2rY7Q100769
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 22:57:53 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ahw0jh8n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 22:57:53 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 21 Mar 2017 12:57:50 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L2veba43778266
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:57:48 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L2vFGP018670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:57:16 +1100
Subject: Re: [PATCH V2 3/6] cxl: Update implementation service layer
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1489489722-935-4-git-send-email-clombard@linux.vnet.ibm.com>
 <d9b3a5af-2355-b218-f024-e3ed09a96cec@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 21 Mar 2017 13:56:51 +1100
MIME-Version: 1.0
In-Reply-To: <d9b3a5af-2355-b218-f024-e3ed09a96cec@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <778ccbb0-5a1c-b2fa-fc39-c7730ea31cf8@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21/03/17 03:17, Frederic Barrat wrote:
>
>
> Le 14/03/2017 à 12:08, Christophe Lombard a écrit :
>> The service layer API (in cxl.h) lists some low-level functions whose
>> implementation is different on PSL8, PSL9 and XSL:
>> - Init implementation for the adapter and the afu.
>> - Invalidate TLB/SLB.
>> - Attach process for dedicated/directed models.
>> - Handle psl interrupts.
>> - Debug registers for the adapter and the afu.
>> - Traces.
>> Each environment implements its own functions, and the common code uses
>> them through function pointers, defined in cxl_service_layer_ops.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>> ---
>>  drivers/misc/cxl/cxl.h     | 34 ++++++++++++++++++++++---------
>>  drivers/misc/cxl/debugfs.c | 16 +++++++--------
>>  drivers/misc/cxl/guest.c   |  2 +-
>>  drivers/misc/cxl/irq.c     |  2 +-
>>  drivers/misc/cxl/native.c  | 50
>> +++++++++++++++++++++++++++-------------------
>>  drivers/misc/cxl/pci.c     | 47
>> +++++++++++++++++++++++++++++--------------
>>  6 files changed, 97 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>> index 4d1b704..3e03a66 100644
>> --- a/drivers/misc/cxl/cxl.h
>> +++ b/drivers/misc/cxl/cxl.h
>> @@ -553,13 +553,23 @@ struct cxl_context {
>>      struct mm_struct *mm;
>>  };
>>
>> +struct cxl_irq_info;
>> +
>>  struct cxl_service_layer_ops {
>>      int (*adapter_regs_init)(struct cxl *adapter, struct pci_dev *dev);
>> +    int (*invalidate_all)(struct cxl *adapter);
>>      int (*afu_regs_init)(struct cxl_afu *afu);
>> +    int (*sanitise_afu_regs)(struct cxl_afu *afu);
>>      int (*register_serr_irq)(struct cxl_afu *afu);
>>      void (*release_serr_irq)(struct cxl_afu *afu);
>> -    void (*debugfs_add_adapter_sl_regs)(struct cxl *adapter, struct
>> dentry *dir);
>> -    void (*debugfs_add_afu_sl_regs)(struct cxl_afu *afu, struct
>> dentry *dir);
>> +    irqreturn_t (*handle_interrupt)(int irq, struct cxl_context *ctx,
>> struct cxl_irq_info *irq_info);
>> +    irqreturn_t (*fail_irq)(struct cxl_afu *afu, struct cxl_irq_info
>> *irq_info);
>> +    int (*activate_dedicated_process)(struct cxl_afu *afu);
>> +    int (*attach_afu_directed)(struct cxl_context *ctx, u64 wed, u64
>> amr);
>> +    int (*attach_dedicated_process)(struct cxl_context *ctx, u64 wed,
>> u64 amr);
>> +    void (*update_dedicated_ivtes)(struct cxl_context *ctx);
>> +    void (*debugfs_add_adapter_regs)(struct cxl *adapter, struct
>> dentry *dir);
>> +    void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct dentry
>> *dir);
>>      void (*psl_irq_dump_registers)(struct cxl_context *ctx);
>>      void (*err_irq_dump_registers)(struct cxl *adapter);
>>      void (*debugfs_stop_trace)(struct cxl *adapter);
>> @@ -805,16 +815,21 @@ void afu_irq_name_free(struct cxl_context *ctx);
>>
>>  #ifdef CONFIG_DEBUG_FS
>>
>> +int cxl_attach_afu_directed_psl(struct cxl_context *ctx, u64 wed, u64
>> amr);
>> +int cxl_activate_dedicated_process_psl(struct cxl_afu *afu);
>> +int cxl_attach_dedicated_process_psl(struct cxl_context *ctx, u64
>> wed, u64 amr);
>> +void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx);
>> +
>
>
> I don't think those prototypes are meant to be dependent on CONFIG_DEBUG_FS

Whoops, looks like I screwed that up when I rebased. :/



-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
