Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A23EDDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 06:27:16 +1000 (EST)
Message-Id: <F2D83919-E38B-4570-B418-5751548A479B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241028884406-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/6] net/ucc_geth: Assign six threads to Rx for UEC
Date: Wed, 29 Apr 2009 15:25:07 -0500
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
	<12410288811793-git-send-email-Haiying.Wang@freescale.com>
	<1241028883630-git-send-email-Haiying.Wang@freescale.com>
	<1241028884406-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 1:14 PM, Haiying Wang wrote:

> when there are 46 snums defined in device tree.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> drivers/net/ucc_geth.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)

Can you be a bit more explicit in the commit message about the  
detection of 46 snums.  How is it that 46 snums equates to 6 threads?

- k

>
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 3e003fe..1f6529f 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3709,7 +3709,10 @@ static int ucc_geth_probe(struct of_device*  
> ofdev, const struct of_device_id *ma
> 		ug_info->uf_info.utfet = UCC_GETH_UTFET_GIGA_INIT;
> 		ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
> 		ug_info->numThreadsTx = UCC_GETH_NUM_OF_THREADS_4;
> -		ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
> +		if (qe_get_num_of_snums() == 46)
> +			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_6;
> +		else
> +			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
> 	}
>
> 	if (netif_msg_probe(&debug))
> -- 
> 1.6.0.2
