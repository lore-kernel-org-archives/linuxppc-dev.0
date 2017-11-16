Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd9Z44BQ7zDr26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:00:59 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGIxkrs077770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 14:00:57 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9ec16w3d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 14:00:54 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 12:00:51 -0700
Subject: Re: [PATCH] [net-next] ibmvnic: This patch fixes the
 dma_mapping_error call to use the correct dma_addr which is inside the
 ibmvnic_vpd struct.
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tlfalcon@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
References: <20171116182809.21733-1-desnesn@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 17:00:47 -0200
MIME-Version: 1.0
In-Reply-To: <20171116182809.21733-1-desnesn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a4b12fe6-1584-be08-9835-d32a6df57e97@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Version 2 of this patch has been already sent with correct styling.

On 11/16/2017 04:28 PM, Desnes Augusto Nunes do Rosario wrote:
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 04aaacb..1dc4aef 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -849,7 +849,6 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>   {
>   	struct device *dev = &adapter->vdev->dev;
>   	union ibmvnic_crq crq;
> -	dma_addr_t dma_addr;
>   	int len = 0;
> 
>   	if (adapter->vpd->buff)
> @@ -879,7 +878,7 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>   	adapter->vpd->dma_addr =
>   		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
>   			       DMA_FROM_DEVICE);
> -	if (dma_mapping_error(dev, dma_addr)) {
> +	if (dma_mapping_error(dev, adapter->vpd->dma_addr)) {
>   		dev_err(dev, "Could not map VPD buffer\n");
>   		kfree(adapter->vpd->buff);
>   		return -ENOMEM;
> 

-- 
Desnes Augusto Nunes do Rosário
------------------------------------------

Linux Developer - IBM / Brazil
M.Sc. in Electrical and Computer Engineering - UFRN

(11) 9595-30-900
desnesn@br.ibm.com
