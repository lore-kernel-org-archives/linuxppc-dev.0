Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTJ8m55fszDqc4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 03:29:44 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4IHSkGp093402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 13:29:41 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ahcctbvkd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 13:29:41 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 18 May 2017 13:29:40 -0400
Subject: Re: [PATCH net-next] ibmvnic: fix missing unlock on error in
 __ibmvnic_reset()
To: Wei Yongjun <weiyj.lk@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
References: <20170518152452.8606-1-weiyj.lk@gmail.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 12:29:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170518152452.8606-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <2a9bde84-eb86-c964-7be8-2018eae45d7b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/18/2017 10:24 AM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add the missing unlock before return from function __ibmvnic_reset()
> in the error handling case.
> 
> Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 4f2d329..27f7933 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1313,6 +1313,7 @@ static void __ibmvnic_reset(struct work_struct *work)
> 
>  	if (rc) {
>  		free_all_rwi(adapter);
> +		mutex_unlock(&adapter->reset_lock);
>  		return;
>  	}
> 
