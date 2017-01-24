Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7Lrv6JPtzDqCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 08:28:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0OLJoWL037898
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:28:28 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286ahttq0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:28:27 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 14:28:26 -0700
Subject: Re: [PATCH] ibmveth: Add a proper check for the availability of the
 checksum features
To: Thomas Huth <thuth@redhat.com>, netdev@vger.kernel.org
References: <1485239321-14947-1-git-send-email-thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 15:28:18 -0600
MIME-Version: 1.0
In-Reply-To: <1485239321-14947-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d2d6c228-18bc-8e14-1314-fd2c8c486640@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/24/2017 12:28 AM, Thomas Huth wrote:
> When using the ibmveth driver in a KVM/QEMU based VM, it currently
> always prints out a scary error message like this when it is started:
>
>  ibmveth 71000003 (unregistered net_device): unable to change
>  checksum offload settings. 1 rc=-2 ret_attr=71000003
>
> This happens because the driver always tries to enable the checksum
> offloading without checking for the availability of this feature first.
> QEMU does not support checksum offloading for the spapr-vlan device,
> thus we always get the error message here.
> According to the LoPAPR specification, the "ibm,illan-options" property
> of the corresponding device tree node should be checked first to see
> whether the H_ILLAN_ATTRIUBTES hypercall and thus the checksum offloading
> feature is available. Thus let's do this in the ibmveth driver, too, so
> that the error message is really only limited to cases where something
> goes wrong, and does not occur if the feature is just missing.

Thanks a lot for this patch, Thomas.  Was going to give an Ack, but its already been applied :)

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a831f94..309f5c6 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1601,8 +1601,11 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  	netdev->netdev_ops = &ibmveth_netdev_ops;
>  	netdev->ethtool_ops = &netdev_ethtool_ops;
>  	SET_NETDEV_DEV(netdev, &dev->dev);
> -	netdev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
> -		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> +	netdev->hw_features = NETIF_F_SG;
> +	if (vio_get_attribute(dev, "ibm,illan-options", NULL) != NULL) {
> +		netdev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> +				       NETIF_F_RXCSUM;
> +	}
>
>  	netdev->features |= netdev->hw_features;
>
