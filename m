Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 006331A068E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 07:42:45 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 22 Apr 2015 15:42:43 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 25C9A3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:42:40 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3MLeh8h30933110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 14:40:43 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3MLgdGS031378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:42:39 -0600
Message-ID: <553815CD.1000407@linux.vnet.ibm.com>
Date: Wed, 22 Apr 2015 16:42:37 -0500
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, anton@au1.ibm.com
Subject: Re: [PATCHv2] ibmveth: Fix off-by-one error in ibmveth_change_mtu()
References: <1429578471-9717-1-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1429578471-9717-1-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 08:07 PM, David Gibson wrote:
> AFAIK the PAPR document which defines the virtual device interface used by
> the ibmveth driver doesn't specify a specific maximum MTU.  So, in the
> ibmveth driver, the maximum allowed MTU is determined by the maximum
> allocated buffer size of 64k (corresponding to one page in the common case)
> minus the per-buffer overhead IBMVETH_BUFF_OH (which has value 22 for 14
> bytes of ethernet header, plus 8 bytes for an opaque handle).
>
> This suggests a maximum allowable MTU of 65514 bytes, but in fact the
> driver only permits a maximum MTU of 65513.  This is because there is a <
> instead of an <= in ibmveth_change_mtu(), which only permits an MTU which
> is strictly smaller than the buffer size, rather than allowing the buffer
> to be completely filled.
>
> This patch fixes the buglet.

Thanks!

Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>1
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Changes since v1:
>  * Fixed a second instance of the same off-by-one error.  Thanks to
>    Thomas Falcon for spotting this.
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cd7675a..1813476 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1238,7 +1238,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  		return -EINVAL;
>  
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> -		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size)
> +		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
>  			break;
>  
>  	if (i == IBMVETH_NUM_BUFF_POOLS)
> @@ -1257,7 +1257,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>  		adapter->rx_buff_pool[i].active = 1;
>  
> -		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size) {
> +		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
>  			dev->mtu = new_mtu;
>  			vio_cmo_set_dev_desired(viodev,
>  						ibmveth_get_desired_dma
