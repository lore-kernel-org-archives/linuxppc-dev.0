Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpKBY5HM8zDrYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 11:15:33 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v881Dv4g010635
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Sep 2017 21:15:30 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cufh6d565-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 21:15:30 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 8 Sep 2017 11:15:27 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v881FOME41746498
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 11:15:24 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v881FOo2006570
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 11:15:24 +1000
Subject: Re: [PATCH] cxl: Dump PSL_FIR1/2 registers on PSL9 error irq
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 8 Sep 2017 11:15:21 +1000
MIME-Version: 1.0
In-Reply-To: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <97b95a75-b5df-bea9-d094-989cd4bb0048@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LGTM

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 07/09/17 22:13, Vaibhav Jain wrote:
> For PSL9 currently we aren't dumping the PSL FIR1/2 registers when a
> PSL error interrupt is triggered. Contents of these registers are
> useful in debugging AFU issues.
> 
> This patch fixes issue by updating the cxl_native_err_irq_dump_regs()
> to dump these regs on PSL error interrupt thereby bringing the
> behavior in line with PSL on POWER-8.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/native.c | 13 +++++++++++--
>   drivers/misc/cxl/pci.c    |  1 +
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 4a82c313cf71..60b91e95821d 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -1261,8 +1261,17 @@ void cxl_native_err_irq_dump_regs(struct cxl *adapter)
>   {
>   	u64 fir1, fir2;
>   
> -	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
> -	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
> +	if (cxl_is_power8()) {
> +		fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
> +		fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
> +	} else if (cxl_is_power9()) {
> +		fir1 = cxl_p1_read(adapter, CXL_PSL9_FIR1);
> +		fir2 = cxl_p1_read(adapter, CXL_PSL9_FIR2);
> +	} else {
> +		/* Dont report garbage */
> +		fir1 = fir2 = 0;
> +		WARN_ON(1);
> +	}
>   
>   	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
>   }
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index d18b3d9292fd..597e145f38e3 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1762,6 +1762,7 @@ static const struct cxl_service_layer_ops psl9_ops = {
>   	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
>   	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
>   	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
> +	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
>   	.debugfs_stop_trace = cxl_stop_trace_psl9,
>   	.write_timebase_ctrl = write_timebase_ctrl_psl9,
>   	.timebase_read = timebase_read_psl9,
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
