Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcxRc4PqMzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 04:54:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7NIs4dG011907
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:54:17 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chcm6t4ev-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:54:16 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 23 Aug 2017 12:54:16 -0600
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 13:54:12 -0500
MIME-Version: 1.0
In-Reply-To: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5440865a-977a-ba27-57a9-49edc8f6cef5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2017 12:18 PM, John Allen wrote:
> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
> order to avoid any unnecessary rtas calls. This substantially reduces the
> running time of memory hot add on lpars with large amounts of memory.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index ca9b2f4..95cf2ff 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -817,6 +817,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
>  		return -EINVAL;
> 
>  	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
> +		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
> +			continue;
> +

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

>  		rc = dlpar_acquire_drc(lmbs[i].drc_index);
>  		if (rc)
>  			continue;
> 
