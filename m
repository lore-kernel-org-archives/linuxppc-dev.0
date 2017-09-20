Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxpqM0556zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:54:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8K5rtKc138426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 01:54:53 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3bt1wspt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 01:54:52 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 20 Sep 2017 15:54:50 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8K5sl0U37421104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:54:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8K5slQ2023484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:54:47 +1000
Subject: Re: [PATCH] powerpc/eeh: Disable EEH stack dump by default
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1505831139-6053-1-git-send-email-joserz@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 20 Sep 2017 15:54:46 +1000
MIME-Version: 1.0
In-Reply-To: <1505831139-6053-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dd3e97e1-9cd5-336f-a59f-3c5235302e58@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/09/17 00:25, Jose Ricardo Ziviani wrote:
> Today, each EEH causes a stack dump to be printed in the logs. In
> production environment it's not quite necessary. Thus, this patch
> adds a new command line argument in order to enable the stack
> dump for debugging purposes.
> 
> For example, instead of the following:
> 
> [  131.778661] EEH: Frozen PHB#2-PE#fd detected
> [  131.778672] EEH: PE location: N/A, PHB location: N/A
> [  131.778677] CPU: 21 PID: 10098 Comm: lspci Not tainted ...
> [  131.778680] Call Trace:
> [  131.778686] [c0000003a140bab0] [c000000000beb58c] dump_stack+...
> <snip ~10 lines>
> [  131.778770] EEH: Detected PCI bus error on PHB#2-PE#fd
> [  131.778775] EEH: This PCI device has failed 1 times in the last hour
> ...
> 
> we will have this by default:
> 
> [12777.175880] EEH: Frozen PHB#2-PE#fd detected
> [12777.175893] EEH: PE location: N/A, PHB location: N/A
> [12777.175922] EEH: Detected PCI bus error on PHB#2-PE#fd
> [12777.175931] EEH: This PCI device has failed 2 times in the last hour
> ...
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

As someone who's had to debug far too many EEH-related bugs, I'd really 
prefer if this remained as is.


Andrew

> ---
>   arch/powerpc/kernel/eeh.c | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 9e81678..4336c3b1 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -157,6 +157,19 @@ static int __init eeh_setup(char *str)
>   __setup("eeh=", eeh_setup);
>   
>   /*
> + * It's not necessary to dump the stack trace when an EEH occours
> + * in the production environment. For debugging, the command line
> + * option "enable_eeh_stacktrace" brings the stack dump back
> + */
> +static bool eeh_show_stacktrace;
> +static int __init enable_eeh_stacktrace(char *p)
> +{
> +	eeh_show_stacktrace = true;
> +	return 0;
> +}
> +early_param("enable_eeh_stacktrace", enable_eeh_stacktrace);
> +
> +/*
>    * This routine captures assorted PCI configuration space data
>    * for the indicated PCI device, and puts them into a buffer
>    * for RTAS error logging.
> @@ -407,7 +420,10 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
>   
>   	pr_err("EEH: PHB#%x failure detected, location: %s\n",
>   		phb_pe->phb->global_number, eeh_pe_loc_get(phb_pe));
> -	dump_stack();
> +
> +	if (eeh_show_stacktrace)
> +		dump_stack();
> +
>   	eeh_send_failure_event(phb_pe);
>   
>   	return 1;
> @@ -504,7 +520,9 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>   				eeh_driver_name(dev), eeh_pci_name(dev));
>   			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
>   				eeh_driver_name(dev));
> -			dump_stack();
> +
> +			if (eeh_show_stacktrace)
> +				dump_stack();
>   		}
>   		goto dn_unlock;
>   	}
> @@ -572,7 +590,9 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>   	       pe->phb->global_number, pe->addr);
>   	pr_err("EEH: PE location: %s, PHB location: %s\n",
>   	       eeh_pe_loc_get(pe), eeh_pe_loc_get(phb_pe));
> -	dump_stack();
> +
> +	if (eeh_show_stacktrace)
> +		dump_stack();
>   
>   	eeh_send_failure_event(pe);
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
