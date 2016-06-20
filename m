Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYFgd1c3hzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 01:50:36 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KFmOf4077200
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 11:50:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2f0gcd4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 11:50:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 09:50:33 -0600
Subject: Re: [PATCH] ibmvnic: fix to use list_for_each_safe() when delete items
To: weiyj_lk@163.com, John Allen <jallen@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1466218408-20940-1-git-send-email-weiyj_lk@163.com>
Cc: netdev@vger.kernel.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 linuxppc-dev@lists.ozlabs.org
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 10:50:26 -0500
MIME-Version: 1.0
In-Reply-To: <1466218408-20940-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <576810C2.6080208@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2016 09:53 PM, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Since we will remove items off the list using list_del() we need
> to use a safe version of the list_for_each() macro aptly named
> list_for_each_safe().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 864cb21..0b6a922 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -3141,14 +3141,14 @@ static void handle_request_ras_comp_num_rsp(union ibmvnic_crq *crq,
>  
>  static void ibmvnic_free_inflight(struct ibmvnic_adapter *adapter)
>  {
> -	struct ibmvnic_inflight_cmd *inflight_cmd;
> +	struct ibmvnic_inflight_cmd *inflight_cmd, *tmp1;
>  	struct device *dev = &adapter->vdev->dev;
> -	struct ibmvnic_error_buff *error_buff;
> +	struct ibmvnic_error_buff *error_buff, *tmp2;
>  	unsigned long flags;
>  	unsigned long flags2;
>  
>  	spin_lock_irqsave(&adapter->inflight_lock, flags);
> -	list_for_each_entry(inflight_cmd, &adapter->inflight, list) {
> +	list_for_each_entry_safe(inflight_cmd, tmp1, &adapter->inflight, list) {
>  		switch (inflight_cmd->crq.generic.cmd) {
>  		case LOGIN:
>  			dma_unmap_single(dev, adapter->login_buf_token,
> @@ -3165,8 +3165,8 @@ static void ibmvnic_free_inflight(struct ibmvnic_adapter *adapter)
>  			break;
>  		case REQUEST_ERROR_INFO:
>  			spin_lock_irqsave(&adapter->error_list_lock, flags2);
> -			list_for_each_entry(error_buff, &adapter->errors,
> -					    list) {
> +			list_for_each_entry_safe(error_buff, tmp2,
> +						 &adapter->errors, list) {
>  				dma_unmap_single(dev, error_buff->dma,
>  						 error_buff->len,
>  						 DMA_FROM_DEVICE);
>
Thanks!

Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
