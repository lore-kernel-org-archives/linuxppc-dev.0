Return-Path: <tushar.n.dave@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXtKX0js5zDr62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 06:20:15 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 vA9JKDkN002628
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 19:20:14 GMT
Subject: Re: [PATCH] [net-next,v3] ibmvnic: Feature implementation of Vital
 Product Data (VPD) for the ibmvnic driver
To: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tlfalcon@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
References: <20171109190012.17981-1-desnesn@linux.vnet.ibm.com>
From: Tushar Dave <tushar.n.dave@oracle.com>
Message-ID: <b6282297-8282-1ed5-8909-9a44dd2349eb@oracle.com>
Date: Thu, 9 Nov 2017 11:20:05 -0800
MIME-Version: 1.0
In-Reply-To: <20171109190012.17981-1-desnesn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/09/2017 11:00 AM, Desnes Augusto Nunes do Rosario wrote:
> This patch implements and enables VDP support for the ibmvnic driver.
> Moreover, it includes the implementation of suitable structs, signal
>   transmission/handling and functions which allows the retrival of firmware
>   information from the ibmvnic card through the ethtool command.
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 149 ++++++++++++++++++++++++++++++++++++-
>   drivers/net/ethernet/ibm/ibmvnic.h |  27 ++++++-
>   2 files changed, 173 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index d0cff28..693b502 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -573,6 +573,15 @@ static int reset_tx_pools(struct ibmvnic_adapter *adapter)
>   	return 0;
>   }
>   
> +static void release_vpd_data(struct ibmvnic_adapter *adapter)
> +{
> +	if (!adapter->vpd)
> +		return;
> +
> +	kfree(adapter->vpd->buff);
> +	kfree(adapter->vpd);
> +}
> +
>   static void release_tx_pools(struct ibmvnic_adapter *adapter)
>   {
>   	struct ibmvnic_tx_pool *tx_pool;
> @@ -753,6 +762,8 @@ static void release_resources(struct ibmvnic_adapter *adapter)
>   {
>   	int i;
>   
> +	release_vpd_data(adapter);
> +
>   	release_tx_pools(adapter);
>   	release_rx_pools(adapter);
>   
> @@ -833,6 +844,53 @@ static int set_real_num_queues(struct net_device *netdev)
>   	return rc;
>   }
>   
> +static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +	union ibmvnic_crq crq;
> +	dma_addr_t dma_addr;
> +	int len;
> +
> +	if (adapter->vpd->buff)
> +		len = adapter->vpd->len;
> +
> +	reinit_completion(&adapter->fw_done);
> +	crq.get_vpd_size.first = IBMVNIC_CRQ_CMD;
> +	crq.get_vpd_size.cmd = GET_VPD_SIZE;
> +	ibmvnic_send_crq(adapter, &crq);
> +	wait_for_completion(&adapter->fw_done);
> +
> +	if (!adapter->vpd->buff)
> +		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
> +	else if (adapter->vpd->len != len)
> +		adapter->vpd->buff =
> +			krealloc(adapter->vpd->buff,
> +				 adapter->vpd->len, GFP_KERNEL);
> +
> +	if (!adapter->vpd->buff) {
> +		dev_err(dev, "Could allocate VPD buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	adapter->vpd->dma_addr =
> +		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
> +			       DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		dev_err(dev, "Could not map VPD buffer\n");
> +		return -ENOMEM;
In this case, driver should release memory for adapter->vpd->buff.

> +	}
> +
> +	reinit_completion(&adapter->fw_done);
> +	crq.get_vpd.first = IBMVNIC_CRQ_CMD;
> +	crq.get_vpd.cmd = GET_VPD;
> +	crq.get_vpd.ioba = cpu_to_be32(adapter->vpd->dma_addr);
> +	crq.get_vpd.len = cpu_to_be32((u32)adapter->vpd->len);
> +	ibmvnic_send_crq(adapter, &crq);
> +	wait_for_completion(&adapter->fw_done);
> +
> +	return 0;
> +}
> +
>   static int init_resources(struct ibmvnic_adapter *adapter)
>   {
>   	struct net_device *netdev = adapter->netdev;
> @@ -850,6 +908,10 @@ static int init_resources(struct ibmvnic_adapter *adapter)
>   	if (rc)
>   		return rc;
>   
> +	adapter->vpd = kzalloc(sizeof(*adapter->vpd), GFP_KERNEL);
> +	if (!adapter->vpd)
> +		return -ENOMEM;
> +
>   	adapter->map_id = 1;
>   	adapter->napi = kcalloc(adapter->req_rx_queues,
>   				sizeof(struct napi_struct), GFP_KERNEL);
> @@ -950,6 +1012,10 @@ static int ibmvnic_open(struct net_device *netdev)
>   
>   	rc = __ibmvnic_open(netdev);
>   	netif_carrier_on(netdev);
> +
> +	/* Vital Product Data (VPD) */
> +	ibmvnic_get_vpd(adapter);
May want to check return value from ibmvnic_get_vpd() ?

-Tushar
> +
>   	mutex_unlock(&adapter->reset_lock);
>   
>   	return rc;
> @@ -1878,11 +1944,15 @@ static int ibmvnic_get_link_ksettings(struct net_device *netdev,
>   	return 0;
>   }
>   
> -static void ibmvnic_get_drvinfo(struct net_device *dev,
> +static void ibmvnic_get_drvinfo(struct net_device *netdev,
>   				struct ethtool_drvinfo *info)
>   {
> +	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
> +
>   	strlcpy(info->driver, ibmvnic_driver_name, sizeof(info->driver));
>   	strlcpy(info->version, IBMVNIC_DRIVER_VERSION, sizeof(info->version));
> +	strlcpy(info->fw_version, adapter->fw_version,
> +		sizeof(info->fw_version));
>   }
>   
>   static u32 ibmvnic_get_msglevel(struct net_device *netdev)
> @@ -3076,6 +3146,77 @@ static void send_cap_queries(struct ibmvnic_adapter *adapter)
>   	ibmvnic_send_crq(adapter, &crq);
>   }
>   
> +static void handle_vpd_size_rsp(union ibmvnic_crq *crq,
> +				struct ibmvnic_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +
> +	if (crq->get_vpd_size_rsp.rc.code) {
> +		dev_err(dev, "Error retrieving VPD size, rc=%x\n",
> +			crq->get_vpd_size_rsp.rc.code);
> +		complete(&adapter->fw_done);
> +		return;
> +	}
> +
> +	adapter->vpd->len = be64_to_cpu(crq->get_vpd_size_rsp.len);
> +	complete(&adapter->fw_done);
> +}
> +
> +static void handle_vpd_rsp(union ibmvnic_crq *crq,
> +			   struct ibmvnic_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +	unsigned char *substr = NULL, *ptr = NULL;
> +	u8 fw_level_len = 0;
> +
> +	dma_unmap_single(dev, adapter->vpd->dma_addr, adapter->vpd->len,
> +			 DMA_FROM_DEVICE);
> +
> +	if (crq->get_vpd_rsp.rc.code) {
> +		dev_err(dev, "Error retrieving VPD from device, rc=%x\n",
> +			crq->get_vpd_rsp.rc.code);
> +		memset(adapter->fw_version, 0, 32);
> +		goto complete;
> +	}
> +
> +	/* get the position of the firmware version info
> +	 * located after the ASCII 'RM' substring in the buffer
> +	 */
> +	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
> +	if (!substr) {
> +		dev_info(dev, "No FW level provided by VPD\n");
> +		memset(adapter->fw_version, 0, 32);
> +		goto complete;
> +	}
> +
> +	/* get length of firmware level ASCII substring */
> +	if ((substr + 2) < (adapter->vpd->buff + adapter->vpd->len)) {
> +		fw_level_len = *(substr + 2);
> +	} else {
> +		dev_info(dev, "Length of FW substr extrapolated VDP buff\n");
> +		memset(adapter->fw_version, 0, 32);
> +		goto complete;
> +	}
> +
> +	/* copy firmware version string from vpd into adapter */
> +	if ((substr + 3 + fw_level_len) <
> +	    (adapter->vpd->buff + adapter->vpd->len)) {
> +		ptr = strncpy((char *)adapter->fw_version,
> +			      substr + 3, fw_level_len);
> +
> +		if (!ptr) {
> +			dev_err(dev, "Failed to isolate FW level string\n");
> +			memset(adapter->fw_version, 0, 32);
> +		}
> +	} else {
> +		dev_info(dev, "FW substr extrapolated VPD buff\n");
> +		memset(adapter->fw_version, 0, 32);
> +	}
> +
> +complete:
> +	complete(&adapter->fw_done);
> +}
> +
>   static void handle_query_ip_offload_rsp(struct ibmvnic_adapter *adapter)
>   {
>   	struct device *dev = &adapter->vdev->dev;
> @@ -3807,6 +3948,12 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
>   		netdev_dbg(netdev, "Got Collect firmware trace Response\n");
>   		complete(&adapter->fw_done);
>   		break;
> +	case GET_VPD_SIZE_RSP:
> +		handle_vpd_size_rsp(crq, adapter);
> +		break;
> +	case GET_VPD_RSP:
> +		handle_vpd_rsp(crq, adapter);
> +		break;
>   	default:
>   		netdev_err(netdev, "Got an invalid cmd type 0x%02x\n",
>   			   gen_crq->cmd);
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
> index 4670af8..d3a6959 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.h
> +++ b/drivers/net/ethernet/ibm/ibmvnic.h
> @@ -558,6 +558,12 @@ struct ibmvnic_multicast_ctrl {
>   	struct ibmvnic_rc rc;
>   } __packed __aligned(8);
>   
> +struct ibmvnic_get_vpd_size {
> +	u8 first;
> +	u8 cmd;
> +	u8 reserved[14];
> +} __packed __aligned(8);
> +
>   struct ibmvnic_get_vpd_size_rsp {
>   	u8 first;
>   	u8 cmd;
> @@ -575,6 +581,13 @@ struct ibmvnic_get_vpd {
>   	u8 reserved[4];
>   } __packed __aligned(8);
>   
> +struct ibmvnic_get_vpd_rsp {
> +	u8 first;
> +	u8 cmd;
> +	u8 reserved[10];
> +	struct ibmvnic_rc rc;
> +} __packed __aligned(8);
> +
>   struct ibmvnic_acl_change_indication {
>   	u8 first;
>   	u8 cmd;
> @@ -700,10 +713,10 @@ union ibmvnic_crq {
>   	struct ibmvnic_change_mac_addr change_mac_addr_rsp;
>   	struct ibmvnic_multicast_ctrl multicast_ctrl;
>   	struct ibmvnic_multicast_ctrl multicast_ctrl_rsp;
> -	struct ibmvnic_generic_crq get_vpd_size;
> +	struct ibmvnic_get_vpd_size get_vpd_size;
>   	struct ibmvnic_get_vpd_size_rsp get_vpd_size_rsp;
>   	struct ibmvnic_get_vpd get_vpd;
> -	struct ibmvnic_generic_crq get_vpd_rsp;
> +	struct ibmvnic_get_vpd_rsp get_vpd_rsp;
>   	struct ibmvnic_acl_change_indication acl_change_indication;
>   	struct ibmvnic_acl_query acl_query;
>   	struct ibmvnic_generic_crq acl_query_rsp;
> @@ -937,6 +950,12 @@ struct ibmvnic_error_buff {
>   	__be32 error_id;
>   };
>   
> +struct ibmvnic_vpd {
> +	unsigned char *buff;
> +	dma_addr_t dma_addr;
> +	u64 len;
> +};
> +
>   enum vnic_state {VNIC_PROBING = 1,
>   		 VNIC_PROBED,
>   		 VNIC_OPENING,
> @@ -978,6 +997,10 @@ struct ibmvnic_adapter {
>   	dma_addr_t ip_offload_ctrl_tok;
>   	u32 msg_enable;
>   
> +	/* Vital Product Data (VPD) */
> +	struct ibmvnic_vpd *vpd;
> +	char fw_version[32];
> +
>   	/* Statistics */
>   	struct ibmvnic_statistics stats;
>   	dma_addr_t stats_token;
> 
