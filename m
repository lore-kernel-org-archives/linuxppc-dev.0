Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0213.hostedemail.com
 [216.40.44.213])
 by lists.ozlabs.org (Postfix) with ESMTP id 619FA1A1A29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 03:47:15 +1000 (AEST)
Message-ID: <1437587228.20787.26.camel@perches.com>
Subject: Re: [PATCH 03/10] dpaa_eth: add configurable bpool thresholds
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 igal.liberman@freescale.com, ppc@mindchasers.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se
Date: Wed, 22 Jul 2015 10:47:08 -0700
In-Reply-To: <1437581806-17420-3-git-send-email-madalin.bucur@freescale.com>
References: <1437581806-17420-1-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-3-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-22 at 19:16 +0300, Madalin Bucur wrote:
> Allow the user to tweak the refill threshold and the total number
> of buffers in the buffer pool. The provided values are for one CPU.

Any value in making these module parameters instead?

> +config FSL_DPAA_ETH_MAX_BUF_COUNT
> +	int "Maximum number of buffers in private bpool"
> +	range 64 2048
> +	default "128"
> +	---help---
> +	  The maximum number of buffers to be by default allocated in the DPAA-Ethernet private port's
> +	  buffer pool. One needn't normally modify this, as it has probably been tuned for performance
> +	  already. This cannot be lower than DPAA_ETH_REFILL_THRESHOLD.
> +
> +config FSL_DPAA_ETH_REFILL_THRESHOLD
> +	int "Private bpool refill threshold"
> +	range 32 FSL_DPAA_ETH_MAX_BUF_COUNT
> +	default "80"
> +	---help---
> +	  The DPAA-Ethernet driver will start replenishing buffer pools whose count
> +	  falls below this threshold. This must be related to DPAA_ETH_MAX_BUF_COUNT. One needn't normally
> +	  modify this value unless one has very specific performance reasons.
> +
>  config FSL_DPAA_CS_THRESHOLD_1G
>  	hex "Egress congestion threshold on 1G ports"
>  	range 0x1000 0x10000000
