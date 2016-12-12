Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcn931pG8zDw9r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:40:23 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCFeHum120107
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:40:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 279v06d8as-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:40:19 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 08:39:49 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DBAC51FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 08:39:25 -0700 (MST)
Subject: Re: [PATCH V9 7/8] powerpc: Check arch.vec earlier during boot for
 memory features
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
 <148109493640.193207.4066849658518994363.stgit@powerkvm6.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 09:39:45 -0600
MIME-Version: 1.0
In-Reply-To: <148109493640.193207.4066849658518994363.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d889c65e-faec-5873-d37b-70a0a506d09d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2016 01:15 AM, Michael Bringmann wrote:
> architecture.vec5 features: The boot-time memory management needs to
> know the form of the "ibm,dynamic-memory-v2" property early during
> scanning of the flattened device tree.  This patch moves execution of
> the function pseries_probe_fw_features() early enough to be before
> the scanning of the memory properties in the device tree to allow
> recognition of the supported properties.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/prom.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 2d49887..bd07157 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -759,6 +759,9 @@ void __init early_init_devtree(void *params)
>  	 */
>  	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
> 
> +	/* Now try to figure out if we are running on LPAR and so on */
> +	pseries_probe_fw_features();
> +
>  	/* Scan memory nodes and rebuild MEMBLOCKs */
>  	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>  	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> @@ -826,9 +829,6 @@ void __init early_init_devtree(void *params)
>  #endif
>  	epapr_paravirt_early_init();
> 
> -	/* Now try to figure out if we are running on LPAR and so on */
> -	pseries_probe_fw_features();
> -
>  #ifdef CONFIG_PPC_PS3
>  	/* Identify PS3 firmware */
>  	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
> 
