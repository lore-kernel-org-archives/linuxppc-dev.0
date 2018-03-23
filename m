Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4076M00cDkzF1Zk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 02:06:32 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2NF53Kd065077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 11:06:30 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gw3jp91sy-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 11:06:29 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 23 Mar 2018 09:06:29 -0600
Subject: Re: [PATCH net-next] ibmvnic: Potential NULL dereference in
 clean_one_tx_pool()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Allen <jallen@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
References: <20180323113615.GA28518@mwanda>
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 10:06:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180323113615.GA28518@mwanda>
Content-Type: text/plain; charset=utf-8
Message-Id: <5dee3753-8ff3-9e2c-45b5-f5b12db1f722@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/23/2018 06:36 AM, Dan Carpenter wrote:
> There is an && vs || typo here, which potentially leads to a NULL
> dereference.

Thanks for catching that!

>
> Fixes: e9e1e97884b7 ("ibmvnic: Update TX pool cleaning routine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5632c030811b..0389a7a52152 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1135,7 +1135,7 @@ static void clean_one_tx_pool(struct ibmvnic_adapter *adapter,
>  	u64 tx_entries;
>  	int i;
>
> -	if (!tx_pool && !tx_pool->tx_buff)
> +	if (!tx_pool || !tx_pool->tx_buff)
>  		return;
>
>  	tx_entries = tx_pool->num_buffers;
>
