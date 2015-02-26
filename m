Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E58991A08A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 00:08:11 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 26 Feb 2015 06:08:09 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 12EEDC90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 07:59:19 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1QD881U25100418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 13:08:08 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1QD87rC032300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 08:08:07 -0500
Message-ID: <54EF1AB6.5010004@linux.vnet.ibm.com>
Date: Thu, 26 Feb 2015 07:08:06 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ibmveth: Add function to enable live MAC address changes
References: <1424910864-32266-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1424910864-32266-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/25/2015 06:34 PM, Thomas Falcon wrote:
> @@ -1327,6 +1327,24 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>  	return ret;
>  }
> 
> +static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
> +{
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	struct sockaddr *addr = p;
> +	u64 mac_address;
> +	int rc;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	ether_addr_copy(dev->dev_addr, addr->sa_data);
> +
> +	mac_address = ibmveth_encode_mac_addr(dev->dev_addr);
> +	rc = h_change_logical_lan_mac(adapter->vdev->unit_address, mac_address);
> +
> +	return rc;

Do you still want to be changing dev->dev_addr if h_change_logical_lan_mac
returns a failure?

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
