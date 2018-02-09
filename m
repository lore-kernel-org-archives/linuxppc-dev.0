Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdFsK6LpyzF0fy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 00:14:45 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19DEbJF069116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 08:14:43 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g1brn1gm2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 08:14:42 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 13:14:39 -0000
Subject: Re: [PATCH 2/3] cxl: Introduce module parameter 'enable_psltrace'
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
 <20180209042535.16845-3-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 14:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180209042535.16845-3-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a3880a5d-6ccb-9a90-14e5-d48376e4c8e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 09/02/2018 à 05:25, Vaibhav Jain a écrit :
> We introduce a new module parameter named 'enable_psltrace' which asks cxl
> to start(by default) psl-traces on an adapter as soon as its probe is
> finished. In case this default behavior is not needed then this
> module parameter can be set to '0'.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h  | 2 ++
>   drivers/misc/cxl/main.c | 4 ++++
>   drivers/misc/cxl/pci.c  | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 81da307b60c0..1af66451cbb4 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -28,6 +28,7 @@
>   #include <uapi/misc/cxl.h>
> 
>   extern uint cxl_verbose;
> +extern bool cxl_enable_psltrace;
> 
>   #define CXL_TIMEOUT 5
> 
> @@ -678,6 +679,7 @@ struct cxl_service_layer_ops {
>   	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
>   	void (*err_irq_dump_registers)(struct cxl *adapter);
>   	void (*stop_psltrace)(struct cxl *adapter);
> +	void (*start_psltrace)(struct cxl *adapter);
>   	void (*write_timebase_ctrl)(struct cxl *adapter);
>   	u64 (*timebase_read)(struct cxl *adapter);
>   	int capi_mode;
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index c1ba0d42cbc8..593f2cdba3d8 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -34,6 +34,10 @@ uint cxl_verbose;
>   module_param_named(verbose, cxl_verbose, uint, 0600);
>   MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
> 
> +bool cxl_enable_psltrace = true;
> +module_param_named(enable_psltrace, cxl_enable_psltrace, bool, 0600);
> +MODULE_PARM_DESC(enable_psltrace, "Set PSL traces on probe. default: on");
> +
I am not too agree to add a new parameter. This can cause doubts.
PSL team has confirmed that enabling traces has no impact.
Do you see any reason to disable the traces ?

>   const struct cxl_backend_ops *cxl_ops;
> 
>   int cxl_afu_slbia(struct cxl_afu *afu)
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 926b13973b73..9e8b8525534c 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1726,6 +1726,9 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>   	if ((rc = cxl_native_register_psl_err_irq(adapter)))
>   		goto err;
> 
> +	if (cxl_enable_psltrace && adapter->native->sl_ops->start_psltrace)
> +		adapter->native->sl_ops->start_psltrace(adapter);
> +
>   	return 0;
> 
>   err:
> 
