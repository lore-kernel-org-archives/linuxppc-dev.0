Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A96D6B7CFB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 06:22:02 +1100 (EST)
Date: Thu, 25 Feb 2010 11:21:59 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: "Steven J. Magnani" <steve@digidescorp.com>
Subject: Re: [async_tx-next PATCH 1/2] fsldma: Fix cookie issues
Message-ID: <20100225192159.GA32092@ovro.caltech.edu>
References: <1266860431-17310-1-git-send-email-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266860431-17310-1-git-send-email-steve@digidescorp.com>
Cc: Zhang Wei <zw@zh-kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2010 at 11:40:31AM -0600, Steven J. Magnani wrote:
> fsl_dma_tx_submit() only sets the cookie on the first descriptor of a
> transaction. It should set the cookie on all.
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
> ---
> diff -uprN a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> --- a/drivers/dma/fsldma.c	2010-02-22 11:16:36.000000000 -0600
> +++ b/drivers/dma/fsldma.c	2010-02-22 11:24:01.000000000 -0600
> @@ -362,7 +362,7 @@ static dma_cookie_t fsl_dma_tx_submit(st
>  		if (cookie < 0)
>  			cookie = 1;
>  
> -		desc->async_tx.cookie = cookie;
> +		child->async_tx.cookie = cookie;
>  	}
>  
>  	chan->common.cookie = cookie;
> 

This looks correct to me. I'm not sure I ever tested the driver with a
chained struct dma_async_tx_descriptor.

Ira
