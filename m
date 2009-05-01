Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67718DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:58:30 +1000 (EST)
Message-Id: <F2CB7830-33F9-4F6C-A782-6B086166FC4D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/6 v2] net/ucc_geth: Assign six threads to Rx for UEC
Date: Fri, 1 May 2009 16:56:19 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 2:40 PM, Haiying Wang wrote:

> in the case the QE has 46 SNUMs for the threads to support four UCC  
> Ethernet at
> 1000Base-T simultaneously.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> v2 change: Add comments for the Rx threads change.
> drivers/net/ucc_geth.c |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)

Dave,

One more patch for you to Ack and let me handle via the powerpc tree  
because of dependencies.

- k

>
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 44f8392..1cb2710 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3702,7 +3702,15 @@ static int ucc_geth_probe(struct of_device*  
> ofdev, const struct of_device_id *ma
> 		ug_info->uf_info.utfet = UCC_GETH_UTFET_GIGA_INIT;
> 		ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
> 		ug_info->numThreadsTx = UCC_GETH_NUM_OF_THREADS_4;
> -		ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
> +
> +		/* If QE's snum number is 46 which means we need to support
> +		 * 4 UECs at 1000Base-T simultaneously, we need to allocate
> +		 * more Threads to Rx.
> +		 */
> +		if (qe_get_num_of_snums() == 46)
> +			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_6;
> +		else
> +			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
> 	}
>
> 	if (netif_msg_probe(&debug))
> -- 
> 1.6.0.2
