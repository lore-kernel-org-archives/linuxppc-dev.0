Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqpWx71nzzDqZT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 03:19:08 +1000 (AEST)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 18:19:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 884882190056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:18:39 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3KHJ1A12752982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:19:01 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3KHJ0SS029489
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:19:01 -0600
Subject: Re: [PATCH] cxl: Increase timeout for detection of AFU mmio hang
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Frank Haverkamp <HAVERKAM@de.ibm.com>
References: <1461083664-12283-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <5717BA03.8090805@linux.vnet.ibm.com>
Date: Wed, 20 Apr 2016 19:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <1461083664-12283-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Received privately:
Tested-by: Frank Haverkamp <haver@linux.vnet.ibm.com>


Le 19/04/2016 18:34, Frederic Barrat a écrit :
> PSL designers recommend a larger value for the mmio hang pulse, 256 us
> instead of 1 us. The CAIA architecture states that it needs to be
> smaller than 1/2 of the RTOS timeout set in the PHB for outbound
> non-posted transactions, which is still (easily) the case here.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Needs to be applied on top of http://patchwork.ozlabs.org/patch/604029/
>
>
>   drivers/misc/cxl/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 94fd3f7..0a9c15b 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -375,8 +375,10 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>   		return -ENODEV;
>   	}
>
> +	psl_dsnctl = 0x0000900000000000ULL; /* pteupd ttype, scdone */
> +	psl_dsnctl |= (0x2ULL << (63-38)); /* MMIO hang pulse: 256 us */
>   	/* Tell PSL where to route data to */
> -	psl_dsnctl = 0x0000900002000000ULL | (chipid << (63-5));
> +	psl_dsnctl |= (chipid << (63-5));
>   	psl_dsnctl |= (capp_unit_id << (63-13));
>
>   	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
>
