Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jbML1zHPzF3GC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 06:37:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w74KYdM1138117
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 Aug 2018 16:37:47 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kn81c80jp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Aug 2018 16:37:47 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Sat, 4 Aug 2018 14:37:46 -0600
Subject: Re: [PATCH] powpc:feature: of_node_put is not needed after iterator.
To: zhong jiang <zhongjiang@huawei.com>, benh@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Sat, 4 Aug 2018 13:37:39 -0700
MIME-Version: 1.0
In-Reply-To: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <eb06cfd4-ccbd-3f7f-2118-10f385d9b217@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2018 07:25 AM, zhong jiang wrote:
> for_each_node_by_name iterators only  exit normally when the loop
> cursor is NULL, So there is no point to call of_node_put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powermac/feature.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
> index 3f82cb2..4eb8cb3 100644
> --- a/arch/powerpc/platforms/powermac/feature.c
> +++ b/arch/powerpc/platforms/powermac/feature.c
> @@ -2889,10 +2889,8 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
>  	/* On all machines, switch modem & serial ports off */
>  	for_each_node_by_name(np, "ch-a")
>  		initial_serial_shutdown(np);
> -	of_node_put(np);
>  	for_each_node_by_name(np, "ch-b")
>  		initial_serial_shutdown(np);
> -	of_node_put(np);
>  }
> 
>  void __init
> 
